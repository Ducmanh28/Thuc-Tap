# Tầng Ứng Dụng
## 1. Tổng quan về tầng ứng dụng
### 1.1. Định nghĩa, vai trò
- Tầng Ứng dụng là tầng thứ bảy trong mô hình OSI
- Có vai trò tiếp nhận, cung cấp thông tin trực tiếp tới người dùng
- Thông qua các phần mềm, dịch vụ, giao thức --> giúp người dùng truy nhập thông tin dữ liệu trên mạng

### 1.2. Chức năng

Tạo điều kiện giao tiếp giữa các ứng dụng trên các hệ thống máy tính với nhau
+ Giúp cho thiết bị có thể nhận dạng, truy cập và sẵn sàng chấp nhận dữ liệu một cách chính xác
+ Chịu trách nhiệm thỏa thuận ở 2 đầu để đảm bảo tính toàn vẹn dữ liệu, quyền riêng tư hay quy trình khôi phục lỗi
+ Nâng cao tính bảo mật bằng cách cho phép xác thực giữa các thiết bị
+ Xác định quy tắc cú pháp trong giao thức hiển thị ở cấp ứng dụng
+ Hiển thị, trình bày dữ liệu ở đầu nhận lên ứng dụng của người dùng
+ Có 2 kiểu ứng dụng cho phép quyền truy cập vào mạng:
    + Ứng dụng nhận biết mạng: email, ...
    + Các dịch vụ cung cấp ứng dụng: truyền file hoặc bộ đệm in
### 1.3 Dịch vụ
- Cho phép người dùng đăng nhập từ xa
- Truy cập, quản lý tệp bên trong thiết bị
- Xác định địa chỉ
- Dịch vụ thư
### 1.4 Nguyên tắc của các ứng dụng mạng:
Cốt lõi của phát triển ứng dụng mạng là viết các chương trình chạy trên các hệ thống đầu cuối khác nhau và sử dụng mạng để liên lạc
![Alt text](/Anh/image1.png)
Mạng máy tính được chia ra làm các mô hình mạng khác nhau như: mạng ngang hàng(Peer to Peer), mạng khách - chủ(Client - Server) và mạng theo mô hình lai(Hybrid)
+ Mô hình ngang hàng(**Peer to peer**): 
    + Tất cả các máy đều là máy chủ, đồng thời cũng là máy khách
    + Các máy trên mạng chia sẻ tài nguyên không phụ thuộc vào nhau
    + Không có quá trình đăng nhập tập trung, nếu đã đăng nhập vào mạng --> có thể sử dụng tất cả tài nguyên(nhưng phải có mật khẩu của người chia sẻ)
+ Mô hình khách - chủ(**Client - Server**): Yêu cầu được gửi từ Client --> Máy chủ. Sau đó Server sẽ đáp ứng các yêu cầu đó. Sau khi thực hiện xong, Server sẽ trở về trạng thái chờ yêu cầu khác. Quá trình xử lý được phân tán trên 3 lớp:
    + Lớp khách(**Clients**): cung cấp dịch vụ trình bày, giao tiếp người dùng với lớp giao dịch thông qua trình duyệt hay các trình ứng dụng để thao tác và xử lý dữ liệu. VD: Chrome, Internet Explorer
    + Lớp giao dịch(**Business**): cung cấp các dịch vụ quản lý, tổ chức, và khai thác cơ sở dữ liệu. Các componenet trước đây được cài đặt trên lớp khách, nay lại được cài trong lớp giao dịch. VD: Khách đặt mua hàng-->Lớp giao dịch kiểm tra mã để quyết định bán hay không ?
    + Lớp nguồn dữ liệu(**Data Source**): cung cấp các dịch vụ tổ chức và lưu trữ các hệ cơ sở dữ liệu quan hệ. Sẵn sàng cung cấp dữ liệu cho lớp giao dịch. Đặc trưng: SQL
+ Mô hình lai(**Hybrid**): 
    + Là mô hình kết hợp giữa 2 mô hình trên
    + Phần lớn các mạng máy tính trên thực tế thuộc mô hình này
## 2. Các lớp con
Tầng Ứng dụng được phát triển với 2 lớp con 
### 2.1. Common Application Server Element (**CASE**)
- Lớp này có nhiệm vụ điều khiển từ xa và truyền dữ liệu 
- Bằng cách cung cấp cách cung cấp các dịch vụ cho Lớp Ứng dụng và yêu cầu các dịch vụ từ lớp Phiên --> Các dịch vụ **CASE** được áp dụng cho các yêu cầu khác nhau
### 2.2. Specific Application Server Element (**SASE**)
- Có nhiệm vụ cung cấp các dịch vụ dành riêng cho ứng dụng
- VD: Truyền tệp, truy cập cơ sở dữ liệu từ xa, thông tin quản lý ứng dụng và xử lý giao dịch
## 3. Các giao thức phổ biến
### 3.1. Giao thức FTP
![Alt text](/Anh/image.png)
#### 3.1.1 Giao thức FTP là gì?
- Giao thức **FTP**(File Transfer Protocol) là một giao thức truyền tải tập tin từ máy này sang máy khác thông qua mạng. 
- Người sử dụng có thể truyền tải dữ liệu như hình ảnh, văn bản, các tập tin nhạc, video,... từ máy tính cá nhân lên máy chủ đặt ở 1 nơi khác 1 cách dễ dàng.
- Nó cũng dùng để truyền tải dữ liệu web lên máy chủ cho dù máy chủ ở rất xa
#### 3.1.2 Chức năng
- Đảm bảo việc chia sẻ tập tin trên môi trường mạng
- Truyền dữ liệu hiệu quả và đáng tin cậy
#### 3.1.3 Cách FTP hoạt động
Dựa trên 2 tiến trình cơ bản, xảy ra giữa `Client FTP - Server FTP`
- Control connection: Được hiểu là kiểm soát kết nối. Tiến trình này cho phép thực hiện công việc giám sát dữ liệu khi đi qua và trong suốt quá trình trao đổi
- Data connection: Thực hiện kết nối dữ liệu qua lại giữa máy chủ và máy khách(chỉ dừng lại khi nhiệm vụ hoàn tất)
#### 3.1.4 Các phương thức truyền

|Vai trò|Ý nghĩa |
|-------|--------| 
|ahahdahd|àlasjfkjf|
