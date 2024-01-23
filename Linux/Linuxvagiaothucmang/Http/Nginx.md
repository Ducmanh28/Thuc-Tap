# Mục này tìm hiểu về Nginx trong UbuntuServer

## Nginx là gì?
Là một phần mềm webServer mã nguồn mở. Ban đầu, được tạo ra nhằm phục vụ webHTTP nhưng ngày nay, nó cũng được dùng làm reverse proxy, HTTP load balancer và email proxy như IMAP, POP3 và SMTP

Nginx được xuất bản tháng 10 năm 2004. Nhà sáng lập của nó triển khai dự án từ năm 2002 nhằm giải quyết [vấn đề C10K](https://en.wikipedia.org/wiki/C10k_problem)- là giới hạn của việc xử lý 10000 kết nối cùng 1 lúc. Nginx đã sử dụng kiến trúc hướng sự kiện(event-driven) không đồng bộ(asynchronous). Tính năng này khiến Nginx Server trở nên đáng tin cậy, tốc độ và có khả năng mở rộng lớn nhất

Nhờ khả năng mạnh mẽ, có thể xử lý hàng ngàn kết nối cùng lúc nên nhiều website có traffic lớn đã sử dụng dịch vụ NGINX. Trong đó có một vài ông lớn như là Google, Netflix, Cloudflare, WordPress,....

## Cách Nginx hoạt động:
Để hiểu cách Nginx hoạt động ra sao thì trước hết ta cần hiểu cách mà 1 webserver vận hành như thế nào!
- Khi bạn yêu cầu 1 trang web trên trình duyệt
  - Trình duyệt sẽ bắt đầu liên lạc với webserver chứa trang web đó
  - Từ webserver mới truy tìm các file liên quan
  - Webserver sẽ trả lại trình duyệt trang web
- Thông thường, mỗi yêu cầu sẽ được xử lý tuần tự theo các bước như trên sẽ được gọi là Single Thread hay cấu trúc luồng. Server sẽ tạo ra 1 thread cho mỗi yêu cầu

Nginx hoạt động theo một cách khác. 
- Hoạt động theo kiến trúc bất đồng bộ, hướng sự kiện. Có thể được hiểu là: Nhứng thread tương đồng nhau sẽ được quản lý bởi 1 process, và mỗi tiến trình này chứa các thực thể nhỏ hơn là *worker connections*. Cả bộ đơn vị này chịu trách nhiệm xử lý các threads
- Worker connection sẽ gửi yêu cầu cho worker process, sau đó yêu cầu này được gửi tới master process. Cuối cùng, Master Process sẽ trả về kết quả cho những yêu cầu đó
- Điều này trông có vẻ đơn giản, một Worker Connection có thể xử lý đến 1024 yêu cầu khác nhau. Vì vậy mà NGINX có thể xử lý hàng ngàn yêu cầu mà không gặp rắc rối gì

## Các tính năng mà Nginx có thể sử dụng:
Máy chủ Web: Có khả năng hoạt động như một máy chủ web, hỗ trợ các giao thức HTTP và HTTPS. Có khả năng phục vụ các tệp tĩnh và động

Reverse Proxy: Có khả năng hoạt động như một máy chủ Proxy ngược, điều hướng yêu cầu từ người dùng đến các máy chủ ứng dụng hoặc dịch vụ phía sau một cách hiệu quả

Cân bằng tải: Nginx cung cấp tính năng cân bằng tải tự động giữa nhiều máy chủ, giúp phân phối tải và tăng cường sẵn sàng và hiệu suất

Mô-đun và Tùy chọn cấu hình linh hoạt

Hiệu suất cao: Có khả năng xử lý hàng ngàn kết nối, tuy nhiên chỉ sử dụng mức tài nguyên tối thiểu

## So sánh giữa NGINX và APACHE
||Nginx|Apache|
|-|----|------|
|Hệ điều hành|Hỗ trợ một số Unix hiện đại và một số tính năng cho window|Chạy trên tất cả các loại hệ thống Unix-like và hỗ trợ đầy đủ cho Windows.|
|Hỗ trợ từ người dùng|Có sự hỗ trợ rất tốt|Thiếu sự hỗ trợ người dùng từ phía công ty (Apache Foundation)|
|Tính năng|Có khả năng xử lý đến 10000 kết nối với nội dung tĩnh nhanh gấp 2.5 lần so với Apache. Sử dụng ít bộ nhớ hơn|Xử lý cùng lúc ít kết nối và tốc độ không được nhanh như Nginx|

## Sử dụng Nginx
### Cài đặt NGINX trên CentOS7
- Cài đặt gói EPEL: `yum install -y epel-release`
- Update: `yum -y update`
- Cài đặt NGINX: `yum install -y nginx`
- Kiểm tra lại cài đặt bằng lệnh `nginx -v`
- ![](/Anh/Screenshot_399.png)
- Khởi chạy Nginx và kiểm tra trạng thái:
```
systemctl start nginx
systemctl enable nginx
systemctl status nginx
```
![](/Anh/Screenshot_401.png)
### Kiểm tra các file Nginx:
Các file cấu hình:
- Sử dụng `ls -l /etc/nginx` để kiểm tra các file của NGINX
- ![](/Anh/Screenshot_400.png)
  - `conf.d` và `default.d`: Các thư mục chứa các file cấu hình phụ
  - `fastcgi.conf` và `fastcgi.conf.default`: Đây là các file cấu hình cho FastCGI - một giao thức để liên kết giữa web server và các ứng dụng
  - `koi-utf` và `koi-win`: Các file cấu hình cho việc mã hóa kí tự
  - `mime.types` và `mime.types.defaults`: File định nghĩa các loại media như hình ảnh, văn bản, video,... dựa trên phần mở rộng của tên file
  - `nginx.conf` và `nginx.conf.default`: Là file cấu hình chính của NGINX
  - `scgi_params` và `scgi_params.default`: Đây là file cấu hình cho SCGI(Simple Common Gateway Interface)
  - `uwsgi)params` và `uwsgi params.default`: Đây là file cấu hình cho uWSGI(Universal Web Server GateWay Interface) 
  - `win-utf`: Đây là một file cấu hình khác liên quan đến mã hóa kí tự
- Giải thích chi tiết file cấu hình `nginx.conf`
  - Mặc định thì file cấu hình của NGINX sẽ nằm trong `etc/nginx/nginx.conf`
  - Nội dung file:
```
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;
    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;
    include /etc/nginx/conf.d/*.conf;
    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;
        include /etc/nginx/default.d/*.conf;
        error_page 404 /404.html;
        location = /404.html {
        }
        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }
}

```
  - Nginx sẽ quản lý cấu hình theo **Derective** và **Block**, trong đó:
    - **Derective** là các câu lệnh cấu hình cụ thể
    - **Block** là các khối lưu trữ một tập hợp các câu lệnh dùng cho một việc gì đó
    - File cấu hình `nginx.conf` sẽ gồm 3 block chính
      - MainBlock: Là khối cấu hình chung nhất, còn được gọi là khối *global*. Những câu lệnh không thuộc khối nào sẽ được nhóm vào khối này. Những cấu hình trong khối này sẽ ảnh hưởng đến toàn bộ máy chủ 
      - EventBlock: Chứa các câu lệnh liên quan đến việc xử lý kết nối mạng. 
      - HttpBlock: Chứa các chỉ thị cấu hình cho máy chủ Http. Nó thường chứa một hoặc nhiều khối Server. Mỗi khối Server sẽ đại diện cho một máy chủ ảo(virtual server) và thường chứa một hoặc nhiều khối location
  - Giai thích từng dòng code:
    - `user nginx`: Xác định người dùng và nhóm mà quá trình Nginx sẽ chạy dưới đó. Trong trường hợp này, Nginx sẽ chạy với quyền của người dùng nginx.
    - `worker_processes auto`: Xác định số lượng tiến trình worker (worker processes) sẽ được tạo ra để xử lý các yêu cầu. auto có nghĩa là Nginx sẽ tự động quyết định số lượng worker dựa trên số lõi CPU có sẵn.
    - `error_log /var/log/nginx/error.log`: Xác định đường dẫn của tệp nhật ký lỗi.
    - `pid /run/nginx.pid;`: Xác định nơi lưu trữ tệp PID (Process ID) của quá trình chính của Nginx.
    - `include /usr/share/nginx/modules/*.conf`: Bao gồm tất cả các tệp cấu hình từ thư mục /usr/share/nginx/modules/.
    - `events { ... }`: Mô tả cấu hình cho phần sự kiện của Nginx.
    - `worker_connections 1024;`: Miêu tả 1 worker_connections có thể làm việc với 1024 kết nối cùng một lúc. Tuy nhiên con số 1024 có thể tăng giảm tùy vào sức mạnh phần cứng và nhu cầu sử dụng của bạn
    - `http { ... }`: Mô tả cấu hình cho phần HTTP của Nginx.
    - `log_format main ...`: Định nghĩa định dạng cho tệp nhật ký truy cập (access log). Điều này quyết định cách thông tin sẽ được ghi vào tệp nhật ký.
    - `access_log /var/log/nginx/access.log main;`: Xác định đường dẫn của tệp nhật ký truy cập và sử dụng định dạng main đã được định nghĩa ở trên.
    - `sendfile on;`: Cho phép sử dụng sendfile để sao chép dữ liệu từ file tới một socket mà không cần copy thông qua bộ đệm của ứng dụng.
    - `tcp_nopush on;` và `tcp_nodelay on;`: Các tùy chọn TCP để kiểm soát chế độ làm việc với gói tin TCP.
    - `keepalive_timeout 65;`: Xác định thời gian giữa các kết nối keep-alive.
    - `types_hash_max_size 4096;`: Đặt kích thước tối đa cho bảng hash sử dụng để xác định kiểu MIME của một tệp.
    - `include /etc/nginx/mime.types;`: Bao gồm tệp mime.types để xác định kiểu MIME của các tệp.
    - `default_type application/octet-stream;`: Xác định kiểu MIME mặc định nếu không thể xác định được kiểu MIME thực tế.
    - `include /etc/nginx/conf.d/*.conf;`: Bao gồm tất cả các tệp cấu hình từ thư mục /etc/nginx/conf.d/.
    - `server { ... }`: Bắt đầu khai báo cấu hình cho một server block (một trang web cụ thể).
    - `listen 80`; và `listen [::]:80;`: Xác định cổng lắng nghe cho server block (port 80 cho IPv4 và IPv6).
    - `server_name _;`: Xác định tên máy chủ cho server block (trong trường hợp này, đối với mọi tên máy chủ).
    - `root /usr/share/nginx/html;`: Xác định thư mục gốc cho server block.
    - `include /etc/nginx/default.d/*.conf;`: Bao gồm các tệp cấu hình mặc định cho server block.
    - `error_page 404 /404.html;`: Xác định trang lỗi cho mã lỗi 404.
    - `location = /404.html { ... }`: Định nghĩa vị trí của trang lỗi 404.
    - `error_page 500 502 503 504 /50x.html;`: Xác định trang lỗi cho mã lỗi 500, 502, 503, và 504.
    - `location = /50x.html { ... }`: Định nghĩa vị trí của trang lỗi 50x.

File log của Nginx:
- Nằm trong dường dẫn: `/var/log/nginx/`
  - `access.log`:  Sẽ chứa các log đăng nhập
  - `error.log`: sẽ chứa các lần log bị lỗi

### Tạo trang web cơ bản sử dụng NGINX trên CentOS 7:
- Tạo thư mục chứa các file cấu thành trang web:
  - Sử dụng câu lệnh: `mkdir /usr/share/nginx/newpage`
  - Cấp quyền thực thi: `chmod 755 /usr/share/nginx/newpage`
  - Tạo file ngôn ngữ cấu tạo trang web: 
    - Truy cập vào thư mục chứa file `cd /usr/share/nginx/newpage`
    - Sử dụng VIM: `vim index.html` 
    - Thêm vào nội dung như sau, rồi lưu và thoát khỏi VIM: 
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Page</title>
</head>
<body>
    <h1>Welcome to LDManh287's Website!</h1>
    <p>This is an example website using Nginx on CentOS 7.</p>
    <h2> Goodbye!!!</h2>
    <p>Now, let's creat your websites</p>
</body>
</html>
```

- Tạo file cấu hình NGINX cho trang web:
  - File cấu hình sẽ nằm trong thư mục có đường dẫn: `/etc/nginx/conf.d`
  - Chúng ta sẽ hạn chế chỉnh sửa trên file cấu hình chính của Nginx
  - Sử dụng VIM: `vim /etc/nginx/conf.d/newpage.com.conf`
  - Thêm vào nội dung sau rồi lưu và thoát khỏi VIM:
```
server{
        listen 80;
        server_name newpage.com www.newpage.com;

        location / {
                root /usr/share/nginx/newpage;
                index index.html;
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html{
                root /usr/share/nginx/html;
        }
}
```
- Thực hiện kiểm tra và khởi động lại file cấu hình
  - Kiểm tra các file cấu hình đã đúng hay chưa: `nginx -t`
  - ![](/Anh/Screenshot_402.png)
  - Nếu hiện ra như hình, ta khởi động lại dịch vụ của Nginx: `systemctl restart nginx`
- Thực hiện cài DNS để phân giải tên miền:
    ```
    192.168.142.210 newpage2873.com
    192.168.142.210 www.newpage2873.com
    ```
