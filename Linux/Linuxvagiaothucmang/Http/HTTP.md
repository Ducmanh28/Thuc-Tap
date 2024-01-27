# Mục này tìm hiểu về HTTP, cách cài đặt và sử dụng
MỤC LỤC
- [Mục này tìm hiểu về HTTP, cách cài đặt và sử dụng](#mục-này-tìm-hiểu-về-http-cách-cài-đặt-và-sử-dụng)
  - [Sơ lược về HTTP](#sơ-lược-về-http)
    - [HTTP là gì?](#http-là-gì)
    - [HTTP hoạt động như thế nào?](#http-hoạt-động-như-thế-nào)
    - [Các phiên bản của HTTP](#các-phiên-bản-của-http)
    - [Gói tin HTTP](#gói-tin-http)
      - [HTTP Request](#http-request)
      - [HTTP Response](#http-response)
    - [StatusCode HTTP](#statuscode-http)
  - [HTTPS](#https)
  - [So Sánh HTTP và HTTPS](#so-sánh-http-và-https)
    - [Chứng chỉ SSL, TLS](#chứng-chỉ-ssl-tls)
    - [Port](#port)
    - [Tốc độ](#tốc-độ)
  - [Cách chuyển http sang https](#cách-chuyển-http-sang-https)
  - [HTTP trong Linux:](#http-trong-linux)

## Sơ lược về HTTP
### HTTP là gì?
HTTP hay còn gọi là Hypertext Transfer Protocol - là một giao thức truyền tải siêu văn bản

Là giao thức tiêu chuẩn cho WWW(World Wide Web) cho việc truyền tải dữ liệu dưới dạng văn bản, âm thanh, hình ảnh, video từ Web Server tới trình duyệt Web của người dùng và ngược lại

Là một giao thức sử dụng ở tầng ứng dụng của mô hình OSI và TCP/IP.
### HTTP hoạt động như thế nào?
![](/Anh/Screenshot_367.png)

Ví dụ khi chúng ta truy cập vào địa chỉ `https://suncloud.vn/`. Quá trình một phiên làm việc HTTP sẽ diễn ra như sau:
- HTTP Client sẽ thiết lập một kết nối TCP đến Server(quá trình này bao gồm thủ tục bắt tay 3 bước). Sau khi thiết lập thành công, Client và Server sẽ thực hiện truyền nhận dữ liệu qua kênh này. Kết nối được thiết lập hay còn được gọi là Socket Interface, bao gồm các thông tin như 
  - Địa chỉ IP
  - Loại giao thức giao vận(TCP là chủ yếu)
  - Port(Mặc định của HTTP sẽ là Port 80)
- Sau khi đã kết nối, Client sẽ gửi một **HTTP Request** tới Server thông qua Socket Interface vừa được thiết lập. Trong gói tin **Request** này sẽ bao gồm đường dẫn yêu cầu(path name) là `/category/internet-of-things`
- Server sau khi nhận và xử lý gói tin **Request** từ Client thì sẽ đóng gói dữ liệu tương ứng mà Client yêu cầu và thực hiện gửi một **HTTP Response** về cho Client. Gói tin **HTTP Response** sẽ là một file HTML chứa các loại dữ liệu khác nhau như văn bản, hình ảnh,...
- Server sẽ đóng kết nối TCP
- Client sau khi nhận được gói tin cũng sẽ đóng kết nối TCP
- Lưu ý: Nếu Client vẫn yêu cầu kết nối liên tục thì Server sẽ không thực hiện đóng kết nối. Kết nôí TCP lúc này vẫn được duy trì sau khi truyền file hoàn tất

### Các phiên bản của HTTP

**HTTP/0.9**: Được khởi xướng bởi Tim Berners-Lee vào năm 1989 tại CERN. Nội dung ý tưởng của HTTP được tóm gọn lại trong một tài liệu cơ bản, bên trong mô tả hoạt động tương tác giữa máy khách và máy chủ ở phiên bản HTTP thử nghiệm đầu tiên, có số 0.9.

**HTTP/1.x**: Phiên bản HTTP/0.9 sau một thời gian được phát triển, trở thành phiên bản chính thức 1.01. HTTP/1 được hoàn thiện và xuất bản tài liệu sử dụng (phiên bản 1.0) vào năm 1996. HTTP tiếp tục được phát triển vào năm 1997 (khi này là phiên bản 1.1), và đặc tính kỹ thuật của nó được cải tiến lần lượt vào các năm 1999, 2014 và 2022.

**HTTP/2**: Được đưa vào sử dụng vào năm 2015. Tính đến tháng 4 năm 2023, nó được sử dụng trên 39% trang web và được gần như toàn bộ trình duyệt web hỗ trợ. HTTP/2 là một giao thức hiệu quả hơn về ngữ nghĩa của HTTP “trên dây”. Nó cung cấp nhiều tính năng mới, bao gồm việc sử dụng kết nối đơn để truyền tải nhiều tài nguyên cùng một lúc, tăng tốc độ tải trang và giảm thời gian tải trang.

**HTTP/3**: Là phiên bản kế nhiệm của HTTP/2 được triển khai vào năm 2022. Nó đã được sử dụng trên 26% trang web và được nhiều trình duyệt hỗ trợ. Phiên bản này sử dụng QUIC thay vì TCP cho giao thức truyền tải cơ bản

### Gói tin HTTP
Có 2 loại gói tin chính được trao đổi 
- Gói tin gửi từ Client tới Server: **HTTP Request**
- Gói tin Server trả lời Client: **HTTP Response**
#### HTTP Request
![](/Anh/Screenshot_368.png)

Gồm 3 thành phần chính là:
- **Request Line**: Bao gồm 3 trường:
  - Phương thức(Method): Là các yêu cầu mà Client muốn Server thực hiện. Một số Method thường hay được sử dụng là:
    - **GET**: Được sử dụng để lấy một thông tin xác định từ Server. Các yêu cầu sử dụng GET chỉ nên nhận dữ liệu, không nên thay đổi dữ liệu
    - **POST**: Yêu cầu máy chủ chấp nhận thực thể được đính kèm trong Request, được xác định bởi URL. Ví dụ như: thông tin khách hàng, file tải lên,...
    - **PUT**: Nếu URL để cập đến một tài nguyên đã có, nó sẽ bị sửa đổi. Nếu URL không trỏ đến một tài nguyên hiện có thì máy chủ có thể tạo ra tài nguyên với URL đó
    - **DELETE**: Xóa bỏ tất cả các đại diện của tài nguyên được chỉ định bởi URL
    - **PATCH**: Áp dụng cho việc sửa đổi một phần của tài nguyên được xác định
  - Đường dẫn(Path): Dùng để định danh nguồn tài nguyên mà Client yêu cầu, bắt buộc có dấu `/`
  - Phiên bản giao thức(HTTP Version): Là phiên bản HTTP mà Client sử dụng(Thường là 1.0/1.1)
- **Các dòng Header**: Các dòng này là không bắt buộc có. Viết ở định dạng "Name=Value" cho phép Client gửi thêm các thông tin bổ sung về thông điệp HTTP request và thông tin về chính Client. Một số Header thông dụng như:
  - **Accept**: loại nội dung có thể nhận được từ thông điệp Response. Ví dụ: Text/plain, text/html
  - **Accept-Encoding**: các kiểu nén được chấp nhận. Ví dụ: gzip, deflate, xz,...
  - **Connection**: tùy chọn điều khiển cho kết nối hiện tại. Ví dụ: Keep-Alive, Close,...
  - **Cookie**: Thông tin Cookie từ Server
- **Phần Body**: Là dữ liệu gửi từ Client đến Server trong gói tin HTTP Request. Đa số các gói tin gửi theo phương thức GET sẽ có BODY trống, các phương thức như POST hay PUT thường dùng để gửi dữ liệu nên có bao gồm dữ liệu trong trường BODY  
#### HTTP Response
Cũng gồm 3 thành phần chính là:
- **Status Line**: Trạng thái của gói tin HTTP, bao gồm 3 thành phần chính
  - Phiên bản giao thức(HTTP Version): Phiên bản giao thức HTTP mà Server hỗ trợ
  - Mã trạng thái(Status Code): mô tả trạng thái kết nối dưới dạng số, mỗi trạng thái sẽ được biểu thị dưới dạng một số nguyên. Một số dạng Status Code:
    -  `1xx` - Thông tin: Yêu cầu được chấp nhận hoặc quá trình tiếp tục
    -  `2xx` - Thành công: Xác nhận rằng hành động đã hoàn tất thành công hoặc đã được hiểu
    -  `3xx` - Chuyển hướng: Client phải thực hiện hành động bổ sung để hoàn thành yêu cầu
    -  `4xx` - Lỗi: Lỗi từ Client chỉ ra rằng yêu cầu không thể hoàn thành hoặc chứa cú pháp sai. Mã lỗi `4xx` sẽ hiện ra khi lỗi bên phía người dùng. Chủ yếu là do không đưa ra một yêu cầu hợp lệ
    -  `5xx` - Lỗi: Lỗi từ Server. Cho biết máy chủ không thể hoàn tất yêu cầu được cho là hợp lệ. Khi duyệt web và thấy lỗi `5xx`, bạn chỉ có thể chờ đợi, vì lúc này Lỗi xuất phát từ phía máy chủ duyệt web, không có cách nào can thiệp để sửa lỗi ngoài việc ngồi chờ bên máy chủ xử lý xong
  - Mô tả trạng thái(Status Text): mô tả trạng thái kết nối dưới dạng văn bản một cách ngắn gọn, giúp người dùng dễ hiểu hơn so với mã trạng thái. Ví dụ: 200-OK, 404-Not Found, 403-Forbiden,...
- **Các dòng Header**: Có chức năng tương tự như gói tin Request, giúp Server có thể truyền thêm các thông tin bổ sung
- **Phần Body**: Là nơi đóng gói dữ liệu để trả về cho Client, thông thường trong duyệt web, nó sẽ trả về một gói HTML để trình duyệt có thể thông dịch được và hiển thị ra cho người dùng

### StatusCode HTTP
Một số mã trạng thái Static Code của giao thức HTTP

|Mã trạng thái|Cụm từ chỉ lý do|Giải thích lỗi|
|-------------|----------------|--------------|
|100|Continue|Yêu cầu đã được hoàn thành và phần còn lại của tiến trình được tiếp tục|
|101|Switching Protocols|Khi yêu cầu một trang, trình duyệt có thể nhận được mã 101, theo sau đó là Header"Upgrade", cho thấy rằng máy chủ đang thay đổi sang phiên bản HTTP khác|
|102|Processing|Lỗi file hệ thống, xuất hiện khi hệ thống kiểm tra `.cod` thấy có sự thay đổi một hay nhiều file `.COD`|
|200|OK|Phản hồi tiêu chuẩn cho các yêu cầu HTTP thành công|
|201|Created|Khi các trạng thái mới được tạo bởi dữ liệu biểu mẫu đã đăng bởi tiến trình CGI, đây là dấu hiệu xác nhận rằng trang đó đang hoạt động|
|202|Accepted|Yêu cầu của Client đã được chấp nhận nhưng chưa được xử lý|
|203|Non-Authoritative Information|Thông tin chứa trong tiêu đề thực thể không phải từ trang web gốc, mà là từ máy chủ của bên thứ ba|
|204|No Content|Nếu nhấp vào một liên kết không có URL mục tiêu, phản hồi này được máy chủ suy ra và không cảnh báo người dùng về bất cứ điều gì|
|205|Reset Content|Điều này cho phép máy chủ reset lại bất kỳ nội dung nào được CGI trả về|
|206|Partial Content|Các file được yêu cầu không được tải xuống hoàn toàn. Ví dụ, mã trạng thái này xuất hiện khi người dùng nhấn nút dừng trước khi trang được load|
|207|Multi-Status|Truyền tải thông tin về nhiều tài nguyên, trong các tình huống có thể có nhiều trạng thái phù hợp|
|300|Multiple Choices|Địa chỉ được yêu cầu đề cập đến nhiều hơn một file. Tùy thuộc vào cách máy chủ được cấu hình, bạn sẽ gặp lỗi hoặc được lựa chọn trang nào mong muốn|
|301|Moved Permanently|Nếu máy chủ được thiết lập đúng cách, nó sẽ tự động chuyển hướng người đọc đến vị trí mới của file|
|302|Found|Trang đã được di chuyển tạm thời và URL mới có sẵn. Bạn sẽ được máy chủ điều hướng đến đó|
|303|See Other|Dữ liệu ở một nơi khác và phương thức GET được sử dụng để truy xuất nó|
|304|Not Modified|Nếu header yêu cầu bao gồm tham số 'if modified since', mã trạng thái này sẽ được trả về, trong trường hợp file không thay đổi kể từ ngày đó|
|305|Use Proxy|Người nhận dự kiến sẽ lặp lại yêu cầu thông qua proxy|
|307|Temporary Redirect|Di chuyển tạm thời phương thức HTTP phiên bản 1.1. Sử dụng nếu bạn luôn dùng URL gốc và thay đổi URL mục tiêu trong tương lai|
|308|Permanent Redirect|Dữ liệu hiện được đặt vĩnh viễn tại một URI khác, được chỉ định bởi Location: HTTP Response header|
|400|Bad Request|Có một lỗi cú pháp trong yêu cầu và yêu cầu bị từ chối|
|401|Unauthorized|Header yêu cầu không chứa mã xác thực cần thiết và client bị từ chối truy cập|
|402|Payment Required|Việc thanh toán là bắt buộc|
|403|Forbidden|Client không được phép xem một file nhất định. Mã trạng thái này cũng được trả lại vào những thời điểm mà máy chủ không muốn có thêm khách truy cập|
|404|Not Found|Các file được yêu cầu không có trên máy chủ. Có thể bởi vì những file này đã bị xóa, hoặc chưa từng tồn tại trước đây. Nguyên nhân thường là do lỗi chính tả trong URL|
|405|Method Not Allowed|Phương pháp đang sử dụng để truy cập file không được cho phép|
|406|Not Acceptable|File được yêu cầu tồn tại nhưng không thể được sử dụng, vì hệ thống client không hiểu định dạng mà file được cấu hình|
|407|Proxy Authentication Required|Yêu cầu phải được cho phép trước khi diễn ra.|
|408|Request Time-out|Máy chủ mất quá nhiều thời gian để xử lý yêu cầu. Lỗi này thường gây ra bởi lưu lượng truy cập mạng cao|
|409|Conflict|Qúa nhiều yêu cầu đồng thời cho một file|
|410|Gone|Các file đã được sử dụng ở vị trí này, nhưng không còn nữa|
|500|Internal Server Error|Phản hồi khó chịu thường xảy ra do sự cố trong code Perl, khi chương trình CGI chạy|
|501|Not Implemented|Yêu cầu không thể được máy chủ thực hiện|
|502|Bad GateWay|Máy chủ cố truy cập đang gửi lại lỗi|
|503|Service Unavailable|Service hoặc file đang được yêu cầu hiện không có sẵn|
|504|Gateway Time-out|Cổng đã hết thời gian. Giống như 408 timeout error, nhưng lỗi này xảy ra tại cổng của máy chủ|

Bạn có thể xem Status Code bằng cách sau:
- Truy cập một trang web bất kì
- Bấm `F12`
- Sau đó bấm `F5` để reset lại trang web
- Xem thông tin ở ô khoanh vùng đỏ
- ![](/Anh/Screenshot_370.png)
## HTTPS
HTTPS hay còn gọi là HyperText Transfer Protocol Secure - là giao thức truyền tải siêu văn bản an toàn. 

Thực chất, đây chính là giao thức HTTP nhưng có tích hợp thêm Chứng chỉ bảo mật SSL, nhằm mã hóa các thông điệp giao tiếp để tăng tính bảo mật.

HTTPS hoạt động tương tự HTTP, nhưng được bổ sung thêm chứng chỉ SSL hoặc TLS. Cho tới hiện tại, đây là các tiêu chuẩn bảo mật hàng đầu cho hàng triệu Website trên toàn thế giới

![](/Anh/Screenshot_369.png)

Cả SSL và TLS đều sử dụng hệ thống PKI(Public Key Infrastructure - hạ tầng khóa công khai) không đối xứng. Hệ thống này sẽ sử dụng hai "khóa" để mã hóa thông tin liên lạc, Khóa công khai và khóa riêng.

Bất cứ thứ gì được mã hóa công khai chỉ có thể được giải mã bằng khóa riêng và ngược lại. Điều này sẽ đảm bảo nội dung được mã hóa khi gửi đi và giải mã khi nhận. Điều này khiến Hacker dù có chen ngang lấy được thông tin thì cũng không thể "hiểu" được thông tin đó

## So Sánh HTTP và HTTPS
### Chứng chỉ SSL, TLS
Sự khác biệt lớn nhất là về các chứng chỉ bảo mật. Trong thời kỳ số hóa hiện nay, HTTPS trở nên cực kì cần thiết cho bảo mật Website. Dù bạn dùng máy tính cá nhân hay công cộng, các tiêu chuẩn SSL sẽ luôn đảm bảo liên lạc giữa máy khách và máy chủ được an toàn, chống bị dòm ngó

### Port
HTTP sử dụng Port 80

HTTPS sử dụng Port 443 - đây chính là cổng hỗ trợ mã hóa kết nối từ máy tính Client đến Server, nhằm bảo vệ gói dữ liệu đang được truyền đi

### Tốc độ
HTTPS chậm hơn HTTP nhưng nhờ sự phát triển công nghệ hiện nay, sự khác biệt đã đạt giới hạn tiệm cận bằng 0
## Cách chuyển http sang https
Cài đặt chứng chỉ SSL: Để sử dụng HTTPS, bạn cần cài đặt chứng chỉ SSL (Secure Sockets Layer) trên máy chủ web của mình. Chứng chỉ SSL giúp mã hóa thông tin giữa máy khách và máy chủ, đảm bảo an toàn cho dữ liệu truyền tải

Cấu hình máy chủ web: Sau khi cài đặt chứng chỉ SSL, bạn cần cấu hình máy chủ web để sử dụng HTTPS. Cấu hình này có thể được thực hiện bằng cách sửa đổi tệp cấu hình máy chủ web của bạn.

Cập nhật liên kết: Sau khi cấu hình máy chủ web, bạn cần cập nhật liên kết trên trang web của mình để sử dụng HTTPS thay vì HTTP. Bạn cần cập nhật tất cả các liên kết trên trang web của mình để đảm bảo rằng chúng đều sử dụng HTTPS

Kiểm tra và xác minh: Cuối cùng, bạn cần kiểm tra và xác minh rằng trang web của mình đang sử dụng HTTPS một cách chính xác. Bạn có thể sử dụng các công cụ trực tuyến để kiểm tra xem trang web của mình đã được cấu hình đúng cách hay chưa
## HTTP trong Linux:
Có thể được sử dụng thông qua nhiều cách khác nhau, bao gồm việc thiết lập máy chủ Web và sử dụng công cụ để tải xuống tệp từ Internet

- **Apache HTTP**: là một trong những máy chủ web phổ biến nhất trên thế giới. Bạn có thể cài đặt để tạo máy chủ web của riêng bạn. Apache cung cấp nhiều tính năng mạnh mẽ, bao gồm các module có thể tải động, hỗ trợ phương tiện truyền thông mạnh mẽ và tích hợp rộng rãi với các phần mềm phổ biến khác
- **NGNIX**: Tương tự như Apache, NGNIX cũng là một máy chủ web phổ biến. Nó cung cấp một số tính năng khác so với Apache, nhưng cũng có thể được sử dụng để tạo máy chủ Web



