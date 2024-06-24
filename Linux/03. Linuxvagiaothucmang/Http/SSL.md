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
  - [Quy trình đăng ký một SSL Certificate:](#quy-trình-đăng-ký-một-ssl-certificate)
    - [Chọn loại chứng chỉ SSL](#chọn-loại-chứng-chỉ-ssl)
    - [Chọn nhà cung cấp chứng chỉ SSL](#chọn-nhà-cung-cấp-chứng-chỉ-ssl)
    - [Tạo yêu cầu ký chứng chỉ (CSR - Certificate Signing Request)](#tạo-yêu-cầu-ký-chứng-chỉ-csr---certificate-signing-request)
    - [Gửi CSR cho nhà cung cấp SSL](#gửi-csr-cho-nhà-cung-cấp-ssl)
    - [Xác minh thông tin](#xác-minh-thông-tin)
    - [Nhận và cài đặt chứng chỉ SSL](#nhận-và-cài-đặt-chứng-chỉ-ssl)
    - [Cấu hình máy chủ web](#cấu-hình-máy-chủ-web)
    - [Kiểm tra và xác minh](#kiểm-tra-và-xác-minh)
  - [Cách tạo một Local Certificate:](#cách-tạo-một-local-certificate)
    - [Yêu cầu cần có:](#yêu-cầu-cần-có)
    - [Thực hành:](#thực-hành)
      - [Trước tiên, chúng ta tạo root CA bằng việc tạo private key:](#trước-tiên-chúng-ta-tạo-root-ca-bằng-việc-tạo-private-key)
      - [Sau đó, chúng ta tạo file xác định danh tính](#sau-đó-chúng-ta-tạo-file-xác-định-danh-tính)
      - [Tiếp đó, chúng ta tạo private key cho trang web](#tiếp-đó-chúng-ta-tạo-private-key-cho-trang-web)
      - [Tạo ra file chứa yêu cầu ký chứng chỉ](#tạo-ra-file-chứa-yêu-cầu-ký-chứng-chỉ)
      - [Tạo file chứa thông tin mở rộng:](#tạo-file-chứa-thông-tin-mở-rộng)
      - [Áp dụng SSL vào trong nginx:](#áp-dụng-ssl-vào-trong-nginx)
  - [Cách tạo một Public Certificate:](#cách-tạo-một-public-certificate)
    - [Yêu cầu cần có:](#yêu-cầu-cần-có-1)
    - [Mô hình thực hành](#mô-hình-thực-hành)
    - [Tiến hành.](#tiến-hành)
      - [Cấu hình trỏ tên miền về WebServer](#cấu-hình-trỏ-tên-miền-về-webserver)
      - [Cấu hình trang web trên WebServer](#cấu-hình-trang-web-trên-webserver)
      - [Xin chứng chỉ SSL cho trang web:](#xin-chứng-chỉ-ssl-cho-trang-web)
      - [Kiểm tra kết quả bằng cách truy cập vào trang web:](#kiểm-tra-kết-quả-bằng-cách-truy-cập-vào-trang-web)

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

## Quy trình đăng ký một SSL Certificate:
Quy trình đăng ký SSL (Secure Sockets Layer) bao gồm các bước sau:

### Chọn loại chứng chỉ SSL
Có nhiều loại chứng chỉ SSL khác nhau phù hợp với nhu cầu của từng trang web, bao gồm:
- Chứng chỉ SSL tiêu chuẩn (Domain Validated - DV): Xác thực tên miền.
- Chứng chỉ SSL cấp tổ chức (Organization Validated - OV): Xác thực cả tên miền và tổ chức.
- Chứng chỉ SSL mở rộng (Extended Validation - EV): Xác thực toàn diện và cung cấp mức độ tin cậy cao nhất.
### Chọn nhà cung cấp chứng chỉ SSL
Chọn một nhà cung cấp chứng chỉ SSL uy tín như:

- Comodo (bây giờ là Sectigo)
- Symantec (nay là một phần của DigiCert)
- Let's Encrypt (miễn phí)
- GeoTrust
- Thawte
### Tạo yêu cầu ký chứng chỉ (CSR - Certificate Signing Request)
CSR là một tập tin chứa thông tin cần thiết để tạo chứng chỉ SSL. Để tạo CSR, bạn cần:

- Một máy chủ hoặc công cụ hỗ trợ tạo CSR (thường là web server hoặc cPanel).
- Cung cấp thông tin tên miền, tên tổ chức, địa chỉ, email, v.v.
### Gửi CSR cho nhà cung cấp SSL
Sau khi tạo CSR, bạn cần gửi tập tin này cho nhà cung cấp SSL thông qua trang quản lý của họ hoặc qua email.

### Xác minh thông tin
Nhà cung cấp SSL sẽ xác minh thông tin của bạn. Quá trình này phụ thuộc vào loại chứng chỉ:

- DV: Xác minh qua email hoặc DNS record.
- OV và EV: Xác minh thêm thông tin tổ chức qua tài liệu pháp lý và có thể gọi điện để xác thực.
### Nhận và cài đặt chứng chỉ SSL
Sau khi xác minh xong, nhà cung cấp sẽ gửi chứng chỉ SSL cho bạn. Bạn cần:

Tải về chứng chỉ và các tập tin liên quan (CA bundle).
Cài đặt chứng chỉ trên máy chủ web của bạn.
### Cấu hình máy chủ web
Cấu hình máy chủ web để sử dụng chứng chỉ SSL mới:

- Apache: Cập nhật tập tin cấu hình với đường dẫn đến chứng chỉ và CA bundle.
- Nginx: Cập nhật tập tin cấu hình với đường dẫn đến chứng chỉ và CA bundle.
- IIS: Sử dụng giao diện quản lý để thêm chứng chỉ.
### Kiểm tra và xác minh
Kiểm tra lại xem chứng chỉ SSL đã được cài đặt đúng cách chưa bằng cách:

Sử dụng công cụ kiểm tra SSL trực tuyến (như SSL Labs).
Kiểm tra trực tiếp trên trình duyệt bằng cách truy cập trang web qua HTTPS.
## Cách tạo một Local Certificate:
### Yêu cầu cần có:
Một máy sử dụng làm Web Server: Ubuntu 22

Một máy sử dụng làm Client: Windows 10

Trên hệ thống Ubuntu cần có:
- Web Server: Apache2 hoặc Nginx
- Ứng dụng tạo chứng chỉ: Openssl

### Thực hành:
Tổng quan các bước:
- Biến chúng ta thành CA:
  - Tạo CA private key
  - Tạo mẫu đăng ký SSL CA PEM
- Đăng ký website:
  - Tạo web private key
  - Tạo mẫu ký(web.csr)
  - Tạo file hỗ trợ ký(web.ext)
  - ký ssl crt(web.crt)

Tầm quan trọng:
- ca.key: Khóa riêng của CA, dùng để ký chứng chỉ.
- ca.pem: Chứng chỉ CA, xác nhận CA.
- web.key: Khóa riêng của website, dùng để mã hóa kết nối SSL.
- web.csr: Yêu cầu ký chứng chỉ, chứa thông tin website và khóa công khai.
- web.ext: Thuộc tính mở rộng cho chứng chỉ SSL.
- web.crt: Chứng chỉ SSL của website, mã hóa kết nối.
#### Trước tiên, chúng ta tạo root CA bằng việc tạo private key:
Câu lệnh khởi tạo:
```
openssl genrsa -out /etc/ssl/private/private.key 2048
```

#### Sau đó, chúng ta tạo file xác định danh tính
Câu lệnh khởi tạo:
```
openssl req -x509 -sha256 -new -nodes -days 3650 -key /etc/ssl/private/private.key -out /etc/ssl/certs/CA.pem
```
Kết quả đầu ra mẫu như sau:
```
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:VN
State or Province Name (full name) [Some-State]:HN
Locality Name (eg, city) []:HN
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Suncloud
Organizational Unit Name (eg, section) []:Suncloud
Common Name (e.g. server FQDN or YOUR name) []:www.testssl.local
Email Address []:ducmanh@suncloud.com
root@MANH-U22-Server:/etc/ssl/certs#
```
Ở trên chính là quá trình định danh cho CA của chúng ta. Nhưng để trang web có thể sử dụng SSL, cần phải tạo cho nó một cặp khóa riêng và được ký bởi CA vừa tạo ở trên.
#### Tiếp đó, chúng ta tạo private key cho trang web
Câu lệnh khởi tạo:
```
openssl genrsa -out /etc/ssl/private/testssl.key 2048
```
#### Tạo ra file chứa yêu cầu ký chứng chỉ 
```
openssl req -new -key /etc/ssl/private/testssl.key -out /etc/ssl/certs/testssl.csr
```
Đầu ra như sau:
```
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:VN
State or Province Name (full name) [Some-State]:HN
Locality Name (eg, city) []:HN
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Suncloud
Organizational Unit Name (eg, section) []:Suncloud
Common Name (e.g. server FQDN or YOUR name) []:www.testssl.com
Email Address []:ducmanh@suncloud.com

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:extra
An optional company name []:
```

#### Tạo file chứa thông tin mở rộng:
```
vim /etc/ssl/certs/testssl.ext
```
Thêm vào nội dung sau
```
  authorityKeyIdentifier = keyid,issuer
  basicConstraints = CA:FALSE
  keyUsage = digitalSignature,nonRepudiation,keyEncipherment,dataEncipherment
  subjectAltName = @alt_names
  [alt_names]
  DNS.1 = www.testssl.local
  IP.1 = 172.16.66.81
```
Ký SSL certificate:
```
openssl x509 -req -in /etc/ssl/certs/testssl.csr -CA /etc/ssl/certs/CA.pem -CAkey /etc/ssl/private/private.key -CAcreateserial -days 365 -sha256 -extfile /etc/ssl/certs/testssl.ext -out /etc/ssl/certs/testssl.crt
```
Kết quả:
```
root@MANH-U22-Server:/etc/ssl/certs# openssl x509 -req -in /etc/ssl/certs/testssl.csr -CA /etc/ssl/certs/CA.pem -CAkey /etc/ssl/private/private.key -CAcreateserial -days 365 -sha256 -extfile /etc/ssl/certs/testssl.ext -out /etc/ssl/certs/testssl.crt
Certificate request self-signature ok
subject=C = VN, ST = HN, L = HN, O = Suncloud, OU = Suncloud, CN = www.testssl.com, emailAddress = ducmanh@suncloud.com
```
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

Để lấy được file chữ ký, nó nằm trong mục `/etc/ssl/certs/CA.pem`. Các bạn sử dụng máy Windows SFTP vào Linux để lấy file về.

Vào trình duyệt, chọn Settings và tìm kiếm mục Certificate:

![](/Anh/Screenshot_725.png)

![](/Anh/Screenshot_726.png)

![](/Anh/Screenshot_727.png)

Sau đó lưu và xác nhận là hoàn tất.

Lúc này, các bạn khởi động lại trình duyệt và tiến hành kiểm thử

- BAN ĐẦU, Khi chưa cấu hình:

![](/Anh/Screenshot_728.png)

- Sau khi cấu hình:

![](/Anh/Screenshot_729.png)


## Cách tạo một Public Certificate:
### Yêu cầu cần có:
- 1 Server có sử dụng Ip Public
- 1 tên miền public
- CertBot(ứng dụng lấy chứng chỉ SSL free)

### Mô hình thực hành
Mô hình thực hành của bài làm sẽ trông như sau:

![](/Anh/Screenshot_732.png)

Giải thích mô hình:
- Trước tiên, chúng ta sẽ SSH vào WebServer để kiểm tra xem có ổn định hay không, có kết nối vào được không, kiểm tra lại các thông tin như IP, Port của webserver.
- Sau khi xác định rằng các thông tin cần thiết đã ổn, chúng ta sẽ truy cập vào trang web quản lý tên miền, yêu cầu trỏ tên miền về Hosting là IP Public của webserver của bạn
- Sau khi trỏ hoàn tất, chúng ta thực hiện cấu hình trang web trên Nginx(cấu hình config và cấu hình nội dung trang web)
- Sau khi hoàn tất, chúng ta tải và cài đặt certbot để xin chứng chỉ ssl cho trang web. 
- Cuối cùng, chúng ta thực hiện tìm kiếm tên miền trên web browser để kiểm chứng

### Tiến hành.
#### Cấu hình trỏ tên miền về WebServer
Ví dụ tôi sử dụng dịch vụ tên miền trên trang web `matbao.com`, tôi sẽ thực hiện cấu hình trỏ về WebServer như sau:

![](/Anh/Screenshot_733.png)

Cấu hình các bản ghi DNS:

![](/Anh/Screenshot_734.png)

Vậy là đã hoàn tất trỏ tên miền về WebServer

#### Cấu hình trang web trên WebServer
Thực hiện cấu hình nội dung trang web trong: `/var/www/test/index.html`

Thêm vào nội dung sau:
```
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to My Website</title>
</head>
<body>
    <h1>Success! The Nginx is working!</h1>
</body>
</html>
```
Thực hiện cấu hình file cấu hình nginx cho trang web ở trong: `/etc/nginx/sites-available/testweb.conf`

Thêm vào nội dung sau:
```
server {
    listen 80;
    server_name www.ducmanh2873.click;

    root /var/www/my_website;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```
Thực hiện kiểm tra lại và khởi động lại dịch vụ nginx:
```
nginx -t

systemctl restart nginx
```
#### Xin chứng chỉ SSL cho trang web:
Các bạn thực hiện truy cập vào trang web [CertBot](https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal) và làm theo hướng dẫn:
- Tải snapd
```
sudo apt update

sudo apt install snapd
```
- Cài certbot với snapd:
```
sudo snap install --classic certbot
```
- Cấu hình để có thể chạy lệnh cerbot bằng cách tạo liên kết tượng trưng:
```
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```
- Khởi chạy certbot cho trang web:
```
sudo certbot --nginx
```
Mẫu đầu ra trông như sau:
```
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Enter email address (used for urgent renewal and security notices)
 (Enter 'c' to cancel): luongducmanh02@gmail.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at
https://letsencrypt.org/documents/LE-SA-v1.4-April-3-2024.pdf. You must agree in
order to register with the ACME server. Do you agree?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: Y

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Would you be willing, once your first certificate is successfully issued, to
share your email address with the Electronic Frontier Foundation, a founding
partner of the Let's Encrypt project and the non-profit organization that
develops Certbot? We'd like to send you email about our work encrypting the web,
EFF news, campaigns, and ways to support digital freedom.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: Y
Account registered.
Please enter the domain name(s) you would like on your certificate (comma and/or
space separated) (Enter 'c' to cancel): www.ducmanh2873.click
Requesting a certificate for www.ducmanh2873.click

Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/www.ducmanh2873.click/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/www.ducmanh2873.click/privkey.pem
This certificate expires on 2024-09-22.
These files will be updated when the certificate renews.
Certbot has set up a scheduled task to automatically renew this certificate in the background.

Deploying certificate
Successfully deployed certificate for www.ducmanh2873.click to /etc/nginx/sites-enabled/testweb.conf
```
- Kiểm tra gia hạn:
```
sudo certbot renew --dry-run
```
Mẫu đầu ra như sau:
```
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/www.ducmanh2873.click.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Account registered.
Simulating renewal of an existing certificate for www.ducmanh2873.click

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Congratulations, all simulated renewals succeeded:
  /etc/letsencrypt/live/www.ducmanh2873.click/fullchain.pem (success)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
root@MANH-U22-Client:/etc/nginx/sites-available# cd /var/www
```
- Kiểm tra lại file cấu hình nginx:
```
server {
    server_name www.ducmanh2873.click;

    root /var/www/test;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/www.ducmanh2873.click/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/www.ducmanh2873.click/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
server {
    if ($host = www.ducmanh2873.click) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    listen 80;
    server_name www.ducmanh2873.click;
    return 404; # managed by Certbot
}
```
- Kiểm tra và khởi động lại dịch vụ nginx như ở trên.

#### Kiểm tra kết quả bằng cách truy cập vào trang web:
Kết quả:

![](/Anh/Screenshot_735.png)
