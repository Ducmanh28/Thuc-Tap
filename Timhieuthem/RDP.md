# Mục này tìm hiểu về RDP
Mục lục
- [Mục này tìm hiểu về RDP](#mục-này-tìm-hiểu-về-rdp)
  - [RDP là gì?](#rdp-là-gì)
  - [Cách sử dụng RDP](#cách-sử-dụng-rdp)
    - [Dùng trực tiếp qua Windows](#dùng-trực-tiếp-qua-windows)
    - [Dùng thông qua MobaXterm](#dùng-thông-qua-mobaxterm)
    - [Cấu hình FireWall cho phép RDP hoạt động](#cấu-hình-firewall-cho-phép-rdp-hoạt-động)
    - [Đổi port RDP](#đổi-port-rdp)
  - [Phân quyền RDP:](#phân-quyền-rdp)
    - [Tạo User](#tạo-user)
      - [Sử dụng GUI để thao tác tạo User](#sử-dụng-gui-để-thao-tác-tạo-user)
      - [Sử dụng CMD](#sử-dụng-cmd)
    - [Phân quyền RDP cho user:](#phân-quyền-rdp-cho-user)
      - [Sử dụng GUI](#sử-dụng-gui)
      - [Sử dụng CMD](#sử-dụng-cmd-1)
  - [Kiểm tra Log RDP trong Windows](#kiểm-tra-log-rdp-trong-windows)
    - [Một số thông tin về Log](#một-số-thông-tin-về-log)
    - [Log RDP:](#log-rdp)
    - [Kiểm tra thời gian lưu Log](#kiểm-tra-thời-gian-lưu-log)

## RDP là gì? 
Giao thức RDP (Remote Desktop Protocol) là một giao thức mạng được Microsoft phát triển, cho phép người dùng kết nối và điều khiển máy tính từ xa thông qua giao diện đồ họa. Dưới đây là tóm tắt về RDP:
- **Chức năng chính**: RDP cho phép người dùng truy cập vào một máy tính từ xa qua mạng, như thể họ đang ngồi trực tiếp trước máy tính đó. Giao thức này hỗ trợ nhiều phiên làm việc đồng thời, cho phép nhiều người dùng kết nối vào một máy chủ cùng lúc.
- **Cách hoạt động**: Khi sử dụng RDP, máy tính người dùng (client) gửi các thao tác như bàn phím và chuột tới máy tính từ xa (server). Máy chủ xử lý các thao tác này và gửi lại hình ảnh giao diện đồ họa tới máy khách. Điều này giúp người dùng thực hiện công việc từ xa mà không cần phải có mặt tại nơi đặt máy tính.
- **Bảo mật**: RDP hỗ trợ các biện pháp bảo mật như mã hóa dữ liệu, xác thực người dùng, và sử dụng giao thức TLS để bảo vệ dữ liệu truyền tải. Tuy nhiên, vì là một mục tiêu phổ biến của các cuộc tấn công mạng, việc bảo mật RDP yêu cầu cấu hình và giám sát cẩn thận.
- **Các tính năng**: RDP hỗ trợ truyền tải dữ liệu như âm thanh, đồ họa, in ấn từ xa, và chuyển đổi thiết bị ngoại vi. Nó cũng cho phép chia sẻ clipboard giữa máy chủ và máy khách, hỗ trợ các phiên làm việc đa màn hình, và khả năng điều chỉnh chất lượng kết nối dựa trên băng thông mạng.
- **Ứng dụng**: RDP thường được sử dụng trong các môi trường doanh nghiệp để quản lý máy chủ, hỗ trợ kỹ thuật từ xa, và làm việc từ xa. Ngoài ra, các phiên bản RDP cũng có sẵn trên nhiều hệ điều hành khác nhau, không chỉ trên Windows mà còn trên macOS, Linux, và thiết bị di động.
- **Phiên bản**: Phiên bản đầu tiên của RDP ra mắt vào năm 1996 và liên tục được cập nhật qua các phiên bản Windows. Phiên bản mới nhất (tính đến năm 2023) đi kèm với nhiều cải tiến về hiệu suất, bảo mật và các tính năng nâng cao.

## Cách sử dụng RDP
Có 2 cách để bạn có thể sử dụng RDP để điều khiển 1 máy windows khác trong mạng nội bộ.
- Dùng trực tiếp Remote Desktop trên Windows
- Dùng thông qua ứng dụng bên thứ 3 như MobaXterm

### Dùng trực tiếp qua Windows
Truy cập `Search --> Remote Desktop Connection`

![](/Anh/Screenshot_643.png)
- Mục Computer: Sẽ là nơi bạn nhập tên thiết bị hoặc địa chỉ IP của máy mà bạn muốn kết nối tới
- Mục Username: Sẽ là nơi bạn nhập tên tài khoản để truy cập vào thiết bị muốn kết nối

Bạn cũng có thể cấu hình RDP để gửi file bằng cách trỏ vào ô `Local Resources --> Local Devices and Resources --> More` và tick chọn như sau:

![](/Anh/Screenshot_644.png)

Sau khi hoàn tất cấu hình, các bạn chọn `Connect` để kết nối

### Dùng thông qua MobaXterm
Truy cập vào `MobaXterm --> New Session --> RDP`

Các bạn có thể cấu hình theo như bên dưới để tối ưu hóa kết nối RDP hơn

![](/Anh/Screenshot_646.png)

### Cấu hình FireWall cho phép RDP hoạt động
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

### Đổi port RDP
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

## Phân quyền RDP:
Ở mục này, chúng ta sẽ tìm cách phân quyền cho 1 User mới được tạo có thể sử dụng RDP.

### Tạo User
Chúng ta sẽ có thể sử dụng 2 cách. Ở đây, tôi sẽ làm mẫu bằng cách tạo ra 2 User. 1 user sử dụng GUI để thao tác, 1 User sử dụng CMD để thao tác.

#### Sử dụng GUI để thao tác tạo User
Trước khi khởi tạo User, bạn cần kiểm tra kiểu Password mà bạn sẽ phải đặt:
- Mở Powershell
- Gõ lệnh sau:
```
Get-ADDefaultDomainPasswordPolicy
```
![](/Anh/Screenshot_701.png)

Như vậy là tôi đã tắt yêu cầu mật khẩu phức tạp. 

Tiến hành tạo mới User:
- Do máy đã cài ADDS nên chúng ta sẽ thực hiện tạo mới User thông qua ADDS 
- Mở hộp thoại RUN và gõ: `dsa.msc`

![](/Anh/Screenshot_702.png)

![](/Anh/Screenshot_703.png)

Lưu ý: mật khẩu tối thiểu 7 chữ số

![](/Anh/Screenshot_704.png)

#### Sử dụng CMD
Mở CMD

Nhập vào câu lệnh sau:
```
net USER <username> <password> /add
```
Ví dụ:
```
net USER TEST2 1234567 /add
```
### Phân quyền RDP cho user:
#### Sử dụng GUI
Mở hộp thoại RUN và gõ: `dsa.msc`

Kiểm tra trong danh sách User tên User mà bạn vừa khởi tạo
, chọn vào mục chỉnh sửa user.

Tiếp đến chọn vào mục Member of và thêm vào Group cho User như sau:

![](/Anh/Screenshot_706.png)

Thêm vào 1 số quyền sau:
- Administrators
- Remote Desktop

Sau đó, thực hiện lưu lại và khởi động lại hệ thống.

#### Sử dụng CMD
Truy cập CMD

Thêm vào câu lệnh sau:
```
# Tổng quan:
net localgroup "Group_name" <User_name> /add
# Thêm vào Remote Desktop User
net localgroup "Remote Desktop Users" TEST2 /add
# Thêm vào admin
net localgroup administrators TEST2 /add
```
## Kiểm tra Log RDP trong Windows
Bất kể hệ điều hành nào, file Log luôn luôn là các file quan trọng giúp người quản lý hệ thống nắm được tình trạng máy cũng như các tiến trình hoạt động trên máy

Log ở Windows hay còn gọi là các event(Sự kiện) là nơi lưu trữ các hoạt động của máy. Bạn có thể xem các event này ở Event Viewer

![](/Anh/Screenshot_707.png)

### Một số thông tin về Log
**Event Log** là một thành phần quan trọng của Windows, giúp quản trị viên hệ thống theo dõi và phân tích các hoạt động của hệ thống, phần mềm, và phần cứng. Các log này có thể bao gồm:
- **Application Log**: Ghi lại các sự kiện từ các ứng dụng đang chạy trên hệ thống.
- **System Log**: Ghi lại các sự kiện từ hệ điều hành Windows.
- **Security Log**: Ghi lại các sự kiện bảo mật, chẳng hạn như đăng nhập thành công hoặc thất bại, thay đổi quyền người dùng, v.v.
- **Setup Log**: Ghi lại các sự kiện liên quan đến cài đặt và cấu hình hệ thống.
- **Forwarded Events**: Ghi lại các sự kiện được chuyển tiếp từ các máy tính khác.

Các EventLog sẽ được lưu dưới dạng file `.evtx` và nằm ở trong:`C:\Windows\System32\winevt\Logs`

Bạn có thể thao tác với các EventLog thông qua EventViewer

### Log RDP:
Để tìm ra log của một phiên Remote Desktop trong Windows, bạn cần kiểm tra các sự kiện trong **Security Log** và **TerminalServices-LocalSessionManager Log**. 

Kiểm tra Security Log:
  - **Event ID 4624**: Đăng nhập thành công.
  - **Event ID 4625**: Đăng nhập thất bại.
  - **Event ID 4634**: Đăng xuất.

- Trước tiên, mở bộ lọc tìm kiếm:

![](/Anh/Screenshot_708.png)

- Lọc các Event ID kết nối của RDP: 4624, 4625, 4634

Kiểm tra trong TerminalServices-LocalSessionManager Log
  - Event ID 21: Một phiên đã được đăng nhập vào Remote Desktop.
  - Event ID 22: Một phiên đã được ngắt kết nối khỏi Remote Desktop.
  - Event ID 23: Một phiên đã được kết nối lại vào Remote Desktop.
  - Event ID 24: Một phiên đã được ngắt kết nối khỏi Remote Desktop mà không đăng nhập lại.
  - Event ID 25: Một phiên đã được ngắt kết nối khỏi Remote Desktop và sau đó đăng nhập lại.

![](/Anh/Screenshot_709.png)

Ví dụ như trong ảnh sau, chúng ta có thể thấy được:
- Ngày và giờ sự kiện được tạo ra
- Mã số sự kiện
- Thông tin thêm như: 
  - User được dùng để kết nối
  - ID của phiên kết nối
  - Địa chỉ IP của người kết nối đến

### Kiểm tra thời gian lưu Log
Để kiểm tra được thao tác mà máy sẽ thực hiện ví dụ đối với Security Log khi Log đầy, chúng ta vào `Event Viewer/ WindowsLog/Security`, chuột phải và chọn `Properties`

![](/Anh/Screenshot_713.png)

Ở đây sẽ có các thông tin như:
- Tên Log
- Đường dẫn lưu Log
- Dung lượng của Log
- Ngày tạo Log
- Ngày chỉnh sửa
- Ngày truy cập
- Dung lượng tối đa lưu log
- Khi log đầy, thực hiện:
  - Ghi đè lên log(ghi đè từ phiên bản cũ nhất)
  - Nén dữ liệu log, không ghi đè
  - Xóa log, không ghi đè


