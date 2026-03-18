# Mục này tìm hiểu về Kubernet
## 1. Khái niệm
### Khái niệm cơ bản
Kubernet(K8s) là một nền tảng điều phối container mã nguồn mở, hoạt động như 1 hệ điều hành cho đám mây giúp quản lý và vận hành các containerized applications trên nhiều máy chủ trong cùng 1 Kubernets cluster.

Mục tiêu chính của Kubernets là tự động hóa toàn bộ vòng đời của các ứng dụng container hóa, bao gồm các việc như triển khai, mở rộng quy mô, phục hồi lỗi, khám phá dịch vụ và cân bằng tải.

Hiểu đơn giản: Kubernet như một "hệ điều hành" chạy trên nhiều máy chủ, giúp bạn quản lý các ứng dụng dễ dàng hơn.

Không chỉ là một công cụ, Kubernetes là một hệ sinh thái hoàn chỉnh (ecosystem), cung cấp framework vững chắc cho việc triển khai, vận hành và quản lý hệ thống phân tán (distributed systems) ở quy mô lớn, với khả năng linh hoạt, phục hồi và mở rộng theo nhu cầu cơ bản và chuyên biệt của doanh nghiệp.



## 2. Kiến trúc của kubernet
Mẫu kiến trúc của Kubernet có thể trông như sau:
![Kiến trúc Kubernet](/Anh/Screenshot_127.png)

Kiến trúc này bao gồm 2 phần chính: Control Plane và Worker Node.
- Control Plane chịu trách nhiệm quản lý, điều phối và duy trì trạng thái mong muốn của toàn bộ cluster. Trong Control Plane bao gồm 5 thành phần:
  - **API Server**: Là "cửa ngõ" giao tiếp. Mọi yêu cầu từ người dùng (Client qua kubectl) hoặc từ các thành phần khác đều phải đi qua đây. Nó kiểm tra tính hợp lệ và thực hiện các thay đổi.
  - **Etcd**: Là một cơ sở dữ liệu dạng Key-Value lưu trữ toàn bộ dữ liệu cấu hình và trạng thái của cluster.
  - **Schedule**: có nhiệm vụ quan sát các Pod mới tạo nhưng chưa được gán vào node nào. Nó sẽ dựa vào tài nguyên (CPU, RAM) để chọn Node phù hợp nhất để chạy Pod đó
  - **Controller Manager** (kube-controller-manager): Chạy các tiến trình nền để duy trì trạng thái mong muốn của cluster. Ví dụ: nếu một Pod bị chết, Node Controller sẽ nhận ra và yêu cầu tạo lại Pod mới để thay thế.
  - **Cloud Controller Manager**: Thành phần này cho phép Kubernetes liên kết với các nhà cung cấp dịch vụ đám mây (như AWS, Google Cloud, Azure) để quản lý các tài nguyên như Load Balancer hoặc Storage từ nhà cung cấp đó.
- Worker Node là nơi các ứng dụng container được triển khai và vận hành thực tế. Nó bao gồm 4 thành phần
  - **Kubelet**: Là một "đại lý" (agent) chạy trên mỗi node. Nó đảm bảo các container được chạy trong Pod theo đúng mô tả từ Control Plane. Nếu container gặp sự cố, Kubelet sẽ cố gắng khởi động lại chúng.
  - **K-proxy** (kube-proxy): Quản lý mạng (networking) cho node. Nó cho phép các Pod liên lạc với nhau và cho phép các yêu cầu từ bên ngoài có thể truy cập vào các dịch vụ bên trong cluster.
  - **Container Runtime**: Phần mềm chịu trách nhiệm chạy các container (ví dụ: Docker, containerd, CRI-O).
  - **Pod**: Một Pod có thể chứa một hoặc nhiều container (như Container A, Container B trong ảnh). Các container trong cùng một Pod sẽ chia sẻ chung tài nguyên mạng và lưu trữ.

**Quy trình hoạt động:**

Hãy tưởng tượng bạn (Client) muốn chạy một ứng dụng web:
- **Gửi yêu cầu**: Bạn dùng lệnh kubectl gửi một bản thiết kế (file YAML) đến API Server.
- **Lưu trữ**: API Server kiểm tra và lưu cấu hình này vào Etcd.
- **Lập lịch**: Scheduler nhận thấy có yêu cầu chạy Pod mới và tìm xem Node A hay Node B còn trống tài nguyên. Giả sử nó chọn Node A.
- **Triển khai**: API Server thông báo cho Kubelet trên Node A. Kubelet yêu cầu Container Runtime tải image ứng dụng về và khởi chạy các container bên trong Pod.
- **Kết nối**: K-proxy thiết lập các quy tắc mạng để đảm bảo người dùng có thể truy cập được vào ứng dụng vừa chạy.
- **Giám sát**: Controller Manager liên tục kiểm tra. Nếu Node A bị hỏng, nó sẽ ra lệnh cho Scheduler chuyển các Pod đó sang Node B để đảm bảo ứng dụng không bị gián đoạn.

## 3. Các chức năng chính
### Dịch vụ cân bằng tải
Kubernetes (K8s) có thể công khai (expose) một container thông qua DNS hoặc địa chỉ IP nội bộ. Khi lưu lượng truy cập tăng cao, K8s tự động thực hiện cân bằng tải (load balancing) để phân phối lưu lượng giữa các Pod, đảm bảo hệ thống hoạt động ổn định và sẵn sàng.

### Điều phối lưu trữ
Kubernetes (K8s) hỗ trợ tự động gắn kết nhiều loại hệ thống lưu trữ, từ ổ đĩa cục bộ (local storage), dịch vụ lưu trữ của các nhà cung cấp đám mây công cộng (AWS EBS, GCP Persistent Disk, Azure Disk), cho đến các giải pháp lưu trữ triển khai trên hạ tầng cloud server. 

### Tự động triển khai và hoàn nguyên
Kubernetes (K8s) sẽ tự động điều phối và điều chỉnh trạng thái thực tế để khớp với trạng thái đó, với tốc độ và cơ chế cập nhật có thể kiểm soát được chỉ bằng việc khai báo trạng thái mong muốn của hệ thống.

### Tối ưu hóa phân bổ tài nguyên
Kubernetes sẽ tự động lập lịch (scheduling) và phân bổ container vào các node phù hợp, nhằm tối ưu hóa việc sử dụng tài nguyên của toàn bộ hệ thống bằng việc cung cấp cho Kubernetes (K8s) một cụm các node và định nghĩa yêu cầu tài nguyên như CPU và bộ nhớ (RAM) cho từng container.

### Tự động hồi phục
Kubernetes có khả năng tự động khởi động lại các container gặp sự cố, thay thế container khi cần, loại bỏ những container không phản hồi và chỉ phân phối (expose) các container ở trạng thái sẵn sàng đến client.

### Quản lý cấu hình và thông tin nhạy cảm
Kubernetes cho phép lưu trữ và quản lý các thông tin nhạy cảm như mật khẩu, token OAuth hay khóa SSH dưới dạng Secrets. Bạn có thể triển khai hoặc cập nhật dữ liệu nhạy cảm và cấu hình ứng dụng mà không cần rebuild lại container image, đồng thời tránh làm lộ thông tin trong cấu hình hệ thống (stack configuration).

### Xử lý theo lô
Ngoài các chức năng cốt lõi, Kubernetes còn hỗ trợ quản lý các tác vụ xử lý theo lô (batch jobs) và quy trình CI/CD (Continuous Integration/Continuous Deployment), đồng thời có khả năng thay thế các container gặp sự cố khi cần thiết để đảm bảo hệ thống ổn định.

### Tự động mở rộng ngang
Kubernetes (K8s) cho phép mở rộng hoặc thu hẹp số lượng container một cách linh hoạt thông qua dòng lệnh (kubectl), giao diện người dùng (UI), hoặc tự động dựa trên mức sử dụng tài nguyên như CPU và RAM (Horizontal Pod Autoscaler).

### Hỗ trợ dual stack IPv4/IPv6
K8s cấp phát địa chỉ IPv4, IPv6 cho Pod và Service.

### Thiết kế mở rộng
Thêm các tính năng vào Kubernetes Cluster mà không cần thay đổi mã nguồn gốc (upstream).

