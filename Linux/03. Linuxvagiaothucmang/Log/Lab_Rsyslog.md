Mục Lục
- [Mục này thực hiện Lab Rsyslog: Thực hiện cấu hình Log tập trung](#mục-này-thực-hiện-lab-rsyslog-thực-hiện-cấu-hình-log-tập-trung)
  - [Tại sao cần đẩy log từ client lên Server](#tại-sao-cần-đẩy-log-từ-client-lên-server)
  - [Chuẩn bị trước khi thực hành](#chuẩn-bị-trước-khi-thực-hành)
    - [Kiến thức cần nhớ](#kiến-thức-cần-nhớ)
    - [Kiến thức mới](#kiến-thức-mới)
    - [Mô hình và yêu cầu thực hành](#mô-hình-và-yêu-cầu-thực-hành)
  - [Thực hành](#thực-hành)
    - [Gửi các log do hệ thống sinh ra:](#gửi-các-log-do-hệ-thống-sinh-ra)
      - [Cấu hình trên Client](#cấu-hình-trên-client)
      - [Cấu hình trên Server](#cấu-hình-trên-server)
      - [Kiểm tra kết quả:](#kiểm-tra-kết-quả)
    - [Gửi các log do các dịch vụ khác sinh ra](#gửi-các-log-do-các-dịch-vụ-khác-sinh-ra)
      - [Cấu hình trên Client](#cấu-hình-trên-client-1)
      - [Cấu hình trên Server](#cấu-hình-trên-server-1)
      - [Tiến hành kiểm tra:](#tiến-hành-kiểm-tra)
    - [Dùng TCP Dump bắt gói tin lúc gửi log và phân tích bằng WireShark](#dùng-tcp-dump-bắt-gói-tin-lúc-gửi-log-và-phân-tích-bằng-wireshark)
    - [Cấu hình Rsyslog để chỉ gửi một số log quan trọng](#cấu-hình-rsyslog-để-chỉ-gửi-một-số-log-quan-trọng)
    - [Cấu hình Rsyslog để chỉ gửi các log ssh](#cấu-hình-rsyslog-để-chỉ-gửi-các-log-ssh)


# Mục này thực hiện Lab Rsyslog: Thực hiện cấu hình Log tập trung
## Tại sao cần đẩy log từ client lên Server
- Khi bạn phải thực hiện quản lý nhiều máy cùng một lúc thì không phải lúc nào bạn cũng có thể ssh vào từng máy để kiểm tra từng file Log được. Lúc này, việc đầy các file log từ các máy về 1 máy để thực hiện quản lý là điều tối ưu nhất

![](/Anh/Screenshot_533.png)

- Hoặc ví dụ khi một máy nào đó trong hệ thống máy của bạn bị lỗi, không thể khởi động được thì qua cấu hình log tập trung, ta có thể xem được file log của máy đó trước khi bị lỗi để sửa. Kể cả khi máy đó bị xóa đi thì chúng ta vẫn có thể xem lại nhật kí hoạt động trên máy đó
## Chuẩn bị trước khi thực hành
### Kiến thức cần nhớ
- Syslog là một giao thức tiêu chuẩn được sử dụng để ghi lại các thông điệp từ các thiết bị và ứng dụng trong mạng, lưu trữ và chuyển tiếp các thông điệp đó
- Rsyslog là một ứng dụng trong Linux, Rsyslog sử dụng giao thức Syslog để thu thập, xử lý và chuyển tiếp các thông điệp 
- File log là các tập tin lưu lại các thông điệp được Rsyslog thu thập

### Kiến thức mới
Log mà Rsyslog có thể thu thập được sẽ được phân chia làm 2 loại lớn:
- Log do các tiến trình hệ thống sinh ra: Như kernel hay auth,..
- Log do các ứng dụng tải về sinh ra: Như apache hay nginx,...

Để có thể cấu hình log tập trung, chúng ta cần hiểu về các module hỗ trợ thu thập log của Rsyslog trước. Hiểu và biết được cách khai báo, cách gọi các module đó như thế nào.

Ở bài này, chúng ta sẽ sử dụng module `imfile` - đây là mudule biến nội dung của 1 file bất kỳ thành các thông điệp mà Rsyslog hiểu được

Sau khi thu tập dữ liệu xong, chúng ta cũng cần phải gửi các log đi dưới định dạng nhất định để khi chúng ta xem log trên Server thì chúng ta có thể hiểu được. Lúc này là lúc chúng ta sử dụng biến `$template`. Một số **template** string tham khảo:

|Template|Nội dung|
|----|-----|
|`%msg%`| Chèn nội dung log message|
|`%timestamp%`| Chèn vào thời gian ghi log
|`%hostname%`| Chèn vào tên máy chủ gửi log
|`%syslogfacility%` và `%syslogfacility-text%`|Chèn mã của dịch vụ sinh log và văn bản tương ứng với cơ sở của syslog|
|`%syslogpriority%` và `%syslogpriority-text%`|Chèn mã của mức độ cảnh báo sinh log và text tương ứng|
|`%programname%`|Chèn tên chương trình sinh ra log|
|`%$YEAR%`, `%$MONTH%`, `%$DAY%`, `%$HOUR%`, `%$MINUTE%`, `%$SECOND%`|Chèn các phần riêng lẻ của **Timestamp**|
|`%fromhost-ip%`|Chèn IP của máy gửi log|
|`%uuid%`|Chèn UID một cách ngẫu nhiên|
|-------------------------------------------------|----------------------------------------------|

Các biến local trong Syslog: Các biến `local0` đến `local7` được sử dụng để định nghĩa các kiểu thông điệp log cụ thể. Bạn có thể gán một giá trị số cho mỗi biến này trong tệp cấu hình **Syslog** và sau đó sử dụng chúng để quy định cách xử lý các thông điệp log từ các nguồn khác nhau. Điều này giúp tổ chức và phân loại các thông điệp log một cách rõ ràng và linh hoạt.

|Số thứ tự biến|Chức năng|
|--------------|---------|
|local0| Được sử dụng để định nghĩa một loại thông điệp log chung, thường là cho các ứng dụng hoặc dịch vụ riêng biệt mà bạn muốn ghi log một cách độc lập|
|local1|Thường được sử dụng cho một mục đích log cụ thể, có thể là cho một ứng dụng hoặc dịch vụ nhất định|
|local2|Thường được sử dụng cho một mục đích log cụ thể, có thể là cho một ứng dụng hoặc dịch vụ nhất định|
|local3|Thường được sử dụng cho một mục đích log cụ thể, có thể là cho một ứng dụng hoặc dịch vụ nhất định|
|local4| Một loại thông điệp log đặc biệt, có thể được sử dụng để ghi log cho một ứng dụng quan trọng hoặc một loại hoạt động cụ thể|
|local5|Được sử dụng cho một mục đích log cụ thể, có thể là để ghi log cho một ứng dụng hoặc dịch vụ nhất định|
|local6|Được sử dụng cho một mục đích log cụ thể, có thể là để ghi log cho một ứng dụng hoặc dịch vụ nhất định|
|local7|Một loại thông điệp log đặc biệt, có thể được sử dụng để ghi log cho các hoạt động quan trọng hoặc một ứng dụng cụ thể|


### Mô hình và yêu cầu thực hành
Mô hình thực hành sẽ được miêu tả qua ảnh như sau:

![](/Anh/Screenshot_534.png)

Tôi có 2 máy ảo:
- Ubuntu Server sẽ dùng làm Logclient
- CentOS 9 sẽ dùng làm RsyslogServer

Tôi dùng PC Windows để SSH và điều khiển 2 máy ảo

Yêu cầu:
- Gửi được tất cả log do hệ thống sinh ra từ client đến server và phải được đưa vào thư mục có tên lấy theo tên dịch vụ sinh ra
- Phải gửi được log do các dịch vụ
  - Http trên cổng 80
  - Tên do chúng ta tự chọn

## Thực hành
Ở trên các hệ thống Linux mặc định đã có Rsyslog rồi nên chúng ta chỉ việc sử dụng thôi
### Gửi các log do hệ thống sinh ra:
#### Cấu hình trên Client
Chúng ta sẽ không thực hiện cấu hình trên file cấu hình chính của Rsyslog. Thay vào đó, chúng ta thực hiện thêm mới 1 file cấu hình phụ như sau:
```
# Tạo file cấu hình mới
ducmanh287@ubuntusv:/etc/rsyslog.d$ sudo vim systemlog.conf

# Thêm vào nội dung sau:
*.* @@192.168.217.132:287

# Thoát, sau đó khởi động lại rsyslog
ducmanh287@ubuntusv:/etc/rsyslog.d$ sudo systemctl restart rsyslog
```
Giải thích code:
- `*.*` ám chỉ  tất cả các nguồn sinh ra log và các mức cảnh báo
- `@@` ám chỉ giao thức TCP. Có thể dùng `@`- UDP
- `192.168.217.132:287`: Địa chỉ máy nhận log và cổng port sử dụng
#### Cấu hình trên Server
Để cấu hình Rsyslog cho việc nhận log trên Server chúng ta thực hiện như sau:
```
# Tạo mới 1 file cấu hình phụ
[ducmanh287@localhost ~]$ sudo vim /etc/rsyslog.d/systemlog.conf

# Thêm vào nội dung sau:
$ModLoad imtcp
$InputTCPServerRun 287 
$template RemoteServer, "/var/log/testlog/%fromhost-ip%/%programname%"
*.* ?RemoteServer

# Thoát khỏi và khởi động lại rsyslog
[ducmanh287@localhost ~]$ sudo systemctl restart rsyslog
```
Giải thích code:
- `$ModLoad imtcp`: Load module imtcp - cho phép nghe qua tcp
- `$InputTCPServerRun 287`: Port sử dụng là 287
- `$template RemoteServer, "/var/log/testlog/%fromhost-ip%/%programname%"`: Đường dẫn lưu log trên server
- `*.* ?RemoteServer`: Áp dụng Template

#### Kiểm tra kết quả:
Ở trên Server, thực hiện truy cập vào thư mục lưu file log của Client mà bạn đã cấu hình:
```
cd /var/log/testlog
```
Tôi sẽ sử dụng tree để xem các file, nếu không có sẵn bạn có thể cài đặt:
```
# Cài đặt
sudo apt install -y tree
sudo yum install -y tree

# Sử dụng
[root@localhost testlog]# tree
``` 
Kết quả:

![](/Anh/Screenshot_535.png)

### Gửi các log do các dịch vụ khác sinh ra
Ở đây ta sẽ cùng kiểm tra các log do dịch Apache sinh ra trên Client sẽ được gửi lên Server.

#### Cấu hình trên Client
Thực hiện cấu hình trên Client như sau:
```
# Thực hiện tạo file cấu hình mới
vim /etc/rsyslog.d/apache2.conf

# Thêm vào nội dung sau:
$Modload imfile
$Inputname /var/log/apache2/access.log
$InputFileTag accesslogapache.log
$InputFileFacility local3
$InputFilePollInterval 10
$InputRunFileMonitor

$InputFilename /var/log/apache2/error.log
$InputFileTag erorrlogapache.log
$InputFileFacility local3
$InputFilePollInterval 10
$InputRunFileMonitor
local3.*@@192.168.217.132:514

#Thoát khỏi vim, lưu file và thực hiện khởi động lại dịch vụ

root@ubuntusv:/etc# systemctl restart rsyslog
```
#### Cấu hình trên Server
Đối với Server nhận log, chúng ta cấu hình như sau:
```
# Tạo một file cấu hình phụ mới
[root@localhost rsyslog.d]# vim apachelog.conf

# Thêm vào nội dung như sau:
$ModLoad imtcp
$InputTCPServerRun 514
$template RemoteServer, "/var/log/testlog/%fromhost-ip%/%programname%"
local3.* ?RemoteServer

# Thoát ra và thực hiện lưu file, khởi động lại dịch vụ Rsyslog
[root@localhost rsyslog.d]# systemctl restart rsyslog
```
#### Tiến hành kiểm tra:
Từ máy Windows, sử dụng dịch vụ Apache, truy cập vào IP của máy Client

![](/Anh/Screenshot_538.png)

Kiểm tra file log bên máy client

![](/Anh/Screenshot_539.png)
![](/Anh/Screenshot_540.png)

Kiểm tra bên máy Server
- Kiểm tra xem file đã tồn tại chưa
- ![](/Anh/Screenshot_541.png)
- Kiểm tra nội dung file
- ![](/Anh/Screenshot_542.png)

### Dùng TCP Dump bắt gói tin lúc gửi log và phân tích bằng WireShark
Trong quá trình gửi log, chúng ta đừng từ client hoặc server thực hiện sử dụng tcpdump bắt các gói tin như sau:
```
root@ubuntusv:/home/ducmanh287# tcpdump -i ens33 port 514 -w testlog.pcap
tcpdump: listening on ens33, link-type EN10MB (Ethernet), snapshot length 262144 bytes
```

Thực hiện chuyển file sang PC: Windows và phân tích lại bằng WireShark như sau:

![](/Anh/Screenshot_543.png)

Kiểm tra với lệnh ss 
```
ss -tn
```
![](/Anh/Screenshot_544.png)

Như các bạn đang thấy, port 514 đang được sử dụng liên tục

### Cấu hình Rsyslog để chỉ gửi một số log quan trọng
Ở đây, ví dụ tôi cần gửi một số file log quan trọng như file:
- auth.log
- kern.log
- syslog

Thực hiện cấu hình trên Client
```
# Thêm mới 1 file cấu hình phụ
root@ubuntusv:/etc/rsyslog.d# vim 01-systemlog.conf

# Thêm vào nội dung như sau:
$Modload imfile
$InputFilePollInterval 10

$InputFileName /var/log/syslog
$InputFileTag systemlog
$InputFileFacility local7
$InputRunFileMonitor
local7.* @@192.168.217.132:514

$InputFileName /var/log/auth.log
$InputFileTag authlog
$InputFileFacility local7
$InputRunFileMonitor
local7.* @@192.168.217.132:514

$InputFileName /var/log/kern.log
$InputFileTag kernlog
$InputFileFacility local7
$InputRunFileMonitor
local7.* @@192.168.217.132:514

# Thực hiện lưu và thoát khỏi VIM. Sau đó khởi động lại Rsyslog
root@ubuntusv:/etc/rsyslog.d# systemctl restart rsyslog
```

Đối với bên Server
```
# Bạn có thể thêm vào file cấu hình phụ sẵn có hoặc thêm mới một file cấu hình phụ dòng lệnh sau:

$ModLoad imtcp
$InputTCPServerRun 514
$template RemoteServer, "/var/log/testlog/%fromhost-ip%/%programname%"
local3.* ?RemoteServer
local7.* ?RemoteServer
```

Tiến hành kiểm tra lại:

![](/Anh/Screenshot_545.png)

Đọc nội dung các file xem đã đúng hay chưa
- File `auth.log`
- ![](/Anh/Screenshot_546.png)
- File `syslog`
- ![](/Anh/Screenshot_547.png)
- File `kernlog`
- ![](/Anh/Screenshot_548.png)

### Cấu hình Rsyslog để chỉ gửi các log ssh 
Thực hiện trên Client:
```
#Thêm vào 1 file cấu hình phụ và thực hiện chèn đoạn code sau:
auth.* @@192.168.217.132:514
```

Thực hiện trên Server
```
# Thêm mới một file cấu hình phụ và thực hiện như sau:
# Chấp nhận log SSH từ máy Ubuntu
if $programname == 'sshd' and $fromhost-ip == '192.168.217.128' then /var/log/ubuntu_ssh.log
& stop
```

Mẫu hiển thị kết quả:
```
Apr 8 15:30:12 ubuntu sshd[1234]: Accepted password for user from 192.168.217.1 port 22 ssh2
Apr 10 15:30:12 ubuntu sshd[1234]: pam_unix(sshd:session): session opened for user user by (uid=0)
```


