# Mục này show ra quá trình lab DNS Local trên Windows
Chúng ta sẽ thực hiện tìm hiểu và thực hành DNS Local 
## Một vài thông tin về DNS Local
Là một hệ thống DNS được triển khai để hoạt động trên hệ thống mạng nội bộ, chủ yếu phục vụ các yêu cầu DNS của các thiết bị trong mạng nội bộ

## So sánh giữa DNS Local và DNS Public
**Phạm vi hoạt động:**
- DNS local: Hoạt động trong mạng nội bộ như gia đình, doanh nghiệp hoặc tổ chức. Nó phục vụ các yêu cầu DNS từ các thiết bị trong mạng cụ thể và được cấu hình và quản lý bởi người quản trị mạng trong mạng đó.
- DNS public: Là các máy chủ DNS được triển khai công cộng trên Internet và phục vụ cho mọi người trên toàn cầu. Các ví dụ của DNS public bao gồm các máy chủ DNS của các nhà cung cấp dịch vụ Internet (ISP) hoặc các dịch vụ DNS công cộng như của Google (8.8.8.8, 8.8.4.4).

**Hiệu suất và độ trễ**:
- DNS local: Thường có hiệu suất cao hơn vì nó nằm gần với người dùng và có thể lưu trữ thông tin trong bộ nhớ cache. Điều này giảm độ trễ và tăng tốc độ phản hồi cho các yêu cầu DNS.
- DNS public: Có thể có độ trễ cao hơn do phải xử lý các yêu cầu từ nhiều nguồn trên toàn cầu. Hiệu suất cũng có thể bị ảnh hưởng bởi các yếu tố như mạng Internet và tải lên máy chủ 
DNS công cộng.

**Bảo mật**:
- DNS local: Có thể được cấu hình để thực hiện các biện pháp bảo mật nhất định như kiểm soát truy cập, lọc nội dung hoặc chặn các trang web độc hại.
- DNS public: Cung cấp dịch vụ DNS mở và không cung cấp các tính năng bảo mật cao cấp như một máy chủ DNS local có thể thực hiện.

**Quản lý và kiểm soát**:
- DNS local: Được quản lý và kiểm soát hoàn toàn bởi người quản trị mạng trong mạng nội bộ. Người quản trị có thể cấu hình và tinh chỉnh máy chủ DNS theo nhu cầu cụ thể của họ.
- DNS public: Không được quản lý hoặc kiểm soát bởi người dùng cuối. Người dùng chỉ có thể chọn máy chủ DNS công cộng mà họ muốn sử dụng.

**Tính riêng tư**:
- DNS local: Có thể cung cấp mức độ riêng tư cao hơn do thông tin DNS của mạng nội bộ không được chia sẻ với công chúng.
- DNS public: Có thể liên kết các yêu cầu DNS với địa chỉ IP của người dùng, tạo ra các vấn đề liên quan đến quyền riêng tư.

## Mô hình hoạt động của DNS Local
![](/Anh/Screenshot_573.png)

Ban đầu, Client gửi truy vấn DNS cho DNS Resolver - đây chính là hệ thống DNS trên máy Client chịu trách nhiệm gửi truy vấn đi tới DNS Server

Tại DNS Server sau khi nhận được truy vấn từ Client sẽ thực hiện tìm trong Data Storge của mình xem có địa chỉ IP cho tên miền cần truy vấn không. 
- Nếu có, sẽ thực hiện trả về địa chỉ IP ứng với tên miền cần truy vấn
- Nếu không, thực hiện trả về thông báo lỗi

Server khi tìm thấy IP ứng với tên miền cần truy vấn thì sẽ gửi lại DNS Response cho DNS Resolver và từ đây sẽ trả về IP cho Client
## Thực hành lab DNS Local Windows
Mô hình thực hành

![](/Anh/Screenshot_601.png)
### Chuẩn bị trước khi thực hành
Chúng ta cần có ít nhất 2 máy để kiểm tra bài thực hành này

Ở đây, tôi có 2 máy như sau:

- Windows 10: `192.168.217.1` đóng vai trò là máy Clients
- Windows Server 2022: `192.168.217.135` đóng vai trò là Server.

Thực hiện cài đặt Windows Server trên máy Windows Server
- Bạn có thể lấy Links tải file ISO ở [đây](https://go.microsoft.com/fwlink/p/?linkid=2195333)
- Sau đó dùng VM Ware cài đặt như bình thường, nếu chưa biết cách cài đặt, bạn có thể tham khảo tại [đây]()
- Sau khi cài đặt và thiết lập xong, chúng ta tiến hành thiết lập DNS Server

Cài đặt IP tĩnh cho Windows Server
- Do Windows Server sẽ đóng vai trò là DNS Server, vì vậy nó cần có địa chỉ IP ổn định và không được thay đổi để Client trỏ đến đúng đích Server.
- Chúng ta thực hiện cấu hình IP và DNS Server như sau:

![](/Anh/Screenshot_578.png)
### Tiến hành 
#### Cài đặt Active Directory và DNS Server
Tại Windows Server:
- Các bạn truy cập vào **Start** --> **Search** và tìm kiếm **Server Manager**

![](/Anh/Screenshot_574.png)

- Tiếp đó, các bạn chọn mục `Add roles and features` để tiếm hành thêm Role

![](/Anh/Screenshot_575.png)

- Tiếp đó, tại mục `Installation Type`, sẽ có 2 danh mục cho bạn chọn. Ở đây chúng ta chọn **Role-based or fearture-based installation**
  - **Role-based or fearture-based installation**: Cấu hình máy chủ bằng cách thêm vai trò, dịch vụ vai trò và tính năng
  - **Remote Desktop Services installation**: Cài đặt các dịch vụ, vai trò cần thiết cho VDI để tạo máy ảo hoặc phiên ảo

![](/Anh/Screenshot_576.png)

- Tại mục Server Selection cho phép ta chọn nơi cài đặt vai trò giữa các máy chủ và ổ đĩa ảo. Chúng ta sẽ chọn máy chủ cài đặt chính là Windows Server 2022. Bảng hiển thị sẽ hiện ra đầy đủ các thông tin như 
  - Tên máy
  - Địa chỉ IP
  - Hệ điều hành của máy

![](/Anh/Screenshot_577.png)

- Sau khi được chuyển Sang tới mục Server Roles, các bạn tích vào 2 mục sau:
    - Active Directory Domain Services
    - DNS Server

![](/Anh/Screenshot_579.png)

- Ở mục Features, bạn chỉ cần để mặc định và bấm chọn `Next`

![](/Anh/Screenshot_580.png)

- Sau đó liên tục bấm Next cho tới màn hình Install

![](/Anh/Screenshot_581.png)

![](/Anh/Screenshot_582.png)

![](/Anh/Screenshot_583.png)

![](/Anh/Screenshot_584.png)

Sau khi hoàn tất, các bạn chọn `Promote this Server to a domain controller` để tiến hành cấu hình thêm

![](/Anh/Screenshot_585.png)

- Tại mục Deployment Configuration các bạn thiết lập thêm mới forest và thiết lập root domain mới như sau:

![](/Anh/Screenshot_586.png)

- Tại mục Domain Controller Options, các bạn thiết lập password cho DSRM

![](/Anh/Screenshot_587.png)

- Các bạn để mặc định và bấm `Next`, đừng quá lo về dòng cảnh báo DNS Server

![](/Anh/Screenshot_588.png)

![](/Anh/Screenshot_589.png)

![](/Anh/Screenshot_590.png)

- Đến khi màn hình Install hiện ra, các bạn chọn `Insall` để tiến hành cài đặt

![](/Anh/Screenshot_591.png)

Sau khi hoàn tất, máy tính sẽ tự khởi động lại

#### Tiến hành cấu hình DNS Server
Các bạn có thể vào DNS Manager bằng 2 cách:
- Truy cập bằng cách sử dụng Tools trong Server Manager
- Truy cập bằng cách tìm kiếm trong Start

![](/Anh/Screenshot_592.png)

Tiến hành tạo 1 zone reverse mới:
- Truy cập vào Reverse Lookup Zones:
- Trong New Zone Wizard
- Nhập `Next` liên tục cho đến khi tới mục điền IPv4
- Bạn điền dải mạng của mình vào. Ví dụ bạn đang sử dụng IP `192.168.217.132` thì ở mục này bạn điền `192.168.217`
- Sau đó chọn `Next` cho tới màn hình `Finshed`. Vậy là bạn đã hoàn tất

![](/Anh/Screenshot_593.png) 

![](/Anh/Screenshot_594.png)

Ở phần Forward Lookup Zone, bạn có thể thấy root server domain mà bạn đã thiết lập, Sau khi truy cập vào, bạn sẽ thấy dòng hiển thị Server của bạn. Truy cập vào và tích chọn như sau

![](/Anh/Screenshot_595.png)

![](/Anh/Screenshot_596.png)

Điều này sẽ cho phép DNS Server của bạn có thể phân giải 2 chiều.

Lúc này ở trên Server DNS, chúng ta thực hiện kiểm tra lại kết quả như sau:
```
ipconfig /flushdns # Lệnh này để giải phóng bộ nhớ cache cũ

ipconfig /registerdns # Lệnh này để đăng ký lại dns

nslookup # Lệnh này để kiểm tra kết quả dns
```
![](/Anh/Screenshot_597.png)

Đúng với những gì đã cài đặt.

#### Tiến hành truy cập từ DNS Client
Tiến hành truy cập cài đặt mạng và cấu hình như sau:

![](/Anh/Screenshot_598.png)

Sử dụng lệnh `nslookup` để kiểm tra:
- Phân giải tên miền thành IP
- Phân giải IP thành tên miền

![](/Anh/Screenshot_602.png)

## Thực hành lab Forward DNS ra Internet trên Windows Server
Cũng tương tự như đối với DNS Local, chúng ta sẽ sử dụng DNS Local có sẵn. Nhưng ở đây, Sau khi truy vấn DNS ở Local xong, truy vấn sẽ được chuyển tiếp từ DNS Server Local sang DNS Server Internet mà chúng ta đã cấu hình. Chi tiết có thể xem ở hình dưới

![](/Anh/Screenshot_603.png)

Quy trình thực hành như sau:
- Mở **DNS Manager**: Bạn có thể mở DNS Manager bằng cách vào: `Server Manager` --> `Tools` --> `DNS`.
- Thêm Forwarders:
  - Trong cửa sổ DNS Manager, chọn tên máy chủ DNS của bạn.
  - Click phải và chọn Properties.
  - Chuyển đến tab Forwarders.
  - Click vào nút Edit.
  - Thêm địa chỉ IP của các máy chủ DNS ngoại vi mà bạn muốn sử dụng (ví dụ: `8.8.8.8`, `8.8.4.4` là các máy chủ DNS của Google).

![](/Anh/Screenshot_604.png)

![](/Anh/Screenshot_605.png)

![](/Anh/Screenshot_606.png)

![](/Anh/Screenshot_607.png)

Sau khi hoàn tất cấu hình, các bạn có thể sử dụng các lệnh sau ở trong CMD để tiến hành khởi động lại dịch vụ DNS
```
net stop dns

net start dns
```

Sau đó sử dụng `nslookup` để kiểm tra 1 trang web bất kì trên Internet

![](/Anh/Screenshot_608.png)

## Thực hành Lab DNS Local ra một website ở UbuntuWebServer trong mạng nội bộ
Ở trên chúng ta đã thực hiện lab DNS Server Local ở các mục tìm kiếm và phân giải tên miền đơn giản giữa 2 máy Windows và ra Internet.

Tiếp đây, chúng ta sẽ cùng thực hiện cấu hình DNS Server sao cho Client kết nối được với Ubuntu Webserver

Mô hình hoạt động và thực hành sẽ trông như hình dưới đây

![](/Anh/Screenshot_609.png)

Các bước thực hành như sau:
- Tạo trang web trên WEBSERVER
- Cấu hình DNS SERVER trỏ tới trang web
- Tiến hành kiểm tra
### Tạo trang web trên Ubuntu 22 sử dụng Apache
Tiến hành tạo trang web là `web.dnstest.local` như sau:

Trước tiên chúng ta cần tạo trang web bằng 1 file `html` cơ bản
- Truy cập vào `/var/www/`, tạo thư mục chứa trang web và khởi tạo file chứa trang web:
```
# Tạo thư mục chứa:
mkdir testdns 
chmod 777 testdns

# Tạo file html
vim index.html
```
- Thêm vào trong file nội dung trang web. Bạn có thể tham khảo mẫu sau:
```
# Thêm vào nội dung trang web:
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TestDNS</title>
</head>
<body>
    <h1>Hello, this is my simple website!</h1>
    <p>Your DNS SERVER WORK SUCCESSFULLY!</p>
    <h2>GOODBYE!<h2>
</body>
</html>
```
- Lưu lại nội dung trang web và cấp quyền truy cập file
```
# Sau đó thực hiện lưu và thoát:
Esc --> wq
# Cấp quyền
chmod 777 testdns.html
```

Sau khi hoàn tất, bây giờ chúng ta sẽ cấu hình cho trang web ở Apache.
- Truy cập vào đường dẫn chứa file cấu hình. File cấu hình cho trang web sẽ nằm ở `sites-available`
```
# Truy cập vào thư mục chứa
cd /etc/apache2/sites-available

# Tạo file cấu hình cho trang web
vim testdns.conf
```
- Khi đã có file, chúng ta thực hiện thêm vào nội dung cấu hình cho trang web. Nếu bạn chưa rõ phần này, bạn có thể tham khảo file cấu hình dưới
```
<VirtualHost *:80>
    ServerAdmin luongducmanh02@gmail.com
    ServerName web.dnstest.local
    DocumentRoot /var/www/testdns

    ErrorLog /var/log/apache2/error.log
    CustomLog /var/log/apache2/access.log combined
</VirtualHost>
```
- Khi đã hoàn tất, các bạn thực hiện lưu và thoát khỏi vim, sau đó khởi động trang web khởi động lại dịch vụ apache2
```
# Lưu và thoát
Esc --> wq

# Khởi động trang web
a2ensite testdns.conf

# Khởi động lại dịch vụ apache2
systemctl reload apache2
```

### Cấu hình DNS Server trỏ tới trang web
Truy cập vào DNS Manager trên DNS Server bằng cách vào `Start --> Search --> DNS`

![](/Anh/Screenshot_610.png)

Tiến hành tạo 1 Zone mới trong DNS Server
- Trong DNS Manager trên Windows Server 2022, chọn tên máy chủ. Ở đây của tôi là `WINSV22` như ảnh trên
- Ở mục **Foward Lookup Zone** click phải chuột và chọn `New Zone`

![](/Anh/Screenshot_611.png)

- Tiếp đến, tại bảng cấu hình New Zone, chúng ta thực hiện như sau

![](/Anh/Screenshot_612.png)

- Có 3 loại Zone mà bạn có thể lựa chọn:
  - PrimaryZone: Tạo 1 bản copy của 1 zone, cái mà có thể cập nhật thư mục, đường dẫn trên Server này
  - SecondaryZone: Tạo 1 bản copy của 1 zone tồn tại trên 1 Server khác. Cái cài đặt này sẽ giúp cân bằng các chương trình tải cho PrimaryServer và cung cấp khả năng chịu lỗi
  - StubZone: Tạo 1 bản sao của zone chứa NS, SOA. Cái Server chứa stubzone không phải Authoritative của zone đó

![](/Anh/Screenshot_613.png)

- Ở đây tiếp tục có 3 lựa chọn cho bạn chọn về cách mà bạn muốn zone data trả lời:
  - Tới tất cả Server DNS chạy trên Quản lý domain ở `infoserver.local`
  - Tới tất cả Server DNS chạy trên Quản lý domain ở trong domain `infoserver.local`
  - Tới tất cả Quản lý domain trong `infoserver.local`

![](/Anh/Screenshot_614.png)

- Ở đây, bạn thực hiện đặt tên cho Zone. Phần tên này chính là phần domain. Ví dụ trang web của tôi là `web.dnstest.local` thì phần zone name này tôi sẽ đặt là `dnstest.local`

![](/Anh/Screenshot_615.png)

- Ở phần dynamic updates này, bạn chỉ nên chọn các bản cập nhật được bảo mật

![](/Anh/Screenshot_616.png)

- Cuối cùng là bấm Finish để hoàn tất quá trình cấu hình

![](/Anh/Screenshot_617.png)

Sau khi hoàn tất cấu hình, chúng ta thực hiện khởi động lại dịch vụ dns trên Windows Server như sau:
- Truy cập vào **cmd** như sau: `Start --> Search --> cmd`
- Nhập các lệnh sau để tiến hành khởi động lại dịch vụ DNS
```
# Tắt dịch vụ dns
net stop dns

# Khởi động dịch vụ dns
net start dns

# Xóa bộ nhớ cache
ipconfig /flushdns

# Đăng ký lại
ipconfig /registerdns
```
### Tiến hành kiểm tra:
Kiểm tra bên phía Server

![](/Anh/Screenshot_618.png)

Kiểm tra bên phía Client `192.168.217.1`

![](/Anh/Screenshot_619.png)

Vậy là đã hoàn tất