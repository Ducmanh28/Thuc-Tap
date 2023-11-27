# Tầng Giao Vận
MỤC LỤC
- [1. Tầng giao vận là gì? ](#1-tầng-giao-vận-là-gì)
- [2. Các chức năng chính của tầng giao vận?](#2-các-chức-năng-chính-của-tầng-giao-vận)
- [3. Dịch vụ ghép kênh và phân kênh](#3-dịch-vụ-ghép-kênh-và-phân-kênh)
    - [3.1 Ghép kênh](#31-ghép-kênh)
    - [3.2 Phân kênh](#32-phân-kênh)
    - [3.3 Phân loại](#33-phân-chia-các-kỹ-thuật)
- [4. Port](#4-port)
    - [4.1 Khái niệm](#41-khái-niệm)
    - [4.2 Chức năng](#42-chức-năng-của-cổng-port)
        - [4.2.1 Chọn lọc gói tin](#421-giúp-chọn-lọc-gói-tin)
        - [4.2.2 Bảo vệ xâm nhập](#422-có-khả-năng-bảo-vệ-xâm-nhập-hại-cho-máy-tính)
    - [4.3 ](#43-những-loại-port-phổ-biến)
- [5. Hai giao thức chính của tầng Transport](#5-hai-giao-thức-chính-của-tầng-transport)
    - [5.1 UDP](#51-udpuser-datagram-protocol)
        - [5.1.1 UDP là gì?](#511-udp-là-gì)
        - [5.1.2 Tác dụng của UDP](#512-tác-dụng-của-udp)
        - [5.1.3 Cách UDP hoạt động?](#513-cách-udp-hoạt-động)
        - [5.1.4 Cấu trúc header](#514-cấu-trúc-header-của-udp)
        - [5.1.5 Ưu điểm của UDP](#515-ưu-điểm-của-udp)
        - [5.1.6 Nhược điểm của UDP](#516-nhược-điểm-của-udp)
        - [5.1.7 Ứng dụng của UDP trong thực tế](#517-ứng-dụng-của-udp-trong-thực-tế)
    - [5.2 TCP](#52-tcptransmission-control-protocol)
        - [5.2.1 TCP là gì?](#521-định-nghĩa)
        - [5.2.2 Tác dụng của TCP](#522-tác-dụng-của-tcp)
        - [5.2.3 Cách TCP hoạt động](#523-cách-mà-tcp-hoạt-động)
        - [5.2.4 Cấu trúc của một gói tin TCP](#524-cấu-trúc-của-một-gói-tin-tcp-segment)

# 1. Tầng giao vận là gì?
- Là tầng thứ 4 trong mô hình OSI, đứng sau và nhận yêu cầu của **tầng Session**, đứng trước và gửi các yêu cầu cho **tầng Network**
- Có nhiệm vụ: nhận dữ liệu-->chia nhỏ/hợp nhất dữ liệu-->quản lý việc gửi dữ liệu từ nguồn đến đích
- Tầng giao vận sẽ tạo ra 1 kết nối logic giữa 2 cổng đầu cuối: tất cả các gói dữ liệu sẽ được truyền theo đường này. Có 3 giai đoạn: thiết lập kết nối, truyền, giải phóng kết nối. Do phải truyền tất cả các gói dữ liệu trên 1 kết nối --> tầng giao vận sẽ phải kiểm soát: thứ tự truyền, lưu lượng, phát hiện lỗi và sửa lỗi
# 2. Các chức năng chính của tầng giao vận?
- Phân mảnh và tái hợp nhất dữ liệu: Dữ liệu sẽ được chia thành các đoạn(*segment*) nhỏ, truyền độc lập với nhau. Mỗi *segment* đều được đánh số thứ tự cho phép ghép các *segment* thành 1 thông điệp hoàn chỉnh sau khi truyền, cũng như là phát hiện lỗi truyền tải khi bị mất segment
- Kiểm soát kết nối: Có thể hướng nối hoặc không hướng nối(TCP hoặc UDP) 
    + Hướng nối: Thực hiện kết nối với tầng giao vận máy nhận trước, sau đó chuyển các gói dữ liệu đi
    + Không hướng nối: Xử lý *segment* như các gói tin độc lập, và thực hiện chuyển tới tầng giao vận máy nhận. Sau khi tất cả dữ liệu được chuyển đi --> giải phóng kết nối
- Kiểm soát lưu lượng: được sử dụng để ngăn việc bên gửi chuyển quá nhiều thông tin.
    + Nếu bên gửi chuyển quá nhiều thông tin --> bên nhận sẽ loại bỏ các gói tin đấy và yêu cầu truyền lại --> điều này làm tắc nghẽn mạng --> giảm hiệu suất của hệ thống.
    + Tầng giao vận sẽ chịu trách nhiệm kiểm soát luồng. Nó sử dụng giao thức "Cửa sổ trượt" giúp kiểm soát luồng dữ liệu.
- Kiểm soát lỗi: Tầng giao vận ở phía gửi đảm bảo rằng toàn bộ thông điệp đến phía nhận là không bị lỗi(hỏng, mất, thừa).Việc khắc phục lỗi thường được thực hiện bằng cách truyền lại. Việc kiểm soát lỗi được thực hiện ở các thiết bị đầu cuối chứ không phải trên đường truyền trung gian 

# 3. Dịch vụ ghép kênh và phân kênh
## 3.1 Ghép kênh
- là các kỹ thuật cho phép ghép nhiều luồng tín hiệu của các nguồn ( hay các đường truyền) tốc độ thấp vào truyền chung trên 1 đường truyền tốc độ cao 
## 3.2 Phân kênh
- là kỹ thuật ngược lại, tách riêng ra từng luồng thông tin được ghép để chuyển cho các nơi nhận
## 3.3 Phân chia các kỹ thuật:
- Dồn kênh không gian(SDM)
- Dồn kênh tần số(FDM)
- Dồn kênh bước sóng(WDM)
- Dồn kênh theo thời gian(TDM)
- Dồn kênh theo mã(CDM)
- Dồn kênh theo tần số trực giao(OFDM)

# 4. Port
Khái niệm Port được sinh ra tại tầng Transport này. Vậy `Port` là gì?
## 4.1 Khái niệm
- Là 1 giao thức 16-bit đứng đầu(chèn vào phần header) của mỗi gói tin 
- Là 1 dạng thuật toán đã được định sẵn và mỗi máy tính cần phải có thì mới có thể gửi và nhận dữ liệu. 
- Đơn giản mà nói thì `Port` như một cánh cổng có quyền cho dữ liệu vào hay ra khỏi hệ thống máy tính 
- Ở trong mạng, cần 1 địa chỉ IP để xác định được 1 máy, nhưng nếu chúng chạy cùng lúc nhiều dịch vụ khác nhau thì phải có cách để phân biệt. Lúc này, ta dùng `Port`
- Ví dụ thực tế:
Server A có địa chỉ IP: 211.445.026.16 đang chạy 3 dịch vụ là website, DNS và FTP. Một máy tính B khác muốn tới Server A thì cần đến địa chỉ IP của máy A hoặc tên miền của A. Nhưng nếu muốn vào website của A thì cần phải biết cổng Port của website A để tránh đi nhầm sang DNS hoặc FTP 
## 4.2  Chức năng của cổng Port
### 4.2.1 Giúp chọn lọc gói tin
- Là 1 thuật toán mà các máy đều cần phải đăng ký để sử dụng
- Port quy định những tập tin nào được phép ra/vào máy
- Thao tác kiểm tra khớp cổng bit sẽ giúp ta kiểm soát và chọn lọc được đâu là tập tin an toàn, đâu là tập tin độc hại
### 4.2.2 Có khả năng bảo vệ xâm nhập hại cho máy tính
Từ tác dụng chọn lọc --> Port có khả năng để chống lại những xâm nhập vào máy 
## 4.3 Những loại Port phổ biến
- Có tổng cộng 65635( 2^16 - 1[Port 0]) **port number**, và được chia làm 3 phần:
    + Well Know Port(WKP): các Port từ 0-1023 được quy định cho 1 số ứng dụng
    + Registered Port(RP): các Port từ 1024-49151 các cổng Port được đăng ký
    + Dynamic/Private Port(D/PP): từ 49152-65535 cổng động/riêng tư
- Theo quy định của IANA thì WKP và RP phải được đăng ký trước khi sử dụng
- 20 - TCP - FTP data: cho phép upload và dowload dữ liệu
- 21 - TCP - FTP control: Khi có máy muốn kết nối tới FTP của bạn, máy đó sẽ phải tự thêm Port và kết nối tới cổng 21 theo mặc định
- 22 - TCP/UDP - SSH Remote Login Protocol: được yêu cầu cho người dùng SSH kết nối tới người phục vụ dịch vụ SSH
- 23 - TCP - Telnet: Người dùng cần kết nối tới cổng này để dùng các dịch vụ của Telnet
- 25 - TCP - SMTP: khi có thư tới Server của bạn, chúng sẽ cố đi quả cổng 25
- 80 - HTTP
- 110 - TCP - POP3
- 143 - TCP/UDP - IMAP 
# 5. Hai giao thức chính của tầng Transport
## 5.1 UDP(User Datagram Protocol)
### 5.1.1 UDP là gì?
![Alt text](/Anh/image12.png)
- Là giao thức không hướng kết nối(UDP không đòi hỏi bên gửi và bên nhận phải thực hiện kết nối trước khi giao đổi dữ liệu)
- Là giao thức giao vận cực kỳ đơn giản
- Có thể nói nếu sử dụng UDP thì gần như ứng dụng làm việc trực tiếp với tầng mạng IP
### 5.1.2 Tác dụng của UDP:
- Cung cấp 2 dịch vụ không được cung cấp ở lớp IP:
    + Cung cấp các PortNumber để giúp phân biệt các yêu cầu khác nhau từ người dùng và sử dụng một thuật toán Checksum để xem dữ liệu có được toàn vẹn hay không
    + Được sử dụng để truyền dữ liệu nhanh hơn. Nó ít đáng tin cậy hơn và được sử dụng để truyền dữ liệu như âm thanh, video
### 5.1.3 Cách UDP hoạt động:
- UDP lấy dữ liệu từ tiến trình ứng dụng, chèn thêm một số trường tiêu đề, trong đó có 2 trường địa chỉ cổng nguồn và đích cho dịch vụ dồn kênh/phân kênh để tạo nên gói dữ liệu segment. 
- Gói segment sau khi được tạo ra sẽ được chuyển tới tầng mạng. Tầng mạng sẽ chịu trách nhiệm gửi gói dữ liệu này tới máy nhận. Nếu segment tới đích, UDP sử dụng số hiệu cổng và địa chỉ IP của máy nhận để truyền dữ liệu trong segment tới đúng máy nhận

### 5.1.4 Cấu trúc header của UDP
Do không yêu cầu về mặt tin cậy nên cấu trúc UDP Segment rất đơn giản
- Chứa 1 tập hợp các tham số gọi là các trường. Có 4 trường, mỗi trường bằng 2 byte:
+ Source Port Number: số hiệu cổng của máy gửi
+ Destination Port Number: số hiệu cổng của máy nhận
+ UDP Length: là độ dài tính bằng byte của UDP Header hoặc bất kỳ gói dữ liệu nào
+ Checksum: Thuật toán kiểm tra lỗi(được sử dụng trong IPv6 và IPv4)
![Alt text](/Anh/image13.png)

### 5.1.5 Ưu điểm của UDP
- Tốc độ và hiệu suất cao: Không có quá trình kiểm tra kết nối và kiểm soát luồng phức tạp như TCP, giúp giảm độ trễ và tăng tốc độ truyền dữ liệu
- Hỗ trợ broadcasting: Hỗ trợ gửi dữ liệu từ 1 máy chủ tới nhiều máy khác trong mạng
- Tốn ít tài nguyên để vận chuyển 
### 5.1.6 Nhược điểm của UDP
- Không kiểm soát được những mất mát về dữ liệu
- Có độ tin cậy thấp
- Không đảm bảo việc phân phối dữ liệu cũng như truyền lại các gói tin bị lỗi
### 5.1.7 Ứng dụng của UDP trong thực tế:
- Các ứng dụng thời gian thực: truyền phát âm thanh, video, livestream, những ứng dụng chấp nhận việc mất dữ liệu, miễn là không ảnh hưởng đến chất lượng dữ liệu khi nhận
- Truy vấn DNS: DNS sử dụng UDP để truy vấn các máy chủ DNS. Khi chúng ta cần phân giải 1 tên miền thành địa chỉ IP, DNS sẽ dùng giao thức UDP để tăng tốc độ và hiệu quả.
- Games Online: Cũng được sử dụng rộng rãi trong việc truyền tải dữ liệu cho các trò chơi trực tuyến

## 5.2 TCP(Transmission Control Protocol)
### 5.2.1 Định nghĩa
- Là giao thức hướng nối - tức là sẽ thực hiện thiết lập kết nối trước rồi sau đó mới thực hiện truyền tải dữ liệu
- Là một giao thức điều khiển truyền vận
- Thuộc loại liên kết(điểm-điểm) giữa duy nhất 1 tiến trình gửi và 1 nhận
- Đảm bảo chuyển giao dữ liệu tới đích 1 cách đáng tin cậy và đúng thứ tự.
- Hoạt động trên các thiết bị đầu cuối, chữ không phải trên các thiết bị trung gian
- Cung cấp đường truyền dữ liệu hai hướng (song công - full duplex)
### 5.2.2 Tác dụng của TCP
- Đảm bảo tính toàn vẹn dữ liệu: đảm bảo các gói tin được gửi từ nguồn tới đích mà không có sự mất mát
- Đảm bảo trình tự dữ liệu: Đảm bảo các gói tin được nhận theo đúng thứ tự mà nó đã gửi đi
- Kiểm soát luồng dữ liệu: Cung cấp cơ chế kiểm soát luồng để ngăn việc quá tải dữ liệu
- Kiểm soát tắc nghẽn: Sử dụng các thuật toán như AIMD, Slow Start, FastRecovery, FastAvoid,... 
- Phân biệt dữ liệu của nhiều ứng dụng: Cung cấp cơ chế phân biệt dữ liệu của nhiều ứng dụng đồng thời chạy trên cùng 1 máy chủ
==> Những điều này giúp TCP trở thành 1 trong những giao thức quan trọng nhất trong việc truyền tải dữ liệu qua mạng
### 5.2.3 Cách mà TCP hoạt động
TCP hoạt động theo 3 giai đoạn chính: Thiết lập liên kết --> Truyền dữ liệu --> Đóng liên. Và quá trình đó được mô tả như sau:
- Quá trình kết nối: TCP sử dụng quy trình bắt tay 3 bước(three way handshake) để thiết lập 1 đường truyền kết nối giữa 2 máy. Quy trình bắt tay 3 bước bao gồm:
    + Máy khách gửi 1 SYN segment tới máy chủ
    + Khi máy chủ nhận được SYN segment, máy chủ sẽ bố trí bộ nhớ cho "*TCP buffer*" và các biến trạng thái cho liên kết TCP. Sau đó, sẽ thực hiện gửi một SYNACK segment trả lời. Số báo nhận(ACK Number) = Sequence của SYN segment +1 (trong đó số SYN sequence được chọn ngẫu nhiên).  
    + Khi nhận được SYNACK segment, máy khách cũng sẽ thiết lập bộ nhớ đệm và các biến trạng thái cho TCP, và thực hiện gửi lại cho máy chủ một segment, trong đó, số ACK = số thứ tự sequence của server + 1, SYN = 0, trường số sequence tăng 1 đơn vị
    ![Alt text](/Anh/image14.png)

- Quá trình truyền dữ liệu: Sau khi thực hiện kết nối hoàn tất giữa 2 máy, TCP bắt đầu thực hiện việc truyền dữ liệu. Dữ liệu được chia thành các "*segment*" , mỗi segment được đóng gói thành các gói tin và được gửi đến máy chủ. Lúc này, máy chủ cũng sẽ gửi lại 1 gói tin ACK để thông báo rằng đã nhận được gói dữ liệu
- Quá trình đóng liên kết: Khi hoàn thành việc truyền dữ liệu, TCP sẽ gửi 1 gói tin `FIN` đến máy chủ để đóng liên kết. Sau khi máy chủ nhận được gói tin `FIN`, nó sẽ gửi lại 1 gói tin `FIN-ACK` để đóng liên kết


### 5.2.4 Cấu trúc của một gói tin TCP Segment
- Do là giao thức tin cậy nên cấu trúc gói tin của TCP rất phức tạp
![Alt text](/Anh/image15.png)
Trong đó:
+ **Source port** và **destination port** đều có độ dài 16 bit được sử dụng để định danh cổng nguồn và cổng đích
+ Sequence number và Acknowledgment number(Số thứ tự và số biên nhận đều dài 32 bit): Số thứ tự sử dụng để đánh số thứ tự các gói tin được truyền đi, từ số này ta có thể tính được có bao nhiêu byte đã được truyền đi. Số biên nhận dùng để báo đã nhận được gói tin nào và mong nhận được byte mang số thứ tự nào tiếp theo
+ Header length(4 bit): cho biết toàn bộ header dài bao nhiêu word(1 word = 4 byte)
+ các bit reserverd: dùng để dự phòng, dành cho việc mở rộng trong tương lai. Hiện tại, giá trị của nó luôn = 0 và không có tác dụng gì
+ Flags(9 bits): được sử dụng để thiết lập kết nối, gửi dữ liệu và đóng kết nối
    - URG: Ưu tiên 1 dữ liệu
    - ACK: Được sử dụng để xác nhận 
    - PSH: Segment yêu cầu chức năng push(khi bit này được bật nghĩa là yêu cầu bên nhận phải chuyển dữ liệu lên trên ngay lập tức)
    - RST: Thiết lập lại kết nối
    - SYN: Để đặt số thứ tự ban đầu
    - FIN: Kết thúc kết nối TCP
+ Window size: 16 bit được sử dụng để kiểm soát lưu lượng, là số lượng byte tối đa mà máy nhận có thể nhận được
+ TCP Checksum: 16 bit kiểm tra lỗi của toàn bộ TCP segment
+ Urgent pointer: 16 bit Sử dụng trong trường hợp cần ưu tiên dữ liệu
+ Options: tối đa 32 bit, cho phép thêm vào TCP những tính năng khác
+ Data: Dữ liệu của lớp trên

### 5.2.5 Ưu điểm của TCP:
- Là giao thức đáng tin cậy
- Có cơ chế kiểm tra lỗi và phục hồi
- Kiểm soát dòng lưu lượng
- Đảm bảo dữ liệu gửi đến đúng đích theo đúng thứ tự được gửi
- Là giao thức mở và không thuộc quyền sở hữu của bất cứ tổ chức hay cá nhân
- TCP gắn một địa chỉ IP cho mỗi máy tính trên Internet và 1 tên miền cho từng trang --> mỗi trang đều được phân biệt cụ thể trong Internet 
### 5.2.6 Nhược điểm của TCP:
- Bắt đầu chậm
- Tốc độ chậm: do sử dụng cơ chế "kiểm soát tắc nghẽn"- nơi mà nó giảm tốc độ truyền khi phát hiện tắc nghẽn. 
- Bắt tay chậm: Qúa trình kết nối của TCP có thể mất thời gian, đặc biệt là khi có nhiều kết nối đồng thời --> Làm giảm hiệu suất mạng
- Tối ưu hóa mạng: Không được tối ưu hóa cho các loại mạng có băng thông thấp, hoặc độ trễ cao, việc sử dụng TCP có thể không hiệu quả

### 5.2.7 Ứng dụng của TCP trong thực tế:
- Truy cập trang web: Khi bạn truy cập trang web bằng trình duyệt, trình duyệt sẽ sử dụng TCP để kết nối với máy chủ web
- Gửi và nhận email: Khi 1 bạn gửi và nhận được được 1 email thì ứng dụng email sẽ sử dụng giao thức TCP cho việc truyền/ tải xuống email đó
- Chia sẻ tệp: Khi tải tệp lên mạng hoặc tải tệp xuống máy tính cá nhân, giao thức TCP được sử dụng
- Truy cập từ xa: Khi truy cập vào 1 máy tính từ xa thông qua SSH, TCP được sử dụng để thiết lập một kết nối an toàn.
- Ứng dụng ngang hàng: Nhiều các ứng dụng ngang hàng như các ứng dụng dùng để chia sẻ tệp sử dụng TCP để thiết lập đường truyền
==> Những ứng dụng này sử dụng khả năng đáng tin cậy và theo thứ tự của TCP để đảm bảo rằng dữ liệu được truyền tải 1 cách chính xác và toàn vẹn

## 5.3 So sánh giữa 2 mô hình TCP và UDP
|Tiêu chí|TCP|UDP|
|--------|---|---|
|Tốc độ|Chậm hơn UDP|Nhanh hơn TCP|
|Dung lượng gói tin|Có dung lượng nặng|Có dung lượng nhẹ|
|Hướng liên kết|Có|Không|
|Sử dụng phiên|Có|Không |
|Độ tin cậy|Có|Không|
|Xác thực|Có|Không|
|Đánh số thứ tự|Có|Không|
|Điều khiển luồng|Có|Không|
|Bảo mật|nhiều hơn UDP|ít hơn TCP|

- So với UDP, TCP có nhiều ưu điểm hơn: TCP cung cấp dịch vụ truyền dữ liệu tin cậy trong khi UDP không làm được. Tuy nhiên trong thực tế, nhiều ứng dụng lại sử dụng UDP vì:
    + Không có giai đoạn thiết lập kết nối: UDP không phải chịu thời gian để thiết lập đường truyền
    + Không duy trì trạng thái kết nối: UDP không phải lưu trữ những thông tin về trạng thái kết nối --> nếu phía server sử dụng UDP thì có khả năng phục vụ đồng thời nhiều client hơn
    + Tiêu đề gói dữ liệu nhỏ: Tiêu đề của TCP là 20byte trong khi UDP chỉ có 8byte
    + Không kiểm soát tốc độ gửi: Tốc độ truyền dữ liệu của UDP chỉ bị giới hạn bởi tốc độ sinh dữ liệu của ứng dụng, khẳ năng của máy tính nguồn và tốc độ truy cập mạng. 
- ==> Ta có thể thấy việc truyền dữ liệu tin cậy không phải tiêu chí quan trọng nhất đánh giá sự thành công của ứng dụng
- Nhưng đối với việc lựa chọn TCP hay UDP thì chúng ta cần tùy thuộc vào mục đích sử dụng của bản thân
    + Đối với việc truyền tải dữ liệu cần nhanh và đảm bảo tốc độ truyền thì việc lựa chọn UDP là phù hợp
    + TCP lại là một lựa chọn tốt nhất để truyền dữ liệu và thông tin phải đầy đủ và đảm bảo được về tính toàn vẹn dữ liệu trong quá trình truyền

|Ứng dụng|Giao thức tầng ứng dụng|Giao thức tầng giao vận|Port|
|--------|-----------------------|-----------------------|----|
|Thư điện tử|SMTP|TCP|25|
|Truy cập từ xa|Telnet|TCP|23|
|Web|HTTP, HTTPS|TCP|80, 443|
|Truyền File|FTP|TCP|20, 21|
|File Server|NFS|thường là UDP|2049|
|Đa phương tiện|Tùy hãng sản xuất|thường là UDP||
|Call online|Tùy hãng sản xuất|thường là UDP||
|Quản lý mạng|SNMP|thường là UDP|161|
|Đinh tuyến|RIP|thường là UDP|520|
|Tên miền|DNS|thường là UDP|53|

# 6. Link tài liệu tham khảo:
- [Ho Dac Phuong - Giao trinh mang co ban]()
- [Suncloud](https://suncloud.vn/transport-layer-trong-mo-hinh-osi#21-don-kenh)
- [CloudZ](https://cloud.z.com/vn/news/udp/)
- [Anh Quang](https://github.com/thanhquang99/thuctap2023/blob/main/thuctap/OSIvaTCPIP/osivatcpipnew.md)
- [DOCS - Tài liệu mẫu](https://docs.google.com/document/d/1Eejm3qP3YKksWkq1G45MXC0WVZKtUqbgtnjXVlr3JAo/edit#heading=h.bnbvuddgzhi0)