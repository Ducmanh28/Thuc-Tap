# Mục này tìm hiểu về phần mềm PostMan, cách sử dụng nó

## PostMan là gì 
Hiểu đơn giản, PostMan là một App Extensions-một ứng dụng mã nguồn mở. 

PostMan là 1 công cụ mạnh mẽ để phát triển, kiểm thử và quản lý API.

PostMan cung cấp cho bạn giao diện đồ họa dễ sử dụng để gửi các yêu cầu HTTP và nhận phản hồi, giúp các nhà phát triển kiểm thử API một cách nhanh chóng mà không cần phải viết mã.

## Tại sao nên dùng PostMan
Post Man mang lại nhiều lợi ích, đặc biệt là trong quá trình phát triển và kiểm thử API
- PostMan cung cấp giao diện đồ họa dễ sử dụng, phù hợp cho cả người mới và chuyên gia
- Bạn có thể gửi đầy đủ các phương thức như: GET, POST, PUT, DELETE,... để thực hiện mọi thao tác với API
- PostMan hỗ trợ tích hợp các công cụ CI/CD (Các phương pháp, công cụ hỗ trợ tự động hóa) và cho phép lưu trữ các bộ sưu tập để chia sẻ
- Tính năng kiểm thử tự động giúp bạn nhanh chóng kiểm tra các trường hợp kiểm thử API mà không cần thực hiện thủ công

## Hướng dẫn sử dụng PostMan
### Cài đặt PostMan
Các bạn truy cập vào trang chủ PostMan

Lựa chọn phiên abanr phù hợp để tải xuống và cài đặt. 

### Màn hình chính của PostMan
![](/Anh/Screenshot_908.png)

Như các bạn có thể thấy, giao diện người dùng của PostMan khá thân thiện và dễ sử dụng
### Hướng dẫn tạo 1 Request
Trước khi tiến hành thao tác với dữ liệu qua PIM . Dữ liệu mẫu sẽ được lấy mẫu tại [đây](https://jsonplaceholder.typicode.com/users)

Sau khi Send, bạn sẽ nhận được response như ở dưới, đúng với nội dung dữ liệu trên trang web:

![](/Anh/Screenshot_910.png)

Lưu ý: Request bạn vừa thực hành ở trên là không an toàn, dữ liệu mở do server không yêu cầu xác thực. Nếu như bạn cố gắng truy cập đến 1 trang web dữ liệu được bảo mật nhưng bạn không có API Token để truy cập thì PostMan sẽ hiển thị lỗi như sau:

![](/Anh/Screenshot_911.png)

### Hướng dẫn làm việc với Request yêu cầu xác thực
Như các bạn cũng biết, khi sử dụng một ứng dụng nào đó thì chúng ta hay phải tạo một tài khoản để có thể đăng nhập vào ứng dụng đó.

Khi vào một trang web bán hàng chẳng hạn, khi bạn muốn thực hiện chức năng thêm vào giỏ hàng thì yêu cầu bạn phải đăng nhập mới có thể thực hiện chức năng đó. Đúng vậy có những chắc năng mà bạn phải đăng nhập mới có thể thưc hiện được.

Để có thể test một chức năng trên postman mà yêu cầu bạn phải đăng nhập thì postman cho phép bạn truyền lên header của nó một biến Authorization có value là dạng chuối mã hóa Base64. Giá trị này chính là giá trị access_token của user khi user đó đăng nhập vào hệ thống.

Thực hiện test thử:
- Trước tiên chúng ta thêm đường dẫn tới API NetBox như bình thường: `https://www.netboxlab.local/api/?format=json`
- Sau đó, chúng ta cấu hình ở mục `Authorization` như sau:
  - Chọn kiểu Auth Type là **API Key** 
  - Nhập Key là: `Authorization`
  - Value: `Token  <Token....>`
  - Add to: Header

![](/Anh/Screenshot_912.png)
- Cuối cùng, chúng ta được kết quả của trang web như sau:

![](/Anh/Screenshot_913.png)

