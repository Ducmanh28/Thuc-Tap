# Mục này tìm hiểu về SSL
MỤC LỤC
- [Mục này tìm hiểu về SSL](#mục-này-tìm-hiểu-về-ssl)
  - [SSL là gì](#ssl-là-gì)
  - [SSL dùng để làm gì?](#ssl-dùng-để-làm-gì)
  - [Cấu tạo của SSL:](#cấu-tạo-của-ssl)
  - [Quy trình hoạt động của SSL:](#quy-trình-hoạt-động-của-ssl)
    - [SSL, TLS HandShake](#ssl-tls-handshake)
    - [Data Transfer](#data-transfer)
    - [Connection Close](#connection-close)
  - [SSL Certificate](#ssl-certificate)
    - [Local Certificate:](#local-certificate)
    - [Public Certificate](#public-certificate)
      - [Các loại Public Certificate:](#các-loại-public-certificate)
  - [Cách tạo một Local Certificate:](#cách-tạo-một-local-certificate)
    - [Yêu cầu cần có:](#yêu-cầu-cần-có)
    - [Thực hành:](#thực-hành)
      - [Trước tiên, chúng ta tạo root CA bằng việc tạo private key:](#trước-tiên-chúng-ta-tạo-root-ca-bằng-việc-tạo-private-key)
      - [Sau đó, chúng ta tạo **Certificate Signing Request** (CSR)](#sau-đó-chúng-ta-tạo-certificate-signing-request-csr)
      - [Tiếp đó, chúng ta tạo chứng chỉ:](#tiếp-đó-chúng-ta-tạo-chứng-chỉ)
      - [Áp dụng SSL vào trong nginx:](#áp-dụng-ssl-vào-trong-nginx)

## SSL là gì
SSL là viết tắt của Secure Sockets Layer, nó là một công nghệ tiêu chuẩn cho phép thiết lập kết nối được mã hóa an toàn giữa máy chủ web(host) và trình duyệt web ở trên máy client. 

Kết nối này sẽ đảm bảo rằng dữ liệu được truyền giữa host và client được duy trì một cách riêng tư, đáng tin cậy. 

SSL hiện nay đã được sử dụng bởi hàng triệu trang web để bảo về các giao dịch trực tuyến của họ với khách hàng.

Có thể nói rằng, SSL giống như một xương sống trong việc đảm bảo an toàn trên Internet. Nó giúp bảo vệ những thông tin nhạy cảm khi chúng được truyền qua mạng máy tính trên thế giới.

## SSL dùng để làm gì?
SSL được sử dụng để bảo vệ dữ liệu được truyền giữa người dùng và trang web, hoặc giữa 2 hệ thống. Nó đảm bảo dữ liệu được truyền giữa máy chủ và máy khách đều được giữ riêng tư và an toàn. SSL sẽ cung cấp các chức năng chính như sau:
- Mã hóa(Encryption): Dữ liệu sẽ được mã hóa để ngăn chặn việc có bên thứ 3 đọc được trong quá trình truyền tải.
- Tính toàn vẹn dữ liệu(Data Integrity): Đảm bảo rằng dữ liệu không bị thay đổi hoặc làm sai lệch trong quá trình truyền tải
- Xác thực(Authentication): Xác minh rằng bạn đang giao tiếp với máy chủ đúng và không phải là một kẻ mạo danh

## Cấu tạo của SSL:
SSL sẽ bao gồm các thành phần sau:
- Chứng chỉ SSL(SSL Certificate): Có 2 kiểu chứng chỉ SSL. Một là chứng chỉ SSL Local(Chứng chỉ tự kí). Kiểu còn lại là Certìicate Authority - CA(Chứng chỉ được cấp).
- Khóa công khai và riêng tư: Khóa công khai được chia sẻ với mọi người và được sử dụng để mã hóa dữ liệu. Khóa riêng tư được giữ bởi máy chủ và được dùng để giải mã dữ liệu.
- Phiên bản SSL: Có nhiều phiên bản SSL. Mỗi phiên bản có một mức độ bảo mật khác nhau. Ngày nay, nó đã tiến hóa thành TLS.

## Quy trình hoạt động của SSL:
### SSL, TLS HandShake
**Client Hello**: Client gửi một yêu cầu ***'Hello'*** tới máy chủ, bao gồm các thông tin như phiên bản SSL mà nó hỗ trợ, các bộ mã hóa mà nó có thể sử dụng, và một số ngẫu nhiên để dùng sau này.

**Server Respone**: Server đáp lại với một tin nhắn ***'Hello'***, chọn phiên bản SSL, bộ mã hóa từ trong danh sách của Client, và gửi lại một số ngẫu nhiên khác để dùng sau này.

**Certificate Exchange**: Server gửi chứng chỉ SSL của mình đến Client để Client có thể xác thực danh tính của Server

**Server Key Exchange**: Nếu cần thiết, Server có thể gửi thêm khóa công khai

**Client Key Exchange**: Client tạo ra một ***"pre-master secret"*** và mã hóa nó bằng khóa công khai của Server, sau đó gửi nó cho Server.

**Key Generation**: Cả máy khách và Server lúc này sẽ sử dụng các số ngẫu nhiên và ***"pre-master secret"*** để tạo ra khóa phiên (session key). Khóa phiên này sẽ được dùng để mã hóa dữ liệu trong phiên làm việc.

**Change Cipher Spec**: Client gửi thông điệp "Change Cipher Spec" để thông báo rằng từ thời điểm này, tất cả dữ liệu gửi đi sẽ được mã hóa bằng khóa phiên. Máy chủ cũng sẽ gửi thông điệp tương tự

**Finished**: Cả máy khách và máy chủ gửi thông điệp "Finished" để xác nhận rằng quy trình bắt tay đã hoàn tất

![](/Anh/Screenshot_724.png)

### Data Transfer
Sau khi quy trình bắt tay để thiết lập kết nối hoàn tất, cả máy khách và máy chủ có thể bắt đầu truyền dữ liệu một cách an toàn bằng cách sử dụng khóa phiên để mã hóa và giải mã dữ liệu

### Connection Close
Khi một trong 2 bên muốn kết thúc kết nối, họ sẽ gửi một thông điệp ***"close-notify"*** để thông báo cho bên kia. Bên nhận thông điệp này cũng sẽ gửi lại 1 thông điệp tương tự để xác nhận và sau đó đóng kết nối.

## SSL Certificate
Có 2 dạng SSL Certificate chính: Local và Public.
### Local Certificate:
Chứng chỉ cục bộ, thường được sử dụng trong các mạng nội bộ, hệ thống thử nghiệm hoặc trong các trường hợp mà mức độ bảo mật cao không phải là ưu tiên hàng đầu. Chứng chỉ này thường được tạo ra bởi các tổ chức tự quản lý hoặc bởi một cơ quan chứng thực CA nội bộ

Đặc điểm:
- Tự ký: Không có xác thực của 1 bên thứ 3 đáng tin cậy
- CA nội bộ: Một tổ chức có thể thiết lập 1 CA nội bộ để phát hành chứng chỉ cho các dịch vụ và máy chủ trong nội bộ.
- Sử dụng nội bộ: Chỉ được sử dụng trong mạng nội bộ
- Không được công nhận rộng rãi: Trình duyệt và hệ thống mạng public không tin vào chứng chỉ tự ký

### Public Certificate
Được phát hành bởi các cơ quan chứng thực công cộng như DigiCert, Let's Encrypt, Comodo, và nhiều tổ chức khác. Chứng chỉ này được công nhận và tin cậy rộng rãi bởi các trình duyệt web và hệ thống

Đặc điểm:
- Xác thực bởi CA công cộng: Chứng chỉ được phát hành sau khi CA công cộng xác thực thông tin của tổ chức hoặc tên miền.
- Được công nhận rộng rãi: Chứng chỉ từ CA công cộng được tin cậy bởi hầu hết các trình duyệt web, hệ điều hành và thiết bị.
- Mức độ bảo mật cao: Quá trình xác thực nghiêm ngặt đảm bảo rằng chứng chỉ thuộc về tổ chức hoặc tên miền đã được xác minh.

#### Các loại Public Certificate:
- Domain Validation (DV) Certificate: Xác thực chỉ tên miền, không xác thực tổ chức. Phù hợp với các trang web cá nhân hoặc blog.
- Organization Validation (OV) Certificate: Xác thực tên miền và tổ chức. Phù hợp với các doanh nghiệp nhỏ và vừa.
- Extended Validation (EV) Certificate: Xác thực tên miền và tổ chức ở mức độ cao nhất, hiển thị thanh địa chỉ màu xanh trên trình duyệt. Phù hợp với các doanh nghiệp lớn và trang web thương mại điện tử.
- Wildcard Certificate: Bảo mật một tên miền và tất cả các subdomain của nó. Ví dụ: `*.example.com` sẽ bảo mật `example.com`, `www.example.com`, `mail.example.com`, v.v.
- Multi-Domain (SAN) Certificate: Bảo mật nhiều tên miền và subdomain khác nhau trong một chứng chỉ. Ví dụ: `example.com`, `example.net`, `example.org`.


## Cách tạo một Local Certificate:
### Yêu cầu cần có:
Một máy sử dụng làm Web Server: Ubuntu 22

Một máy sử dụng làm Client: Windows 10

Trên hệ thống Ubuntu cần có:
- Web Server: Apache2 hoặc Nginx
- Ứng dụng tạo chứng chỉ: Openssl

### Thực hành:
#### Trước tiên, chúng ta tạo root CA bằng việc tạo private key:
Câu lệnh khởi tạo:
```
openssl genpkey -algorithm RSA -out /etc/ssl/private/private.key -aes256
```
Sau khi nhập lệnh này, chúng ta nhập passphrase để tạo, đầu ra trông như sau:
```
..............+....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.+.....+.......+........+...+....+...+.........+...+...........+....+...+.....+............+.+.....+......+.+.........+.....+.+..+.......+...+......+..+.........+...+.+..+....+.....+......+.......+.....+...+....+......+..+............+.+..+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...+..............+.+.................+......+.+......+..+.+...............+.....+...................+...+..+.......+...+....................+...+.......+...............+.....+.......+.........+......+.....+......+...+............+....+.....+.+........+....+...+............+.....+...+...+.......+..+................+..............+.+...........+.........+...............+......+......+....+...+........+....+......+..+.+......+.....+...+......+.......+...+..+............+......+......+.+........+....+......+...............+..+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
..+......+....+.....+.......+..+...+.......+........+...+....+...+...+..+.......+..+.........+.+...+........+.........+.........+.......+..+......+.+.....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.+....+.....+...+..................+.......+...+..+............+.+.........+...+........+...+.+.....+....+..+.......+..+.+..+.......+........+...............+...+...+.+...+...+..+.....................+....+..+.+..+..........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...+......+...+....+..+.+............+...............+..+.........+............+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Enter PEM pass phrase:
Verifying - Enter PEM pass phrase:
```
#### Sau đó, chúng ta tạo **Certificate Signing Request** (CSR)
Câu lệnh khởi tạo:
```
openssl req -new -key /etc/ssl/private/private.key -out /etc/ssl/certs/certificate.csr
```
Kết quả đầu ra mẫu như sau:
```
Enter pass phrase for /etc/ssl/private/private.key:
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:VN
State or Province Name (full name) [Some-State]:HANOI
Locality Name (eg, city) []:HANOI
Organization Name (eg, company) [Internet Widgits Pty Ltd]:SunCloud
Organizational Unit Name (eg, section) []:VietTelCo
Common Name (e.g. server FQDN or YOUR name) []:www.testssl.local
Email Address []:luongducmanh03@suncloud.com.vn

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:# Enter your password
An optional company name []:VTC
```
#### Tiếp đó, chúng ta tạo chứng chỉ:
Câu lệnh khởi tạo:
```
openssl x509 -req -days 365 -in /etc/ssl/certs/certificate.csr -signkey /etc/ssl/private/private.key -out /etc/ssl/certs/certificate.crt
```
Kết quả đầu ra của câu lệnh này: 
```
Enter pass phrase for /etc/ssl/private/private.key:
Certificate request self-signature ok
subject=C = VN, ST = HANOI, L = HANOI, O = SunCloud, OU = VietTelCo, CN = www.testssl.local, emailAddress = luongducmanh03@suncloud.com.vn
```
Như vậy là đã hoàn tất khởi tạo.

#### Áp dụng SSL vào trong nginx:
Các bạn lưu passphrase vào trong file có tên là `passphrase.txt` và lưu vào trong `/etc/nginx/passphrase.txt`

Sau đó, cấu hình nginx như sau:
- Truy cập vào đường dẫn chứa file cấu hình: `/etc/nginx/sites-available/testssl.conf`
- Thêm vào nội dung sau:
```
server {
        listen 80;
        server_name www.testssl.local;
        return 301 https://$host$request_uri;
}
server {
        listen 443 ssl;
        server_name www.testssl.local;
        ssl_certificate /etc/ssl/certs/certificate.crt;
        ssl_certificate_key /etc/ssl/private/private.key;
        ssl_password_file /etc/nginx/passphrase.txt;

  location / {
        root /usr/share/nginx/ducmanh/testssl;
        index index.html index.htm;
  }
}
```

Sau đó, chúng ta thực hiện tạo một file html trang web:
- Truy cập vào đường dẫn `/usr/share/nginx/ducmanh/testssl`
- Tạo file: `vim index.html`
- Thêm vào nội dung sau:
```
<DOCTYPE html>
<html>
  <head>
    <title>www.testssl.local</title>
  </head>
  <body>
    <h1>Success: Test SSL complete on Ubuntu22 </h1>
    <h2>Success: Thank you and goodbye! </h2>
  </body>
</html>
```

Tuy nhiên, lúc này, trang web của bạn vẫn chưa chấp nhận chứng chỉ tự ký này. Chúng ta sẽ cấu hình cho nó có thể chấp nhận chứng chỉ tự ký.

Để lấy được file chữ ký, nó nằm trong mục `/etc/ssl/certs/certificate.crt`. Các bạn sử dụng máy Windows SFTP vào Linux để lấy file về.

Vào trình duyệt, chọn Settings và tìm kiếm mục Certificate:

![](/Anh/Screenshot_725.png)

![](/Anh/Screenshot_726.png)

![](/Anh/Screenshot_727.png)

Sau đó lưu và xác nhận là hoàn tất.

Lúc này, các bạn khởi động lại trình duyệt và tiến hành kiểm thử

- BAN ĐẦU, Khi chưa cấu hình:

![](/Anh/Screenshot_728.png)

- Sau khi cấu hình:

 