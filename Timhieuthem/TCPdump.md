# Mục này tìm hiểu về tcpdump
Nếu như bạn sử dụng các phiên bản của hệ điều hành Unix/Linux, `tcpdump` sẽ là công cụ giúp bạn kiểm tra lưu lượng mạng và lưu lại những gói tin bắt được.

## TCPdump là gì?
Là công cụ hỗ trợ phân tích các gói dữ liệu mạng theo dòng lệnh.

Cho phép người sử dụng chặn và lọc các gói tin TCP/IP được truyền đi hoặc được nhận trên một mạng mà máy tính có tham gia.

Tcpdump sẽ lưu lại những gói tin đã bắt được, sau đó sẽ được dùng để phân tích

==> Nôm na hiểu đơn giản thì Tcpdump là một công cụ dò mạng, có vai trò trong việc gỡ rối và kiểm tra các vấn đề liên quan đến bảo mật và kết nối mạng

## TCPdump có thể được dùng để làm những gì?
- Kiểm tra và ghi lại lưu lượng mạng để phát hiện sự cố mạng
- Phân tích lưu lượng mạng để xác định vấn đề bảo mật hoặc hiệu suất
- Giám sát và kiểm tra hiệu suất mạng
- Điều tra và phân tích giao thức mạng

## Tcpdump cấu trúc như thế nào?
Thường được triển khai dưới dạng một ứng dụng dòng lệnh.
- Giao diện dòng lệnh: Cung cấp cho người dùng cú pháp và tùy chọn để chỉ định các yêu cầu cụ thể
- Bộ lọc: Cho phép người dùng lọc và chỉ định loại lưu lượng mạng cụ thể mà họ muốn theo dõi
- Giao diện lập trình ứng dụng(API): Cung cấp khả năng tích hợp TCPdump vào các ứng dụng mạng khác

