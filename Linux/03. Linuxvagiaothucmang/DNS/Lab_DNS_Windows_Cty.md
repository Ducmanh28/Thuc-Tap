Mục lục
- [Mục này Show ra quá trình Lab DNS trên cụm máy lab của công ty](#mục-này-show-ra-quá-trình-lab-dns-trên-cụm-máy-lab-của-công-ty)
  - [RDP](#rdp)
    - [RDP là gì?](#rdp-là-gì)
    - [Cách sử dụng RDP](#cách-sử-dụng-rdp)
      - [Dùng trực tiếp qua Windows](#dùng-trực-tiếp-qua-windows)
      - [Dùng thông qua MobaXterm](#dùng-thông-qua-mobaxterm)
      - [Cấu hình FireWall cho phép RDP hoạt động](#cấu-hình-firewall-cho-phép-rdp-hoạt-động)
      - [Đổi port RDP](#đổi-port-rdp)
  - [Thực hành các bài lab về DNS Server Local trên hệ thống Lab công ty](#thực-hành-các-bài-lab-về-dns-server-local-trên-hệ-thống-lab-công-ty)
    - [Bài Lab 1: Cấu hình DNS Server Local giữa 2 máy Windows.](#bài-lab-1-cấu-hình-dns-server-local-giữa-2-máy-windows)
    - [Bài Lab 2: Cấu hình DNS Server Local sao cho Windows Client trỏ tới được 1 WebSite trên UbuntuWebServer](#bài-lab-2-cấu-hình-dns-server-local-sao-cho-windows-client-trỏ-tới-được-1-website-trên-ubuntuwebserver)
      - [Mô hình gồm có 3 máy như sau:](#mô-hình-gồm-có-3-máy-như-sau)
      - [Ubuntu WebServer](#ubuntu-webserver)
      - [DNS Server](#dns-server)
      - [Client](#client)
    - [Bài Lab 3: Cấu hình DNS Server Local sao cho Ubuntu Client trỏ tới được 1 trang web Public](#bài-lab-3-cấu-hình-dns-server-local-sao-cho-ubuntu-client-trỏ-tới-được-1-trang-web-public)
      - [Mô hình gồm có 2 máy như sau:](#mô-hình-gồm-có-2-máy-như-sau)
      - [Để thực hiện được:](#để-thực-hiện-được)
      - [Trên DNS Server](#trên-dns-server)
      - [Trên Ubuntu Client](#trên-ubuntu-client)

# Mục này Show ra quá trình Lab DNS trên cụm máy lab của công ty
Để có thể triển khai được mô hình trên cụm máy Lab của công ty, trước tiên chúng ta cần tìm hiểu về giao thức sẽ sử dụng để truy cập vào hệ thống lab. Ở đây, giao thức được sử dụng là RDP(Remote Desktop Protocol)

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
- Sau khi hoàn tất các bạn lưu lại và thoát

![](/Anh/Screenshot_684.png)

Bây giờ chúng ta thực hiện thêm 2 rules (UDP/TCP) vào trong Firewall --> Advance Setting --> Inbound Rules --> New Rule

![](/Anh/Screenshot_683.png)

Sau đó tiến hành kiểm tra lại

![](/Anh/Screenshot_685.png)

## Thực hành các bài lab về DNS Server Local trên hệ thống Lab công ty 
Trước khi thực hành các bài Lab, chúng ta cần thực hiện cài đặt lại tên máy chủ sao cho dễ nhận biết và sử dụng
- Bấm tổ hợp phím `Windows+R` để mở hộp thoại **Run** sau đó nhập vào `sysdm.cpl` để mở hộp thoại Systems Properties 
- Thực hiện đổi tên thành **WINSVM19**

![](/Anh/Screenshot_647.png)

Tiếp đó chúng ta thực hiện cài IP tĩnh cho hệ thống DNS như sau:

![](/Anh/Screenshot_648.png)

Cài đặt AD DS và DNS Server cho máy. Mục này đã làm ở **Lab_DNS_Windows**. Nếu các bạn chưa biết có thể tìm kiếm file và xem
### Bài Lab 1: Cấu hình DNS Server Local giữa 2 máy Windows.
Ban đầu khi thực hiện nslookup, không rõ máy chủ tên gì, không phân giải được gì:

![](/Anh/Screenshot_649.png)

Truy cập vào DNS Manager và thực hiện cấu hình. Tiến hành tạo 1 Reverse Look Up Zone.

![](/Anh/Screenshot_650.png)

Tạo bản ghi Reverse cho bản ghi A của DNS Server

![](/Anh/Screenshot_651.png)

Sau khi đã có bản ghi Reverse, chúng ta đã có cho mình 1 DNS Server. Bạn có thể sử dụng lệnh `nslookup` để kiểm tra. Server có thể phân giải được từ tên miền --> IP và ngược lại.

![](/Anh/Screenshot_655.png)

![](/Anh/Screenshot_656.png)

Trên máy Server, thực hiện thêm mới bản ghi cho máy Client như sau

![](/Anh/Screenshot_659.png)

Và ta được kết quả:

![](/Anh/Screenshot_658.png)

### Bài Lab 2: Cấu hình DNS Server Local sao cho Windows Client trỏ tới được 1 WebSite trên UbuntuWebServer
#### Mô hình gồm có 3 máy như sau:
Máy Client: Laptop Win 10: `172.16.66.2`

DNS Server: VM WinSV 19: `172.16.66.83`

Ubuntu WedServer: `172.16.66.81`

#### Ubuntu WebServer
Đầu tiên chúng ta sẽ thực hiện tạo trang web và cấu hình apache trên Ubuntu Server
- Nội dung file trang web được lưu ở: `/var/www/testdns/index.html`
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Simple Website</title>
</head>
<body>
    <h1>Hello, this is my simple website!</h1>
    <p>Welcome to my website hosted on Apache2. I create this web to test DNS Local </p>
    <h2>Thanks for vistting my website!</h2>
    <p>Now, let's create your website<p>
    <h3>GOODBYE!!!</h3>
</body>
</html>
```
- Nội dung file cấu hình được lưu ở `/etc/apache2/sites-available/testdns.conf`
```
<VirtualHost *:80>
    ServerAdmin luongducmanh02@gmail.com
    ServerName web.dnstest.local
    DocumentRoot /var/www/testdns

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
- Thực hiện khởi động file cấu hình và dịch vụ apache
```
a2ensite testdns.conf

sudo systemctl reload apache2
```
#### DNS Server
Truy cập vào DSN Manager và thực hiện tạo 1 Foward Lookup Zone mới có tên `dnstest.local`

![](/Anh/Screenshot_661.png)

Sau đó tại zone này, chúng ta thực hiện tạo mới 1 bản ghi trỏ tới trang web ở Ubuntu WebServer

![](/Anh/Screenshot_662.png)

Sau khi hoàn tất chúng ta mở CMD và thực hiện các lệnh sau
```
ipconfig /registerdns

net stop dns
net start dns
```

Kiểm tra kết quả:
```
nslookup web.dnstest.local

nslookup 172.16.66.83
```
Kết quả:

![](/Anh/Screenshot_663.png)

Thực hiện kiểm tra trang web

![](/Anh/Screenshot_664.png)

#### Client
Thực hiện truy cập CMD và kiểm tra bằng `nslookup`

![](/Anh/Screenshot_665.png)

Thực hiện truy cập tới trang web

![](/Anh/Screenshot_666.png)

Kết quả hiển thị như thế này nghĩa là bạn đã thành công

### Bài Lab 3: Cấu hình DNS Server Local sao cho Ubuntu Client trỏ tới được 1 trang web Public
#### Mô hình gồm có 2 máy như sau:
- Ubuntu Client: `172.16.66.82`
- DNS Server: `172.16.66.83`

#### Để thực hiện được:
Để thực hiện được, chúng ta cần cấu hình cho DNS Server Foward ra Internet(có thể là 8.8.8.8 của Google)

#### Trên DNS Server
Truy cập vào DNS Manager

Thực hiện cấu hình trong Fowarder

![](/Anh/Screenshot_667.png)

Cấu hình như sau:

![](/Anh/Screenshot_668.png)

Lưu lại cấu hình, đăng ký lại tên miền và khởi động lại dịch vụ DNS
```
ipconfig /registerdns

net stop dns
net start dns
```
Kiểm tra trên Server bằng `nslookup`

![](/Anh/Screenshot_669.png)

#### Trên Ubuntu Client
Thực hiện cài DNS Server cho máy như sau
- Truy cập vào File cấu hình mạng cho Ubuntu: `/etc/netplan/99-netcfg-vmware.yaml`
- Xóa toàn bộ và thực hiện thềm vào nội dung sau:
```
# Generated by VMWare customization engine.
network:
  version: 2
  renderer: networkd
  ethernets:
    ens160:
      dhcp4: no
      dhcp6: no
      addresses:
        - 172.16.66.82/24
      routes:
        - to: default
          via: 172.16.66.1
      nameservers:
        addresses:
          - 172.16.66.83
```
Khởi động lại dịch vụ mạng sau đó kiểm tra bằng `nslookup` và `curl`
```
nslookup 172.16.66.83
```
![](/Anh/Screenshot_671.png)

Kiểm tra bằng lệnh curl:

![](/Anh/Screenshot_672.png)




