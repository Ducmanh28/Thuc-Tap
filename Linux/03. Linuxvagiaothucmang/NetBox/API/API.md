# Mục này tìm hiểu về API và API trong Netbox
## API là gì?
API (Application Programming Interface) là một tập hợp các giao thức, công cụ, và định nghĩa cho việc xây dựng và tích hợp phần mềm ứng dụng. API cho phép các phần mềm giao tiếp với nhau, giúp ứng dụng này có thể sử dụng chức năng của ứng dụng khác một cách an toàn và có kiểm soát mà không cần phải hiểu chi tiết về cách hoạt động bên trong của nó.

Đơn giản hơn, API là một cầu nối giữa 2 ứng dụng. Đóng vai trò làm trung gian giúp 2 ứng dụng giao tiếp với nhau. Ví dụ, A muốn giao tiếp với C thì phải thông qua B. Ở đây, B chính là API

[](/Anh/Screenshot_894.png)

## API dùng để làm gì?
API được dùng để kết nối các hệ thống khác nhau, giúp chúng chia sẻ dữ liệu và dịch vụ. 

Ví dụ, một ứng dụng di động có thể sử dụng API của một dịch vụ thời tiết để hiển thị thông tin thời tiết cho người dùng mà không cần phải tự xây dựng cơ sở dữ liệu thời tiết.

## Cấu tạo của API
API thường được cấu thành bởi:

- Giao thức: Quy tắc giao tiếp giữa các ứng dụng, thường là HTTP/HTTPS.
- Endpoint: URL mà các yêu cầu được gửi tới.
- Request: Yêu cầu từ một ứng dụng gửi đến API, bao gồm thông tin cần thiết như phương thức HTTP (GET, POST, PUT, DELETE) và dữ liệu cần truyền tải.
- Response: Phản hồi từ API, chứa dữ liệu mà ứng dụng yêu cầu.
## Cơ chế hoạt động của API
API hoạt động dựa trên mô hình yêu cầu-đáp ứng (request-response):

- Client gửi một yêu cầu tới API bằng cách gọi một endpoint cụ thể.
- Server xử lý yêu cầu, truy xuất dữ liệu hoặc thực hiện hành động và trả về một phản hồi cho client.

[](/Anh/Screenshot_895.png)

## Khi nào sử dụng API trong thực tế?
API được sử dụng khi:

- Cần kết nối các hệ thống hoặc dịch vụ khác nhau.
- Muốn truy cập dữ liệu hoặc chức năng của một ứng dụng khác mà không cần xây dựng từ đầu.
- Xây dựng các ứng dụng phức tạp có nhiều thành phần hoặc microservices.
## Một số thuật ngữ trong API
HTTP Methods: Các giao thức HTTP phổ biến trong API:
- GET: Lấy dữ liệu
- POST: Gửi dữ liệu
- PUT: Cập nhật dữ liệu hiện có trên Server
- DELETE: Xóa dữ liệu

Status Code: Mã trạng thái HTTP:
- 200 OK: Yêu cầu thành công
- 404 Not Found: Không tìm thấy tài nguyên
- 500 Interal Server Error: Lỗi từ phía Server

Headers: Các thông tin bổ sung gửi kèm yêu cầu hoặc phản hồi, như kiểu nội dung (Content-Type), xác thực (Authorization), hoặc thông tin định dạng dữ liệu.

Payload/Body: Phần dữ liệu chính gửi trong yêu cầu hoặc phản hồi, thường chứa thông tin JSON hoặc XML.

API Key: Chuỗi mã bảo mật được sử dụng để xác thực người dùng và bảo vệ API khỏi truy cập trái phép.

Rate Limiting: Hạn chế số lượng yêu cầu mà client có thể gửi đến API trong một khoảng thời gian nhất định để tránh quá tải.

Authentication: Quá trình xác thực người dùng khi truy cập API, có thể qua API Key, OAuth, JWT, Basic Auth, v.v.

Versioning: Quản lý các phiên bản khác nhau của API để đảm bảo tính tương thích khi có thay đổi hoặc cập nhật.

REST (Representational State Transfer): Kiến trúc API phổ biến, dựa trên các phương thức HTTP và sử dụng URL để đại diện tài nguyên.

SOAP (Simple Object Access Protocol): Giao thức API sử dụng XML để truyền tải dữ liệu, phức tạp và bảo mật cao hơn REST.

JSON (JavaScript Object Notation): Định dạng dữ liệu nhẹ, dễ đọc và phổ biến khi trao đổi dữ liệu trong API.

Webhooks: Hình thức gửi dữ liệu tự động từ server đến client khi có sự kiện nhất định, khác với mô hình request-response truyền thống của API.
## Các ứng dụng giống API
Một số ứng dụng tương tự API:

- Webhooks: Tương tự API, nhưng thay vì client gửi yêu cầu, server tự động gửi thông báo đến client khi có sự kiện.
- RPC (Remote Procedure Call): Cho phép gọi hàm từ xa trên một hệ thống khác, nhưng thường ít phổ biến hơn API hiện đại.
## Tại sao sử dụng API mà không dùng cái khác?
API được sử dụng vì tính linh hoạt, khả năng mở rộng, và sự tiêu chuẩn hóa, giúp dễ dàng tích hợp giữa các hệ thống khác nhau mà không cần tái xây dựng.

## Ưu nhược điểm của API
Ưu điểm:

- Tính mô-đun: Cho phép tái sử dụng chức năng của hệ thống khác.
- Tính mở rộng: Dễ dàng tích hợp với các hệ thống mới.
- Bảo mật: Quyền truy cập có thể được kiểm soát thông qua API.

Nhược điểm:
- Phụ thuộc: Hệ thống có thể phụ thuộc vào API của bên thứ ba.
- Độ phức tạp: Cần quản lý phiên bản và duy trì tính tương thích khi API thay đổi.
