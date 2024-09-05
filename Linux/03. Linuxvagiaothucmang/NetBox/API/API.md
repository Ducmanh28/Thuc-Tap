# Mục này tìm hiểu về API và API trong Netbox
## API là gì?
API (Application Programming Interface) là một tập hợp các giao thức, công cụ, và định nghĩa cho việc xây dựng và tích hợp phần mềm ứng dụng. API cho phép các phần mềm giao tiếp với nhau, giúp ứng dụng này có thể sử dụng chức năng của ứng dụng khác một cách an toàn và có kiểm soát mà không cần phải hiểu chi tiết về cách hoạt động bên trong của nó.

Đơn giản hơn, API là một cầu nối giữa 2 ứng dụng. Đóng vai trò làm trung gian giúp 2 ứng dụng giao tiếp với nhau. Ví dụ, A muốn giao tiếp với C thì phải thông qua B. Ở đây, B chính là API

![](/Anh/Screenshot_894.png)

## Lịch sử hình thành và phát triển:
### Khái niệm ban đầu:
- Những năm 1940-1960: Khi máy tính mới bắt đầu xuất hiện, các nhà khoa học và lập trình viên đã tạo ra các hàm và thư viện phần mềm để giúp các chương trình có thể tái sử dụng và tương tác với các phần khác của hệ thống --> API sơ khai
- Những năm 1960-1970: Khái niệm "API" bắt đầu hình thành trong bối cảnh các hệ thống máy tính lớn. Các giao diện lập trình được tạo ra để cho phép các chương trình truy cập và sử dụng tài nguyên của hệ thống mà không cần phải biết chi tiết cụ thể của chúng.

### Phát triển trong các hệ điều hành
Vào những năm 1970 và 1980, sự phát triển của các hệ điều hành như UNIX và Windows đã đưa API trở nên phổ biến hơn
- UNIX cung cấp các giao diện hệ thống cho phép các chương trình thực hiện các tác vụ như quản lý tệp, xử lý tiến trình, và giao tiếp mạng.
- Windows API (WinAPI) của Microsoft cũng đã giúp chuẩn hóa cách các ứng dụng tương tác với hệ điều hành Windows, mở ra kỷ nguyên phát triển phần mềm rộng rãi trên nền tảng này.

### Sự bùng nổ của dịch vụ Web và API Web
- Những năm 1990: Với sự bùng nổ của internet và sự phát triển của các dịch vụ web, nhu cầu giao tiếp giữa các hệ thống phân tán đã tăng mạnh. SOAP ra đời và đây là một trong những hình thức đầu tiên của API web.
- Năm 2000: Roy Fielding giới thiệu kiến trúc REST (Representational State Transfer) trong luận án tiến sĩ của mình. RESTful API, sử dụng HTTP và thường trả về dữ liệu dưới dạng JSON, nhanh chóng trở thành tiêu chuẩn cho việc phát triển API.

### API trong kỷ nguyên hiện đại
- Những năm 2010 và sau đó: API trở thành xương sống của rất nhiều ứng dụng và dịch vụ hiện đại. Các công ty lớn đã mở các API công khai của họ, cho phép các nhà phát triển bên thứ ba xây dựng các ứng dụng và dịch vụ trên nền tảng của họ
- Vào giữa những năm 2010, GraphQL được phát triển bởi Facebook như một cách linh hoạt hơn để tương tác với dữ liệu
## API dùng để làm gì?
API được dùng để kết nối các hệ thống khác nhau, giúp chúng chia sẻ dữ liệu và dịch vụ. 

Ví dụ, một ứng dụng di động có thể sử dụng API của một dịch vụ thời tiết để hiển thị thông tin thời tiết cho người dùng mà không cần phải tự xây dựng cơ sở dữ liệu thời tiết.

## Cấu tạo của API
API thường được cấu thành bởi:

- Giao thức: Quy tắc giao tiếp giữa các ứng dụng, thường là HTTP/HTTPS.
- Endpoint: URL mà các yêu cầu được gửi tới.
- Request: Yêu cầu từ một ứng dụng gửi đến API, bao gồm thông tin cần thiết như phương thức HTTP (GET, POST, PUT, DELETE) và dữ liệu cần truyền tải.
- Response: Phản hồi từ API, chứa dữ liệu mà ứng dụng yêu cầu.

## Các loại API
### REST (Representational State Transfer):
Kiến trúc: REST là một phong cách kiến trúc để xây dựng các dịch vụ web. Nó dựa trên giao thức HTTP và tuân theo nguyên tắc cụ thể như stateless, cachable, client-server

Đặc điểm:
- REST sử dụng các phương thức như GET, POST, PUT, DELETE để thao tác với tài nguyên
- Mỗi tài nguyên được đại diện bằng một URL duy nhất
- Dữ liệu trả về thường dưới dạng JSON hoặc XML
- Ưu điểm: Dễ sử dụng, dễ hiểu, dễ mở rộng và tương thích với nhiều loại ứng dụng
- Nhược điểm: Thiếu các tiêu chuẩn nghiêm ngặt và đôi khi không phù hợp cho các hệ thống phức tạp

Thực tế sử dụng:
- REST rất phổ biến trong việc xây dựng các ứng dụng web và mobile nhờ tính đơn giản và khả năng tương thích cao
- Lý tưởng khi bạn muốn hỗ trợ nhiều loại client khác nhau(Web, Mobile, IoT) với cùng một API
- Dùng trong các hệ thống đơn giản --> Trung bình: REST phù hợp với các hệ thống không quá phức tạp, nơi các thao tác CRUD là chủ yếu.

### SOAP (Simple Object Access Protocol)
Kiến trúc: SOAP là một giao thức dựa trên XML để trao đổi thông điệp giữa các hệ thống thông qua mạng

Đặc điểm:
- SOAP dựa trên các giao thức như HTTP, SMTP để truyền tải dữ liệu
- Các thông điệp SOAP được định dạng dưới dạng XML và tuân theo một bộ tiêu chuẩn nghiêm ngặt
- SOAP hỗ trợ bảo mật thông qua các tiêu chuẩn như WS-Security
- Ưu điểm: Bảo mật tốt hơn, hỗ trợ giao dịch phân tán và tích hợp tốt với các hệ thống phức tạp
- Nhược điểm: Phức tạp hơn REST, khó học và triển khai, hiệu suất thấp hơn do kích thước của thông điệp XML

Thực tế sử dụng:
- SOAP phù hợp với các hệ thống doanh nghiệp, tài chính, nơi tính bảo mật, tính toàn vẹn dữ liệu, và tuân thủ tiêu chuẩn là ưu tiên hàng đầu
- Khi cần giao dịch phân tán hoặc tích hợp với các hệ thống kế thừa, SOAP là lựa chọn tốt.
- SOAP hỗ trợ các tính năng giao dịch (transaction), bảo mật WS-Security, và đảm bảo tính nhất quán của dữ liệu.

### GraphQL:
Là một ngôn ngữ truy vẫn cho các API, cho phép client yêu cầu chính xác những gì họ cần từ server

Đặc điểm:
- Client có thể yêu cầu chính xác các trường dữ liệu cần thiết, tránh việc lấy quá nhiều hay quá ít dữ liệu
- Không giống REST, GraphQL thường chỉ sử dụng một endpoint duy nhất để xử lý mọi loại truy vấn
- Server định nghĩa rõ ràng các loại dữ liệu có thể truy vẫn và các mối quan hệ giữa chúng
- Ưu điểm: Giảm thiểu over-fetching và under-fetching, tăng hiệu suất cho client, dễ dàng mở rộng
- Nhược điểm: Phức tạp trong việc triển khai và bảo trì, yêu cầu client phải biết cấu trúc dữ liệu

Thực tế sử dụng:
- Khi bạn cần truy vấn dữ liệu từ nhiều nguồn và muốn giảm thiểu over-fetching (lấy thừa dữ liệu) và under-fetching (lấy thiếu dữ liệu).
- GraphQL cho phép client yêu cầu chính xác dữ liệu cần thiết, giúp cải thiện hiệu suất và trải nghiệm người dùng.
- Khi bạn cần thay đổi giao diện người dùng nhanh chóng mà không cần chỉnh sửa nhiều ở back-end.

### WebSocket
Là một giao thức truyền thông hai chiều dựa trên TCP, được thiết kế để duy trì một kết nối liên tục giữa client và server

Đặc điểm:
- Cho phép cả client và server gửi thông điệp qua lại bất kỳ lúc nào mà không cần client phải khởi tạo yêu cầu trước (full-duplex)
- Lý tưởng cho các ứng dụng yêu cầu thời gian thực như chat, trò chơi trực tuyến, và cập nhật dữ liệu liên tục
- WebSocket có thể hoạt động qua các proxy HTTP, giúp duy trì tính tương thích với các mạng hiện tại
- Ưu điểm: Hiệu suất cao trong việc truyền tải dữ liệu liên tục, giảm độ trễ trong giao tiếp
- Nhược điểm: Phức tạp hơn để triển khai và debug, cần chú ý đến bảo mật và quản lý kết nối

Thực tế sử dụng:
- WebSocket là lựa chọn lý tưởng cho các ứng dụng như chat, trò chơi trực tuyến, giao dịch chứng khoán, và các ứng dụng cần cập nhật dữ liệu liên tục.
- Khi bạn cần giao tiếp hai chiều giữa client và server mà không muốn client phải gửi yêu cầu mới mỗi lần cập nhật.
- Các thiết bị IoT thường cần giao tiếp liên tục và cập nhật real-time, nơi WebSocket tỏ ra rất hiệu quả.
## Cơ chế hoạt động của API
API hoạt động dựa trên mô hình yêu cầu-đáp ứng (request-response):

- Client gửi một yêu cầu tới API bằng cách gọi một endpoint cụ thể. Một yêu cầu chuẩn bao gồm các thành phần như sau:
  - URL: địa chỉ endpoint của API mà bạn muốn gửi yêu cầu
  - Method: phương thức giao tiếp với URL đó. Thường là GET hoặc POST
  - Headers: Là nơi chứa các thông tin cần thiết của 1 Request nhưng end-users không cần biết đến sự tồn tại của nó. Ví dụ:Khi người dùng đăng nhập vào một ứng dụng: Quá trình xác thực sẽ sử dụng headers như Authorization, nhưng người dùng chỉ thấy màn hình đăng nhập và không cần biết các chi tiết kỹ thuật.
  - Body: Chứa dữ liệu mà Client muốn truyền tải tới Server
- Server xử lý yêu cầu, truy xuất dữ liệu hoặc thực hiện hành động và trả về một phản hồi cho client. Cấu trúc 1 Response thường như sau:
  - Status code: Mã trạng thái
  - Headers: Tương tự như Header của Request
  - Body: Dữ liệu mà Client yêu cầu sau khi được Server xử lý

![](/Anh/Screenshot_895.png)

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

## Sử dụng API
Sử dụng API chính là dùng các phương thức GET và POST đối với dữ liệu.

Đối với Linux, lệnh `curl` hay `wget` chính là 1 minh chứng cho việc sử dụng API. Nói đơn giản, API chính là dựa trên http để hoạt động
