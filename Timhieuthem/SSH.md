# Mục này tìm hiểu về giao thức SSH, cách cài đặt và sử dụng
MENU
- [Mục này tìm hiểu về giao thức SSH, cách cài đặt và sử dụng](#mục-này-tìm-hiểu-về-giao-thức-ssh-cách-cài-đặt-và-sử-dụng)
  - [SSH là gì?](#ssh-là-gì)
  - [SSH dùng để làm gì nhỉ ?](#ssh-dùng-để-làm-gì-nhỉ-)
  - [Vậy cách mà SSH hoạt động ra sao?](#vậy-cách-mà-ssh-hoạt-động-ra-sao)
    - [Định danh Host:](#định-danh-host)
    - [Mã hóa:](#mã-hóa)
    - [Chứng thực](#chứng-thực)
  - [Sử dụng SSH:](#sử-dụng-ssh)
    - [Trên Windows](#trên-windows)
      - [Giới thiệu về Puty và MobaXterm](#giới-thiệu-về-puty-và-mobaxterm)
    - [Trên Linux](#trên-linux)
  - [Nguồn tham khảo](#nguồn-tham-khảo)

Trước khi tiến hành sử dụng SSH, chúng ta cần nắm rõ lý thuyết về SSH.
## SSH là gì?
- SSH là viết tắt của Secure Shell, là một giao thức mạng được sử dụng để truyền tải dữ liệu một cách bảo mật giữa 2 thiết bị
- Giao thức SSH sử dụng mã hóa để đảm bảo rằng thông tin truyền tải được bảo mật 
- Được sử dụng rộng rãi để kết nối với các máy chủ từ xa và quản lý các tệp tin trên đó
- Sử dụng để đăng nhập vào các hệ thống Linux và Unix, cho phép quản trị viên máy chủ thực hiện các thao tác tác vụ quản lý hệ thống từ xa

## SSH dùng để làm gì nhỉ ?
- Cung cấp khả năng quản lý an toàn, truy cập từ xa vào tài nguyên, các bản vá phần mềm và cập nhật trong các trung tâm dữ liệu
- Còn cho phép quản lý bộ định tuyến được bảo vệ, bảo trị phần cứng và quản trị nền ảo hóa
- Được áp dụng trong các tình huống như sau:
  - Kết nối với Server từ xa
  - Sao lưu, sao chép tệp và phản chiếu tệp bằng **SFTP**
  - Bảo mật TCP/IP và các giao thức mạng khác bằng cách ánh xạ cổng của Client với cổng của Server
  - Chuyển dữ liệu nhạy cảm thông qua một kênh an toàn
  - Sử dụng VPN(Virtual Private Network)
- Khóa SSH là biện pháp để tự động hóa truy cập Server với đăng nhập không cần mật khẩu, quản lý cấu hình và sao lưu

## Vậy cách mà SSH hoạt động ra sao?
- Hiểu đơn giản quá trình này sẽ gồm 3 bước:
  - Định danh Host: Mục này sẽ xác định xem ai đang là người muốn sử dụng SSH(phần đăng nhập)
  - Mã hóa: Mục này sẽ thiết lập kênh truyền dữ liệu an toàn, được bảo mật
  - Chứng thực: Xác thực xem người dùng có quyền truy cập hệ thống hay không
  - ![](/Anh/Screenshot_277.png)
- Bây giờ ta tiến hành đi tìm hiểu chi tiết hơn về từng bước này:
### Định danh Host:
- Việc định danh Host sẽ được thực hiện qua việc trao đổi khóa giữa client và server.
- Mỗi máy tính có một khóa định danh duy nhất. Mỗi khóa này gồm 3 thành phần:
  - Khóa công khai: được sử dụng khi cần trao đổi giữa các máy chủ với nhau trong phiên làm việc SSH. Chúng ta sẽ sao chép các kí tự tại khóa này và bỏ vào file `~/.ssh.authorized_keys` ở trên Server của mình
  - Khóa riêng: ta cần lưu file này vào trong máy tính cá nhân. Dữ liệu sẽ được mã hóa bằng khóa riêng và chỉ có thể được giải mã bằng khóa công khai
  - Keyphrase: Đây là mật khẩu mà bạn sẽ sử dụng để mở được PrivateKey. Việc sử dụng passphrase này sẽ đem lại lợi ích vì tính bảo mật của key không bao giờ được hiển thị với bất kỳ ai khác, cho dù nó được mã hóa như thế nào

### Mã hóa:
- Quá trình truyền dữ liệu diễn ra qua một bước trung gian đó là mã hóa/ giải mã
- Dữ liệu gửi/ nhận đều được mã hóa và giải mã theo cơ chế được thỏa thuận giữa máy chủ và client
  - Việc lựa chọn cơ chế mã hóa thường do máy khách đảm nhận
  - Các cơ chế thường được chọn bao gồm:
      - 3DES: Phương pháp mã hóa mặc định cho SSH
      - IDEA: Nhanh hơn 3DES, chậm hơn Blowfish
      - Blowfish: Nhanh và bảo mật, nhưng các phương pháp mã hóa đang được cải tiến
- Sau khi cơ chế mã hóa được lựa chọn, máy chủ và máy khách sẽ thực hiện trao đổi khóa cho nhau
  - Việc trao đổi mã khóa cũng sẽ được bảo mật 

### Chứng thực
- Đây là bước cuối cùng và là bước đa dạng nhất
- Mỗi định danh và truy cập của người dùng có thể được cung cấp theo nhiều cách khác nhau
  - Kiểu chứng thực rhosts có thể được sử dụng, nhưng không phải mặc định
  - Chứng thực RSA, sử dụng ssh-keygen và ssh-agent để chứng thực các cặp khóa
## Sử dụng SSH:
### Trên Windows
#### Giới thiệu về Puty và MobaXterm
- [PuTTY](https://putty.org/) và [MobaXterm](https://mobaxterm.mobatek.net/) đều là các phần mềm SSH client, giúp người dùng truy cập vào máy chủ từ xa thông qua giao thức SSH. Tuy nhiên:
  -  MobaXterm còn hỗ trợ truy cập vào sFTP, FTP, RSH, Telnet và nhiều giao thức khác nữa. MobaXterm còn có nhiều tính năng hữu ích như lưu trữ thông tin của nhiều server theo dạng profile, kết nối một server với nhiều giao thức khác nhau, hỗ trợ lưu session, không cần gõ lại mật khẩu mà chỉ cần nhập username là nó từ đó tìm session phù hợp, và nhiều tính năng khác. 
-  PuTTY và MobaXterm đều là các công cụ tốt để truy cập vào máy chủ từ xa, tuy nhiên, MobaXterm có nhiều tính năng hơn và hỗ trợ nhiều giao thức hơn so với PuTTY

### Trên Linux
- Khi tạo khóa SSH trong Linux, bạn có thể sử dụng lệnh ssh-keygen được tích hợp sẵn
  - Sử dụng lệnh:
    - `ssh-keygen -t rsa -b 4096`
  - Tiếp theo, bạn chọn nơi để lưu Private key
    - `Enter file in which to save the key (/home/username/.ssh/id_rsa):`
    - Public key sẽ được lưu trong cùng một vị trí, dưới cùng tên tệp, nhưng có phần mở rộng `.pub`. Nếu bạn không nhập gì thì sẽ sử dụng thư mục mặc định `/home/username/.ssh/id_rsa`
  - Cuối cùng, bạn sẽ phải nhập mật khẩu. Đây sẽ là mật khẩu cần thiết để tải Private key và sử dụng nó để kết nối qua SSH sau này:
    - `Enter passphrase (empty for no passphrase):`
  - Toàn bộ quá trình sẽ trông như sau:
  - ![](/Anh/Screenshot_278.png)
  - Như vậy, chúng ta đã tạo được cả 2 keys:
    - Một **Private key** được ghi vào `/home/{username}/.ssh/id_rsa`
    - Một **Public key** được ghi vào `/home/{username}/.ssh/id_rsa.pub`
## Nguồn tham khảo 
- [WIKI](https://vi.wikipedia.org/wiki/SSH)
- [Topdev](https://topdev.vn/blog/giao-thuc-ssh-la-gi/#huong-dan-ket-noi-server-su-dung-ssh)
