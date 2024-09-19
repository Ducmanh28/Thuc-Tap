# Mục này tìm hiểu API trong NetBox
API là một phần quan trọng trong hệ thống NetBox, cho phép người dùng tương tác với NetBox thông qua các yêu cầu http mà không cần sử dụng giao diện người dùng trực quan. 
## Cơ chế API của NetBox
NetBox sử dụng API RESTful - một loại API phổ biến trong thiết kế hệ thống và giao tiếp giữa các ứng dụng. 
### Một số đặc điểm
REST (Representational State Transfer) là một phong cách kiến trúc cho thiết kế dịch vụ web. RESTful API hoạt động dựa trên các phương thức HTTP tiêu chuẩn (GET, POST, PUT, DELETE) để thực hiện các thao tác CRUD trên các tài nguyên.

- Stateless: Mỗi yêu cầu từ client đến server phải chứa tất cả các thông tin cần thiết để thực hiện yêu cầu. Server không lưu trạng thái của client giữa các yêu cầu.
- Client-Server Architecture: Tách biệt client và server, cho phép phát triển và mở rộng dễ dàng
- Cacheable: Các phản hồi từ server có thể được cache để giảm tải cho server và tăng hiệu suất
- Layered System: Kiến trúc có thể bao gồm nhiều lớp, giúp tăng tính bảo mật và khả năng mở rộng

### Tại sao NetBox chọn API RESTful mà không chọn các loại API khác ?
- Tính đơn giản: RESTful API dễ hiểu và dễ triển khai, nhờ vào việc sử dụng các phương thức HTTP tiêu chuẩn và giao thức JSON/XML cho dữ liệu
- Khả năng mở rộng: Kiến trúc RESTful hỗ trợ khả năng mở rộng tốt, cho phép NetBox dễ dàng thêm các tính năng mới hoặc thay đổi mà không làm gián đoạn dịch vụ hiện tại.
- Tính Tương Thích: RESTful API tương thích với nhiều công cụ và thư viện khác nhau, giúp dễ dàng tích hợp với các hệ thống khác.
- Hiệu Suất: Bằng cách sử dụng các phương thức HTTP cơ bản và cache, API RESTful có thể đạt hiệu suất cao và giảm tải cho server.

- SOAP thường phức tạp hơn và yêu cầu băng thông lớn hơn so với RESTful, không phù hợp với môi trường yêu cầu đơn giản và nhẹ nhàng như NetBox.
-  RESTful API đã đủ đáp ứng nhu cầu của NetBox và dễ triển khai hơn, trong khi GraphQL có thể thêm độ phức tạp không cần thiết


## Sử dụng
### Địa chỉ API: 
Thường là `URL/api/...` 

Ví dụ: http://netboxlab.local/api
### Xác thực 
API NetBox sử dụng xác thực Token. Token cần được gửi trong header `Authorization`

Token có thể được tạo trong giao diện NetBox

### Một số EndPoint chính
Devices: /api/dcim/devices/ - Quản lý các thiết bị.

Device Types: /api/dcim/device-types/ - Quản lý các loại thiết bị.

Sites: /api/dcim/sites/ - Quản lý các site.

Racks: /api/dcim/racks/ - Quản lý các rack.

Cables: /api/dcim/cables/ - Quản lý các cable.

IP Addresses: /api/ipam/ip-addresses/ - Quản lý các địa chỉ IP.

### Cấu trúc sử dụng
GET: Lấy dữ liệu từ server.

POST: Tạo dữ liệu mới trên server.

PUT/PATCH: Cập nhật dữ liệu hiện có trên server.

DELETE: Xóa dữ liệu trên server.

### Test API
Đường dẫn để test sẽ nằm ở: `https://<URL NETBOX>/api/schema/swagger-ui/`

![](/Anh/Screenshot_898.png)

Mọi chức năng liên quan đến các thành phần trong NetBox đều có thể test ở đây

