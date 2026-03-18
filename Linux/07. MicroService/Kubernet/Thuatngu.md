# Tổng hợp các thuật ngữ, khái niệm, thành phần liên quan đến Kubernet
## 1. Nhóm Kiến trúc & Hạ tầng (Cluster Architecture)
Đây là khung xương của hệ thống, bao gồm các thành phần điều khiển và thực thi.
- **Cluster**: Tập hợp toàn bộ các máy (Nodes) được quản lý bởi Kubernetes.
- **Control Plane**: "Bộ não" quản lý trạng thái của cụm (gồm API Server, etcd, Scheduler, Controller Manager).
- **Node** (Worker Node): Máy vật lý hoặc máy ảo nơi ứng dụng thực sự chạy.
- **Kubelet**: Agent chạy trên từng Node để giao tiếp với Control Plane.
- **Kube-proxy**: Thành phần quản lý mạng trên từng Node.
- **Container Runtime**: Phần mềm chạy container (như containerd hoặc CRI-O).

## 2. Nhóm Đối tượng Workload (Workload Objects)
Các thành phần này định nghĩa cách ứng dụng của bạn chạy.
|**Thuật ngữ**|**Ý nghĩa**|
|---|---|
|Pod|Đơn vị nhỏ nhất, chứa một hoặc nhiều container.|
|Deployment|Quản lý việc triển khai và cập nhật ứng dụng (Stateless).|
|StatefulSet|Dành cho các ứng dụng cần định danh và lưu trữ cố định (Database).|
|DaemonSet|Đảm bảo mỗi Node trong cụm đều chạy một bản sao của Pod (Logging, Monitoring).|
|Job / CronJob|Chạy các tác vụ ngắn hạn hoặc theo lịch trình.|
|ReplicaSet|Đảm bảo số lượng bản sao Pod luôn đúng như mong muốn.|
## 3. Nhóm Mạng & Dịch vụ (Networking & Services)
Cách các thành phần liên lạc với nhau và với thế giới bên ngoài.
- **Service** (Svc): Một cách trừu tượng để lộ ứng dụng chạy trên một bộ Pods dưới dạng một dịch vụ mạng.
- **ClusterIP**: Chỉ truy cập nội bộ.
- **NodePort**: Mở cổng trên mỗi Node để truy cập từ ngoài.
- **LoadBalancer**: Sử dụng bộ cân bằng tải của nhà cung cấp Cloud.
- **Ingress**: Quản lý truy cập bên ngoài vào các Service (thường là HTTP/HTTPS), hỗ trợ định tuyến theo URL.
- **Ingress Controller**: Thành phần thực thi các quy tắc Ingress (ví dụ: Nginx Ingress Controller).
- **Endpoint / EndpointSlice**: Danh sách các IP của Pod mà Service hướng tới.
- **Network Policy**: Các quy tắc bảo mật điều phối luồng traffic giữa các Pod (rất quan trọng cho CKS).
## 4. Nhóm Lưu trữ (Storage)
Quản lý dữ liệu bền vững (Persistence).
- **Volume**: Thư mục chứa dữ liệu có thể truy cập bởi các container trong Pod.
- **PersistentVolume** (PV): Tài nguyên lưu trữ trong cụm được Admin cấu hình sẵn.
- **PersistentVolumeClaim** (PVC): Yêu cầu của người dùng về tài nguyên lưu trữ (như "tôi cần 10GB").
- **StorageClass**: Cho phép tự động tạo PV (Dynamic Provisioning) dựa trên yêu cầu của PVC.

## 5. Nhóm Cấu hình & Bảo mật (Config & Security)
Nơi lưu trữ các biến môi trường và thiết lập an toàn.
- **ConfigMap**: Lưu trữ cấu hình không nhạy cảm (file config, env vars).
- **Secret**: Lưu trữ dữ liệu nhạy cảm (passwords, tokens, keys) dưới dạng base64.
- **ServiceAccount (SA)**: Định danh cho các tiến trình chạy trong Pod để giao tiếp với API Server.
- **RBAC (Role-Based Access Control)**: Kiểm soát quyền truy cập dựa trên vai trò.
- **Role / ClusterRole**: Định nghĩa các quyền (được làm gì).
- **RoleBinding / ClusterRoleBinding**: Gán quyền cho User hoặc ServiceAccount.
- **Admission Controller**: Các plugin can thiệp vào quá trình gửi request tới API Server (như quét bảo mật, gán giá trị mặc định).

## 6. Nhóm Quản lý tài nguyên & Lập lịch (Scheduling & Management)
Cách K8s quyết định Pod sẽ chạy ở đâu và như thế nào.
- **Namespace**: Cách chia nhỏ cụm vật lý thành các cụm ảo để quản lý (ví dụ: dev, staging, prod).
- **Label & Selector**: Cặp Key-Value dùng để đánh dấu và lọc các đối tượng.
- **Annotation**: Ghi chú thêm thông tin cho đối tượng (không dùng để lọc).
- **Resource Quota**: Giới hạn tổng tài nguyên một Namespace có thể dùng
- **LimitRange**: Giới hạn tài nguyên tối thiểu/tối đa cho từng Pod/Container.
- **Taints & Tolerations**: Ngăn chặn Pod chạy trên các Node nhất định trừ khi có sự cho phép đặc biệt.
- **Node Affinity**: Ưu tiên hoặc bắt buộc Pod phải chạy trên một nhóm Node nhất định.

## 7. Nhóm Công cụ mở rộng (Ecosystem & Tools)
- **Kubectl**: Công cụ dòng lệnh chính để tương tác với K8s.
- **Helm**: Trình quản lý gói (Package Manager) cho Kubernetes (giống như apt hay yum).
- **Kustomize**: Công cụ tùy chỉnh cấu hình YAML mà không cần dùng template.
- **CRD (Custom Resource Definition)**: Cho phép bạn tự định nghĩa các đối tượng mới cho Kubernetes.
- **Operator**: Một phương thức đóng gói, triển khai và quản lý ứng dụng Kubernetes bằng cách kết hợp CRD và Custom Controller.
