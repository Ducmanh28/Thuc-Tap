# Thực hiện cấu hình 1 số bài toán webserver đơn giản sử dụng NGINX trên CentOS 7
Trước khi vào phần thực hành, chúng ta cần:
- Đảm bảo NGINX đã được cài đặt và đang được chạy sẵn trên hệ điều hành
  - Sử dụng lệnh `nginx -v` để kiểm tra phiên bản
  - Sử dụng lệnh `systemctl status nginx` để kiểm tra trạng thái 
    - Nếu chưa được bật chạy thì có thể dùng `systemctl start nginx` và `systemctl enable nginx` để khởi động
- Đảm bảo rằng bạn có quyền **root** để truy cập vào Server CentOS 7
- Tạo 1 Folder chứa tất cả các bài làm ở trong đường dẫn /var/www
  - Sử dụng `mkdir Baitap`
  - Sau đó, tạo 4 folder con trong thư mục **Baitap** vừa tạo chứa các bài làm: `mkdir Bailam1`, `mkdir Bailam2`,... 
  - Tạo các thư mục chứa các file Log: `mkdir Log`, và lần lượt tạo các file `error.log` và `access.log`

Thay đổi quyền sở hữu: `chown nginx:nginx tên_file(thư mục)`

Chỉnh sửa nội dung file host trong `C:\Windows\System32\drivers\etc/hosts`

Bây giờ chúng ta đi vào các bài toán
## Bài 1: 1 Webserver, 1 Domain, 1 IP,  1 Port
Tạo file trang web bằng ngôn ngữ **HTML**, sử dụng trình soạn thảo VIM. File sẽ nằm trong `/var/www/Baitap/Bailam1`
- Tạo file: `vim /var/www/Baitap/Bailam1/index.html`
- Chép nội dung sau vào file:
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BaiLam1</title>
</head>
<body>
    <h1>Welcome to LDManh287's Website!</h1>
    <p>This is an example website using Nginx on CentOS 7.</p>
    <h2> CompleteBaiLam1</h2>
    <p>GoodBye!!!</p>
</body>
</html>
```
- Thực hiện lưu file và thoát khỏi VIM
- Thực hiện cấp quyền cho File:`chmod 755 Bailam1`

Tạo file cấu hình:
- Sử dụng VIM để tạo file: `vim /etc/nginx/conf.d/Bailamthu1.com.conf`
- Chép nội dung sau vào file: 
```
server {
        listen 80;
        server_name bailamthu1.com;
        location / {
                root /var/www/Baitap/Bailam1;
                index index.php index.html index.htm;
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html{
                root /usr/share/nginx/html;
        }
}
```
- Thực hiện lưu file và thoát khỏi VIM
 
Kiểm tra lại:
- Sử dụng lệnh `nginx -t` để kiểm tra xem file cấu hình đã đúng hay chưa 
- Nếu đã ổn, thực hiện restart lại nginx: `systemctl restart nginx`

Tạo domain trỏ tới địa chỉ IP trong file **hosts**: `192.168.142.210 bailamthu1.com`

Kiểm tra thành quả:

![](/Anh/Screenshot_410.png)

File Log:

![](/Anh/Screenshot_411.png)

## Bài 2: 1 Webserver, 3 Domain, 1 IP, 1 Port
Tạo file trang web:
- Sử dụng `vim /var/www/Baitap/Bailam2/index.html`
- Chép nội dung sau vào file:
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial -scale=1.0">
    <title>Bailam2</title>
</head>
<body>
    <h1>Welcome to LDManh287's Website!</h1>
    <p>This is an example website using Nginx on CentOS 7.</p>
    <h2> CompleteBaiLam2</h2>
    <p>GoodBye!!!</p>
</body>
</html>
```
- Thực hiện lưu và thoát khỏi VIM
- Kiểm tra lại phân quyền bằng lệnh `ll`

Tạo file cấu hình cho Bailam2
- File cấu hình nằm trong đường dẫn: `/etc/nginx/conf.d`
- Tạo file `vim Bailamthu2.com.conf`
- Chép nội dung sau vào file:
```
server{
    listen 80;
    server_name bailamthu2.com www.bailamthu2.com bailamthu2.vn;
    location / {
            root /var/www/Baitap/Bailam2;
            index index.html;
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html{
            root /usr/share/nginx/html;
    }

    error_log /var/www/Baitap/Bailam2/Log/error.log;
    access_log /var/www/Baitap/Bailam2/Log/access.log;
}
```
- Lưu và thoát khỏi vim

Kiểm tra lại:
- Sử dụng `nginx -t`:
- ![](/Anh/Screenshot_415.png)
- Khởi động lại nginx: `systemctl restart nginx`

Kiểm tra kết quả:

![](/Anh/Screenshot_412.png)

![](/Anh/Screenshot_413.png)

![](/Anh/Screenshot_414.png)

## Bài 3: 1 Website sử dụng 1 domain, 1 IP, 3 Port
Trước tiên chúng ta cần xác định xem sẽ dùng những Port nào. Để xem thông tin về Port, các bạn có thể xem tại [đây](https://github.com//Ducmanh28/Thuc-Tap/blob/main/OSIvaTCP-IP/4.%20TransportLayer.md)
- Tôi sẽ dùng Port mặc định 80
- 2 Port thêm lần lượt là 90 và 100
- Thực hiện mở 2 Port:
```
firewall-cmd --zone=public --add-port=90/tcp --permanent
firewall-cmd --zone=public --add-port=100/tcp --permanent
firewall-cmd --reload
```

Sau khi mở Port thành công, chúng ta tạo file trang web:
- Sử dụng: `vim /var/www/Baitap/Bailam3/index.html`
- Chép nội dung sau vào file:
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bailam3</title>
</head>
<body>
    <h1>Welcome to LDManh287's Website!</h1>
    <p>This is an example website using Nginx on CentOS 7.</p>
    <h2> CompleteBaiLam3</h2>
    <p>GoodBye!!!</p>
</body>
</html>
```
- Sau đó lưu và thoát khỏi VIM. 
- Lưu ý kiểm tra quyền 
Tạo file cấu hình cho trang web:
- Vào thư mục chứa file: `cd /etc/nginx/conf.d`
- Tạo file `vim Bailamthu3.com.conf`
- Chép nội dung sau vào file:
```
server{
    listen 80;
    listen 90;
    listen 100;
    server_name bailamthu3.com;
    location / {
            root /var/www/Baitap/Bailam3;
            index index.html;
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html{
            root /usr/share/nginx/html;
    }

    access_log /var/www/Baitap/Bailam3/Log/access.log;
    error_log /var/www/Baitap/Bailam3/Log/error.log;
}
```
- Lưu và thoát khỏi VIM

Kiểm tra lại:
- Sử dụng `nginx -t`
- Khởi động lại `systemctl restart nginx`

Tạo domain trỏ tới IP `192.168.142.210 bailam3.com`

Kiểm tra kết quả: 
- Nhập `bailamthu3.com:80`
- ![](/Anh/Screenshot_416.png)
- Nhập `bailamthu3.com:90`
- ![](/Anh/Screenshot_417.png)
- Nhập `bailamthu3.com:100`
- ![](/Anh/Screenshot_418.png)

## Bài 4: Cấu hình 2 webserver, 1 domain , 1 ip , nhiều Port
Ý tưởng: Mỗi webserver cho 1 port nhưng có cùng 1 domain

Tạo file `index1.html` trang web: tương tự như các bước ở trên
- Chép nội dung sau vào file:
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bailam 4.1</title>
</head>
<body>
    <h1>Welcome to LDManh287's Website!</h1>
    <p>This is an example website using Nginx on CentOS 7.</p>
    <h2> Complete BaiLam 4.1</h2>
    <p>GoodBye!!!</p>
</body>
</html>
```
- Tiếp tục tạo file `index2.html`
- Chép nội dung sau vào file:
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bailam 4.2</title>
</head>
<body>
    <h1>Welcome to LDManh287's Website!</h1>
    <p>This is an example website using Nginx on CentOS 7.</p>
    <h2> Complete BaiLam 4.2</h2>
    <p>GoodBye!!!</p>
</body>
</html>
```
Tạo file cấu hình nginx: Như cách làm ở các bài trên
- Chép nội dung sau vào file:
```
server{
    listen 80;
    server_name bailamthu4.com;
    location / {
            root /var/www/Baitap/Bailam4;
            index index1.html;
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html{
            root /usr/share/nginx/html;
    }

    access_log /var/www/Baitap/Bailam4/Log/access.log
    error_log /var/www/Baitap/Bailam4/Log/error.log
}

server{
    listen 90;
    server_name bailamthu4.com;
    location / {
            root /var/www/Baitap/Bailam4;
            index index2.html;
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html{
            root /usr/share/nginx/html;
    }

    access_log /var/www/Baitap/Bailam4/Log/access.log
    error_log /var/www/Baitap/Bailam4/Log/error.log    
}
```

Thực hiện kiểm tra và khởi động lại nginx

Thực hiện thêm domain

Kiểm tra kết quả:
- Nhập `bailamthu4.com`
- ![](/Anh/Screenshot_419.png)

- Nhập `bailamthu4.com:90`
- ![](/Anh/Screenshot_420.png)
