# Tìm hiểu về WordPress
Mục Lục
- [Tìm hiểu về WordPress](#tìm-hiểu-về-wordpress)
  - [Tổng quan về WordPress?](#tổng-quan-về-wordpress)
  - [Cách WordPress hoạt động ra sao?](#cách-wordpress-hoạt-động-ra-sao)
  - [Sử dụng WordPress](#sử-dụng-wordpress)
    - [Cài đặt L.A.M.P](#cài-đặt-lamp)
    - [Tạo cơ sở dữ liệu cho tài khoản WordPress](#tạo-cơ-sở-dữ-liệu-cho-tài-khoản-wordpress)
    - [Tiến hành cài WordPress:](#tiến-hành-cài-wordpress)
    - [Cấu hình WordPress](#cấu-hình-wordpress)
    - [Hoàn thành giao diện WordPress](#hoàn-thành-giao-diện-wordpress)
    - [Tạo thử một trang web sử dụng WordPress](#tạo-thử-một-trang-web-sử-dụng-wordpress)

## Tổng quan về WordPress?
Là một hệ thống mã nguồn mở dùng để xuất bản blog/website

Được viết bằng ngôn ngữ lập trình PHP và sử dụng cơ sở dữ liệu MySQL

Được biết đến như một CMS miễn phí nhưng tốt, dễ sử dụng và phổ biến nhất trên thế giới

Với WordPress, chúng ta có thể tạo trang web thương mại điện tử, cổng thông tin, portfolio online, diễn đàn thảo luận

## Cách WordPress hoạt động ra sao?
Hoạt động dựa trên kiến trúc client-server trong đó:
- Server Side
  - Ngôn ngữ lập trình: Được viết bằng PHP
  - Cơ sở dữ liệu MySQL hoặc MariaDB để lưu trữ dữ liệu như bài viết, trang, bình luận, cài đặt và nhiều thông tin khác
  - Môi trường WebServer: Hoạt động dựa trên các máy chủ Web như Apache, Nginx hoặc Microsoft IIS
- Client Side
  - Trình duyệt Web: Người dùng truy cập vào trang web WordPress thông qua một trình duyệt web như Google Chrome, Mozilla FireFox, hoặc Safari,...
  - HTML/CSS/JavaScript: WordPress sinh ra mã HTML,CSS và JS để hiển thị nội dung và tương tác với người dùng

Quy trình hoạt động:
- Khởi đầu:
  - Người quản trị cài đặt WordPress trên máy chủ web và cấu hình kết nối với cơ sở dữ liệu
- Xử lý yêu cầu:
  - Khi người dung truy cập trang web của WordPress, máy chủ nhận yêu cầu từ trình duyệt của họ
  - Máy chủ sử dụng các mã nguồn PHP để tạo ra các trang web động dựa trên yêu cầu của người dùng
- Truy xuất dữ liệu:
  - WP truy vấn cơ sở dữ liệu để lấy thông tin cần thiết như bài viết, trang, cài đặt, và các tùy chọn khác
- Tạo và Render HTML:
  - Dữ liệu từ cơ sở dữ liệu được dùng để tạo HTML, CSS và JS cần thiết để hiển thị trang web
  - Mã HTML được tạo dựa trên các themes và plugin được cài đặt
- Gửi Phản Hồi:
  - Mã HTML, CSS và JavaScript được gửi từ máy chủ đến trình duyệt của người dùng qua giao thức HTTP.
  - Trình duyệt của người dùng hiển thị trang web được tạo ra bởi WordPress.
- Tương Tác với Người Dùng:
  - Người dùng tương tác với trang web bằng cách nhấp chuột, điền vào các biểu mẫu, hoặc thực hiện các hành động khác.
  - JavaScript được sử dụng để xử lý các sự kiện và tương tác người dùng một cách mượt mà.
- Cập Nhật Dữ Liệu:
  - Khi người dùng tạo mới hoặc cập nhật nội dung (ví dụ: viết bài, thêm bình luận), WordPress cập nhật cơ sở dữ liệu tương ứng.

## Sử dụng WordPress
-  Trước khi cài WordPress, ta cần phải tiến hành cài L.A.M.P trên máy Server
-  LAMP là một nội dung thiết yếu khi máy muốn sử dụng để làm WebServer. Nhưng nó là các mảng không thống nhất với nhau, để quản trị được các mảng đó, ta sử dụng WordPress.
### Cài đặt L.A.M.P
Tham khảo tại [đây](https://docs.google.com/document/d/1B9yRPQWeYw4L0qxPBNBS6hb31WlLMyesmMyQx2reafY/edit#heading=h.mqaz6ogkl82d)

### Tạo cơ sở dữ liệu cho tài khoản WordPress
Đăng nhập vào MariaDB bằng tài khoản root:
`mysql -u root -p`

Bạn sẽ cần phải nhập mật khẩu root mà bạn đã tạo khi setting MariaDB.

Sau khi đăng nhập thành công, bạn nhập khối lệnh sau để khởi tạo người dùng và database mới
```
CREATE DATABASE wordpress;
CREATE USER ducmanh@localhost IDENTIFIED BY 'ducmanh2872003';
GRANT ALL PRIVILEGES ON wordpress.* TO ducmanh@localhost INDENTIFIED BY 'ducmanh2872003';
FLUSH PRIVILEGES; 
```

Sau khi khởi tạo thành công, thoát khỏi MariaDB: `exit`

### Tiến hành cài WordPress:
Sử dụng lệnh `wget` để cài. Lưu ý, bạn đang ở thư mục nào thì `wget` sẽ cài về thư mục đó
- Sử dụng `cd /var/www/html` để truy cập vào đường dẫn
- Sử dụng `sudo wget https://vi.wordpress.org/wordpress-6.2.3-vi.tar.gz` để cài WordPress
- ![](/Anh/Screenshot_422.png)
- Giải nén file sử dụng `sudo tar xvfz wordpress-6.2.3-vi.tar.gz    `
- ![](/Anh/Screenshot_423.png)
### Cấu hình WordPress
- Di chuyển đến thư mục chứa file cấu hình:
  - `cd /var/www/html/wordpress`
- Kiểm tra các file: `ll`
- ![](/Anh/Screenshot_424.png)
  - File cấu hình của WordPress là `wp-config.php`
  - Nhưng do chỉ có file `wp-config-sample.php` nên để cho an toàn, thay vì đổi tên ta thực hiện copy ra một file mới
- Sử dụng VIM để thực hiện các chỉnh sửa: `vim wp-config.php`
- ![](/Anh/Screenshot_425.png)
- Thực hiện chỉnh sửa nội dung file như sau:
```
/** Tên database cho WordPress */
define( 'DB_NAME', 'wordpress' );

/** tên User Database */
define( 'DB_USER', 'ducmanh' );

/** Password của User */
define( 'DB_PASSWORD', 'ducmanh2872003' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );
```
- Kết quả sẽ hiển thị như sau:
- ![](/Anh/Screenshot_426.png)
- Thực hiện lưu file và thoát.

- Cấp quyền:
```
sudo chmod -R 755 /var/www/*
sudo chown -R www-data:www-data /var/www/*
sudo systemctl restart apache2
```
- Tiến hành đổi default root:
    - `vim /etc/apache2/sites-available/000-default.conf`
    - Chỉnh sửa default root:
    - `DocumentRoot /var/www/html/wordpress/`
    - Lưu file và thoát.

### Hoàn thành giao diện WordPress
Trên trình duyện của bạn, gõ IP của server chứa WordPress, sau đó trình duyệt sẽ xuất hiện như sau:

![](/Anh/Screenshot_427.png)

Lúc này, tiến hành cài đặt các thông tin cá nhân của bạn. Bạn có thể tham khảo mẫu dưới

![](/Anh/Screenshot_428.png)

Trang chủ của WorPress hiện ra như sau:

![](/Anh/Screenshot_429.png)

### Tạo thử một trang web sử dụng WordPress
![](/Anh/Screenshot_430.png)

