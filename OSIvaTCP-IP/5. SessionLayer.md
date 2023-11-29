# Tầng Phiên
MỤC LỤC
- [1. Tầng phiên là gì](#1-tầng-phiên-là-gì)
- [2. Nhiệm vụ của lớp phiên](#2-nhiệm-vụ-của-lớp-phiên)
- [3. Chức năng](#3-chức-năng)
- [4. Cách lớp phiên hoạt động](#4-cách-lớp-phiên-hoạt-động)
- [5. Một số giao thức dùng trong lớp phiên](#5-một-số-giao-thức-sử-dụng-trong-lớp-session)
    - [5.1 RTCP](#51-rtcpreal-time-transport-control-protocol)
        - [5.1.1 Định nghĩa](#511-định-nghĩa)
        - [5.1.2 Cách hoạt động](#512-cách-hoạt-động)
    - [5.2 PPTP ](#52-pptp-point-to-point-tunneling-protocol)
        - [5.2.1 Định nghĩa](#521-định-nghĩa)
        - [5.2.2 Các tính năng chính](#522-các-tính-năng-chính)
        - [5.2.3 Cách hoạt động](#523-cách-hoạt-động)
        - [5.2.4 Ưu điểm và nhược điểm](#524-ưu-và-nhược-điểm-của-pptp)
    - [5.3 PAP ](#53-pappassword-authentication-protocol)
    i

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
- RTCP hoạt động bằng cách gửi các gói tin điều khiển đến các thiết bị đầu cuối để thu thập thông tin về chất lượng dịch vụ và điều chỉnh các thông số truyền tải dữ liệu. Các gói tin RTCP được gửi định kỳ và được đồng bộ hóa với các gói tin RTP. Tuy nhiên, tần suất gửi các gói tin RTCP có thể được điều chỉnh để đáp ứng yêu cầu của các ứng dụng khác nhau 
### 5.2 PPTP (Point-to-Point Tunneling Protocol)
* VPN hay còn gọi là Virtual Network, được dịch là mạng riêng ảo, là công nghệ cho phép người dùng thiết lập 1 mạng riêng ảo với 1 mạng khác trên Internet
![Alt text](/Anh/image10.png)
#### 5.2.1 Định nghĩa
![Alt text](/Anh/image9.png)
- Là 1 giao thức được phát triển vào những năm 1990 bởi 1 nhóm các công ty công nghệ hàng đầu
- Ban đầu, PPTP được thiết kế để hỗ trợ việc kết nối từ xa vào các mạng doanh nghiệp thông qua 1 đường dẫn an toàn. PPTP cho phép người dùng kết nối an toàn và truyền dữ liệu qua 1 mạng công cộng như Internet, nhằm đảm bảo tính riêng tư và bảo mật cho các dữ liệu quan trọng
#### 5.2.2 Các tính năng chính
Giao thức PPTP có một số tính năng quan trọng, làm cho nó trở thành lựa chọn phổ biến trong việc tạo VPN:
- Dễ cài đặt và sử dụng: Người dùng có thể nhanh chóng thiết lập kết nối với VPN thông qua giao diện đồ họa đơn giản
- Tính tương thích cao: có khả năng tương thích với hầu hết các nền tảng và hệ điều hành phổ biến hiện nay, bao gồm Windows, macOS, Linux và các thiết bị di động như điện thoại thông minh và máy tính bảng
- Hiệu suất tốt: được thiết kế để đạt hiệu suất cao, cho phép truyền dữ liệu 1 cách nhanh chóng và mượt mà thông qua kết nối VPN
- Hỗ trợ mã hóa: hỗ trợ mã hóa dữ liệu để đảm bảo tính bảo mật trong quá trình truyền dữ liệu qua kết nối VPN. Nhưng PPTP có độ an toàn hạn chế
- Khi đường hầm VPN được thiết lập, PPTP hỗ trợ 2 luồng thông tin:
    + Luồng điều khiển: Quản lý, ngắt kết nối VPN
    + Luồng dữ liệu: Các gói tin dữ liệu được truyền qua đường hầm kết nối 2 điểm 
- Ở đây đường hầm là thuật ngữ chỉ việc tạo ra 1 kết nối ảo giữa 2 điểm trên mạng, Đường hầm này cho phép dữ liệu được truyền đi 1 cách an toàn qua mạng công cộng trong khi vẫn duy trì tính riêng tư và bảo mật như khi sử dụng mạng riêng
#### 5.2.3 Cách hoạt động
![Alt text](/Anh/image11.png)
Khi bạn dùng PPTP để kết nối vào một VPN, quá trình gồm 2 giai đoạn chính:thiết lập kết nối và xác thực
- Trước tiên, bạn cần yêu cầu với máy chủ để thiết lập VPN
- Sau đó, quá trình xác thực diễn ra. Máy chủ PTTP yêu cầu người dùng xác thực bằng tên người sư dụng và mật khẩu. Sau khi xác thực thành công, máy khách và máy chủ thỏa thuận những thông số cần thiết để thiết lập kết nối, bao gồm giao thức mã hóa và cơ chế xác thực
- Cuối cùng, máy khách và máy chủ thiết lập kết nối PPTP thông qua giao thức mã hóa đã được thoải thuận. Khi kết nối được thiết lập, dữ liệu có thể truyền qua kết nối mạng riêng ảo an toàn.
#### 5.2.4 Ưu và nhược điểm của PPTP
##### 5.2.4.1 Ưu điểm
- Dễ sử dụng
- Tương thích cao
- Hiệu suất tốt
- Tiết kiệm băng thông     
##### 5.2.4.2 Nhược điểm
- Độ an toàn hạn chế
- Khả năng bị tấn công 
- Không hỗ trợ IPv6
- Cấu hình phức tạp hơn cho máy chủ
### 5.3 PAP(Password Authentication Protocol)
#### 5.3.1 Định nghĩa
Là 1 giao thức xác thực mật khẩu
#### 5.3.2 Công dụng
- Được sử dụng để xác thực người dùng khi truy cập vào các dịch vụ của một ISP
- Nó cho phép người dùng gửi tên đăng nhập và mật khẩu chưa mã hóa qua mạng, máy chủ sẽ so sánh dữ liệu nhận được với dánh sách tên và mật khẩu đã được mã hóa
#### 5.3.3 Dịch vụ:
- PAP cung cấp dịch vụ xác thực người dùng
- Nó được sử dụng khi 1 máy trạm truy cập từ xa tới hệ thống mạng tập đoàn, nơi nó phải gửi ID và mật khẩu tới hệ thống mạng đích
#### 5.3.4 Cách hoạt động:
- Hoạt động theo cơ chế 2 chiều
- Trong quá trình xác thực, router A gửi tên người dùng và mật khẩu cho router B
-Sau đó router B dẽ quyết định chấp nhận hay từ chối
#### 5.3.5 Ưu, nhược điểm 
- Mặc dù PAP có thể hữu ích trong 1 số trường hợp nhất đinh, nhú nhue khi một phần mềm giao thưc được cài đặt không hỗ trợ 
- Mật khẩu của PAP được truyền dưới dạng văn bản rõ ràng, điều này có thể dẫn đến các vấn đề về bảo mật

==> PAP không được gọi là 1 giao thức xác thực mạnh mẽ
### 5.4 RPC(Remote Procedure Call)
#### 5.4.1 Định nghĩa
Giao thức RPC (Remote Procedure Call) là một cách để một chương trình máy tính yêu cầu dịch vụ từ một chương trình khác nằm trên một máy tính từ xa mà không cần phải hiểu chi tiết về mạng.
#### 5.4.2 Công dụng
- Được thiết kế để cung cấp cho việc truyền tải thông tin giữa client và server dễ dàng hơn, bảo mật hơn, thuận tiện hơn cho việc đồng bộ hóa các luồn dữ liệu
- Các hàm chứa trong RPC hỗ trợ cho việc truy cập bất kỳ chương trình nào đòi hỏi phương pháp giao tiếp từ client đến server
#### 5.4.3 Cách hoạt động của RPC
- Một chương trình (gọi là client) cần thực hiện một công việc nào đó, nhưng công việc đó nằm trên một máy tính khác (gọi là server).
- Client sẽ gửi một yêu cầu đến server, yêu cầu server thực hiện công việc đó.
- Server nhận yêu cầu, thực hiện công việc, và sau đó gửi kết quả trở lại cho client.
- Client nhận kết quả và tiếp tục công việc của mình.
#### 5.4.4 Ưu điểm của RPC
Ưu điểm của RPC là nó giúp cho việc phát triển phần mềm trở nên dễ dàng hơn, bởi vì lập trình viên không cần phải quan tâm đến chi tiết của mạng.
#### 5.4.5 Nhược điểm của RPC
Nhược điểm của RPC là nó có thể gặp phải các vấn đề về bảo mật, vì dữ liệu được truyền qua mạng có thể bị người khác đánh cắp.

### 5.5 SDP(Sockets Direct Protocol)
- Là giao thức hỗ trợ các luồng socket qua cấu trúc mạng Remote Direct Memory Access
- Mục đích của SDP là cung cấp một giải pháp thay thế được tăng tốc RDMA cho giao thức TCP trên giao thức IP 
