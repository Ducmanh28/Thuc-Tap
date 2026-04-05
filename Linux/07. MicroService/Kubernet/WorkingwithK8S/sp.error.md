# Một số lỗi mà có thể bạn sẽ gặp phải khi sử dụng K8S
## Lỗi connection refused
### Mô tả lỗi:
```
root@k8s-master:~# kubectl cluster-info
E0403 14:26:54.759177   85134 memcache.go:265] couldn't get current server API group list: Get "https://172.16.66.84:6443/api?timeout=32s": dial tcp 172.16.66.84:6443: connect: connection refused
E0403 14:26:54.759926   85134 memcache.go:265] couldn't get current server API group list: Get "https://172.16.66.84:6443/api?timeout=32s": dial tcp 172.16.66.84:6443: connect: connection refused
E0403 14:26:54.761658   85134 memcache.go:265] couldn't get current server API group list: Get "https://172.16.66.84:6443/api?timeout=32s": dial tcp 172.16.66.84:6443: connect: connection refused
E0403 14:26:54.762289   85134 memcache.go:265] couldn't get current server API group list: Get "https://172.16.66.84:6443/api?timeout=32s": dial tcp 172.16.66.84:6443: connect: connection refused
E0403 14:26:54.764084   85134 memcache.go:265] couldn't get current server API group list: Get "https://172.16.66.84:6443/api?timeout=32s": dial tcp 172.16.66.84:6443: connect: connection refused

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
The connection to the server 172.16.66.84:6443 was refused - did you specify the right host or port?
root@k8s-master:~# kubectl cluster-info dump
The connection to the server 172.16.66.84:6443 was refused - did you specify the right host or port?
```
Khi bạn sử dụng 1 lệnh `kubectl` nhưng lại bị lỗi ***connection refused*** thì phải làm sao?
### Nguyên nhân:
Vấn đề nằm ở sự xung đột giữa cấu hình Kernel Linux và Go Runtime. Khi IPv6 bị vô hiệu hóa hoàn toàn (disable_ipv6 = 1), nhưng API Server không được chỉ định rõ ràng địa chỉ IP để lắng nghe (Bind Address), nó sẽ mặc định cố gắng mở socket trên IPv6 loopback [::1]. Do Kernel đã đóng ngăn xếp IPv6, socket này không thể khởi tạo, dẫn đến API Server bị treo hoặc không thể mở cổng 6443.

### Hướng giải quyết
Có 2 hướng giải quyết: Bật lại IPv6 hoặc ép API Server chạy thuần IPv4.

Kiểm tra trạng thái hệ thống:
```bash
root@k8s-master:~# crictl ps -a | grep kube-apiserver

4d143d214cbeb       f44c6888a2d24       7 minutes ago        Running             kube-apiserver            1                   ad50aa195cf18       kube-apiserver-k8s-master

389fab71e5c2f       f44c6888a2d24       10 days ago          Exited              kube-apiserver            0                   edd1992cc3859       kube-apiserver-k8s-master
```
Chúng ta có thể thấy kube-apiserver đã ***Exited***

Kiểm tra file Manifest
```YAML
root@k8s-master:~# vim /etc/kubernetes/manifests/kube-apiserver.yaml

- command:
    - kube-apiserver
    - --advertise-address=172.16.66.84
    - --allow-privileged=true
    - --authorization-mode=Node,RBAC
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --enable-admission-plugins=NodeRestriction
    - --enable-bootstrap-token-auth=true
    - --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt
    - --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
    - --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key
    - --etcd-servers=https://127.0.0.1:2379
    - --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt
    - --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key
    - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
    - --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt
    - --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key
    - --requestheader-allowed-names=front-proxy-client
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --requestheader-extra-headers-prefix=X-Remote-Extra-
    - --requestheader-group-headers=X-Remote-Group
    - --requestheader-username-headers=X-Remote-User
    - --secure-port=6443
    - --service-account-issuer=https://kubernetes.default.svc.cluster.local
    - --service-account-key-file=/etc/kubernetes/pki/sa.pub
    - --service-account-signing-key-file=/etc/kubernetes/pki/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --tls-cert-file=/etc/kubernetes/pki/apiserver.crt
    - --tls-private-key-file=/etc/kubernetes/pki/apiserver.key

```
Do không có cấu hình gì nên chúng ta có thể đoán được đang mặc định dùng IPV6

Thêm vào dòng sau:
```YAML
- --bind-address=0.0.0.0
```
Giá trị `0.0.0.0` sẽ ép API Server lắng nghe trên tất cả các interface IPv4, bao gồm cả `127.0.0.1` và `172.16.66.84`

Kiểm tra lại cổng đang mở:
```bash
root@k8s-master:~# ss -tulnp | grep 6443
tcp   LISTEN 0      4096               *:6443             *:*    users:(("kube-apiserver",pid=98704,fd=3))
```
Đảm bảo kubectl trỏ đúng IP Server
```bash
root@k8s-master:~# cat ~/.kube/config | grep server
    server: https://172.16.66.84:6443
```
Kiểm tra log:
```bash
root@k8s-master:~# systemctl status kubelet

● kubelet.service - kubelet: The Kubernetes Node Agent

     Loaded: loaded (/usr/lib/systemd/system/kubelet.service; enabled; preset: enabled)

    Drop-In: /usr/lib/systemd/system/kubelet.service.d

             └─10-kubeadm.conf

     Active: active (running) since Fri 2026-04-03 14:28:11 +07; 12min ago

       Docs: https://kubernetes.io/docs/

   Main PID: 85767 (kubelet)

      Tasks: 12 (limit: 2263)

     Memory: 72.4M (peak: 73.2M)

        CPU: 32.606s

     CGroup: /system.slice/kubelet.service

             └─85767 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib>



Apr 03 14:28:28 k8s-master kubelet[85767]: E0403 14:28:28.409820   85767 pod_workers.go:1298] "Error syncing pod, skipping" err="failed to \"CreatePodSandbox\">

Apr 03 14:28:29 k8s-master kubelet[85767]: E0403 14:28:29.035613   85767 remote_runtime.go:193] "RunPodSandbox from runtime service failed" err="rpc error: cod>

Apr 03 14:28:29 k8s-master kubelet[85767]: E0403 14:28:29.035701   85767 kuberuntime_sandbox.go:72] "Failed to create sandbox for pod" err="rpc error: code = U>

Apr 03 14:28:29 k8s-master kubelet[85767]: E0403 14:28:29.035745   85767 kuberuntime_manager.go:1184] "CreatePodSandbox for pod failed" err="rpc error: code = >

Apr 03 14:28:29 k8s-master kubelet[85767]: E0403 14:28:29.035830   85767 pod_workers.go:1298] "Error syncing pod, skipping" err="failed to \"CreatePodSandbox\">

Apr 03 14:28:30 k8s-master kubelet[85767]: I0403 14:28:30.780356   85767 scope.go:117] "RemoveContainer" containerID="9336275282e656f2bed3c5b9ae669f6a0e4aa6aa0>

Apr 03 14:34:41 k8s-master kubelet[85767]: I0403 14:34:41.869297   85767 topology_manager.go:215] "Topology Admit Handler" podUID="9cab4463-5257-49a7-aad2-5d88>

Apr 03 14:34:41 k8s-master kubelet[85767]: I0403 14:34:41.996286   85767 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started fo>

Apr 03 14:34:41 k8s-master kubelet[85767]: I0403 14:34:41.996496   85767 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started fo>

Apr 03 14:34:44 k8s-master kubelet[85767]: I0403 14:34:44.054948   85767 pod_startup_latency_tracker.go:102] "Observed pod startup duration" pod="kube-system/c>

lines 1-23/23 (END)
```
Bản log `systemctl status kubelet` này cho thấy trạng thái "hỗn hợp": Kubelet đã chạy (Active), nhưng hệ thống đang gặp xung đột nghiêm trọng về Mạng (CNI/Flannel) và Kết nối API.

Cách giải quyết tối ưu nhất sẽ là xóa flanel đi và khởi tạo lại
```bash
kubectl delete -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```
Cài đặt lại
```bash
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```

Tuy nhiên lúc này, tôi lại gặp phải lỗi xác thực
```bash
root@k8s-master:~# kubectl get pods -n kube-flannel

Error from server (Forbidden): pods is forbidden: User "kubernetes-admin" cannot list resource "pods" in API group "" in the namespace "kube-flannel"
```
Thực hiện làm sạch và cấp quyền Admin
```bash
export KUBECONFIG=/etc/kubernetes/admin.conf

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
```bash
root@k8s-master:~# kubectl get pods -A
NAMESPACE      NAME                                 READY   STATUS        RESTARTS        AGE
kube-flannel   kube-flannel-ds-45gm5                1/1     Running       0               12d
kube-flannel   kube-flannel-ds-dzk86                1/1     Running       0               12d
kube-flannel   kube-flannel-ds-xd9t7                1/1     Running       1 (2d18h ago)   12d
kube-system    coredns-76f75df574-258ws             1/1     Running       0               2d4h
kube-system    coredns-76f75df574-4kwcl             1/1     Terminating   0               4d2h
kube-system    coredns-76f75df574-9mfr4             1/1     Terminating   0               13d
kube-system    coredns-76f75df574-d4cl8             1/1     Terminating   0               13d
```
Kết quả:
```bash
root@k8s-master:~# kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
k8s-master     Ready    control-plane   13d   v1.29.15
k8s-worker-1   Ready    worker          13d   v1.29.15
k8s-worker-2   Ready    worker          13d   v1.29.15

```