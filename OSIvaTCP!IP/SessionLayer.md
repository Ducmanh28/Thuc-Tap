# Tầng Phiên
MỤC LỤC
- [1. Tầng phiên là gì](#1-tầng-phiên-là-gì)
- [2. Nhiệm vụ của lớp phiên](#2-nhiệm-vụ-của-lớp-phiên)
- [3. Chức năng](#3-chức-năng)
- [4. Cách lớp phiên hoạt động](#4-cách-lớp-phiên-hoạt-động)
- [5. Một số giao thức dùng trong lớp phiên](#5-một-số-giao-thức-sử-dụng-trong-lớp-session)
## 1. Tầng phiên là gì
- Là phân lớp thứ 5 trong mô hình OSI
- Là 1 trong 3 phân lớp nhỏ của Tầng Application trong mô hình TCP/IP
- Là lớp quan trọng trong mô hình OSI
- là 1 bộ điều khiển hộp thoại
- Chủ yếu xác định cách bắt đầu, điều khiển và kết thúc cuộc hội thoại giữa các hệ thống giao tiếp
- Các luồng dữ liệu được đánh dấu và đồng bộ hóa đúng cách để các phần cuối của thông báo khi được đánh dấu không bị cắt sớm hay mất mát dữ liệu
- Đáp ứng yêu cầu của lớp Presentation và gửi các yêu cầu cho lớp Session

==> Tóm lại hiểu nôm na khi chúng ta lướt web và tảo ra nhiều tabs để mỗi tab là 1 việc thì tầng phiên là tầng đảm bảo cho các tabs ổn định và phân chia lưu lượng mạng đều
## 2. Nhiệm vụ của lớp phiên
- Kiểm soát hội thoại, cho phép hai hệ thống giao tiếp với nhau ở chế độ bán song công hoặc song công
- Quản lý mã thông báo, ngăn cho 2 bên thực hiện cùng một hoạt động quan trọng cùng 1 lúc
- Đồng bộ hóa, cho phép một quy trình thêm các điểm kiểm tra được coi là điểm đồng bộ hóa và dữ liệu
- cho phép người dùng trên các máy tính khác nhau thiết lập các phiên giao tiếp tích cực giữa chúng

## 3. Chức năng:
- Kiểm soát hội thoại: Cho phép 2 thực thể(tiến trình) cùng tham gia vào 1 cuộc hộ thoại. Nó cho phép truyền thông giữa 2 tiến trình được thực hiện theo chế độ half-duplex hoặc full-duplex
- Đồng bộ hóa: Cho phép 1 tiến trình thêm các mốc(Gọi là điểm đồng bộ - synchronization point) vào luồng dữ liệu
![Alt text](/Anh/image8.png)
- VD: Nếu 1 hệ thống cần gửi 1 file txt 1000, cứ sau 100 trang sẽ chèn các điểm đồng bộ  --> nhận từng cụm 100 trang sẽ được thực hiện độc lập
- Gỉa sử khi chuyền tới trang 529 bỗng bị hỏng --> Việc truyền lại sẽ bắt đầu từ 501 chứ không phải truyền lại từ  01

## 4. Cách lớp phiên hoạt động
![Alt text](/Anh/image7.png)
- Một kết nối được thiết lập và duy trì trong khi 2 ứng dụng giao tiếp với nhau trong 1 cuộc trò chuyện hoặc 1 phiên trong 1 khoảng thời gian nhất định. Lớp phiên xây dựng cầu nối giúp 2 bên nói chuyện được lâu dài
- Khi giao tiếp giữa các ứng dụng hoàn tất, các dịch vụ lớp Session sẽ kết thúc kết nối. Một số kết nối chỉ gửi gói tin theo 1 hướng(truyền simplex). Một kết nối phổ biến khác là bán song công(half-duplex)- tức là kết nối 2 chiều nhưng chỉ cho phép truyền 1 chiều tại 1 thời điểm. Còn lại là kết nối song công(full-dupex)- cho phép giao tiếp 2 chiều diễn ra
## 5. Một số giao thức sử dụng trong lớp Session
Tầng phiên sử dụng một số giao thức để đảm bảo an toàn, bảo mật và chính xác kết nối giữa các ứng dụng người dùng 2 điểm đầu cuối.
Một số giao thức:
### 5.1 RTCP(Real-time Transport Control Protocol)
#### 5.1.1 Định nghĩa
- RTCP hay còn gọi là giao thức vận chuyển thời gian thực
- RTCP làm việc song song với RTP(Real-time Transfer Protocol). Trong khi RTP thực hiện chuyển giao dữ liệu thực, RTCP lại được dùng để gửi các gói tin điều khiển cho những bên tham dự vào cuộc hội thoại
#### 5.1.2 Cách hoạt động
- RTCP hoạt động bằng cách gửi các gói tin điều khiển đến các thiết bị đầu cuối để thu thập thông tin về chất lượng dịch vụ và điều chỉnh các thông số truyền tải dữ liệu 1. Các gói tin RTCP được gửi định kỳ và được đồng bộ hóa với các gói tin RTP 1. Tuy nhiên, tần suất gửi các gói tin RTCP có thể được điều chỉnh để đáp ứng yêu cầu của các ứng dụng khác nhau

