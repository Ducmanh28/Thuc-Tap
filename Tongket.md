# Mục này tổng hợp những kiến thức đã học trong 1 tuần

## Nội dung làm việc 2023 
### Từ 19/12 - 23/12 
- Hoàn thành tìm hiểu IP và chia Subnet
  - Hiểu Subnet dùng để làm gì
  - Làm các bài tập phần chia Subnet
  - Tạo ra ứng dụng chia Subnet
- Bắt đầu tìm hiểu sang phần hệ điều hành Linux:
  - Ubuntu:
    - Thực hiện cài đặt Ubuntu Server trên VMWare
    - Thực hiện set IP tĩnh cho Ubuntu Server:
      - Dùng cách chỉnh file 00-installer
      - Dùng các câu lệnh phần nmcli
    - Thực hiện test Ping thông giữa máy ảo và máy chủ sau khi set IP
  - CentOS 7:
    - Thực hiện cài đặt CentOS 7 trên VMWare
      - Tìm hiểu CentOS 7
      - Tìm hiểu các phiên bản của CentOS 7
    - Thực hiện set IP tĩnh cho CentOS 7 
      - Dùng cách chỉnh sửa file trong sysconfig
      - Dùng các câu lệnh nmcli
    - Thực hiện test Ping thông giữa máy ảo và máy chủ sau khi set
  - Thực hiện tìm hiểu 2 trình soạn thảo văn bản trong Linux
    - NANO:
      - Tổng quát
      - Cách sử dụng
      - Các tổ hợp phím
      - Các chức năng khi kết hợp nhiều tổ hợp phím
    - VIM/VI:
      - Tổng quát
      - 
  - Thực hiện làm việc với Server Vật Lý (Dell EMC)
    - Lắp đặt 1 số linh kiện cho Server
    - Cài OS cho Server bằng USB
    - Cài RAID cho Server
    - Cài iDRAC9 cho Server
    - Cài OS cho Server thông qua iDRAC9

### Từ 26/12 - 29/12
- Hoàn thành tìm hiểu VI/VIM
  - Các mode của VIM
  - Các phím tắt và cách sử dụng của từng mode
  - Sử dụng thử từng chức năng
- So sánh giữa VIM/NANO:
  - Sử dụng VIM:
    - Có các chế độ
    - Các phím tắt không quá khó để sử dụng
    - Sử dụng tối đa chức năng 1 cách đơn giản
- Tìm hiểu quá trình Boot của 1 hệ điều hành
  - BIOS/UEFI là gì?
  - Boot Device là gì? Các loại Boot Device
  - GRUB Boot Loader là gì?
    - Các loại GRUB
    - Quá trình GRUB Boot Loader
  - Quá trình Execute systemd là gì ?
    - Systemd là gì
    - Cấu tạo Systemd
  - File .target và các Startup Scripts
- Bắt đầu các thao tác cơ bản với hệ điều hành Linux(Sử dụng Ubuntu Server)
  - Các tổ hợp phím tắt cơ bản làm việc với terminal
  - Các câu lệnh cơ bản
    - Hỗ trợ hiểu biết về hệ thống
    - Làm quen với Process
  - Các câu lệnh làm việc
    - Làm việc với file

## Nội dung làm việc 2024
### Từ 2/1 - 6/1
- Bổ sung thêm thông tin vào phần thao tác Linux cơ bản:
  - Trợ giúp trong Linux
  - Các câu lệnh làm việc với hệ thống
- Tiếp tục tìm hiểu các câu lệnh cơ bản của Linux
  - Các lệnh về phân quyền người dùng đối với 1 file
  - Làm việc với Shell
- Kiểm tra các package đã được cài trong UbuntuServer
  - Sử dụng lệnh `apt list --installed `
- Kết hợp sử dụng Linux với các giao thức 
  - SSH
    - Khái niệm SSH
    - Công dụng
    - Cách hoạt động: 
      - Định danh host
      - Mã hóa/giải mã
      - Chứng thực
    - Các ứng dụng để sử dụng SSH
      - Sử dụng trên Windows
        - Putty
        - MobaXterm
        - Sử dụng lệnh trên CMD
      - Sử dụng trên Linux
        - Dùng lệnh
    - Tiến hành sử dụng SSH
- Tham gia vào lớp học viết tài liệu SEO
  - SEO là gì?
  - Cách viết tài liệu SEO
### Từ 9/1 - 13/1
- Tìm hiểu chi tiết về giao thức SSH
  - Các cơ chế truy cập:
    - Bằng user
    - Bằng key
  - File log/file cấu hình SSH
    - `/etc/ssh/ssh_config`
    - `/var/log/auth.log`
  - Quản lý truy cập SSH thông qua telegram
    - Cài `jq`(có thể không cần)
    - Tạo Bot Telegram
    - Viết Scripts `ssh-telegram.sh` và lưu vào `/etc/profile.d`
    - Cho phép khởi chạy file `ssh-telegram.sh`
    - Thực hiện SSH và kiểm tra quá trình
  - Disable roots từ xa, đổi port
    - Đều thực hiện chỉnh sửa trong file `etc/ssh/ssh_config`
- Hoàn thành tìm hiểu LinuxNoteForProfessional
- Bắt đầu tìm hiểu về Linux Fundamentals
  - Lịch sử phát triển Linux
  - Các lệnh khởi đầu:
    - Lệnh trợ giúp `man`
    - Lệnh `pwd`
    - Lệnh `cd`
    - Lệnh `ls`
    - Lệnh `mkdir`, `rmdir`
    - Lệnh `file`, `touch`

### Từ 16/1 - 20/1
- Tập trung tìm hiểu giao thức HTTP
  - HTTP: Khái niệm, tác dụng, cấu trúc gói tin
  - HTTPS: Khái niệm, tác dụng, so sánh http và https, cách từ HTTP --> HTTPS
  - Sử dụng http trên windows
  - Sử dụng http trên Linux
    - Apache2:
      - khái niệm, công dụng, cách sử dụng 
      - File log Apache
      - File cấu hình Apache
      - Tạo trang web đơn giẳn sử dụng apache2
      - Một số bài toán cấu hình webserver đơn giản
        - 1 website có 1 tên miền, 1 ip, 1 port
        - 1 website có nhiều tên miền, 1 ip, 1 port
        - 1 website có 1 tên miền, 1 ip, nhiều port
        - nhiều website có 1 tên miền, 1 ip, nhiều port
      
### Từ 23/1 - 27/1 
- Tập trung vào giao thức HTTP
  - Sử dụng http trên Linux:
    - Nginx:
      - khái niệm, công dụng, cách sử dụng
      - So sánh giữa Nginx và Apache
      - File log của Nginx
      - File cấu hình của Nginx
      - Tạo trang web đơn giản sử dụng Nginx
- Viết bài về L.A.M.P
  - LAMP là gì? Cách cài đặt LAMP trên UbuntuServer
  - LAMP là gì? Cách cài đặt LAMP trên CentOS 7
- Tìm hiểu cách đưa một website ra môi trường Internet
  - Lựa chọn Nhà Cung Cấp Dịch Vụ Hosting và Đăng Ký Tên Miền
  - Phát triển Trang Web
  - Tạo và Cấu Hình Trang Web
  - Tạo và Cấu Hình Trang Web
  - Cấu Hình Cơ Sở Dữ Liệu (Nếu Cần Thiết)
  - Kiểm Tra và Kiểm Soát Lỗi
  - Cấu Hình DNS và Đăng Ký Tên Miền
  - Kiểm Tra và Đưa Trang Web Lên Internet

### Từ 30/1 - 3/2
- Tập trung vào giao thức Http
  - Lab các bài toán về Nginx
  - Lab đưa trang web lên Internet khi có 1 Server sở hữu IP Public, 1 DNS.
  - Chỉnh sửa và thêm các nội dung còn thiếu phần Nginx và Apache
  - Tìm hiểu về WordPress
    - Lý thuyết về WordPress
    - Thực hành cài đặt và sử dụng WordPress
- Tìm hiểu thêm:
  - Tìm hiểu về IP Table: 
    - Khái niệm 
    - Dùng để làm gì
    - Tại sao cần dùng?
    - Ưu và nhược điểm
  - Tìm hiểu về 5 Scripts 
    - Vẽ ra hình
    - Tạo chữ có màu sắc
    - Mã hóa tệp tin/ thư mục
    - Trình bày sức khỏe hệ thống
    - Giám sát việc sử dụng ổ đĩa

### Từ 5/2 - 19/2
- Tập trung vào tìm hiểu Python
  - Tìm hiểu 30 ngày học tập Python (Đã học đến ngày )
  - Kết hợp tìm hiểu và học trên CodeLearn
- Tìm hiểu thêm về IPTable
  - Các thành phần chính của IPTable
    - Table
    - Chain
    - Target

### Từ 20/2 - 26/2
- Tìm hiểu Python
- Đọc lại nội dung về IpTables

### Từ 27/2 - 1/3
- Bổ sung thông tin về IpTables
  - Thứ tự các bảng mà gói tin phải đi qua
  - Quy trình xử lý một gói tin
  - Khi có mâu thuẫn giữa các rule
  - Nội dung các file cấu hình của IpTables
- Sử dụng IpTables trên CentOS 7 
  - Cài đặt
  - Thêm rule bằng 2 cách
    - Bằng cách chỉnh sửa file cấu hình
    - Bằng cách thao tác với các lệnh
  - Làm một số bài toán cấu hình IpTables:
    - Chặn 1 địa chỉ IP cụ thể
    - Cho phép truy cập SSH từ 1 IP
    - Giới hạn thời gian SSH
    - Giới hạn tần suất các gói tin TCP đến cổng 80
    - Mở cổng 80 cho phép truy cập vào 1 trang web cụ thể và chặn truy cập vào các trang web khác
  - Lab IpTables trên CentOS 9:
    - Học cách cài đặt và sử dụng
    - Lab 1 số bài toán cơ bản như ở CentOS 7
    - Lab 1 số bài toán nâng cao hơn:
      - Cấu hình IpTables giới hạn SSH vào Server và gửi cảnh báo cho người dùng số lần đã SSH(chưa hoàn thành)

### Từ 2/3 - 9/3 
- Hoàn thành bài toán cấu hình IpTables còn dở
- Lab IpTables theo Server World: 3 ví dụ
  - Tìm hiểu về giao diện mạng
  - Tìm hiểu bảng NAT của IpTables
### Từ 12/3 - 16/3
Tìm hiểu Ubuntu 22 theo Server World
- Install và Setting cơ bản cho Ubuntu
  - Cài đặt
  - Làm việc với User
  - Cài đặt mạng
  - Cài đặt hệ thống
  - VIM Setting
  - Sudo Setting
- SSH
  - SSH Server
  - SSH Client
    - Ubuntu
    - Windows
  - SSH File Transfer 
    - Ubuntu
    - Windows
  - SSH Xác thực Key-Pair
### Từ 18/3 - 24/3 
Tìm hiểu SSH Ubuntu
- SSH Key- Pair ( tiếp tục)
  - tạo, xóa khóa
  - đăng nhập bằng khóa
  - kiểm tra file log
  - So sánh lệnh `scp` và `ssh-copy-id`
- Tìm hiểu Tcpdump
  - Khái niệm, công dụng, cách sử dụng
  - Sử dụng tcpdump
    - Một vài thao tác cơ bản
    - Bắt các gói tin đơn giản
    - Bắt gói tin SSH khi chuyển khóa
    - Bắt các gói tin SSH khi đăng nhập
  - Kết hợp giữa Tcpdump và WireShark
    - Bắt các gói tin bằng TcpDump trên Ubuntu, lưu file
    - Sử dụng SFTP để chuyển file `.pcap` sang Windows
    - Phân tích bằng WireShark trên Windows

### Từ 25/3 - 30/3
Tìm hiểu và viết bài về các lệnh được giao
- Lệnh netstat, ss: Các lệnh hiển thị, kiểm tra thông tin về mạng. Trong đó, ss tối ưu hơn netstat
- Lệnh nc(netcat): Kiểm tra, thiết lập các kết nối mạng, thực hiện các thao tác trực tiếp với kết nối mạng

Tiếp tục tìm hiểu Server World
- SFTP only Chroot: Chỉ cho phép dùng sftp trên một thư mục nhất định
- SSH - Agent: tạo khóa ssh đăng nhập không cần mật khẩu

### Từ 1/4 - 6/4 
Tiếp tục tìm hiểu về Server World mục SSH
- SSHPass: 
- SSHFS - SSH File System
- SSH Port Forwarding
- Parallel SSH

Dùng `tcpdump` bắt gói tin nc khi thực hiện chuyển dữ liệu và phân tích lại bằng WireShark

Tìm hiểu về Log, giao thức Syslog, ứng dụng RSyslog
- Log là các file thông điệp
- Syslog là giao thức được sử dụng để tìm kiếm, lưu trữ, phân tích và chuyển tiếp các Logfile
- Rsyslog là ứng dụng sử dụng giao thức Syslog

Thực hành lab Rsyslog: Dựng 2 máy ảo Linux cấu hình Log tập trung
- Thực hiện gửi các log do hệ thống sinh ra
- Thực hiện gửi các log do các ứng dụng tải về sinh ra(Http)

### Từ 7/4 - 13/4
Tiếp tục làm lại phần Rsyslog
- Làm chi tiết hơn phần Log
- Lọc ra và gửi các Log SSH
- Sử dụng tcpdump, lệnh ss, lệnh nc và netstat để kiểm tra quá trình gửi Log
- Cấu hình Rsyslog ghi lại các lệnh mà User đã sử dụng
  - Cấu hình cho các User có sẵn
  - Cấu hình cho các User được thêm mới sau này
  - Cấu hình Logrotate, tìm hiểu về các biến Local
  - Cấu hình Rsyslog để gửi cmd đến Server
- Việc gửi Log còn gặp lỗi:
```
rsyslogd: pidfile '/run/rsyslogd.pid' and pid 1839 already exist.
If you want to run multiple instances of rsyslog, you need to specify
different pid files for them (-i option).
rsyslogd: run failed with error -3000 (see rsyslog.h or try https://www.rsyslog.com/e/3000 to learn what that number means)
```
Sửa tạm thời

### Từ 15/4 - 20/4
Kiểm tra trạng thái Port trên Server
- Khi đứng từ Server
  - Lệnh `ss`: `ss -tuln `
  - Lệnh `netstat`: `netstat -tuln`

- Khi đứng từ Client
  - Lệnh `nc` có thể sử dụng để kiểm tra các port TCP/UDP 
```
nc - zv 192.168.217.132 514

nc -uzv 192.168.217.132 514
```
  - Lệnh `nmap` có thể sử dụng để quét các Port
```
nmap -p 514 192.168.217.132

nmap -sU -p 514 192.168.217.132
```
  - Lệnh `telnet` có thể sử dụng để kiểm tra các port TCP
```
telnet 192.168.217.132 514
```
Tuy nhiên:
- Trong quá trình tìm hiểu còn gặp lỗi khi sử dụng `nc`: Lỗi khi thực hiện tắt card mạng vẫn có thể kết nối tới Server. Đánh giá khả năng gây lỗi do các cache và buffer, sau khi thực hiện xóa thì chưa gặp lại tình trạng lỗi
- Đối với lệnh telnet, cần phân biệt giữa Port mở đang lắng nghe và Port mở không lắng nghe. Kể cả trên Server có mở Port thông qua tường lửa nhưng không có dịch vụ nào sử dụng Port để Port lắng nghe thì Telnet sẽ hiển thị không thể kết nối

Hoàn thành gửi CMD Log thông qua Port 514 UDP từ CLient đến Server

Lý thuyết về DNS:
- Là hệ thống phân giải tên miền thành địa chỉ IP tương ứng và ngược lại
- Giúp máy tính và các thiết bị truy cập internet dễ dàng tìm kiếm và kết nối với các máy chủ và dịch vụ thông qua tên miền thay vì phải ghi nhớ địa chỉ IP số
- Trong môi trường Linux, dịch vụ DNS thường được triển khai thông qua các máy chủ DNS như BIND (Berkeley Internet Name Domain) hoặc dnsmasq(dùng chủ yếu là dnsmasq)
-  DNS cài đặt không gian tên phân cấp dùng cho các đối tượng trên Internet. Các tên DNS được xử lý từ trái sang phải, sử dụng dấu chấm để ngăn cách. Mỗi quốc gia có 1 tên miền, ngoài ra còn có 6 tên miền lớn gồm: edu, com, gov, org và net. 6 miền lớn này nằm ở Mỹ. Những tên miền không chỉ ra tên nước một cách tường minh thì mặc nhiên nằm ở Mỹ
-  Các Server tham gia vào hệ thống DNS:
   -  **DNS Recursor**: Đóng vai trò liên lạc với các server khác để thay nó làm nhiệm vụ phản hồi cho client
   -  **Local Nameserver**: Dùng để chứa thông tin để truy xuất và tìm kiếm máy chủ tên miền. 
   -  **Root Nameserver**: Đùng để định hướng cho việc tìm kiếm
   -  **TLD Nameserver**: Nó sẽ chịu trách nhiệm quản lý toàn bộ thông tin của 1 phần mở rộng tên miền chung
   -  **SLD Nameserver**: Là phần chịu trách nhiệm quản lý phần domain trước đuôi. Đứng ngay sau **TLD Nameserver**
   -  **Authiritative Nameserver**: Đây là nơi việc phân giải tên miền diễn ra

### Từ 22/04 - 27/04
Tiếp tục tìm hiểu Lý thuyết về DNS:
- Lịch sử hình thành và phát triển phát triển: 
  - Trước khi có DNS, người ta sử dụng "Hosts" file
  - 1983 DNS ra đời
  - 1984 bắt đầu ra môi trường Internet thực tế
  - 1984 đến nay, các bản cập nhật, mở rộng, nâng cấp thêm
- Lưu lượng DNS: Là lượng dữ liệu truyền tải giữa máy tính của người dùng và máy chủ DNS khi thực hiện phân giải
- Mô hình và cách thức hoạt động
  - Người dùng tìm tên miền
  - PC gửi truy vấn đến các máy chủ DNS
  - Các máy chủ lần lượt tìm kiếm từ Local DNS --> ROOT DNS --> TLD Server --> Authoritative trả về địa chỉ IP

![](/Anh/Screenshot_566.png)
- DNS Caching: là bộ nhớ lưu lại các tên miền đã được phân giải
- Một số bản ghi DNS phổ biến: 
  - A Record: Bản ghi IPv4
  - AAAA Record: Bản ghi IPv6
  - CNAME Record: Bản ghi alias
- Cấu trúc gói tin:
  - Thông tin truy vấn bao gồm 1 `header` và `question record`
  - Thông tin trả lời bao gồm một `header`, `question record` và `answer record`, các bản ghi có thẩm quyền và các bản ghi bổ sung
- Các loại truy vấn: 
  - Recursive query: Là gói tin yêu cầu
  - Iterative query: Là gói tin trả về tốt nhất. Có thể trả về IP hoặc trả về Server chứa thông tin cần tìm
- DNS Registry và DNS Registrar
  - DNS Registry là các tổ chức quản lý các TLD Server
  - DNS Registrar là các tổ chức, công ty mạng cung cấp các dịch vụ đăng ký tên miền, được cấp phép bởi Registry
- Mô hình cấp bậc, phân quyền DNS Server:
  - ROOT NAME SERVER do ICANN và một số tổ chức lớn quản lý, có 13 ROOT NAME SERVER trên toàn thế giới
  - TLD SERVER do các Registry quản lý
  - SLD SERVER do các tổ chức, công ty cá nhân quản lý
  - AUTHORITATIVE SERVER do các Registrar quản lý
  - LOCAL NAME SERVER do các User quản lý

- Một số ví dụ thực tế:
  - Khi kết nối đến dantri.vn từ Việt Nam
  - Khi kết nối đến dantri.vn từ Mỹ
  - Khi kết nối đến 1 tên miền không tồn tại
- Băt và phân tích các gói tin DNS bằng WireShark
  - Gói tin gửi yêu cầu hỏi về tên miền tới DNS Server
  - DNS Server thực hiện trả về IP nếu tên miền ấy tồn tại

![](/Anh/Screenshot_569.png)

- Cấu hình Lab DNS Local trên Windows 
  - Máy ảo cài Windows Server và cấu hình làm DNS Server
  - Máy chính dùng Windows 10 cấu hình DNS Client
  - Mô hình thực hành trông như dưới
  - Sử dụng lệnh `nslookup` để kiểm tra

![](/Anh/Screenshot_572.png)

### Từ 6/5 - 11/5
Triển khai Lab DNS Local
- Mô hình triển khai

![](/Anh/Screenshot_601.png)

- Các bài lab triển khai:
  - DNS Local giữa 2 máy windows
  - DNS Foward ra Internet
  - ![](/Anh/Screenshot_603.png)
  - DNS Local trỏ tới trang web ở WebServer Unbuntu
  - ![](/Anh/Screenshot_609.png)

- Quá trình triển khai:
  - Chuẩn bị: Các thiết bị VM
    - Windows 10
    - Windows Server 2022
      - Đổi tên thành **WINSV22**
      - Cài IP tĩnh
      - Thiết lập DNS Local là IP của SV
  - Triển khai:
    - Server:
      - Cài AD DS(Active Directory Domain Systems)
      - Cài DNS Server
      - Cấu hình AD DS làm DC(Domain Controller)
      - Cấu hình DNS Server
        - Tạo Zone mới
        - Thêm Bản ghi A hoặc CNAME
        - Tạo bản ghi PTR
      - Thực hiện `nslookup` xuôi ngược để kiểm thử
    - Client:
      - Thiết lập DNS Server là **WINSV22**
      - Thực hiện `nslookup` xuôi-ngược để kiểm thử 
      - Sử dụng WireShark để bắt gói tin và kiểm thử
  - Kết quả:

![](/Anh/Screenshot_597.png)

![](/Anh/Screenshot_602.png)

![](/Anh/Screenshot_608.png)

![](/Anh/Screenshot_618.png)

![](/Anh/Screenshot_619.png)

![](/Anh/Screenshot_620.png)

### Từ 13/5 - 19/5
Tiếp tục hoàn thành các bài Lab DNS Local
- Chỉnh sửa bài lab web apache local
- Làm bài lab ubuntu server local trỏ ra ngoài Internet thông qua DNS Server Local
- Thực hiện các bài Lab DNS Server trên hệ thống LAB của công ty

Tìm hiểu giao thức nfs
- Là giao thức dùng để truy cập vào các tập tin của 1 Server nào đó từ xa
- Mọi hành động chỉnh sửa thêm mới đối với các tập tin ở trên Client đều sẽ được lưu lại trên Server
- Giao thức RPC hay còn gọi là mô hình kỹ thuật mạng thể hiện sự giao tiếp giữa Client và Server
- Sử dụng NFS
  - Cài đặt trên Server và Client
  - Tạo tệp chia sẻ
  - Kết nối và thao tác trên tệp
  - Đóng kết nối
### Từ 20/5 - 25/5:
Chỉnh sửa lại phần cài đặt IP cho Ubuntu

Giao thức RDP:
- Thực hiện bật Firewall, cho phép Port 3389. 
  - Bật Firewall sẽ không còn Ping được nếu như không cấu hình Firewall cho phép Ping(File and Printer Sharing)
  - Không thể Remote nếu như không mở port 3389(Port mặc định của RDP)
  - Cấu hình mở Port trong Firewall, InboundRules phần RDP
- Thay đổi Port. 
  - Thực hiện thay đổi Port mặc định RDP trong `regedit`
  - Thực hiện cấu hình Firewall mở port vừa thay đổi

Giao thức NFS:
- Khi 2 máy Ubuntu và Centos9 cùng Mount vào 1 thư mục trên Server thì khi có bất kì thay đổi nào với thư mục. Tất cả các máy đều sẽ thấy.
  - Cấu hình chia sẻ folder trên Server trước
  - Tạo file mount và thực hiện Mount từ Client
- Viết Bashscripts auto_nfs.sh làm được những việc như sau:
  - Kiểm tra OS xem có phải Ubuntu hay không
  - Đúng là Ubuntu sẽ hỏi người dùng muốn cài trên Server hay Client.
    - Nếu chọn Server:
      - Thực hiện cài đặt
      - Bật tường lửa
      - Show ra các thư mục đã chia sẻ nếu như đã cài đặt
    - Nếu chọn Client:
      - Hỏi người dùng xem chỉ muốn cài đặt hay vừa cài đặt vừa tự động Mount tới Server
        - Chỉ muốn cài đặt sẽ chỉ cài đặt
        - Cài đặt và tự động Mount:
          - Cài đặt 
          - Yêu cầu nhập vào Ip Server
            - Kiểm tra IP
            - Kiểm tra xem Port NFS trên Server có mở không
          - Yêu cầu nhập vào tên thư mục mount trên thiết bị
            - Nếu chưa có thư mục mount sẽ tự động tạo
          - Thực hiện Mount tới Server
          - In ra kết quả của việc Mount
- Tìm hiểu về Fstab:
  - là một tệp tin ở trong hệ thống Linux, được sử dụng để xác định các hệ thống tập tin và các thiết bị lưu trữ được gắn kết tự động và được tự động mount khi hệ thống khởi động. 
  - Cấu hình để tự động Mount
```
172.16.66.81:/mnt/shared /mnt/nfs_shared nfs defaults 0 0
```  





Nhiệm vụ tuần tới:
Sau khi hoàn thành các nhiệm vụ ở trên thì thực hiện
- Tìm hiểu lệnh iperf test tốc độ đọc ghi dữ liệu
- Câu lệnh của linux: disk sentinel linux. List devices, ktra cái nào là disk —> thực hiện lệnh check tốc độ
- Tìm hiểu về latency, iops, bandwith, các thông số về ổ cứng.
- Viết bashscripts: chạy lệnh kiểm tra tốc độ đọc/ghi của tất cả ổ cứng