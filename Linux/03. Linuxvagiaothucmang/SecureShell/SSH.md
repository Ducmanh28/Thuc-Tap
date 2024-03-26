# Mục này tìm hiểu về giao thức SSH, cách cài đặt và sử dụng
MENU
- [Mục này tìm hiểu về giao thức SSH, cách cài đặt và sử dụng](#mục-này-tìm-hiểu-về-giao-thức-ssh-cách-cài-đặt-và-sử-dụng)
  - [SSH là gì?](#ssh-là-gì)
  - [SSH dùng để làm gì nhỉ ?](#ssh-dùng-để-làm-gì-nhỉ-)
  - [Các cơ chế truy cập của SSH](#các-cơ-chế-truy-cập-của-ssh)
  - [Vậy cách mà SSH hoạt động ra sao?](#vậy-cách-mà-ssh-hoạt-động-ra-sao)
    - [Định danh Host:](#định-danh-host)
    - [Mã hóa:](#mã-hóa)
    - [Chứng thực](#chứng-thực)
  - [Sử dụng SSH:](#sử-dụng-ssh)
    - [Trên Windows](#trên-windows)
      - [Giới thiệu về Puty và MobaXterm](#giới-thiệu-về-puty-và-mobaxterm)
      - [Sử dụng MobaXterm](#sử-dụng-mobaxterm)
        - [Tiến hành cài đặt](#tiến-hành-cài-đặt)
        - [Tiến hành sử dụng](#tiến-hành-sử-dụng)
        - [SSH từ máy A sang máy B](#ssh-từ-máy-a-sang-máy-b)
    - [Trên Linux](#trên-linux)
    - [Lưu ý tìm hiểu thêm về SSH:](#lưu-ý-tìm-hiểu-thêm-về-ssh)
      - [File cấu hình và File Log của SSH](#file-cấu-hình-và-file-log-của-ssh)
      - [Disable quyền truy cập Root từ xa:](#disable-quyền-truy-cập-root-từ-xa)
      - [Đổi port](#đổi-port)
      - [Giám sát truy cập SSH thông qua Telegram](#giám-sát-truy-cập-ssh-thông-qua-telegram)
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

## Các cơ chế truy cập của SSH
- Có 3 cơ chế truy cập chính:
  - Đăng nhập bằng mật khẩu: Là cách đơn giản nhất. Chỉ cần nhập tên người dùng và mật khẩu
  - Sử dụng **Private/Public Key**: Là cách an toàn hơn để truy cập SSH. Thực hiện tạo một cặp khóa trên máy client, sau đó thêm cặp khóa vào máy chủ. Khi kết nối, máy chủ sẽ check khóa của máy khách
  - Xác thực 2 bước với **Google Authenticator**: Là cách tăng cường bảo mật cho SSH bằng cách thêm một lớp xác thực thứ 2
- Để kiểm tra cơ chế truy cập:
  - Trên Windows:
    - Truy cập theo đường dẫn `C:\Windows\System32\OpenSSH` 
    - Chọn file `sshd_config_default`
    - ![](/Anh/Screenshot_289.png)
  - Trên Linux:
    - Giả sử bạn không biết file cấu hình này nằm ở đâu, chỉ biết tên của nó là `sshd_config` như trên windows
    - Thực hiện sử dụng lệnh `locate 'sshd_config'` để tìm kiếm
    - ![](/Anh/Screenshot_290.png)
    - Sử dụng lệnh `cat /etc/ssh/sshd_config` để xem nội dung file
    - ![](/Anh/Screenshot_291.png)

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
#### Sử dụng MobaXterm
##### Tiến hành cài đặt
- Tải phiên bản ứng dụng [MobaXterm](https://mobaxterm.mobatek.net/download.html)
- Chọn phiên bản trả phí hoặc miễn phí. Do nhu cầu sử dụng nên tôi sẽ ưu tiên chọn Miễn phí
- ![](/Anh/Screenshot_280.png)
- Màn hình chính sau khi tải và cài đặt xong của ứng dụng:
- ![](/Anh/Screenshot_281.png)
##### Tiến hành sử dụng
- MobaXterm hỗ trợ rất nhiều những kiểu kết nối, nhưng ở đây chúng ta sẽ tập trung vào giao thức **SSH**
- Tiến hành thiết lập 1 Session mới
- Trong mục **Session**, bạn chọn **New Session**, sau đó bảng **Session Settings** sẽ hiện ra với đa dạng các giao thức, chọn **SSH**
- ![](/Anh/Screenshot_282.png)
- Sau khi kết nối xong, màn hình sẽ hiển thị như sau:
- ![](/Anh/Screenshot_283.png)
- Sau khi Login xong, ta tiến hành cài MasterKey:
- ![](/Anh/Screenshot_284.png)
- Quá trình kết nối hoàn tất, ta sử dụng lệnh `systemctl status sshd` để kiểm tra trạng thái **SSH**
- ![](/Anh/Screenshot_285.png)
- Tiến hành kiểm tra IP xem có kết nối đúng thiết bị hay không:
- ![](/Anh/Screenshot_286.png)
##### SSH từ máy A sang máy B
- Điều kiện ban đầu:
  - Cả 2 máy đều cần cài **OpenSSH Server và Client**
  - Ghi nhớ tên User và Password của mỗi máy
  - Thực hiện bật **OpenSSH** trong Services
  - ![](/Anh/Screenshot_288.png)
  - Sử dụng MobaXterm hoặc thực hiện trực tiếp trong CMD để thiết lập kết nối bằng lệnh `ssh [user_name]/[user_id]`
  - Sau khi nhập mật khẩu, quá trình kết nối đã hoàn tất
  - ![](/Anh/Screenshot_287.png)
### Trên Linux
- Khi tạo khóa SSH trong Linux, bạn có thể sử dụng lệnh ssh-keygen được tích hợp sẵn
  - Sử dụng lệnh:
    - `ssh-keygen -t rsa `
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

### Lưu ý tìm hiểu thêm về SSH:
#### File cấu hình và File Log của SSH
- File cấu hình SSH sẽ nằm trong đường dẫn `/etc/ssh/ssh_config`
  - Có thể dùng lệnh `cat` để xem file
  - ![](/Anh/Screenshot_305.png)
  - Dùng VIM để chỉnh sửa nội dung file(Chuyển sang quyền Roots mới có thể thực hiện chỉnh sửa và lưu file)
  - Giải thích nội dung từng dòng trong đoạn mã:
    - `Host *`: Áp dụng cấu hình cho tất cả các máy chủ
    - `ForwardAgent no`: Không chuyển tiếp yêu cầu xác thực SSH agent
    - `ForwardX11 no`: Không chuyển tiếp X111.
    - `ForwardX11Trusted yes`: Cho phép chuyển tiếp X11 một cách an toàn
    - `PasswordAuthentication yes`: Cho phép xác thực bằng mật khẩu
    - `HostbasedAuthentication no`: Không sử dụng xác thực dựa trên máy chủ
    - `GSSAPIAuthentication no`: Không sử dụng xác thực GSSAPI.
    - `GSSAPIDelegateCredentials no`: Không ủy quyền thông tin xác thực GSSAPI
    - `GSSAPIKeyExchange no`: Không sử dụng trao đổi khóa GSSAPI.
    - `GSSAPITrustDNS no`: Không tin tưởng DNS khi sử dụng xác thực GSSAPI.
    - `MatchMode no` Không sử dụng chế độ batch
    - `CheckHostIP yes`: Kiểm tra IP của máy chủ
    - `AddressFamily any`: Cho phép sử dụng bất kỳ gia đình địa - chỉ nào.
    - `ConnectTimeout 0`: Không giới hạn thời gian chờ kết nối1.
    - `StrictHostKeyChecking ask`: Hỏi người dùng trước khi thêm khóa máy chủ
    - `IdentityFile ~/.ssh/id_rsa`: Đường dẫn đến tệp khóa riêng
    - `Port 22`: Cổng mà SSH sẽ kết nối đến
    - `Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc`: Danh sách các thuật toán mã hóa được chấp nhận
    - `MACs hmac-md5,hmac-sha1,umac-64@openssh.com`: Danh sách các thuật toán MAC được chấp nhận
    - `EscapeChar ~`: Ký tự thoát
    - `Tunnel no`: Không tạo đường hầm
    - `TunnelDevice any:any`: Thiết bị được sử dụng để tạo đường hầm
    - `PermitLocalCommand no`: Không cho phép thực thi lệnh cục bộ
    - `VisualHostKey no`: Không hiển thị khóa máy chủ dưới dạng hình ảnh
    - `ProxyCommand ssh -q -W %h:%p gateway.example.com`: Sử dụng lệnh proxy để kết nối đến máy chủ
    - `RekeyLimit 1G 1h`: Giới hạn thời gian và dữ liệu trao đổi khóa
    - `UserKnownHostsFile ~/.ssh/known_hosts.d/%k`: Đường dẫn đến tệp chứa danh sách máy chủ đã biết
    - `SendEnv LANG LC_*`: Gửi các biến môi trường cụ thể1.
    - `HashKnownHosts yes`: Mã hóa các mục trong tệp máy chủ đã biết
    - `GSSAPIAuthentication yes`: Sử dụng xác thực GSSAPI
- File log SSH nằm trong đường dẫn `/var/log/auth.log`
  - Chúng ta có thể xem log SSH thông qua `journalctl`
    - `journalctl -u ssh`: Xem ssh logs
    - `journalctl -u ssh --sinceyesterday`: Xem logs từ ngày hôm qua
    - `journalctl -u ssh --until"2023-01-11 07:00:00"`: Xem ssh logs từ 1 khoảng thời gian nhất định
    - `journalctl -fu ssh`: Xem logs ssh theo thời gian thực
  - Tìm kiếm cụ thể logs ssh:
    - `sudo grep sshd /var/log/auth.log`
  - Nếu muốn tạo tệp log riêng:
    - Tạo một tệp `vim /etc/rsyslog.d/sshd.conf`
    - Thêm code sau:
    - ```
      if $programname == 'sshd'
      then /var/log/sshd.log 
      ```
    - Khởi động lại `rsyslog`
      - `sudo service rsyslog restart`
    - Để xem nhật ký SSH sử dụng lệnh `journalctl`, bạn cần thay đổi “**LogLevel**” từ **INFO** sang **VERBOSE** trong tệp `/etc/ssh/sshd_config3`. Sau đó, khởi động lại dịch vụ rsyslog với lệnh `sudo service rsyslog restart`. Sau đó, các lần đăng nhập SSH sẽ được ghi vào tệp `/var/log/auth.log`
#### Disable quyền truy cập Root từ xa:
- Sử dụng trình soạn thảo VIM để mở file cấu hình SSH
- `vim /etc/ssh/sshd_config`
- Tìm tới dòng `#PermitRootLogin` và thực hiện chỉnh sửa
- ![](/Anh/Screenshot_292.png)
- Bỏ dấu **#** và thay đổi `prohibit-password` thành `no`
- ![](/Anh/Screenshot_293.png)
- Thực hiện lưu file và reboot lại máy. Bây giờ, bạn không thể đăng nhập với quyền root thông qua SSH
#### Đổi port 
- Thực hiện kiểm tra Port SSH đang sử dụng:
  - Dùng lệnh `netstat -nltp | grep sshd`
  - ![](/Anh/Screenshot_294.png)
- Thực hiện chỉnh sửa file cấu hình
  - Sử dụng lệnh `vim /etc/ssh/sshd_config`
  - Sửa dòng `#Port 22` thành `Port <port_number>` - port_number là số tùy ý do ta chọn, miễn thỏa mãn yêu cầu đặt port
  - Ví dụ, tôi đổi Port thành `Port 2345`
- Tiến hành mở Port
  - Kiểm tra tường lửa UFW có hoạt động hay không
  - `sudo ufw status verbose`
  - ![](/Anh/Screenshot_295.png)
  - Do tường lửa không hoạt động nên ta không cần mở port bằng tay nữa
- Reset SSH
  - Sử dụng lệnh `systemctl restart sshd` để khởi động lại ssh
  - ![](/Anh/Screenshot_296.png)
#### Giám sát truy cập SSH thông qua Telegram
- Việc giám sát truy cập SSH là điều quan trọng mà Người quản lý máy chủ cần phải làm
- Ta có thể cài đặt để nhận thông báo khi có lượt truy cập SSH thông qua ứng dụng Telegram
- Việc cài đặt và quá trình sẽ diễn ra như sau:
  - Trước tiên, để nhận được thông báo, phải có người gửi thông báo cho mình. Trong trường hợp này, chúng ta sẽ sử dụng BOT của Telegram
  - Tiến hành tạo BOT Telegram:
    - Trên thanh **Search** của Telegram, tìm kiếm **BOTFATHER**
    - Thực hiện trò chuyện với **BOTFATHER** `/start`
    - Tạo Bot mới bằng cách nhập `/newbot`
    - Quá trình tạo sẽ diễn ra như sau:
    - ![](/Anh/Screenshot_308.png)
    - Tin nhắn **Done** hiện ra nghĩa là bạn đã hoàn thành việc tạo BOT. Hãy chú ý tới **Token** vì nó sẽ được dùng để điều khiển BOT của bạn
  - Tiến hành kiểm tra BOT:
    - Truy cập đường dẫn sau `https://api.telegram.org/bot<TOKEN>/getMe`
    - Lưu ý thay <Token> bằng Token bot của bạn
    - Ví dụ Bot của tôi sẽ có đường dẫn là [BOTDUCMANH](https://api.telegram.org/bot6740699828:AAGyqyeheYfcUpWSbLuW6T18w4xI-Jh0-Ac/getMe)
    - Thông tin của BOT sẽ hiện ra 
    - ![](/Anh/Screenshot_300.png)
  - Bây giờ, bạn cần biết ID Chat:
    - Truy cập Telegram
    - Tìm kiếm **@myidbot** 
    - `/start` và nhập lệnh `/getid` để tìm id của mình
    - ![](/Anh/Screenshot_301.png)
  - Tiếp đó, ta cần một trình biên dịch để đọc các file `.json`. Ở đây, ta sẽ dùng trình biên dịch `jq`
    - Có thể cài đặt bằng cách dùng lệnh `apt install jq -y`
  - Tiến hành cài Scripts gửi thông báo
    - Chúng ta cần xác định thư mục để tạo scripts
      - Thư mục ở đây sẽ có đường dẫn `/etc/profile.d`
      - Thư mục sẽ nằm trong list các thư mục hệ thống, nằm trong `profile.d` vì thư mục này được sử dụng để chứa các script mà hệ thống sẽ chạy khi mà một người dùng đăng nhập vào hệ thống
      - Các file có kết thúc là `.d` hay còn gọi là `directory` để chỉ ra rằng đây là thư mục chứa các file hoặc scripts của hệ thống
    - Sau khi xác nhận xong đường dẫn tạo thư mục, ta dùng trình soạn thảo văn bản để tạo ra 1 file mới và đặt tên cho file này là `ssh-telegram.sh`.
      - File `.sh` là các file **Shell Scripts**, là một file text chứa một chuỗi các lệnh cho hệ thống dựa trên UNIX/DEBIAN/LINUX/UBUNTU
      - Các file `.sh` là các file thực thi của OS Unix, tương đương với các file `.bat` trên Windows. Có thể tham khảo thêm các file [`.bat`](https://quantrimang.com/cong-nghe/file-bat-la-gi-196163)
    - Tiếp đó, ta thực hiện chỉnh sửa file `ssh-telegram.sh` như sau: 
    - ```
      USERID="<target_user_id>" #USERID của bạn
      TOKEN="<bot_private_TOKEN>" #TOKEN của bot đã lập
      TIMEOUT="10"
      URL="https://api.telegram.org/bot$TOKEN/sendMessage"
      DATE_EXEC="$(date "+%d %b %Y %H:%M")"
      TMPFILE='/tmp/ipinfo.txt'
      if [ -n "$SSH_CLIENT" ]; then
      IP=$(echo $SSH_CLIENT | awk '{print $1}')
      PORT=$(echo $SSH_CLIENT | awk '{print $3}')
      HOSTNAME=$(hostname -f)
      IPADDR=$(echo $SSH_CONNECTION | awk '{print $3}')
      curl http://ipinfo.io/$IP -s -o $TMPFILE
      CITY=$(cat $TMPFILE | jq '.city' | sed 's/\"//g')
      REGION=$(cat $TMPFILE | jq '.region' | sed 's/\"//g')
      COUNTRY=$(cat $TMPFILE | jq '.country' | sed 's/\"//g')
      ORG=$(cat $TMPFILE | jq '.org' | sed 's/\"//g')
      TEXT=$(echo -e "Thời gian: $DATE_EXEC\nUser: ${USER} logged in to $HOSTNAME ($IPADDR)\nFrom $IP - $ORG - $CITY, $REGION, $COUNTRY on port $PORT")
      curl -s -X POST --max-time $TIMEOUT $URL -d "chat_id=$USERID" -d text="$TEXT" > /dev/null
      rm $TMPFILE
      fi 
      ```
    - Giải mã Code:
      - Giải thích các biến được sử dụng:
        - **USERID**: Nhập vào ID Chat của bạn
        - **TOKEN**: Nhập vào Token bot bạn đã lập
        - **TIMEOUT**: Thời gian chờ tối đa
        - **URL**: Đường Link đến Bot Telegram của bạn
        - **DATE_EXEC**: Biến này chứa thời gian của hệ thống
        - **TMPFILE**: Khởi tạo File [Temp](https://fptshop.com.vn/tin-tuc/thu-thuat/file-tmp-la-gi-cach-mo-file-tmp-tren-windows-151813)
        - **$SSH_CLIENT**: Biến này chứa ip, port_number của SSH_CLIENT 
        - ![](/Anh/Screenshot_303.png)
        - **$SSH_CONNECTION**: Biến này chứa IP đích, nguồn, cổng port kết nối SSH
        - ![](/Anh/Screenshot_304.png)
        - **$HOSTNAME**: Biến này chứa tên máy chủ
        - **$TEXT**: Biến này chứa nội dung cảnh báo
      - Giải thích từng dòng code:
        - `USERID="<target_user_id>"`: Đây là ID của người dùng Telegram mà bạn muốn gửi thông báo đến. Bạn cần thay <target_user_id> = id chat của bạn
        - `TOKEN="<bot_private_TOKEN>"`: Đây là mã token riêng của bot Telegram mà bạn đã tạo. Bạn cần thay <bot_private_TOKEN> = TOKEN bot của bạn
        - `TIMEOUT="10"`: Đây là thời gian chờ tối đa (tính bằng giây) cho việc gửi thông báo qua bot.
        - `URL="https://api.telegram.org/bot$TOKEN/sendMessage"`: Đây là URL của API Telegram, được sử dụng để gửi tin nhắn từ bot.
        - `DATE_EXEC="$(date "+%d %b %Y %H:%M")"`: Đây là lệnh để lấy thời gian hiện tại của hệ thống.
        - `TMPFILE='/tmp/ipinfo.txt'`: Đây là đường dẫn tới file tạm thời, được sử dụng để lưu thông tin về địa chỉ IP.
        - `if [ -n "$SSH_CLIENT" ]; then`: Đây là câu lệnh kiểm tra xem biến môi trường SSH_CLIENT có giá trị hay không. Nếu có, đoạn mã bên trong khối if sẽ được thực thi.
          - `if`: Bắt đầu vào câu điều kiện trong bash scripts
          - `[-n "$SSH_CLIENT"]`: Là biểu thức điều kiện. Tùy chọn `-n` sẽ kiểm tra xem biến trong `" "` có độ dài khác 0 hay không.
            - Nếu khác 0 sẽ trả về True
            - Nếu = 0 sẽ trả về False
          - `then`: Nếu điều kiện True sẽ khởi chạy các câu lệnh sau `then - fi`. Nếu điều kiện là False sẽ khởi chạy các câu lệnh sau `fi` mà bỏ qua các câu lệnh từ `then - fi`
        - `IP=$(echo $SSH_CLIENT | awk '{print $1}')`: Đây là lệnh để lấy địa chỉ IP của người dùng đang kết nối qua SSH.
          - `echo` để in ra giá trị
          - Tùy chọn thêm `awk '{print $1}'`: Là lấy giá trị đầu tiên của biến
          - Tức là lệnh này sẽ in ra giá trị đầu tiên trong biến $SSH_CLIENT
        - `PORT=$(echo $SSH_CLIENT | awk '{print $3}')`: Đây là lệnh để lấy cổng mà người dùng đang kết nối qua SSH.
        - `HOSTNAME=$(hostname -f)`: Đây là lệnh để lấy tên máy chủ.
        - `IPADDR=$(echo $SSH_CONNECTION | awk '{print $3}')`: Đây là lệnh để lấy địa chỉ IP của máy chủ.
        - `curl http://ipinfo.io/$IP -s -o $TMPFILE`: Đây là lệnh để lấy thông tin về địa chỉ IP từ trang web ipinfo.io và lưu vào file tạm thời.
        - `CITY=$(cat $TMPFILE | jq '.city' | sed 's/\"//g')`: Đây là lệnh để lấy thông tin về thành phố từ file tạm thời
          - `cat $TMPFILE`: Đọc file $TMPFILE
          - `jq '.city'`: lấy giá trị của trường **city** từ file **JSON**
          - `sed 's/\"//g'`: Dùng để xóa dấu `"` trong chuỗi văn bản
          - `'s/\"//g'`: `s` là lệnh thay thế, `\"` là dấu `"` cần xóa, `//` là phần thay thế(trống), `g` là tùy chọn thay thế trên toàn bộ văn bản
        - `REGION=$(cat $TMPFILE | jq '.region' | sed 's/\"//g')`: Đây là lệnh để lấy thông tin về khu vực từ file tạm thời.
        - `COUNTRY=$(cat $TMPFILE | jq '.country' | sed 's/\"//g')`: Đây là lệnh để lấy thông tin về quốc gia từ file tạm thời.
        - `ORG=$(cat $TMPFILE | jq '.org' | sed 's/\"//g')`: Đây là lệnh để lấy thông tin về tổ chức từ file tạm thời.
        - `TEXT=$(echo -e "Thời gian: $DATE_EXEC\nUser: ${USER} logged in to $HOSTNAME ($IPADDR)\nFrom $IP - $ORG - $CITY, $REGION, - $COUNTRY on port $PORT")`: Đây là lệnh để tạo nội dung cảnh báo.
        - `curl -s -X POST --max-time $TIMEOUT $URL -d "chat_id=$USERID" -d text="$TEXT" > /dev/null`: Đây là lệnh để gửi cảnh báo qua bot Telegram.
          - `curl`: Đây là lệnh được sử dụng để gửi yêu cầu HTTP
          - `-s`: Là một tùy chọn của `curl`, khiến `curl` hoạt động ở chế độ im lặng, không in ra thông tin về quá trình kết nối và tiến trình
          - `-X POST`: Tùy chọn này sẽ chỉ định `curl` gửi một yêu cầu **HTTP POST**
          - `--max-time $TIMEOUT`: Tùy chọn này đặt thời gian chờ tối đa cho toàn bộ quá trình kết nối
          - `$URL`: Là URL mà `curl` sẽ gửi yêu cầu đến
          - `-d "chat_id=$USERID"` và `-d text="$TEXT"`: các tùy chọn `-d` để tùy chọn dữ liệu sẽ được gửi trong yêu cầu POST 
          - `> /dev/null `: Chuyển hướng đầu ra của `curl` đến `/dev/null`. Điều này có nghĩa bạn sẽ không thấy bất kì đầu ra của `curl` trên màn hình console
        - `rm $TMPFILE`: Đây là lệnh để xóa file tạm thời sau khi script thực hiện xong.
        - `fi`: Được dùng để kết thúc một khối lệnh `if`
        ``
- Kiểm tra quá trình:
  - Dùng lệnh `cat /etc/profile.d/ssh-telegram.sh`
  - ![](/Anh/Screenshot_309.png)
  - Test thử kết quả:
  - ![](/Anh/Screenshot_307.png)
## Nguồn tham khảo 
- [WIKI](https://vi.wikipedia.org/wiki/SSH)
- [Topdev](https://topdev.vn/blog/giao-thuc-ssh-la-gi/#huong-dan-ket-noi-server-su-dung-ssh)
- [TạoBot](https://lethach.com/tao-bot-canh-bao-truy-cap-ssh-qua-telegram/)
- [Anh Quang](https://github.com/thanhquang99/thuctap2023/blob/main/thuctap/03-Linux/00-linux-tim-hieu-truoc/07-mobaxterm.md)
