# Cấu hình IpTables theo các ví dụ ở Server World
## Ví dụ 1:
Mô hình hoạt động: 

![](/Anh/Screenshot_469.png)

- Máy Laptop sẽ kết nối tới Server thông qua cơ chế NAT của VMW NAT từ IP 192.168.68.58 sang IP 192.168.217.1 cho cùng dải mạng với Server.
- Khi Server đã kết nối được với Laptop, nó sẽ truy cập ra Internet thông qua Laptop

Yêu cầu thực hiện:
- DROP tất cả Input theo mặc định
- ACCEPT tất cả Output theo mặc định
- Chấp nhận các kết nối đã thiết lập
- Chấp nhận các kết nối Loopback
- Ping 5 lần/phút từ dải `192.168.217.0/24`
- Chấp nhận các kết nối SSH từ dải `192.168.217.0/24`

Thực hành:
- Thực hiện chỉnh sửa các Default Chain ở trong file cấu hình IpTables: `/etc/sysconfig/iptables`
```
vim /etc/sysconfig/iptables
```
- Thực hiện chỉnh sửa với nội dung như sau:
```
*filter
:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [0:0]
COMMIT
```
- Sau đó Save file và thoát. Cuối cùng, khởi động lại Iptables
```
systemctl restart iptables
```
- Hoặc cũng có thể sử dụng trực tiếp các lệnh sau mà không cần chỉnh sửa file cấu hình:
```
# Lệnh này để xóa toàn bộ cấu hình trước đó đã cài. Nếu bạn đang SSH, bạn sẽ bị văng khỏi kết nối
iptables -F

# Lệnh này xóa tất cả các chain mà bạn đã tạo(trong Filter Tables)
iptables -X

# Các lệnh để thay đổi default chain(trong Filter Tables)
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

# Thực hiện lưu và khởi động lại Iptables
service iptables save
service iptables restart
```
- Thực hiện các yêu cầu bằng cách sử dụng lệnh:
```
# Chấp nhận các kết nối đã thiết lập:
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Chấp nhận các kết nối Loopback
iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT

# Cho phép ping 5 lần/phút từ dải 192.168.217.0/24
iptables -A INPUT -p icmp --icmp-type echo-request -s 192.168.217.0/24 -d 192.168.217.132 -m limit --limit 1/m --limit-burst 5 -j ACCEPT

# Cho phép các kết nối SSH từ dải 192.168.217.0/24
iptables -A INPUT -p tcp -m state --state NEW -m tcp -s 192.168.217.0/24 -d 192.168.217.132 --dport 22 -j ACCEPT

# Thực hiện lưu và reset Iptables
service iptables save
service iptables restart
```
- Kiểm tra lại kết quả:
```
iptables -L
```
![](/Anh/Screenshot_470.png)

- Hoặc các bạn cũng có thể viết 1 file scripts và khởi chạy như sau:
```
# Lệnh tạo file
vim /home/iptables1.sh

# Nội dung file
#!/bin/bash

trust_host='192.168.217.0/24'
my_host='192.168.217.132'

/sbin/iptables -F
/sbin/iptables -X

/sbin/iptables -P INPUT DROP
/sbin/iptables -P OUTPUT ACCEPT
/sbin/iptables -P FORWARD DROP

/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

/sbin/iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT

/sbin/iptables -A INPUT -p icmp --icmp-type echo-request -s $trust_host \
-d $my_host -m limit --limit 1/m --limit-burst 5 -j ACCEPT

/sbin/iptables -A INPUT -p tcp -m state --state NEW -m tcp -s $trust_host \
-d $my_host --dport 22 -j ACCEPT

/etc/rc.d/init.d/iptables save
/etc/rc.d/init.d/iptables restart

# Lệnh khởi chạy
sh iptables1.sh
```
## Ví dụ 2:
Mô hình thực hiện:

![](/Anh/Screenshot_472.png)

- Laptop sẽ kết nối tới mạng **LAN 1** đi ra Router và Internet
- Server sẽ có 2 card mạng là eth1 và eth2
  - eth1 sẽ kết nối với **LAN 1** và kết nối được với Laptop thông qua **LAN 1**. Tương tự đi ra Internet
  - eth2 sẽ kết nối với mạng nội bộ **LAN 2** 
- Để quá trình thực hành dễ dàng nhìn thấy kết quả hơn, tôi có thêm 1 máy VM1: `192.168.217.128` kết nối với Server thông qua **LAN 2**
- Mô hình mới sẽ trông như sau

![](/Anh/Screenshot_473.png)

Yêu cầu thực hiện:
- DROP INPUT theo mặc định
- CHẤP NHẬN OUTPUT theo mặc định
- DROP FORWARD theo mặc định
- CHẤP NHẬN kết nối đã được thiết lập
- CHẤP NHẬN kết nối từ loopback
- CHẤP NHẬN kết nối Ping cho 5 lần mỗi phút từ mạng nội bộ **LAN 2** (192.168.217.0/24)
- CHẤP NHẬN kết nối SSH từ **LAN 2**(192.168.217.0/24)
- CHẤP NHẬN các gói tin gửi đi thông qua máy chủ từ mạng nội bộ **LAN 2** (192.168.217.0/24) và dịch địa chỉ nguồn
Thực hành:
- Đối với các yêu cầu như sau, chúng ta thực hiện tương tự **Ví dụ 1** hoặc bạn có thể dùng trực tiếp Scripts được viết bên dưới
  - DROP INPUT theo mặc định
  - CHẤP NHẬN OUTPUT theo mặc định
  - DROP FORWARD theo mặc định
  - CHẤP NHẬN kết nối đã được thiết lập
  - CHẤP NHẬN kết nối từ loopback 
  - CHẤP NHẬN kết nối Ping cho 5 lần mỗi phút từ mạng nội bộ **LAN 2** (192.168.217.0/24)
  - CHẤP NHẬN kết nối SSH từ **LAN 2**(192.168.217.0/24)
- Sử dụng Scripts bên dưới:
```
# Lệnh tạo file
vim /home/iptables2.sh

# Nội dung file
#!/bin/bash

trust_host='192.168.217.0/24'
my_host='192.168.217.132'

/sbin/iptables -F
/sbin/iptables -X

/sbin/iptables -P INPUT DROP
/sbin/iptables -P OUTPUT ACCEPT
/sbin/iptables -P FORWARD DROP

/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

/sbin/iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT

/sbin/iptables -A INPUT -p icmp --icmp-type echo-request -s $trust_host \
-d $my_host -m limit --limit 1/m --limit-burst 5 -j ACCEPT

/sbin/iptables -A INPUT -p tcp -m state --state NEW -m tcp -s $trust_host \
-d $my_host --dport 22 -j ACCEPT

/etc/rc.d/init.d/iptables save
/etc/rc.d/init.d/iptables restart

# Lệnh khởi chạy
sh iptables2.sh
```
- Đối với yêu cầu: "CHẤP NHẬN các gói tin gửi đi thông qua máy chủ từ mạng nội bộ **LAN 2** (192.168.217.0/24) và dịch địa chỉ nguồn", ta thực hành như sau:
```
iptables -t nat -A POSTROUTING -o eth0 -s $trust_host -j MASQUERADE
```
- Giải mã câu lệnh:
  - `-t nat`: Tham số `-t` được sử dụng để chỉ định bảng mà quy tắc sẽ áp dụng. Trong trường hợp này, chúng ta đang làm việc với bảng NAT - nơi mà các quy tắc cho việc chuyển tiếp gói tin sẽ được quản lý
   - `-A POSTROUTING`: Tham số `-A` được sử dụng để thêm một quy tắc vào cuối của một chuỗi. Trong trường hợp này, chúng ta đang thêm một quy tắc vào chuỗi **POSTROUTING**, điều này có nghĩa là quy tắc sẽ được áp dụng cho các gói tin ra khỏi hệ thống sau khi đã được xử lý bởi bảng **filter** và **mangle**
   - `-o eth0`: Tham số `-o` được sử dụng để chỉ định giao diện mạng đích cho gói tin. Trong trường hợp này, chúng ta chỉ định rằng quy tắc này sẽ áp dụng cho gói tin ra khỏi giao diện mạng **eth0**
   - `-j MASQUERADE`: Tham số `-j` được sử dụng để chỉ định hành động sẽ được thực hiện nếu một gói tin phù hợp với quy tắc. Trong trường hợp này, chúng ta sử dụng **MASQUERADE**, điều này có nghĩa là địa chỉ nguồn của gói tin sẽ được thay đổi thành địa chỉ IP của giao diện mạng mà gói tin ra khỏi hệ thống. Điều này thường được sử dụng trong trường hợp NAT, nơi mà địa chỉ IP của các máy tính trong mạng nội bộ được "ẩn" đằng sau một địa chỉ IP công cộng khi giao tiếp ra ngoài mạng internet.
- Kiểm tra lại kết quả thực hành:
```
iptables -L

iptables -t nat -L
```
![](/ANH/Screenshot_474.png)

