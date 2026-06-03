# Quy trình cài đặt
Mục này nêu ra các mục cần cài đặt trên hệ thống này
## K8S
Vì được triển khai bằng K8S, vậy nên chúng ta cần có K8S trên cả 3 VM. Vui lòng tham khảo tại đây để xem hướng dẫn cài đặt K8S.

## NetBox
Sau khi cài đặt K8S trên cả 3 VM và kết nối thành công, chúng ta sẽ bắt đầu cài đặt NetBox. Thay vì cài đặt thủ công, chúng ta sẽ sử dụng K8S để cài đặt NetBox để đảm bảo:
- Tính nhất quán: Toàn bộ hệ thống (Netbox, MySQL, Backend, Frontend) nằm chung một kiến trúc giúp quản lý Network (Service, Ingress) và Security (Secrets) đồng bộ
- Self-healing: Nếu Pod Netbox bị lỗi, K8s sẽ tự khởi động lại 
- Dễ dàng mở rộng: Sau này khi dữ liệu "Truth data" lớn lên, có thể tách Database của Netbox sang node khác chỉ bằng vài dòng cấu hình

### Cài đặt StorageClass
Netbox, PostgreSQL và Redis đều cần Persistent Volume (PV) để lưu dữ liệu. Chúng ta sẽ dùng ổ cứng cục bộ của các node.

```Bash
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
```
Thiết lập local-path làm StorageClass mặc định của cụm:

```Bash
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```
Kiểm tra lại: `kubectl get sc` (Đảm bảo có chữ (default) cạnh local-path)

### Cài đặt Helm
Nếu Master chưa có Helm, cài đặt thông qua script chính thức:

```Bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
Thêm repository của Netbox:

```Bash
helm repo add netbox https://charts.netbox.oss.netboxlabs.com/
helm repo update
```
### Tạo file cấu hình values.yaml
Tạo một file tên là netbox-values.yaml trên Master. File này sẽ ghi đè các cấu hình mặc định của Helm Chart, thiết lập password và cấu hình mạng dạng NodePort để bạn có thể truy cập thẳng từ laptop.

```YAML
# netbox-values.yaml
superuser:
  name: admin
  email: admin@local.dev
  password: adminpassword 

service:
  type: NodePort
  port: 80
  nodePort: "32080"
postgresql:
  enabled: true
  auth:
    postgresPassword: supersecretpostgres
    password: netboxdbpassword
    database: netbox
  primary:
    persistence:
      enabled: true
      size: 5Gi
redis:
  enabled: true
  auth:
    password: netboxredispassword
  master:
    persistence:
      enabled: true
      size: 1Gi
worker:
  enabled: true
```
### Triển khai Netbox
Tạo một namespace riêng cho hạ tầng quản lý để dễ kiểm soát, sau đó cài đặt Netbox:

```Bash
# Tạo namespace
kubectl create namespace netbox-system

# Triển khai bằng Helm
helm install my-netbox netbox/netbox -f netbox-values.yaml -n netbox-system
```
### Kiểm tra và Truy cập
Quá trình khởi tạo Pods, đặc biệt là Database và chạy script Migration của Netbox sẽ mất khoảng 3-5 phút.

Kiểm tra trạng thái các Pod:

```Bash
MANH-U82:~# kubectl get pods -n netbox-system -w
NAME                              READY   STATUS                  RESTARTS        AGE
my-netbox-56c5d8f896-gtjl5        0/1     Running                 1 (3m56s ago)   22m
my-netbox-postgresql-0            1/1     Running                 0               22m
my-netbox-valkey-primary-0        1/1     Running                 0               22m
my-netbox-valkey-replicas-0       1/1     Running                 0               22m
my-netbox-valkey-replicas-1       1/1     Running                 0               20m
my-netbox-valkey-replicas-2       1/1     Running                 0               19m
my-netbox-worker-8d95f64f-c8z6f   0/1     Init:CrashLoopBackOff   7 (95s ago)     22m
```
Khi tất cả các Pod (netbox, postgresql, redis, worker) chuyển sang trạng thái Running và READY 1/1, hệ thống đã sẵn sàng.

Để xem chi tiết quá trình cài đặt:
```Bash
root@MANH-U82:~# kubectlogs -f my-netbox-56c5d8f896-gtjl5 -n netbox-system
Defaulted container "netbox" out of: netbox, init-dirs (init)
⚙️ Applying database migrations
🧬 loaded config '/etc/netbox/config/configuration.py'
🧬 loaded config '/etc/netbox/config/extra.py'
🧬 loaded config '/etc/netbox/config/logging.py'
🧬 loaded config '/etc/netbox/config/plugins.py'
Operations to perform:
  Apply all migrations: account, auth, circuits, contenttypes, core, dcim, django_rq, extras, ipam, sessions, social_django, taggit, tenancy, thumbnail, users, virtualization, vpn, wireless
Running migrations:
  Applying virtualization.0023_squashed_0036... OK
  Applying virtualization.0037_protect_child_interfaces... OK
  Applying virtualization.0038_virtualdisk... OK
  Applying virtualization.0039_virtualmachine_serial_number... OK
  Applying virtualization.0040_convert_disk_size... OK
  Applying virtualization.0041_charfield_null_choices... OK
  Applying virtualization.0042_vminterface_vlan_translation_policy... OK
  Applying virtualization.0043_qinq_svlan... OK
```
**Lưu ý**: *Quá trình này thường tốn vài phút tùy thuộc vào tốc độ **đọc/ghi** file trên VM!*

Kiểm thử: Truy cập: *`http://172.16.66.82:30080`*

![](/Anh/Screenshot_1073.png)

## 