TTap
# Tìm hiểu tổng quan về mô hình `OSI` VÀ `TCP/IP`
## I. Mô hình `TCP/IP` 
### 1. Mô hình `TCP/IP` là gì?
- `TCP` (Transmission Control Protocol) chia nhỏ dữ liệu ra thành những gói và đảm bảo việc truyền dữ liệu thành công
- `IP` (Internet Protocol) định tuyến (route) các gói dữ liệu khi chúng được truyền qua mạng, đảm bảo dữ liệu sẽ đến đúng nơi cần nhận
- `TCP/IP` hay (Transmission Control Protocol/Internet Protocol) là một giao thức điều khiển truyền nhận
- Là giao thức liên mạng được sử dụng để kết nối các thiết bị mạng với nhau trong môi trường internet
- Cũng được sử dụng như một giao thức truyền thông bên trong mạng máy tính riêng
- Hoạt động như một lớp trừu tượng giữa các ứng dụng Internet và hạ tầng thiết bị đầu cuối. Nghĩa là: `TCP/IP` che dấu tất cả các chi tiết về việc truyền tải dữ liệu qua mạng, bao gồm việc định tuyến dữ liệu, xử lý lỗi, kiểm soát tốc độ truyền và nhận dữ liệu,...  ⇒ nhằm mục đích giúp đơn giản hóa quá trình phát triển ứng dụng, tạo ra 1 giao diện chuẩn cho các ứng dụng để giao tiếp với nhau
### 2. Tổng quan về các tầng trong mô hình `TCP/IP`
TCP/IP gồm có 4 tầng xếp chồng lên nhau theo thứ tự: **Network Access** (Tầng vật lý) → **Network** (Tầng mạng) → **Transport** (Tầng giao vận) → **Application** (Tầng ứng dụng), sau đây là một vài thông tin cơ bản về các tầng: 
#### 2.1. Tầng Vật Lý
- Là tầng thấp nhất trong mô hình `TCP/IP`
- Chịu trách nghiệm truyền dữ liệu giữa các thiết bị trong cùng 1 mạng. Tại đây, các gói dữ liệu được đóng vào khung (Frame) và được định tuyến đi đến đích được chỉ định ban đầu
- Đơn vị đo của tầng này là ‘**Frame**’ - dung lượng một khối dữ liệu nhỏ
#### 2.2. Tầng Mạng
- Là tầng xử lý quá trình truyền gói tin trên mạng
- Dữ liệu được phân thành các đoạn nhỏ để truyền đi. Mỗi đoạn có thể không bằng nhau về kích thước nhưng phải nhỏ hơn 64kb
    - Lý do: để đảm bảo hiệu suất và độ tin cậy của quá trình truyền tin
- Chức năng quan trọng nhất của tầng này là làm nhiệm vụ định tuyến và dẫn đường cho tệp tin đi đúng hướng
- Đơn vị đo của tầng này là ‘**Packets**’ - hay còn gọi là 1 gói tin. '**Packets**' chứa các thông tin gồm header chứa các thông tin đến việc định tuyến và xử lý giao tiếp còn payload chứa dữ liệu
#### 2.3. Tầng giao vận
- Hoạt động nhờ 2 giao thức chính là `TCP` và `UDP` (User Datagram Protocol). Hai giao thức này hỗ trợ nhau trong việc phân luồng dữ liệu
- `TCP` mất nhiều thời gian để đảm bảo độ an toàn nhưng không ổn về hiệu suất 
- `UDP` có  thời gian vận chuyển nhanh nhung lại không đảm bảo về độ an toàn
- Đơn vị đo lường của tầng này là ‘**Segment**’ - tương tự như ‘**Packets**’ nó cũng gồm 2 phần: Header chứa các thông tin như số thứ tự (**SQE**), cờ điều khiển, kích thước cửa sổ trượt và check lỗi. Còn lại Payload chứa dữ liệu cần truyền đi
#### 2.4. Tầng ứng dụng
- Cung cấp giao tiếp đến người dùng
- Cung cấp các ứng dụng cho phép người dùng trao đổi dữ liệu ứng dụng thông qua các dịch vụ mạng khác nhau (duyệt web, chat, gửi email, …)
- Dữ liệu khi tới tầng này sẽ được định dạng theo kiểu **byte nối byte**, cùng với đó là các thông tin định tuyến giúp xác định hướng đi đúng của 1 gói tin 
### 3. Cách mà mô hình `TCP/IP` hoạt động
![Imgur](https://i.imgur.com/nduAw89.png)
- Dữ liệu được gửi từ tầng **Application** xuống các ngăn xếp
- Tại nơi gửi dữ liệu, mỗi tầng sẽ coi gói tin của tầng trên như là của nó và thực hiện thêm vào gói tin đó các thông tin điều khiển sau đó chuyển tiếp xuống tầng dưới
- Tại nơi nhận dữ liệu, quá trình này diễn ra ngược lại, mỗi tầng thực hiện tách thông tin điều khiển của mình ra rồi chuyển dữ liệu lên tầng trên
### 4. Ưu điểm của mô hình `TCP/IP`
- Là mô hình tự do, không chịu sự kiểm soát của bất kỳ tổ chức nào trên thế giới → giúp tạo điều kiện cho sự phát triển và đổi mới
- Có khả năng tương thích cao với tất cả các hệ điều hành, phần cứng máy tính và mạng→Có thể hoạt động trên hầu hết các loại hệ thống và thiết bị, từ máy tính cá nhân đến máy chủ
- Có khả năng mở rộng cao với cấu trúc ***server-client***→Hỗ trợ một lượng lớn thiết bị và người dùng cùng 1 lúc
⇒ Xuất phát từ thiết kế và cấu trúc của mô hình. Mô hình này được thiết kế để làm việc với 1 loạt các giao thức và dịch vụ mạng 
### 5. Nhược điểm của mô hình `TCP/IP`
- Cài đặt phức tạp, khó quản lý
- Tầng `Transport` không đảm bảo phân phối các gói tin
- Những giao thức ở trong mô hình rất khó thay thế 
- Không có sự tách biệt rõ ràng giữa những khái niệm về giao diện, dịch vụ và giao thức
Dễ bị tấn công **SYN** - một kiểu tấn công từ chối dịch vụ (*DDoS*)
⇒ Không hiệu quả để mô ta những công nghệ trong mạng mới
### 6. Những tìm hiểu thêm về mô hình TCP/IP
#### 6.1. Hai giao thức ở tầng `Transport`: TCP và UDP 
##### 6.1.1. `TCP`(Tranmission Control Protocol) 
- Là giao thức connection-oriented (truyền tải hướng kết nối) -> Thiết lập kết nối trước rồi sau đó mới truyền dữ liệu
- TCP là giao thức nằm trong tầng `Transport` của mô hình `TCP/IP`
- Cung cấp cơ chế báo nhận: Khi A gửi dữ liệu cho B, B nhận được thì gói tin cho A thì xác nhận là đã nhận. Nếu B không nhận được thì A sẽ gửi lại đến khi B nhận được thì thôi
- Cung cấp cơ chế đánh số thứ tự gói tin cho các đơn vị dữ liệu, sử dụng để ráp các gói tin chính xác ở điểm nhận và lọc các gói tin bị trùng lặp
- Có các cơ chế điều khiển luồng thích hợp giúp tránh tắc nghẽn
- Hỗ trợ cơ chế truyền và nhận cùng một lúc
- Phục hồi dữ liệu truyền bị mất (A gửi mà B không nhận được thì sẽ tự động gửi lại cho đến khi B nhận được)
==> Trong thực tế, ta thường sử dụng giao thức TCP cho việc gửi tin nhắn, email hay các nội dung văn bản. Vì những nộ dung này yêu cầu về độ chính xác thông tin cao
##### 6.1.2. `UDP` (User Datagram Protocol)
- Ngược lại với TCP, thì UDP là giao thức connectionless (truyền tải hướng không kết nối) → Không thực hiện thiết lập kết nối trước mà thực hiện truyền ngay khi có dữ liệu⇒ truyền tải rất nhanh cho dữ liệu của lớp ứng dụng
- Nhưng nó không đảm bảo tính tin cậy khi truyền mà không có cơ chế phục hồi dữ liệu (không quan tâm gói tin có đến đích hay không, không quan tâm việc mất dữ liệu) ⇒ dễ bị lỗi
- Nhanh và hiệu quả đối với những dữ liệu nhỏ, khắt khe về thời gian chuyển 
- Bản chất không trạng thái nên UDP hữu dụng đối với các trả lời truy vấn nhỏ với số lượng người truy cập lớn
- Đối với giao thức UDP, ta thường sử dụng để gửi video, hình ảnh. Những thứ có thể chấp nhận hình ảnh không rõ nét nhưng vẫn có thểm hiểu được nội dung
##### 6.1.3. So sánh giống và khác nhau giữa 2 giao thức
- Giống nhau: Đều là các giao thức ở tầng `Transport` của mô hình `TCP/IP`, có chức năng kết nối các máy lại với nhau và truyền dữ liệu cho nhau
- Khác nhau:

|   `TCP/IP`  |        `UDP`      |
|-------------|-------------------|
|Hướng kết nối|Hướng không kết nối|
|Độ tin cậy cao|Độ tin cậy thấp|
|Gửi dữ liệu dạng luồng byte|Gửi dữ liệu dạng datagram|
|Không cho phép mất gói tin|Cho phép mất gói tin|
|Đảm bảo việc truyền dữ liệu|Không đảm bảo việc truyền dữ liệu|
|Có sắp xếp thứ tự các gói tin|Không sắp xếp thứ tự các gói tin|
|Tốc độ truyền thấp hơn UDP|Tốc độ truyền cao|

- Kiểm tra máy của bạn sử dụng các giao thức nào ?
- B1: Thực hiện chạy cmd với quyền admin

![Alt text](image.png)

- B2: Gõ dòng lệnh: `netstat -ab` 

![Alt text](image-1.png)

- B3: Thực hiện kiểm tra:

![Alt text](image-2.png)
==> Hầu hết các giao thức ở trên này là TCP
![Alt text](image-3.png)
==> Ta bắt đầu thấy các trình sử dụng giao thức UDP ở dưới

#### 6.2. Một số giao thức phổ biến khác
- `HTTP`(Hyper Text Transfer Protocol): Truyền tải dữ liệu không an toàn giữa **web-client** và **web-server**
- `HTTPS` (Hyper Text Transfer Protocol Secure): Truyền tải dữ liệu an toàn giữa **web-client** và **web-server**
- `FTP` (File Transfer Protocol): Giao thức cho phép người dùng lấy hoặc gửi tệp từ 1 thiết bị khác
## II. Mô hình OSI
### 1. Mô hình OSI là gì?
- Mô hình `OSI` (Open Systems Interconnection Reference Model): Mô hình tham chiếu kết nối các hệ thống mở - là một thiết kế dựa trên nguyên lý tầng cấp, lý giải một cách trừu tượng kỹ thuật kết nối truyền thông giữa các máy tính và thiết kế giao thức mạng giữa chúng
    + "Trừu tượng": Nghĩa là OSI không đề cập đến chi tiết cụ thể về cách thức hoạt động của từng tầng, thay vào đó nó chỉ đưa ra một khung chung
    ==> OSI cung cấp một cách nhìn trừu tượng về cách thức giao tiếp và trao đổi dữ liệu giữa các máy tính thông qua mạng, và cung cấp một khung để thiết kế và hiểu các giao thức mạng
- Mô tả bảy tầng mà hệ thống máy tính sử dụng để giao tiếp qua mạng
### 2. Tổng quan về các lớp trong mô hình OSI
![Imgur](https://i.imgur.com/PZaR7Lg.png)
Mô hình OSI gồm có 7 tầng xếp chồng theo thứ tự: Physical, DataLink, Network, Transport, Session, Presentation, Application
Tổng quan chức năng của các tầng trong mô hình OSI:
* Tầng Application: Tương tác với chương trình ứng dụng và mạng
* Tầng Presentation: Chuyển đổi, nén dữ liệu, mã hóa và giải mã dữ liệu
* Tầng Session: Kiểm soát các phiên hội thoại giữa các máy tính. Thiết lập, quản lý và kết thúc các phiên truyền thông giữa các ứng dụng
* Tầng Transport: Chia thông tin thành các gói nhỏ hơn, chuyển xuống lớp dưới hoặc nhận thông tin từ lớp dưới và thực hiện phục hồi sau đó chuyển lên lớp trên
* Tầng Network: Đảm bảo chuyển chính xác giữa các thiết bị cuối trong mạng
* Tầng Data Link: Tạo/gỡ bỏ khung tông tin (Frames), kiểm soát luồng và lỗi
* Tầng Physical: Đảm bảo các yêu cầu truyền/nhận các chuỗi bit qua phương tiện vật lý 
#### 2.1. Tầng Aplication
![Imgur](https://i.imgur.com/UFTsCDU.png)
- Là tầng gần với người sử dụng nhất. Cung cấp phương tiện cho người dùng truy nhập các thông tin và dữ liệu trên mạng thông qua chương trình ứng dụng. Tầng này là giao diện chính để người dùng tương tác với các chương trình ứng dụng và với mạng
- Một số giao thức trong tầng này: Telnet, FTP, HTTP, HTTPS, SMTP, X.400 Mail remote
- Data unit: data
### 2.2. Tầng Presentation 
![Imgur](https://i.imgur.com/oFzJfjU.png)
- Hoạt động như một tầng dữ liệu mạng.
- Thực hiện dịch dữ liệu từ Application sang một Format chung và ngược lại.
- Các chức năng:
+ Dịch các mã kí tự từ ASCII sang EBCDIC
+ Chuyển đổi dữ liệu
+ Nén dữ liệu để giảm lượng dữ liệu truyền mạng
+ Mã hóa và giải dữ liệu để đảm bảo sự bảo mật mạng
- Data Unit: data
### 2.3. Tầng Session 
![Imgur](https://i.imgur.com/FRikh4E.png)
- Cung cấp các nhu cầu, dịch vụ cho tầng **Presentation** 
- Chịu trách nhiệm đóng, mở luồng giao tiếp giữa 2 thiết bị (Thời gian giữa mở và đóng được gọi là phiên)
==> Đảm bảo phiên mở đủ lâu để truyền dữ liệu và đóng đủ nhanh để tránh lãng phí tài nguyên
- Tầng này còn cung cấp dịch vụ đánh dấu điểm hoàn thành.
    + Ví dụ: Khi truyền 1 file dung lượng 10GB, cứ sau mỗi 1GB sẽ đánh dấu điểm hoàn thành. --> Khi bị mất dữ liệu hoặc tạm ngừng ở 1 điểm 6GB thì ta chỉ cần truyền 4GB chưa được truyền
- Data unit: data
### 2.4. Tầng Transport
![Imgur](https://i.imgur.com/dUVLbPG.png)
- Có nhiệm vụ chuyển dữ liệu giữa các hệ thống đầu cuối của máy chủ. Đảm bảo việc truyền dữ liệu tin cậy, kiểm soát luồng dữ liệu và phân đoạn
- 'Port' chính là từ tầng này ra. 'Port' được hiểu như một cái cổng kiểm soát ra vào dữ liệu. Mỗi port khác nhau sẽ cung cấp dịch vụ khác nhau
- Có 65535 port, một số port phổ biến: Port 21-FTP; Port 22-SSG; Port 23-Telnet;...
- Các giao thức phổ biến: TCP, UDP, SSL (Secure Sockets Layer), TLS (Transport Layer Security)
- Data unit: segment
### 2.5. Tầng Network
![Imgur](https://i.imgur.com/mFGalyk.png)
- Cung cấp địa chỉ IPv4, định tuyến đường đi
- Kiểm tra sự ổn định của đường truyền, xác định đường đi từ nguồn tới đích của một gói giao thức IP
- Giải quyết vấn đề nghẽn mạng
- Thông kê số lượng các gói tin truyền qua mạng, cấm hoặc cho phép các gói tin của giao dịch nào đó
- Địa chỉ IP được sử dụng phổ biến ở tầng này
- Router là thiết bị đặc trưng hoạt động
- Các giao thức phổ biến: IP(Internet Protocol), ICMP(Internet Control Message Protocol), IGMP(Internet Group Management Protocol),...
- Data unit: packets
### 2.6. Tầng DataLink
![Imgur](https://i.imgur.com/jNIsv4p.png)
- Thực hiện truyền dữ liệu giữa các mạng kề nhau trong một mạng diện rộng, hoặc giữa các nút trong một segment mạng cục bộ
- Kiểm soát lỗi đường truyền, thông lượng
- Thực hiện đóng gói thông tin thành các frame, gửi các frame một cách tuần tự trên mạng
- Xử lý các thông báo xác nhận
- Sử dụng địa chỉ MAC
- SWITCH là thiết bị hoạt động ở tầng này
- Xác định ranh giới giữa các frame bằng cách đánh số (SEQ)
- Các giao thức tiêu biểu: RARP, ARP, HDLC, LLC, MAC,...
- Data unit: frames
### 2.7. Tầng Physical
![Imgur](https://i.imgur.com/ZDFsHf8.png)
- Tầng vật lý liên quan truyền dữ liệu. Truyền dữ liệu bằng các bit qua các thiết bị chuyển mạng hoặc các thiết bị vật lý được kết nối với nhau bằng dây dẫn.
- Tầng vật lý cần quan tâm đến các vấn đề về thao tác vật lý như ghép nối cơ khí, điện tử bảng mạch. Thủ tục và môi trường truyền tin bên dưới nó ví dụ mức điện áp tương ứng với bit 0 - 1, thời gian tồn tại của xung…
- Data Unit: bits
## 3. Quá trình truyền dữ liệu của cấu trúc OSI
![Imgur](https://i.imgur.com/wD66dOO.png)
Quá trình đóng gói dữ liệu của cấu trúc OSI diễn ra như sau:
1. Ở tầng **Application**, người dùng tiến hành đưa thông tin cần gửi vào máy tính. Các thông tin này thường có dạng như: hình ảnh, văn bản,…
2. Sau đó thông tin dữ liệu này được chuyển xuống tầng **Presentation** để chuyển các dữ liệu thành một dạng chung để mã hóa dữ liệu và nén dữ liệu.
3. Dữ liệu tiếp tục được chuyển xuống tầng **Session**. Tầng này là tầng phiên có chức năng bổ sung các thông tin cần thiết cho phiên giao dịch (gửi- nhận) này. Các bạn có thể hiêu nôm na là tâng phiên cũng giống như các cô nhân viên ngân hàng làm nhiệm vụ xác nhận, bổ sung thông tin giao dịch khi bạn chuyển tiền tại ngân hàng.
4. Sau khi tầng **Session** thực hiện xong nhiệm vụ, nó sẽ tiếp tục chuyển dữ liệu này xuống tầng **Transport**. Tại tầng này, dữ liệu được cắt ra thành nhiều Segment và cũng làm nhiệm vụ bổ sung thêm các thông tin về phương thước vận chuyển dữ liệu để đảm bảo tính bảo mật, tin cậy khi truyền trong mô hình mạng.
5. Tiếp đó, dữ liệu sẽ được chuyển xuống tầng **Network**. Ở tầng này, các segment lại tiếp tục được cắt ra thành nhiều gói Package khác nhau và bổ sung thông tin định tuyến. Tầng **Network** này chức năng chính của nó là định tuyến đường đi cho gói tin chứa dữ liệu.
6. Dữ liệu tiếp tục được chuyển xuống tầng **Data Link**. Tại tầng này, mỗi Package sẽ được băm nhỏ ra thành nhiều Frame và bổ sung thêm các thông tin kiểm tra gói tin chứa dữ liệu để kiểm tra ở máy nhận.
7. Cuối cùng, các Frame này khi chuyển xuống tầng **Physical** sẽ được chuyển thành một chuỗi các bit nhị phân (0 1….) và được đưa lên cũng như phá tín hiệu trên các phương tiện truyền dẫn (dây cáp đồng, cáp quang,…) để truyền dữ liệu đến máy nhận.
==> Quá trình đóng gói dữ liệu là quá trình được thực hiện từ trên xuống theo mô hình OSI, là quá trình mà các giao thức thêm thông tin của chúng vào dữ liệu. Ở mỗi giai đoạn của quá trình thì dữ liệu lại có một tên gọi khác nhau.
## 4. Ưu điểm và nhược điểm của mô hình OSI
### 4.1. Ưu điểm
- Cung cấp một cách tiếp cận mô-đun tốt cho kiến trúc hệ thống
- Phân biệt rõ ràng giữa dịch vụ, giao diện và giao thức
- Không dựa trên bất kỳ công nghệ cụ thể nào, vì vậy nó hoạt động như một tham chiếu chung trong các kiến trúc hệ thống khác nhau
- Là một mô hình mạng tiêu chuẩn dành cho thiết bị máy tính
- Hỗ trợ các dịch vụ không kết nối và định hướng kết nối
- Hoạt động linh hoạt với nhiều giao thức khác nhau
- Có khả năng thích ứng và độ an toàn cao
### 4.2. Nhược điểm
- Mặc dù mô hình OSI cung cấp một cách tiếp cận mô-đun tốt cho kiến trúc hệ thống, nhưng nó hoàn toàn là lý thuyết
- Thực tế là mô hình OSI không được hỗ trợ về mặt kỹ thuật có nghĩa là có sự phân chia chức năng tùy ý trong các lớp khác nhau
### 4.3. Lý do
- Mô hình OSI được thiết kế để làm rõ ràng sự phân biệt giữa dịch vụ, giao diện và giao thức, và không dựa trên bất kỳ công nghệ cụ thể nào ==> có khả năng hoạt động linh hoạt với nhiều giao thức khác nhau và có khả năng thích ứng cao 
- Tuy nhiên, do mô hình OSI hoàn toàn là lý thuyết và không được hỗ trợ về mặt kỹ thuật, nên có sự phân chia chức năng tùy ý trong các lớp khác nhau
# III. So sánh giữa 2 mô hình `TCP/IP` và `OSI`
## 1. Sự giống nhau:
- Đều có kiến trúc phân lớp, mỗi tầng đảm nhiệm 1 vai trò độc lập
- Đều sử dụng kỹ thuật chuyển Packets. Nghĩa là: Chia nhỏ gói dữ liệu và gửi qua mạng một cách độc lập
- Chúng đều là các mô hình logic
## 2. Sự khác nhau: 
![Imgur](https://i.imgur.com/Y7jboqr.png)
# IV. Khi nào thì dùng `TCP/IP`, khi nào dùng `OSI`
Như ta đã biết thì cả 2 mô hình này đều được sử dụng để mô tả cách hệ thống mạng giao tiếp với nhau. Tuy nhiên:
    
- Mô hình OSI thường được sử dụng như một công cụ tham khảo để hiểu rõ hơn về nguyên lý hoạt động và truyền tin của mạng máy tính. Giúp chuẩn hóa các thành phần mạng để phát triển dễ dàng hơn. Tuy nhiên mô hình OSI không thực tế được sử dụng để liên lạc
- TCP/IP được sử dụng rộng rãi hơn. Cho phép nới lỏng các nguyên tắc và cung cấp các nguyên tắc chung. Được sử dụng để thiết lập kết nối và giao tiếp qua mạng

# V. Cách kiểm tra xem máy tính của bạn đang dùng gì?
- B1: Thực hiện chay cmd với quyền admin
![Alt text](image.png)

- B2: Gõ dòng lệnh: `netstat -ab` 
![Alt text](image-1.png)

- B3: Thực hiện kiểm tra:
![Alt text](image-2.png)
==> Hầu hết các giao thức ở trên này là TCP
![Alt text](image-3.png)

# VI. Tài liệu tham khảo:
https://itforvn.com/bai-2-mo-hinh-osi-va-tcpip/

https://docs.google.com/document/d/13el-GUU8dbBZnsE5kuA5PyUtPv18eru4/edit

https://vietnix.vn/mo-hinh-osi-la-gi/

https://www.avg.com/en/signal/what-is-tcp-ip

