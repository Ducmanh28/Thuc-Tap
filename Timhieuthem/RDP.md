## RDP
### RDP là gì? 
Giao thức RDP (Remote Desktop Protocol) là một giao thức mạng được Microsoft phát triển, cho phép người dùng kết nối và điều khiển máy tính từ xa thông qua giao diện đồ họa. Dưới đây là tóm tắt về RDP:
- **Chức năng chính**: RDP cho phép người dùng truy cập vào một máy tính từ xa qua mạng, như thể họ đang ngồi trực tiếp trước máy tính đó. Giao thức này hỗ trợ nhiều phiên làm việc đồng thời, cho phép nhiều người dùng kết nối vào một máy chủ cùng lúc.
- **Cách hoạt động**: Khi sử dụng RDP, máy tính người dùng (client) gửi các thao tác như bàn phím và chuột tới máy tính từ xa (server). Máy chủ xử lý các thao tác này và gửi lại hình ảnh giao diện đồ họa tới máy khách. Điều này giúp người dùng thực hiện công việc từ xa mà không cần phải có mặt tại nơi đặt máy tính.
- **Bảo mật**: RDP hỗ trợ các biện pháp bảo mật như mã hóa dữ liệu, xác thực người dùng, và sử dụng giao thức TLS để bảo vệ dữ liệu truyền tải. Tuy nhiên, vì là một mục tiêu phổ biến của các cuộc tấn công mạng, việc bảo mật RDP yêu cầu cấu hình và giám sát cẩn thận.
- **Các tính năng**: RDP hỗ trợ truyền tải dữ liệu như âm thanh, đồ họa, in ấn từ xa, và chuyển đổi thiết bị ngoại vi. Nó cũng cho phép chia sẻ clipboard giữa máy chủ và máy khách, hỗ trợ các phiên làm việc đa màn hình, và khả năng điều chỉnh chất lượng kết nối dựa trên băng thông mạng.
- **Ứng dụng**: RDP thường được sử dụng trong các môi trường doanh nghiệp để quản lý máy chủ, hỗ trợ kỹ thuật từ xa, và làm việc từ xa. Ngoài ra, các phiên bản RDP cũng có sẵn trên nhiều hệ điều hành khác nhau, không chỉ trên Windows mà còn trên macOS, Linux, và thiết bị di động.
- **Phiên bản**: Phiên bản đầu tiên của RDP ra mắt vào năm 1996 và liên tục được cập nhật qua các phiên bản Windows. Phiên bản mới nhất (tính đến năm 2023) đi kèm với nhiều cải tiến về hiệu suất, bảo mật và các tính năng nâng cao.

### Cách sử dụng RDP
Có 2 cách để bạn có thể sử dụng RDP để điều khiển 1 máy windows khác trong mạng nội bộ.
- Dùng trực tiếp Remote Desktop trên Windows
- Dùng thông qua ứng dụng bên thứ 3 như MobaXterm

#### Dùng trực tiếp qua Windows
Truy cập `Search --> Remote Desktop Connection`

![](/Anh/Screenshot_643.png)
- Mục Computer: Sẽ là nơi bạn nhập tên thiết bị hoặc địa chỉ IP của máy mà bạn muốn kết nối tới
- Mục Username: Sẽ là nơi bạn nhập tên tài khoản để truy cập vào thiết bị muốn kết nối

Bạn cũng có thể cấu hình RDP để gửi file bằng cách trỏ vào ô `Local Resources --> Local Devices and Resources --> More` và tick chọn như sau:

![](/Anh/Screenshot_644.png)

Sau khi hoàn tất cấu hình, các bạn chọn `Connect` để kết nối

#### Dùng thông qua MobaXterm
Truy cập vào `MobaXterm --> New Session --> RDP`

Các bạn có thể cấu hình theo như bên dưới để tối ưu hóa kết nối RDP hơn

![](/Anh/Screenshot_646.png)

#### Cấu hình FireWall cho phép RDP hoạt động
Như các bạn đã thấy, việc kiểm soát firewall trên hệ thống Lab là rất quan trọng. Trước kia để có thể dễ dàng sử dụng hệ thống Lab nên tôi đã thực hiện tắt tường lửa. Tuy nhiên đối với hệ thống thực tế, việc tắt tường lửa là việc rất nguy hiểm và có thể gây ảnh hưởng xấu tới hệ thống của bạn.

Nếu bây giờ chúng ta mở Firewall ngay lập tức trên máy Server, lúc này, chúng ta không thể ping cũng như không thể RDP vào Server được nữa mà sẽ bị văng ra ngay

Vậy nên chúng ta cần phải cấu hình FireWall trước khi bật nó lên để tránh bị văng khỏi thiết bị Lab.

Chúng ta sẽ cấu hình bằng cách mở Port 3389 như sau:
- Các bạn truy cập vào cài đặt Firewall --> Advance Settings --> Inbound Rules
  - Inbound Rules là các quy tắc với các gói tin từ bên ngoài vào trong hệ thống của bạn
  - Outbound Rules là các quy tắc với các gói tin từ bên trong hệ thống của bạn đi ra ngoài
- Bạn hãy tìm trong List các quy tắc xem có quy tắc cho Remote Desktop hay chưa. Nếu có, các bạn thực hiện chỉnh sửa ở quy tắc này

![](/Anh/Screenshot_677.png)

![](/Anh/Screenshot_678.png)

Làm tương tự với các quy tắc khác của RDP. Vậy là bạn đã hoàn thành.

Hoặc với cách đơn giản hơn, bạn có thể truy cập vào Firwall --> Allow app and features through Firewall --> Click vào Remote Desktop

![](/Anh/Screenshot_679.png)

Thêm vào đó quy tắc cho phép ping đến máy chủ

![](/Anh/Screenshot_680.png)

![](/Anh/Screenshot_681.png)

Vậy là chúng ta đã hoàn thành.

#### Đổi port RDP
Vậy còn khi mà chúng ta không muốn sử dụng port mặc định 3389 của RDP mà muốn chuyển sang dùng 1 port khác thì cấu hình như thế nào ?

Ví dụ trước khi cấu hình tưởng lửa, tôi thử kết nối đến máy chủ bằng giao thức RDP thông qua port 3400 thì kết quả trả về như sau:

![](/Anh/Screenshot_682.png)

Trước tiên, chúng ta thực hiện đổi port cho giaot thức RDP như sau:
- Các bạn mở hộp thoại Run, gõ 'regedit'
- Tiếp đến các bạn truy cập theo đường Link sau:`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp`
- Sau đó tìm file `Port Numbers` và thực hiện đổi từ 3389 thành 3400
- Sau khi hoàn tất các bạn lưu lại và thoát. Lưu ý tích vào mục Decimal để có thể nhập số thập phân

![](/Anh/Screenshot_686.png)

Bây giờ chúng ta thực hiện thêm 2 rules (UDP/TCP) vào trong Firewall --> Advance Setting --> Inbound Rules --> New Rule

![](/Anh/Screenshot_683.png)

Sau đó tiến hành kiểm tra lại

![](/Anh/Screenshot_685.png)
