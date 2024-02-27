MỤC LỤC
- [Cài đặt IP Tables](#cài-đặt-ip-tables)
- [Sử dụng IpTables trên CentOS 7](#sử-dụng-iptables-trên-centos-7)
  - [Chỉnh sửa file cấu hình](#chỉnh-sửa-file-cấu-hình)
    - [Các file của IpTables trong CentOS 7](#các-file-của-iptables-trong-centos-7)
      - [File iptables](#file-iptables)
      - [File iptables-config](#file-iptables-config)
    - [Thực hiện thêm rule bằng cách chỉnh sửa file cấu hình](#thực-hiện-thêm-rule-bằng-cách-chỉnh-sửa-file-cấu-hình)
  - [Thêm các rule cho IpTables bằng lệnh](#thêm-các-rule-cho-iptables-bằng-lệnh)
- [Một số câu lệnh bổ sung:](#một-số-câu-lệnh-bổ-sung)

# Cài đặt IP Tables
Mặc định các máy đã được cài sẵn Firewalld. Vậy nên trước khi tiến hành cài đặt chúng ta cần kiểm tra xem các dịch vụ của Firewalld có đang bật hay không, nếu có hãy thực hiện tắt chúng 
```
systemctl status firewalld
```

```
systemctl stop firewalld
systemctl disable firewalld
``` 

Cài đặt IpTable trên CentOS 7
- Mặc định Iptable đã được cài đặt sẵn trên hệ điều hành, nhưng để sử dụng nó như một services, chúng ta cần cài đặt thêm gói sau:
```
yum install iptables-services -y
```

Bật dịch vụ của Iptables:
```
systemctl start iptables
systemctl enable iptables
```
Do lúc này, Firewalld vẫn còn được coi là tường lửa mặc định nên ta cần ẩn nó đi
```
systemctl mask firewalld
```
Lúc này, ta đã có thể sử dụng IpTables được rồi

# Sử dụng IpTables trên CentOS 7
Có 2 cách mà chúng ta có thể sử dụng để cấu hình các rule cho IpTables. 
- Chỉnh sửa trong file cấu hình `/etc/sysconfig/iptables`
- Sử dụng lệnh để thao tác với IpTables.(Cách này sẽ yêu cầu ta phải lưu lại cấu hình rồi mới reload IpTabbles)
## Chỉnh sửa file cấu hình 
### Các file của IpTables trong CentOS 7
- `/etc/sysconfig/iptables`: Đây là nơi lưu trữ các quy tắc tường lửa cho IPv4. Các quy tắc trong tệp này được áp dụng khi dịch vụ IpTables khởi động hoặc khởi động lại
- `/etc/sysconfig/ip6tables`: Tệp này lưu trữ các quy tắc tường lửa cho IPv6
- `/etc/sysconfig/iptables-config`: Đây là tệp cấu hình cho dịch vụ, chứa các biến môi trường và các tuỳ chọn cấu hình khác cho IpTables ở IPv4
- `/etc/sysconfig/ip6tables-config`: Đây là tệp cấu hình cho dịch vụ, chứa các biến môi trường và các tuỳ chọn cấu hình khác cho IpTables ở IPv6

Chúng ta sẽ tìm hiểu cấu hình cho IPv4 trước
#### File iptables
Đây là nơi mà chúng ta sẽ thêm các rules.

Nội dung file mặc định:
```
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
```
- ***filter**: Đây là phần đầu tiên của tệp cấu hình. Nó xác định bảng mã mà các quy tắc sẽ được áp dụng. Trong trường hợp này, chúng ta sử dụng bảng `Filter` - là bảng mặc định để kiểm soát việc lọc các gói tin
- **:INPUT ACCEPT [0:0]**, **:FORWARD ACCEPT [0:0]**, **:OUTPUT ACCEPT [0:0]**: Các dòng này định nghĩa các chain trong bảng `Filter`:
  - **INPUT**: Dành cho gói tin đang vào máy chủ
  - **FORWARD**: Dành cho gói tin đang đi qua máy chủ
  - **OUTPUT**: Dành cho gói tin đang ra khỏi máy chủ
  - **[0:0]**: Là số lượng gói tin và byte đã xử lý trong mỗi chain
- `-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT`: Quy tắc này cho phép các gói tin liên quan hoặc đã thiết lập (RELATED, ESTABLISHED) đi qua chain INPUT. Các gói tin này thường là phản hồi từ các yêu cầu gửi trước đó hoặc các kết nối đã được thiết lập
- `-A INPUT -p icmp -j ACCEPT`: Quy tắc này cho phép gói tin ICMP(ping) đi qua chain INPUT
- `-A INPUT -i lo -j ACCEPT`: Quy tắc này cho phép gói tin đi qua giao diện loopback, giúp các dịch vụ local truy cập vào máy chủ
- `-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT`: Quy tắc này cho phép kết nối TCP mới đến cổng 22 đi qua chain INPUT
- `-A INPUT -j REJECT --reject-with icmp-host-prohibited`: Tất cả các gói tin không thông qua các quy tắc trên sẽ bị từ chối  và gửi lại thông báo ICMP"host-prohibited"
- `-A FORWARD -j REJECT --reject-with icmp-host-prohibited`:Tất cả các gói tin không khớp với các quy tắc trong chain FORWARD sẽ bị từ chối và gửi lại thông báo ICMP "host-prohibited"
- `COMMIT`: Kết thúc phần cấu hình cho bảng `Filter`
#### File iptables-config
File này sẽ là nơi chứa cấu hình của Iptables

Nội dung mặc định của file:
```
IPTABLES_MODULES=""

IPTABLES_SAVE_ON_STOP="no"

IPTABLES_SAVE_ON_RESTART="no"

IPTABLES_SAVE_COUNTER="no"

IPTABLES_STATUS_NUMERIC="yes"

IPTABLES_STATUS_VERBOSE="no"

IPTABLES_STATUS_LINENUMBERS="yes"
```
- **IPTABLES_MODULES**: Đây là một biến môi trường cho phép bạn chỉ định các modules IpTables bổ sung nào được tải vào sau khi các quy tắc tường lửa được áp dụng. Các modules này thường được sử dụng để hỗ trợ các tính năng đặc biệt như NAT, hay các giao thức đặc biệt như FTP, IRC,...
- **IPTABLES_SAVE_ON_STOP**: Xác định xem các quy tắc tường lửa hiện tại có được lưu lại vào tệp cấu hình khi dịch vụ dừng lại không? Nếu được đặt thành `yes`, tất cả các quy tắc sẽ được lưu vào `/etc/sysconfig/iptables` khi dịch vụ Iptables dừng
- **IPTABLES_SAVE_ON_RESTART**: Xác định xem các quy tắc tường lửa hiện tại có được lưu lại vào tệp cấu hình khi dịch vụ khởi động lại không? Nếu được đặt thành `yes`, tất cả các quy tắc sẽ được lưu vào `/etc/sysconfig/iptables` khi dịch vụ Iptables khởi động lại
- **IPTABLES_SAVE_COUNTER**: Xác định xem bộ đếm cho quy tắc và chain có được lưu lại vào tệp cấu hình không? Nếu được đặt thành `yes`, các bộ đếm sẽ được lưu vào `/etc/sysconfig/iptables` khi sử dụng lệnh `service iptables save` hoặc khi dịch vụ iptables dừng hoặc khởi động lại
- **IPTABLES_STATUS_NUMERIC**: Xác định xem các địa chỉ IP và số cổng có được in ra dưới dạng số hay không. Nếu được đặt thành `yes`, các địa chỉ IP và số cổng sẽ được in ra dưới dạng số trong các lệnh `iptables -L` hoặc `iptables-save`
- **IPTABLES_STATUS_VERBOSE**: Xác định thông tin về số lượng gói tin và byte cũng như thông tin về thiết bị input/output có được in ra trong định dạng verbose hay không. Nếu được đặt thành `yes`, thông tin chi tiết về số lượng gói tin và byte sẽ được in ra trong các lệnh `iptables -L` hoặc `iptables-save`
- **IPTABLES_STATUS_LINENUMBERS**: Xác định xem mỗi quy tắc có được in ra với số đếm riêng hay không. Nếu được đặt thành `yes`, mỗi quy tắc sẽ được in ra với số thứ tự của nó trong danh sách quy tắc trong các lệnh `iptables -L` hoặc `iptables-save`
### Thực hiện thêm rule bằng cách chỉnh sửa file cấu hình
Ta sẽ thực hiện thêm rule bằng cách chỉnh sửa file `/etc/sysconfig/iptables`

Câu lệnh hoàn chỉnh:
```
vim /etc/sysconfig/iptables
```

Để thêm một quy tắc mới:
- Ví dụ để mở Port 80 và Port 443:
- Thêm vào 2 dòng ở dưới như sau:
```
-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT

-A INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
```
![](/Anh/Screenshot_451.png)

Sau khi đã thêm quy tắc, ta thực hiện lưu file và thoát khỏi trình soạn thảo. Sau đó, thực hiện reset IpTables
```
systemctl restart iptables
```
***Lưu ý***: Chain **OUTPUT** mặc đính sẽ chấp nhận tất cả nên ta không cần set rule cho chain này. Tuy nhiên nếu như mặc định **OUTPUT** chặn tất cả các gói tin thì ta cần phải thêm rule để gói tin có thể ra được

Chúng ta có thể thực hiện kiểm tra lại bằng câu lệnh sau:
```
iptables -L
```
![](/Anh/Screenshot_452.png)

## Thêm các rule cho IpTables bằng lệnh
Câu lệnh tổng quát:
```
iptables -I <chain> -i <interface> -p <protocol(tcp/udp)> -s <source> --dport <port_number> -j <target>
```
Trong đó:
- `-I`: insert các thao tác trong lệnh vào chain chỉ định
- `-i`: xác định card mạng
- `-p`: xác định giao thức
- `-s`: xác định địa chỉ nguồn. Có thể là tên máy, hoặc địa chỉ IP
- `--dport`: xác định cổng thực hiện giao thức
- `-j`: xác định hành động. Có thể là:
  - **ACCEPT**: Cho phép đi qua
  - **DROP**: Không cho phép
  - **RETURN**: Yêu cầu trở về chain trước đó

Ví dụ: 
- Mở port 80 và port 443 cho Http và Https:
```
iptables -I INPUT -p tcp --dport 80 -j ACCEPT

iptables -I INPUT -p tcp --dport 443 -j ACCEPT
```
- Lưu lại các quy tắc vừa thêm:
```
service iptables save
```
- Khởi động lại dịch vụ:
```
systemctl restart iptables
```
- Kiểm tra lại các dịch vụ:
```
iptables -L
```
![](/Anh/Screenshot_452.png)

# Một số câu lệnh bổ sung:
- Xoá tất cả rule đã thiết lập:
```
iptables -F
```
- Xem các rule đã có:
```
iptables -L
``` 
- Xoá dòng thứ n của chain chỉ định
```
iptables -D <chain> n
```
- Mặc định nếu ta không chỉ ra table trong iptables thì nó sẽ hiểu là `Filter Tables`. Nhưng khi ta muốn sử dụng tables khác thì ta chỉ cần chỉ đích danh bảng đó ra:
```
iptables -t <tables>
``` 
- Kết hợp gọi bảng và xem các chain trong bảng, các rules:
```
iptables -t <tables> -L
```
![](/Anh/Screenshot_453.png) 

- Cài đặt cho các gói đến từ mạng `192.168.68.187/24` và thoát qua ens33 sẽ nhận được địa chỉ IP nguồn được đặt thành `11.22.33.44`
```
iptables -t nat -A POSTROUTING -o ens33 -s 192.168.68.187/24 -j SNAT --to-source 11.22.33.44
```
