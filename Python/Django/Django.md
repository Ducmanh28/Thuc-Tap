# Tổng quan về Django và Framework
Django là một ***framework*** bậc cao của Python có thể thúc đẩy việc phát triển phần mềm thần tốc và clean, thiết kế thực dụng. 

Được xây dựng bởi nhiều lập trình viên kinh nghiệm, Django tập trung lớn những vấn đề phát triển Web, bạn có thể phát triển trang web của bạn mà không cần xây dựng từ những căn bản. Đặc biệt nó *free* và *open source*.

***Framework*** là các đoạn code đã được viết sẵn, cấu thành nên một bộ khung và các thư viện lập trình được đóng gói. Chúng cung cấp các tính năng có sẵn như mô hình, API và các yếu tố khác để tối giản cho việc phát triển các ứng dụng web phong phú, năng động. Các framework giống như là chúng ta có khung nhà được làm sẵn nền móng cơ bản, bạn chỉ cần vào xây dựng và nội thất theo ý mình.

# Tính năng của Django
- **Là một Framework hoàn thiện**: Django được phát triển theo hệ tư tưởng "***Batteries included***" - có nghĩa là tích hợp toàn bộ. Nó sẽ cung cấp mọi thứ cho developer. giúp họ không phải nghĩ, không phải dùng thêm các nội dung ngoài. Mà thay vào đó chỉ cần tập trung phát triển sản phẩm, tất cả đều hoạt động liền mạch với nhau

- **Đa năng**: Django có thể được sử dụng để xây dựng hầu hết các loại website, từ hệ thống quản lý nội dung, cho đến các mạng xã hội hay web tin tức. Nó có thể làm việc với framework client-side và chuyển nội dung hầu hết sang các loại format(HTML, JSON, XML, RESS,...)

- **Bảo mật**: Django giúp các developer trong việc sửa các lỗi bảo mật thông thường bằng cách cung cấp các Framework có những kĩ thuật "Phải làm như vậy" để bảo vệ website.
  - ***Ví dụ***: Django cung cấp bảo mật quản lý tên tài khoản và mật khẩu, tránh các lỗi cơ bản như để thông tin session lên cookie, mã hóa mật khẩu thay vì lưu thẳng.

- **Dễ Scale**: Django sử dụng kiến trúc ***shared-nothing*** dựa vào ***component*** (mỗi phần của kiến trúc sẽ độc lập với nhau, và có thể thay thế hoặc sửa đổi nếu cần thiết). Có sự chia tách rõ ràng giữa các phần nghĩa là nó có thể scale cho việc gia tăng traffic bằng cách thêm phần cứng ở mỗi cấp độ: `caching`, `servers`, `database servers`, hoặc `application servers`. Nhiều web về kinh doanh đã thành công khi Django được scale đáp ứng yêu cầu của họ

- **Dễ maintain**: code Django được viết theo nguyên tắc thiết kế và pattern có thể khuyến khích ý tưởng bảo trì và tái sử dụng code. Trên thực tế, nó sự theo khái niệm "***Don't Repeat Yourself***" làm cho không có sự lặp lại không cần thiết, giảm một lượng code.

- **Tính linh động**: Django được viết bằng Python, nó có thể chạy đa nền tảng. Nó có nghĩa rằng bạn không ràng buộc một platform server cụ thể. Django được hỗ trợ tốt ở nhiều nhà cung cấp hosting, họ sẽ cung cấp hạ tầng và tài liệu cụ thể cho hosting web Django.

# Sự phổ biến của Django
Các trang web phổ biến sử dụng Django: Disqus, Instagram, Knight Foundation, MacArthur Foundation, Mozilla, National Geographic, Open Knowledge Foundation, Pinterest, and Open Stack

# Các thành phần của Django
Models: Nơi mà bạn tạo và quản lý cơ sở dữ liệu.

Views: Nơi xử lý các yêu cầu và trả về phản hồi.

Templates: Nơi sử dụng HTML với Django để tạo giao diện người dùng.

URLs: Nơi định tuyến URL trong ứng dụng Django.