# XÂY DỰNG CLOUD MANAGEMENT PORTAL TRÊN KUBERNETES
## Mô tả
Xây dựng và triển khai 1 trang web quản lý sử dụng Kubernets

Hệ thống:
- `172.16.66.82`: K8S Master
- `172.16.66.83`: K8S Worker 1
- `172.16.66.84`: K8S Worker 2

Cấu hình:
- Backend: Python
- Frontend: HTML, CSS, JavaScripts
- Database: MySQL
- TruthData: NetBox
- Auth: JWT
- WebServer: Nginx
- API: RestFull API
- Runtime: Containerd
- Deploy: Kubernets

## Mục tiêu
Xây dựng được 1 trang web hỗ trợ người dùng và ADMIN có thể kiểm soát, quản lý các Server, Thiết bị, VM,... dựa trên nguồn dữ liệu thực từ NetBox
- User có thể thao tác với máy chủ, nắm được các thông tin về máy chủ của mình
- Admin trực tiếp quản lý toàn bộ hệ thống bao gồm xem, quản lý các thông tin liên quan đến người dùng, thiết bị, vm,...
- Tất các các sự thay đổi trên hệ thống đều sẽ được ghi logs và gửi cảnh báo về 1 ứng dụng tin nhắn như: Telegram

Trang Web được triển khai hoàn toàn trên K8S. Được đóng gói và container hóa để dễ dàng triển khai và nâng cấp, mở rộng cũng như đảm bảo về các vấn đề bảo mật