# Bài lab01
## Mục tiêu
Sử dụng k8s tạo 1 trang web nginx

Yêu cầu:
- Sử dụng kubectl
- Tạo namespace riêng
- Truy cập vào container sửa file cấu hình

## Thực hành
Tạo namespace:
```
root@k8s-master:~# kubectl create ns nginx-ns
namespace/nginx-ns created
```
Kiểm tra:
```
root@k8s-master:~# kubectl get ns
NAME              STATUS   AGE
default           Active   6d4h
kube-flannel      Active   5d3h
kube-node-lease   Active   6d4h
kube-public       Active   6d4h
kube-system       Active   6d4h
nginx-ns          Active   94s
test              Active   54m
```

Tạo pod trên namespace:
```
root@k8s-master:~# kubectl run nginx-pod --image=nginx -n nginx-ns
pod/nginx-pod created
```
Kiểm tra:
```
root@k8s-master:~# kubectl get pods -n nginx-ns
NAME        READY   STATUS    RESTARTS   AGE
nginx-pod   1/1     Running   0          117s
```
Xem thông tin pod:
```
root@k8s-master:~# kubectl describe pod nginx-pod -n nginx-ns
Name:             nginx-pod
Namespace:        nginx-ns
Priority:         0
Service Account:  default
Node:             k8s-worker-2/172.16.66.82
Start Time:       Sun, 29 Mar 2026 20:08:54 +0700
Labels:           run=nginx-pod
Annotations:      <none>
Status:           Running
IP:               10.244.1.4
...
```
Phân tích:

- Scheduling
  - Node: `k8s-worker-2`: default-scheduler (trên Master) đã thực hiện xong các bước Filtering (lọc node đủ tài nguyên) và Scoring (chọn node tối ưu nhất). Kết quả là Pod được đẩy về worker-2 thay vì worker-1.

  - Events: Nhìn vào khối Events, chúng ta thấy quy trình diễn ra cực nhanh. Chỉ mất 2.027 giây để kubelet kéo Image Nginx từ Registry

- Networking
  - IP: `10.244.1.4`: Đây là địa chỉ IP nội bộ của Pod. Dải IP này thuộc Subnet mà Flannel đã cấp phát riêng cho `k8s-worker-2`.

  - IPs: Việc chỉ hiển thị một IP duy nhất xác nhận Pod đang chạy trong chế độ Single-Stack IPv4, hoàn toàn khớp với việc bạn đã xử lý các vấn đề về IPv6 trước đó.

- Runtime Layer
  - Container ID: Bắt đầu bằng containerd://e8ad7.... Đây là định danh vật lý mà bạn có thể tìm thấy nếu gõ crictl ps trực tiếp trên máy k8s-worker-2.

  - Mounts: Pod tự động mount một Volume `kube-api-access-xj8kq`. Đây là nơi chứa Service Account Token, cho phép ứng dụng bên trong Pod (nếu cần) có thể thực hiện các cuộc gọi API ngược lại API Server một cách an toàn.

- Conditions
  - Toàn bộ các Conditions (Initialized, Ready,ContainersReady, PodScheduled) đều ở trạng thái True.

  - `Ready: True`: Xác nhận rằng không chỉ Container đã chạy, mà nó đã sẵn sàng để tiếp nhận Traffic. Tuy nhiên, do  chưa cấu hình Liveness hay Readiness Probe, nên K8s chỉ đơn giản kiểm tra xem tiến trình Nginx có đang tồn tại hay không.

Truy cập vào trong container và sửa file nội dung:

```
root@k8s-master:~# kubectl exec -it nginx-pod -n nginx-ns -- /bin/bash
root@nginx-pod:/# 
```
Sửa nội dung:
```
cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Default tittle</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(to right, #f8f8f8, #000000);
      color: #fff;
      animation: fadeIn 1.5s ease-in;
    }
    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
    .container {
      max-width: 800px;
      margin: 80px auto;
      background-color: rgba(255, 255, 255, 0.1);
      padding: 40px;
      box-shadow: 0 8px 20px rgba(255, 0, 0, 0.3);
      border-radius: 20px;
      backdrop-filter: blur(10px);
    }
    h1 {
      color: #06c422;
      text-shadow: 2px 2px 4px #000000;
    }
    p {
      line-height: 1.8;
      font-size: 18px;
      text-shadow: 1px 1px 2px #000000;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>Welcome to Nginx</h1>
    <p>Complete config Nginx using K8S</p>
EOFtml>>
```
Thoát
```
root@nginx-pod:/# exit
exit
```
Sử dụng service để expose port ra Internet
```
root@k8s-master:~# kubectl expose pod nginx-pod -n nginx-ns --port=80 --target-port=80 --type=NodePort
service/nginx-pod exposed
```
Kiểm tra:
```
root@k8s-master:~# kubectl get svc -n nginx-ns
NAME        TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
nginx-pod   NodePort   10.109.215.139   <none>        80:32323/TCP   34s
```
