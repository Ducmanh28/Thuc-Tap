# Apache HTTP
MỤC LỤC
- [Apache HTTP](#apache-http)
  - [Cài đặt Apache2](#cài-đặt-apache2)
  - [Kiểm tra các file cấu hình của Apache 2](#kiểm-tra-các-file-cấu-hình-của-apache-2)
    - [apache2.conf](#apache2conf)
  - [Kiểm tra file Log apache2](#kiểm-tra-file-log-apache2)
  - [Tạo một trang web đơn giản sử dụng Apache2](#tạo-một-trang-web-đơn-giản-sử-dụng-apache2)
- [Một số bài toán cấu hình webserver đơn giản:](#một-số-bài-toán-cấu-hình-webserver-đơn-giản)
  - [Bài 1: Cấu hình 1 websites, sử dụng 1 tên miền - 1 IP - 1 Port](#bài-1-cấu-hình-1-websites-sử-dụng-1-tên-miền---1-ip---1-port)
  - [Bài 2: Cấu hình 1 Website sử dụng nhiều tên miền, 1 IP, 1 Port](#bài-2-cấu-hình-1-website-sử-dụng-nhiều-tên-miền-1-ip-1-port)
  - [Bài 3: Cấu hình 1 Webserver sử dụng 1 Domain, 1 IP, Nhiều Port](#bài-3-cấu-hình-1-webserver-sử-dụng-1-domain-1-ip-nhiều-port)
  - [Bài 4: Cấu hình 2 Webserver sử dụng 1 Domain, 1 IP, 2 Port](#bài-4-cấu-hình-2-webserver-sử-dụng-1-domain-1-ip-2-port)

## Cài đặt Apache2
- Sử dụng lệnh `sudo apt install apache2 -y` để cài đặt Apache cho Ubuntu Server
- Kiểm tra phiên bản để chắc chắn ứng dụng đã được cài bằng lệnh `apache2 -v`
- ![](/Anh/Screenshot_372.png)
- Thực hiện kiểm tra trạng thái xem Apache đã hoạt động hay chưa bằng một trong 2 lệnh sau:
  - `sudo service apache2 status` 
  - hoặc 
  - `sudo systemctl status apache2`
  - ![](/Anh/Screenshot_373.png)
## Kiểm tra các file cấu hình của Apache 2
Các file cấu hình của Apache2 sẽ nằm trong thư mục có đường dẫn sau: `/etc/apache2`

Sử dụng lệnh `ls -l` để xem các file cấu hình của apache2

![](/Anh/Screenshot_374.png)

- **apache2.conf**: Là file cấu hình chính của Apache2, nó chứa các chỉ thị cấu hình toàn cục cho máy chủ web như tên máy chủ, số lượng tiến trình, cách xử lý các yêu cầu,...
- **conf-available**: Thư mục chứa các file cấu hình có sẵn nhưng không được kích hoạt. Các file này thường liên quan đến các tính năng hoặc chức năng cụ thể của Apache, như bảo mật, nén,...
  - ![](/Anh/Screenshot_375.png)
  - Nội dung các file
    - **charset.conf**: Cài đặt bảng mã mặc định cho máy chủ
    - **localized-error-page.conf**: Cho phép sử dụng trang lỗi được định rõ cho các ngôn ngữ cụ thể
    - **other-vhosts-access-log.conf**: Cấu hình log của máy chủ khi dùng nhiều máy chủ ảo
    - **security.conf**: Bao gồm cấu hình an ninh, có thể chứa các cài đặt như giới hạn phương thức HTTP, tắt truy xuất tệp cấu hình,...
    - **serve-cgi-bin.conf**: Cấu hình phục vụ các tệp CGI từ mục `cgi-bin`
  - Có thể kích hoạt hoặc vô hiệu hóa các file này bằng lệnh `a2enconf` và `a2disconf`
- **conf-enabled**: Thư mục chứa các file cấu hình đã được kích hoạt. Các file này là liên kết tượng trưng đến các file trong thư mục **conf-available**. Các file này sẽ được đọc bởi **apache2.conf** khi khởi động máy chủ web
  - ![](/Anh/Screenshot_376.png)
- **envvars**: File chứa các biến môi trường cho Apache2. Các biến này sẽ được sử dụng bởi Script khởi động và dừng của Apache, như `apachectl` hoặc `service`. Các biến này bao gồm các đường dẫn tới các file quan trọng, tên người dùng và nhóm chạy Apache,...
- **magic**: File dùng để xác định kiểu MIME của các file. Kiểu MIME là một chuỗi kí tự đung để miêu tả nội dung của một file.
- **mod-available**: Thư mục chứa các module có sẵn nhưng không được kích hoạt. Các module là các thành phần mở rộng chức năng của Apache, cho phép nó hỗ trợ các giao thức, ngôn ngữ lập trình, hoặc các tính năng khác.
  - Có thể dùng `a2enmod` để khởi động và `a2dismod` để vô hiệu hóa
- **mod-enabled**: Thư mục chứa các module đã được kích hoạt. Các file này là các liên kết tượng trưng đến các file trong **mod-available**. Các file này sẽ được đọc bởi **apache2.conf** khi khởi động máy chủ web
- **ports.conf**: File cấu hình port cho Apache, xác định port nào sẽ lắng nghe yêu cầu từ Client. Mặc định Port cho HTTP sẽ là 80 và HTTPS sẽ là 443. Chúng ta có thể thay đổi các Port này nếu muốn
- **sites-available**: Thư mục chứa các virtual-host có sẵn nhưng không được kích hoạt. Virtual-host là một cách để Apache phục vụ nhiều trang web khác nhau trên cùng một máy chủ, bằng cách sử dụng tên miền hoặc địa chỉ IP khác nhau
  - ![](/Anh/Screenshot_377.png)
  - Nội dung các tệp:
    - **000-default.conf**: Là một tệp cấu hình mặc định được tạo khi bạn cài đặt apache2
    - **default-ssl.conf**: Tệp cấu hình SSL mặc định
  - Để kích hoạt, sử dụng lệnh `a2ensite` và vô hiệu hóa sử dụng lệnh `a2dissite`

### apache2.conf
Sử dụng lệnh `cat /etc/apache2/apache2.conf` để xem nội dung file cấu hình chính

```
DefaultRuntimeDir ${APACHE_RUN_DIR}
PidFile ${APACHE_PID_FILE}
Timeout 300
KeepAlive On
MaxKeepAliveRequests 100
KeepAliveTimeout 5
User ${APACHE_RUN_USER}
Group ${APACHE_RUN_GROUP}
HostnameLookups Off
ErrorLog ${APACHE_LOG_DIR}/error.log
LogLevel warn
IncludeOptional mods-enabled/*.load
IncludeOptional mods-enabled/*.conf
Include ports.conf
<Directory />
        Options FollowSymLinks
        AllowOverride None
        Require all denied
</Directory> 
<Directory /usr/share>
        AllowOverride None
        Require all granted
</Directory>
<Directory /var/www/>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
</Directory>
AccessFileName .htaccess
<FilesMatch "^\.ht">
        Require all denied
</FilesMatch>
LogFormat "%v:%p %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" vhost_combined
LogFormat "%h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %O" common
LogFormat "%{Referer}i -> %U" referer
LogFormat "%{User-agent}i" agent
IncludeOptional conf-enabled/*.conf
IncludeOptional sites-enabled/*.conf

```
Giải thích từng dòng trong đoạn mã:
- `DefaultRuntimeDir ${APACHE_RUN_DIR}`: Định nghĩa thư mục mặc định cho runtime files của Apache.
- `PidFile ${APACHE_PID_FILE}`: Xác định nơi lưu trữ tệp tin PID (Process ID) của Apache.
- `Timeout 300`: Thiết lập thời gian tối đa mà một kết nối có thể chờ đợi response từ máy chủ.
- `KeepAlive On`: Cho phép sử dụng Keep-Alive để giữ mở các kết nối HTTP để sử dụng lại chúng cho các yêu cầu sau.
- `MaxKeepAliveRequests 100`: Đặt giới hạn số yêu cầu tối đa cho mỗi kết nối Keep-Alive.
- `KeepAliveTimeout 5`: Thiết lập thời gian chờ tối đa cho mỗi yêu cầu khi sử dụng Keep-Alive.
- `User ${APACHE_RUN_USER}`: Định nghĩa người dùng hệ thống dùng để chạy các worker processes của Apache.
- `Group ${APACHE_RUN_GROUP}`: Xác định nhóm người dùng mà worker processes của Apache sẽ chạy dưới
- `HostnameLookups Off`: Tắt việc thực hiện định danh máy chủ dựa trên địa chỉ IP
- `ErrorLog ${APACHE_LOG_DIR}/error.log`: Đặt đường dẫn của tệp log lỗi.
- `LogLevel warn`: Thiết lập cấp độ log cho các thông báo lỗi.
- `IncludeOptional mods-enabled/*.load` và `IncludeOptional mods-enabled/*.conf`: Bao gồm các tệp tin cấu hình và modules từ thư mục mods-enabled.
- `Include ports.conf`: Bao gồm tệp cấu hình cho cổng mạng.
- `<Directory />`: Cấu hình quyền truy cập cho thư mục gốc.
- `<Directory /usr/share>` và `<Directory /var/www/>`: Cấu hình quyền truy cập cho các thư mục con trong hệ thống tệp tin.
- `AccessFileName .htaccess`: Xác định tên tệp tin cấu hình tài nguyên
- `<FilesMatch "^\.ht">`: Cấu hình quyền truy cập cho các tệp tin có tên bắt đầu bằng ".ht".
- `LogFormat ...`: Định dạng log cho các thông điệp log.
- `IncludeOptional conf-enabled/*.conf` và `IncludeOptional sites-enabled/*.conf`: Bao gồm các tệp cấu hình từ thư mục conf-enabled và sites-enabled.

## Kiểm tra file Log apache2
File log của Apache 2 nằm trong thư mục có đường dẫn sau: `/var/log/apache2/`

![](/Anh/Screenshot_379.png)

Một số tập Log quan trọng:
- **access.log**: Ghi lại mọi yêu cầu được gửi đến máy chủ, bao gồm thông tin về địa chỉ IP của máy client, tài nguyên được yêu cầu, mã trạng thái và nhiều thông tin khác
- **error.log**: Ghi lại thông báo lỗi của máy chủ Apache, bao gồm lỗi cấu hình, lỗi HTTP và một số lỗi khác
- **other_vhosts_access.log**: Nếu máy chủ Apache được cấu hình để chạy nhiều máy chủ ảo(Virtual Hosts), thông tin truy cập cho từng máy chủ ảo có thể được ghi vào tệp nhật ký riêng

Có thể dùng các lệnh như `cat`, `less`, `tail -f` để xem nội dung các file này

![](/Anh/Screenshot_378.png)

## Tạo một trang web đơn giản sử dụng Apache2 
Tạo 1 thư mục chứa các tệp của trang web trong đường dẫn `/var/www/html/`
- Ví dụ: `mkdir /var/www/html/myweb`, sau đó cấp quyền bằng cách dùng lệnh `chmod 777 myweb`
- ![](/Anh/Screenshot_380.png)

Bây giờ, sẽ cần chút am hiểu về ngôn ngữ lập trình web HTML để code một trang web đơn giản:
- Sử dụng vim để tạo file:`cd /var/www/html/myweb` để truy cập vào thư mục chứa web và dùng `vim index.html` để tạo file trang web
- Có thể dùng nội dung code đơn giản như sau:
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
    <p>Welcome to my website hosted on Apache2.</p>
    <h2>Thanks for vistting my website!</h2>
    <p>Now, let's create your website<p>
    <h3>GOODBYE!!!</h3>
</body>
</html>
```
- Sau khi viết code xong, lưu và đóng tệp

Chỉnh sửa file cấu hình Apache2:
- Thêm 1 file cấu hình mới bằng lệnh: `sudo vim /etc/apache2/sites-available/myweb.conf`
- Thêm đoạn code sau để cấu hình Virtual Host:
```
<VirtualHost *:80>
    ServerAdmin luongducmanh02@gmail.com
    ServerName mywebsite.com
    DocumentRoot /var/www/html/mywebsite

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
Giải thích:
- **<VirtualHost *:80>**: Dòng này bắt đầu một khối cấu hình cho một virtual host, chỉ định rằng nó sẽ áp dụng cho bất kỳ địa chỉ IP nào (theo dấu *) trên cổng 80. 
- **ServerAdmin webmaster@mywebsite.com**: Dòng này chỉ định địa chỉ email của người quản trị máy chủ web. Địa chỉ này sẽ được hiển thị trong các trang lỗi hoặc các thông báo từ máy chủ web, để người dùng có thể liên hệ khi gặp sự cố
- **ServerName mywebsite.com**: Dòng này chỉ định tên miền của virtual host. Tên miền này sẽ được sử dụng để phân biệt các virtual host khác nhau trên cùng một máy chủ, bằng cách so sánh với trường Host trong yêu cầu HTTP. Bạn cần phải có một bản ghi DNS cho tên miền này, trỏ đến địa chỉ IP của máy chủ web, hoặc không ai có thể truy cập trang web của bạn
- **DocumentRoot /var/www/myweb**: Dòng này chỉ định đường dẫn đến thư mục chứa các file tĩnh của virtual host, như HTML, CSS, JS, hình ảnh, v.v. Đây là nơi Apache sẽ tìm kiếm các file khi nhận được yêu cầu từ người dùng. Bạn cần phải đảm bảo rằng thư mục này tồn tại và có quyền truy cập cho Apache1.
- **ErrorLog ${APACHE_LOG_DIR}/error.log**: Dòng này chỉ định đường dẫn đến file nhật ký lỗi của virtual host. File này sẽ ghi lại các lỗi xảy ra trong quá trình xử lý yêu cầu, như không tìm thấy file, quyền truy cập bị từ chối, v.v. File này sẽ giúp bạn kiểm tra và khắc phục các sự cố. Biến ${APACHE_LOG_DIR} là một biến môi trường được định nghĩa trong file envvars của Apache
- **CustomLog ${APACHE_LOG_DIR}/access.log combined**: Dòng này chỉ định đường dẫn đến file nhật ký truy cập của virtual host. File này sẽ ghi lại các thông tin về các yêu cầu được nhận và phản hồi được gửi, như địa chỉ IP, thời gian, phương thức, URL, mã trạng thái, kích thước, v.v. Tham số combined là một định dạng nhật ký tiêu chuẩn, bao gồm các thông tin cơ bản và một số thông tin bổ sung, như trình duyệt và trang giới thiệu
- **<./VirtualHost>**: Dòng này kết thúc khối cấu hình cho virtual host

Thực hiện khởi chạy `myweb.conf` và restart Apache2
- `sudo a2ensite myweb.conf`
- `sudo systemctl restart apache2`
- ![](/Anh/Screenshot_383.png)

Thực hiện cấp tên miền để có thể phân giải:
- Truy cập vào đường dẫn sau: `C:\Windows\System32\drivers\etc`
- Tìm file `hosts` và thực hiện thêm tên miền vào
- ` 192.168.142.142 ducmanh287`
- Thực hiện lưu và thoát

Lên trình duyệt bất kì và tìm kiếm theo tên miền bạn đã cài: `ducmanh287.com`

Trang web của bạn sẽ hiện ra:
![](/Anh/Screenshot_384.png)

# Một số bài toán cấu hình webserver đơn giản:
Việc cấu hình các webserver này sẽ được tôi thực hành trên máy ảo chạy hệ điều hành UbuntuServer và sử dụng Apache2 để thực hiện. 

Thực hiện với quyền root trên máy(sử dụng `sudo su`)
## Bài 1: Cấu hình 1 websites, sử dụng 1 tên miền - 1 IP - 1 Port

Thực hiện tạo 1 file chứa trang web, đặt tên là bai1 ở trong đường dẫn `/var/www/`.
- Thực hiện bằng câu lệnh `mkdir /var/www/bai1`.
- Đây sẽ là thư mục chứa tất cả các file như PHP, HMTL, hình ảnh, video,... liên quan đến việc khởi tạo trang web
- Do chúng ta chỉ cần thao tác một trang web đơn giản, sử dụng ngôn ngữ html
- Khởi tạo 1 file html bằng lệnh `vim bai1.html` và ghi nội dung như sau:
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BAI1</title>
</head>
<body>
    <h1>Hello, this is my simple website!</h1>
    <p>Tao thanh cong 1 website 1 domain, 1 ip, 1 port</p>
    <h2>GOODBYE<h2>
</body>
</html>
```
- Sau khi khởi tạo xong, thực hiện Lưu File và thoát `:wq`
- Thực hiện cấp quyền truy cập cho thư mục `bai1` bằng lệnh: `chmod 777 bai1`

Thực hiện tạo một file cấu hình VirtualHost cho trang web
- File sẽ nằm trong đường dẫn `/etc/apache2/sites-available`
- File cần tạo sẽ là một file cấu hình nên sẽ có đuôi `.conf`
- Sử dụng lệnh `vim bai1.conf` để tạo file và thực hiện chỉnh sửa file như sau:
```
<VirtualHost *:80>
    ServerAdmin luongducmanh02@gmail.com
    ServerName bailam1.com
    DocumentRoot /var/www/bai1

    ErrorLog /var/log/apache2/error.log
    CustomLog /var/log/apache2/access.log combined
</VirtualHost>
```
- Thực hiện lưu file `:wq` 
- Khởi động file cấu hình mạng bằng lệnh `a2ensite bai1.conf`
- Restart lại apache2 bằng lệnh `systemctl restart apache2`

Thực hiện set dns trong `/etc/hosts` của UbuntuServer hoặc trong `Systems32` của Windows

Thực hiện kiểm tra lại 
![](/Anh/Screenshot_388.png)

Như thế này là đã thành công

## Bài 2: Cấu hình 1 Website sử dụng nhiều tên miền, 1 IP, 1 Port
Thực hiện tạo thư mục `bai2` trong đường dẫn `/var/www` 
- Thực hiện tạo file trang web đuôi `.html` có nội dung như sau:
- ![](/Anh/Screenshot_392.png)
- Lưu file và cấp quyền cho phép Apache2 khởi chạy thư mục bằng lệnh `chmod 777 bai2`
- 
Tạo thư mục chứa file cấu hình apache2 của bài 2 bằng cách sử dụng lệnh `vim /etc/apache2/sites-available/bai2.conf`
- Chỉnh sửa file cấu hình với nội dung như sau:
```
<VirtualHost *:80>
    ServerAdmin luongducmanh02@gmail.com
    ServerName www.bailam2.com
    ServerAlias www.bailam21.com
    DocumentRoot /var/www/bai2
</VirtualHost>
```
- Thực hiện lưu file vừa tạo `:wq`
- Khởi chạy file cấu hình: `a2ensite bai2.conf`
- Khởi động lại Apache2: `systemctl restart apache2`

Thực hiện tạo DNS để phân giải tên miền trong `Systems32/drivers/etc/hosts`
```
192.168.142.142 www.bailam2.com
192.168.142.142 www.bailam21.com
```
Kiểm tra kết quả:
![](/Anh/Screenshot_390.png)
![](/Anh/Screenshot_391.png)

Như vậy là đã thành công!

## Bài 3: Cấu hình 1 Webserver sử dụng 1 Domain, 1 IP, Nhiều Port

Thực hiện tạo file code trang web
- Tạo thư mục chứa: `mkdir /var/www/bai3`
- Cấp quyền cho apache2 chạy thư mục: `chmod 777 /var/www/bai3`
- Tạo file `.html`: `vim /var/www/bai3/bai3.html`
- Thêm vào code như sau:
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BAI3</title>
</head>
<body>
    <h1>Hello, this is my simple website!</h1>
    <p>Tao thanh cong 1 website 1 domain, 1 ip, nhieu port</p>
    <h2>GOODBYE<h2>
</body>
</html>
```
- Lưu và thoát khỏi VIM: `:wq`
- Kiểm tra lại: `cat /var/www/bai3/bai3.html`
- ![](/Anh/Screenshot_393.png)

Thực hiện thêm các port
- Thêm port bằng cách chỉnh sửa file `ports.conf`
  - Thêm vào dòng mới `Listen 81`
  - ![](/Anh/Screenshot_394.png)

Thực hiện tạo file cấu hình Apache2 cho trang web
- Tạo file `.conf` bằng **VIM** dùng câu lệnh sau: `vim /etc/apache2/sites-available/bai3.conf`
- Thực hiện thêm vào file nội dung như sau:
```
<VirtualHost *:80>
    ServerAdmin luongducmanh02@gmail.com
    ServerName bailam3.com
    DocumentRoot /var/www/bai3
</VirtualHost>

<VirtualHost *:81>
    ServerAdmin luongducmanh02@gmail.com
    ServerName bailam3.com
    DocumentRoot /var/www/bai3
</VirtualHost>
```
- Thực hiện lưu file và đóng **VIM** `:wq`
- Khởi chạy file cấu hình `a2ensite bai3.conf`
- Khởi động lại Apache2 `systemctl restart apache2`

Thực hiện tạo DNS để phân giải tên miền
```
192.168.142.142 bailam3.com
```

Kiểm tra kết quả:
![](/Anh/Screenshot_396.png)
![](/Anh/Screenshot_395.png)


## Bài 4: Cấu hình 2 Webserver sử dụng 1 Domain, 1 IP, 2 Port
Thực hiện tạo file code trang web:
- Tạo 2 thư mục chứa 2 file trang web
  - `mkdir /var/www/bai4` chứa file `.html` trang web thứ nhất
  - `mkdir /var/www/bai41` chứa file `.html` trang web thứ hai
- Cấp quyền cho 2 thư mục:
  - `chmod 777 bai4`
  - `chmod 777 bai41`
Thực hiện tạo file cấu hình:
- File cấu hình sẽ nằm trong `/etc/apache2/sites-available`
- Tạo file `bai4.conf`
- Do tạo 2 trang web, sử dụng 2 Ports, ý tưởng của bài sẽ là mỗi trang web sử dụng 1 ports khác nhau nhưng có cùng 1 domain và ip, và chúng ta cần phải tạo 2 VirtualHost
- Nội dung file:
```
<VirtualHost *:80>
    ServerAdmin luongducmanh02@gmail.com
    ServerName bailam4.com
    DocumentRoot /var/www/bai4
</VirtualHost>

<VirtualHost *:81>
    ServerAdmin luongducmanh02@gmail.com
    ServerName bailam4.com
    DocumentRoot /var/www/bai41
</VirtualHost>
``` 
- Khởi động trang web: `a2ensite bai4.conf`
- Khởi động lại Apache2: `systemctl restart apache2`

Đặt DNS phân giải tên miền:
- `192.168.142.142 bailam4.com`

Kiểm tra kết quả:
![](/Anh/Screenshot_397.png)
![](/Anh/Screenshot_398.png)
