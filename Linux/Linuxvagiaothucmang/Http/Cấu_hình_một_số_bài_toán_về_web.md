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