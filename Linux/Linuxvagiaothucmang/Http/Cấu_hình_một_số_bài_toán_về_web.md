# Một số bài toán cấu hình webserver đơn giản:
Việc cấu hình các webserver này sẽ được tôi thực hành trên máy ảo chạy hệ điều hành UbuntuServer và sử dụng Apache2 để thực hiện. 

Thực hiện với quyền root trên máy(sử dụng `sudo su`)
## Bài 1: Cấu hình 1 websites, sử dụng 1 tên miền - 1 IP - 1 Port

Thực hiện tạo 1 file chứa trang web, đặt tên là bai1 ở trong đường dẫn `/var/www/html`.
- Thực hiện bằng câu lệnh `mkdir /var/www/html/bai1`.
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
    <h2>GOODBYE<!DOCTYPE html>
</body>
</html>
```
- Sau khi khởi tạo xong, thực hiện Lưu File và thoát `:wq`

Thực hiện tạo một file cấu hình VirtualHost cho trang web
- File sẽ nằm trong đường dẫn `/etc/apache2/sites-available`
- File cần tạo sẽ là một file cấu hình nên sẽ có đuôi `.conf`
- Sử dụng lệnh `vim bai1.conf` để tạo file và thực hiện chỉnh sửa file như sau:
- 