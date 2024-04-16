MỤC LỤC
- [Hướng dẫn cấu hình Rsyslog gửi các Log mỗi khi người dùng sử dụng câu lệnh bất kỳ](#hướng-dẫn-cấu-hình-rsyslog-gửi-các-log-mỗi-khi-người-dùng-sử-dụng-câu-lệnh-bất-kỳ)
  - [Kiến thức cần có:](#kiến-thức-cần-có)
  - [Thực hành với Ubuntu 22](#thực-hành-với-ubuntu-22)
    - [Đối với các User có sẵn.](#đối-với-các-user-có-sẵn)
    - [Đối với các User được thêm mới](#đối-với-các-user-được-thêm-mới)
  - [Cấu hình Logrotate cho CMDLog](#cấu-hình-logrotate-cho-cmdlog)
    - [Tổng quát về Logrotate](#tổng-quát-về-logrotate)
    - [Cấu hình logrotate theo số lượng file](#cấu-hình-logrotate-theo-số-lượng-file)
    - [Cấu hình logrotate theo dung lượng tối đa của file](#cấu-hình-logrotate-theo-dung-lượng-tối-đa-của-file)
  - [Tiến hành gửi cmdlog đến Server](#tiến-hành-gửi-cmdlog-đến-server)
  - [Kiểm tra quá trình gửi Log](#kiểm-tra-quá-trình-gửi-log)

# Hướng dẫn cấu hình Rsyslog gửi các Log mỗi khi người dùng sử dụng câu lệnh bất kỳ

## Kiến thức cần có:
Để có thể làm tốt phần cấu hình Rsyslog này, chúng ta cần có những kiến thức sau:
- Biết cách sử dụng `logger` trong Rsyslog để thu thập các thông điệp
- Biết cách sử dụng các biến `local` trong Rsyslog
- Biến `PROMPT_COMMAND` là một biến phụ mà mỗi khi ta sử dụng câu lệnh nào thì biến `PROMPT_COMMAND` cũng sẽ được thực hiện kèm theo
- File `/etc/skel/` là thư mục chứa cấu hình mẫu mà mỗi khi user mới được tạo đều sẽ phải tuân theo
- File `/~.bashrc/` là file mà mỗi khi có người đăng nhập vào hệ thống thì file sẽ được khởi chạy

## Thực hành với Ubuntu 22
### Đối với các User có sẵn.
Đối với các User đã tồn tại sẵn trên hệ thống, chúng ta không thể thực hiện cài đặt cmd Log đồng thời cho tất cả User mà thay vào đó, phải thực hiện thủ công trên từng User. Ở đây, tôi sẽ ví dụ với user ***root***

Như đã biết, file `/~.bashrc` là file mà mỗi lần có người đăng nhập vào thì sẽ tự động khởi chạy. Vì vậy, chúng ta thực hiện cấu hình trên file này như sau:
```
export IP_CLIENT=$(echo $SSH_CLIENT | awk '{print $1}')
export PROMPT_COMMAND='logger -p local6.info "$SUDO_USER $LOGNAME $IP_CLIENT $(history 1 ) "'
```
***Giải thích***:
- `IP_CLIENT=$(echo $SSH_CLIENT | awk '{print $1}')`: Gán biến **IP_CLIENT** bằng trường giá trị thứ 1 trong biến môi trường **$SSH_CLIENT** - chính là giá trị địa chỉ IP. 
- `PROMPT_COMMAND='logger -p local6.info "$SUDO_USER $LOGNAME $IP_CLIENT $(history 1 ) "'`: Gán biến **PROMPT_COMMAND** bằng lệnh đưa 1 thông điệp vào biến local6 với nội dung thông điệp bao gồm
  - **$SUDO_USER**: Người dùng
  - **$LOGNAME**: Tên người dùng
  - **$IP_CLIENT**: Địa chỉ IP
  - **$(history 1)**: Câu lệnh được thực thi

***Lưu ý:*** 
- Biến **PROMPT_COMMAND** không cho phép sử dụng các câu lệnh lọc để lấy một phần giá trị của biến. Vậy nên ở trên tôi mới tạo ra biến **$IP_CLIENT** để lưu trữ giá trị địa chỉ IP
- Nội dung đưa vào bằng `logger` phải được đặt trong dấu `""`
- Ta có thể sử dụng các biến ***local0-7***, tuy nhiên phải kiểm tra xem biến mà ta định sử dụng đã được dùng hay chưa để tránh nhầm lẫn trong việc gửi các log. Để kiểm tra được, ta cần đọc nội dung file cấu hình của **Rsyslog**

Tiến hành chạy file cấu hình mới:
```
./ .bashrc
```
Sau đó, chúng ta thực hiện tạo 1 file chứa các Log cmd như sau:
```
touch /var/log/cmd.log
```
Tiếp đó, chúng ta thực hiện chỉnh sửa nội dung file cấu hình phụ của **Rsyslog** như sau:
```
root@ubuntusv:~# vim /etc/rsyslog.d/50-default.conf

# Thêm vào nội dung sau:
local6.*                    /var/log/cmd.log

# Thực hiện lưu file và thoát khỏi VIM. Sau đó, khởi động lại dịch vụ Rsyslog
root@ubuntusv:~# systemctl restart rsyslog
```
Sau khi hoàn tất, tiến hành khởi động lại hệ thống và thực hiện một vài câu lệnh để kiểm tra.

![](/Anh/Screenshot_549.png)

### Đối với các User được thêm mới
Đối với các User được thêm mới sau này, chúng ta có thể tạo một mẫu sẵn để mỗi khi có User được thêm mới thì sẽ đều áp dụng qui tắc ghi Log

Như chúng ta đã biết, thư mục `/etc/skel/` là thư mục chứa các cấu hình mẫu mà mỗi khi User mới được thêm vào sẽ đều phải tuân thủ các quy tắc trong này. Chúng ta sẽ thực hiển chỉnh sửa ở trong đường dẫn này

Cách làm như sau:
```
# Truy cập vào thư mục sau
[root@localhost ~]# vim /etc/skel/.bashrc

# Thêm vào nội dung như sau:
export IP_CLIENT=$(echo $SSH_CLIENT | awk '{print $1}')
export PROMPT_COMMAND='logger -p local6.info "$SUDO_USER $LOGNAME $IP_CLIENT $(history 1 ) "'
```
Ở đây, tôi tiếp tục đẩy các log về biến ***local6***. Mà ở trên đã thực hiện cấu hình Rsyslog lưu các log của biến ***local6*** rồi. Vậy nên ở dưới này chúng ta không cần thực hiện cấu hình Rsyslog nữa

Tạo thử một user mới và kiểm thử kết quả
```
# Thêm mới 1 user
[root@localhost ~]# useradd ducmanh2873

# Truy cập vào User mới tạo
[root@localhost ~]# useradd ducmanh2873
[ducmanh2873@localhost ~]$
```
Thực hiện 1 vài câu lệnh bất kỳ và kiểm tra kết quả

![](/Anh/Screenshot_550.png)

## Cấu hình Logrotate cho CMDLog
Do mỗi ngày chúng ta sử dụng rất nhiều câu lệnh, vì vậy, nội dung file cmdlog sẽ rất lớn. Lúc này, chúng ta cần thiết lập tự động xóa file sau mỗi ngày hoặc vài ngày

### Tổng quát về Logrotate
Logrotate là một công cụ dùng để quản lý các tệp log trên hệ thống Linux. Nó cho phép tự động xoay vòng, nén và xóa các tệp log cũ sau một khoảng thời gian nhất định. Mục tiêu chính của Logrotate là giảm lượng dung lượng lưu trữ của log, ngăn chặn các tệp log trở nên quá lớn và duy trì hệ thống log hiệu quả.

Các chức năng chính của Logrotate bao gồm:
- **Xoay vòng log files**: Logrotate sẽ di chuyển tệp log hiện tại sang một vị trí khác và tạo một tệp log mới để tiếp tục ghi log. 
- **Nén log files**: Logrotate có thể nén các tệp log cũ sau khi chúng được xoay vòng, giúp tiết kiệm không gian đĩa lưu trữ.
- **Xóa log files cũ**: Logrotate có thể xóa các tệp log cũ sau khi chúng đã được lưu trữ hoặc sau một khoảng thời gian nhất định. 
- **Chạy các script hoặc lệnh**: Bạn có thể cấu hình Logrotate để chạy các script hoặc lệnh cụ thể sau khi xoay vòng log files, cho phép bạn thực hiện các tác vụ phụ trợ như khởi động lại dịch vụ log.

Tệp cấu hình chính của Logrotate thường là /etc/logrotate.conf. Tuy nhiên, thường có các tệp cấu hình phụ bổ sung được lưu trữ trong thư mục /etc/logrotate.d/, mỗi tệp cấu hình này định nghĩa các quy tắc cụ thể cho việc quản lý log của một ứng dụng cụ thể.
### Cấu hình logrotate theo số lượng file
Thêm file cấu hình Logrotate cho cmdlog
```
# Truy cập vào file cấu hình của Logrotate và tạo file cấu hình cho cmdlog
[root@localhost ducmanh287]# vim /etc/logrotate.d/cmdlog

# Thêm vào nội dung như sau:
/var/log/cmdlog.log {
daily
rotate 4
create
dateext
compress
}
```
***Giải thích***:
- `daily`: Tạo ra file mới mỗi ngày
- `rotate 4`: Cho phép tạo ra tối đa 4 file
- `create`: Làm mới mỗi ngày
- `dateext`: Thêm ngày tháng vào tên file
- `compress`: Cho phép nén file 

Kiểm tra file cấu hình bằng lệnh
```
[root@localhost ducmanh287]# logrotate -d /etc/logrotate.d/cmdlog
Handling 1 logs

rotating pattern: /var/log/cmdlog.log  after 1 days (4 rotations)
empty log files are rotated, old logs are removed
considering log /var/log/cmdlog.log
Creating new state
  Now: 2024-04-11 17:06
  Last rotated at 2024-04-11 17:00
  log does not need rotating (log has already been rotated)

# Thực hiện cấp quyền
[root@localhost ducmanh287]# chmod 755 /var/log

# Thực hiện chạy file cấu hình
[root@localhost ducmanh287]# logrotate -f /etc/logrotate.d/cmdlog
```
Kết quả:

![](/Anh/Screenshot_551.png)

### Cấu hình logrotate theo dung lượng tối đa của file
Để cấu hình Logrotate theo dung lượng tối đa của file chúng ta thực hiện như sau:
```
# Thêm vào file cấu hình của logrotate như sau:
[root@localhost ducmanh287]# vim /etc/logrotate.d/cmdlog

# Thêm vào nội dung như sau:
/var/log/cmdlog.log {
size 100M
rotate 4
create
dateext
compress
}
```
***Giải thích***:
- `size 100M`: Dung lượng tối đa của file là 100Mb
- `rotate 4`: Cho phép tối đa tạo ra 4 file
- `create`: Tạo file mới mỗi ngày
- `dateext`: Thêm ngày tháng vào tên file
- `compress`: Cho phép nén file

Thực hiện kiểm tra và cài đặt
```
[root@localhost log]# logrotate -d /etc/logrotate.d/cmdlog
WARNING: logrotate in debug mode does nothing except printing debug messages!  Consider using verbose mode (-v) instead if this is not what you want.

reading config file /etc/logrotate.d/cmdlog
Reading state from file: /var/lib/logrotate/logrotate.status
Allocating hash table for state file, size 64 entries
Creating new state

Handling 1 logs

rotating pattern: /var/log/cmdlog.log  after 1 days (4 rotations)
empty log files are rotated, old logs are removed
considering log /var/log/cmdlog.log
  Now: 2024-04-11 17:16
  Last rotated at 2024-04-11 17:09
  log does not need rotating (log has already been rotated)

# Thực hiện chạy file cấu hình

[root@localhost log]# logrotate -f /etc/logrotate.d/cmdlog
```
Kiểm tra kết quả:

![](/Anh/Screenshot_552.png)

## Tiến hành gửi cmdlog đến Server
Ở trên máy client chúng ta thực hiện cấu hình như sau:
```
root@ubuntusv:/etc/rsyslog.d# vim /etc/rsyslog.d/514-cmdlog.conf
$Modload imfile
$InputFilePollInterval 10

$InputFileName /var/log/cmdlog.log
$InputFileTag cmdlog
$InputFileFacility local5
$InputRunFileMonitor
local5.* @@192.168.217.132:514
```
Việc cấu hình như trên sẽ gửi dữ liệu ở trong File `cmdlog.log` lưu vào biến `local5` và thực hiện gửi đi

Cấu hình trên Server, thêm vào file cấu hình chính của Rsyslog nội dung sau
```
module(load="imudp")
input(type="imudp" port="514")
$template RemoteServer, "/var/log/%fromhost-ip%/%programname%"
*.* ?RemoteServer
```
Việc cấu hình như trên sẽ áp dụng template cho tất cả các gói log nhận được

Kiểm tra kết quả:

![](/Anh/Screenshot_553.png)

## Kiểm tra quá trình gửi Log
Trước tiên, chúng ta cần phải xem Port 514 đã thực sự hoạt động hay chưa

Nếu đứng từ Server, chúng ta thực hiện bằng cách sử dụng lệnh ss, netstat như sau:
```
#Một vài câu lệnh
ss -lan | grep "514"      hoặc ss -lun | grep "514"

netstat -lan | grep 514... 
#Mẫu hiển thị đầu ra sẽ trông như sau
[root@localhost ducmanh287]# ss -lun | grep "514"
UNCONN 0      0            0.0.0.0:514       0.0.0.0:*
UNCONN 0      0            0.0.0.0:514       0.0.0.0:*
UNCONN 0      0               [::]:514          [::]:*
UNCONN 0      0               [::]:514          [::]:*
```
Vậy nếu đứng từ Client, làm sao chúng ta biết được Server đã mở port 514 hay chưa?

Lúc này, chính là lúc mà lệnh `nc` hoặc `telnet` phát huy tác dụng của mình. 
```
# Thực hiện dùng lệnh nc kiểm tra xem có kết nối được tới Server hay không?
ducmanh287@ubuntusv:~$ nc -uzv 192.168.217.132 514
Connection to 192.168.217.132 514 port [udp/syslog] succeeded!
 
Như vậy là đã kết nối thành công tới Server thông qua [udp/syslog] port 514
```

Ở trên Server, thực hiện kiểm tra lắng nghe trên cổng 514 như sau:
```
[root@localhost ducmanh287]# nc -ul 514
<173>Apr 16 07:22:55 ubuntusv cmdlog Apr 16 07:22:53 ubuntusv root:   211  root (192.168.217.1) 16/04/24 07:22:52 heel
<173>Apr 16 07:22:55 ubuntusv cmdlog Apr 16 07:22:53 ubuntusv root:   212  root (192.168.217.1) 16/04/24 07:22:53 dsfsdg
<173>Apr 16 07:22:55 ubuntusv cmdlog Apr 16 07:22:54 ubuntusv root:   213  root (192.168.217.1) 16/04/24 07:22:54 sgfd
....
# Như vậy nghĩa là Server đã lắng nghe thành công
```

Bắt gói tin và kiểm tra nội dung gói tin thử:
```
[root@localhost ducmanh287]# tcpdump -i ens33 port 514 -w testlog.pcap -c 50
dropped privs to tcpdump
tcpdump: listening on ens33, link-type EN10MB (Ethernet), snapshot length 262144 bytes
^C9 packets captured
9 packets received by filter
0 packets dropped by kernel
```

**Kiểm tra bằng WireShark**

![](/Anh/Screenshot_554.png)

Như các bạn có thể thấy, khi gửi bằng UDP, chúng ta có thể đọc toàn bộ nội dung gói tin Syslog

**Giải thích lý do:**
- Khi sử dụng giao thức TCP để gửi gói tin Syslog, dữ liệu thường được gửi dưới dạng các chuỗi ký tự được mã hóa, thường là theo các định dạng như RFC3164 hoặc RFC5424. Với giao thức TCP, dữ liệu được chia thành các phần (hoặc gói tin TCP) và được gửi dưới dạng các phần riêng lẻ. Vì vậy khi bạn bắt gói tin bằng Wireshark, Wireshark sẽ hiển thị mỗi gói tin TCP dưới dạng một đơn vị riêng biệt, chứ không phải là dữ liệu đầy đủ của thông điệp Syslog.
- Trong khi đó, khi sử dụng giao thức UDP, mỗi thông điệp Syslog thường được gửi trong một gói tin UDP đầy đủ và độc lập. Do đó, khi bạn bắt gói tin UDP bằng Wireshark, mỗi gói tin sẽ chứa đầy đủ thông điệp Syslog mà không cần phải ghép nối như trong trường hợp của giao thức TCP.