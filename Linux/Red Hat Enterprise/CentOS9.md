MỤC LỤC
- [Mục này ghi ra quá trình sử dụng CentOS 9](#mục-này-ghi-ra-quá-trình-sử-dụng-centos-9)
  - [Cài đặt](#cài-đặt)
  - [Sử dụng CentOS 9](#sử-dụng-centos-9)
    - [IP Tables](#ip-tables)
      - [Cài đặt IP Tables:](#cài-đặt-ip-tables)
      - [Cấu hình IP Tables chỉ cho phép 1 IP được phép SSH vào](#cấu-hình-ip-tables-chỉ-cho-phép-1-ip-được-phép-ssh-vào)
      - [Cấu hình Ip Tables cho phép Ping](#cấu-hình-ip-tables-cho-phép-ping)
      - [Cấu hình IpTables giới hạn số lần SSH và có script hiển thị số lần SSH mỗi khi người dùng SSH vào Server](#cấu-hình-iptables-giới-hạn-số-lần-ssh-và-có-script-hiển-thị-số-lần-ssh-mỗi-khi-người-dùng-ssh-vào-server)

# Mục này ghi ra quá trình sử dụng CentOS 9
## Cài đặt
Quá trình cài đặt CentOS sẽ tương tự như so với phiên bản CentOS 7

Ở máy CentOS 9 này, để tối ưu trong quá trình sử dụng, tôi sẽ sử dụng tài khoản root để đăng nhập vào Server CentOS9 luôn

Trong quá trình sử dụng, tôi sẽ để cơ chế kết nối mạng là NAT và bật DHCP cho máy CentOS 9.

Dải mạng mà máy hiện đang sử dụng là `192.168.217.130`

## Sử dụng CentOS 9
### IP Tables
#### Cài đặt IP Tables:
- Cài đặt như các bước cài đặt IP Tables trên hệ điều hành CentOS 7
- Các câu lệnh cài đặt lần lượt như sau:
```
systemctl stop firewalld
systemctl disable firewalld
systemctl mask firewalld

yum update
yum upgrade
yum install -y iptables-services

systemctl start iptables
systemctl enable iptables
```
#### Cấu hình IP Tables chỉ cho phép 1 IP được phép SSH vào
Trước tiên, ta cần xoá hết cấu hình mặc định của iptables bằng câu lệnh sau:
```
iptables -F

service iptables save
service iptables restart
```
Sau đó chỉnh sửa lại các default chain như sau:
```
*filter
: INPUT DROP [0:0]
: FORWARD DROP [0:0]
: OUTPUT ACCEPT [0:0]
```
Lúc này, ta không còn có thể SSH được nữa do đã xoá hết các rules mặc định.

Do tôi đang sử dụng cơ chế NAT để thiết lập kết nối giữa máy ảo và máy thật qua VMW sử dụng VMnet8. Vậy nên chúng ta cần kiểm tra xem IP VMnet 8 hiện tại đang là gì hoặc chúng ta cũng có thể xem trực tiếp từ màn hình đăng nhập SSH. IP chính của máy cá nhân sẽ không cùng dải mạng với máy ảo nên việc cho phép ip này trong IpTables sẽ là vô nghĩa vì nó sẽ không thể hiểu được

![](/Anh/Screenshot_462.png)
![](/Anh/Screenshot_459.png)

Sau khi đã biết IP, chúng ta vào máy CentOS 9 và nhập câu lệnh như sau:
```
iptables -A INPUT -p tcp -s 192.168.217.1 --dport 22 -j ACCEPT

service iptables save

service iptables restart
```
Sau khi hoàn tất, để chắc chắn ta có thể kiểm tra lại bằng lệnh 
```
iptables -L
```
![](/Anh/Screenshot_461.png)

Để kiểm tra xem quá trình làm việc có thành công hay không, tôi đã test thử trên một con máy ảo Ubuntu Server, ban đầu nó không thể SSH vào được

![](/Anh/Screenshot_463.png)

Nhưng sau khi tôi cài đặt iptables cho phép IP của máy UbuntuServer thì hiện tại đã có thể SSH vào được:

![](/Anh/Screenshot_464.png)

#### Cấu hình Ip Tables cho phép Ping 
Trường hợp đề ra: Máy ảo có thể kết nối ra Internet qua máy chính, có thể SSH được nhưng khi bạn muốn test thử ping thì lại không được nữa. Lỗi này sảy ra chính là do bạn chưa cấu hình IpTables cho phép Ping. 

Sửa chữa điều này rất đơn giản. Bạn chỉ cần thêm một rules cho phép ping vào bảng rules của IpTables.

Câu lệnh sẽ như sau:
```
iptables -A INPUT -p icmp -j ACCEPT

service iptables save 
service iptables restart
```
Kiểm tra lại bằng lệnh
```
iptables -L
```
![](/Anh/Screenshot_465.png)

Kiểm tra bằng cách Ping thử

![](/Anh/Screenshot_466.png)

#### Cấu hình IpTables giới hạn số lần SSH và có script hiển thị số lần SSH mỗi khi người dùng SSH vào Server
Trước tiên, ta sẽ cần tạo một Chain mới cho việc theo dõi số lần SSH:
```
iptables -N SSH_COUNT
````

Sau khi thêm mới Chain thành công, ta thực hiện thêm các rules vào Chain:
```
iptables -A SSH_COUNT -p tcp --dport 22 -m state --state NEW -m recent --set --name SSH

iptables -A SSH_COUNT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 86400 --hitcount 5 --name SSH -j LOG --log-prefix "SSH Connection: "
```
Giải thích một chút về rules
- `-m state --state NEW`: Chỉ áp dụng cho các kết nối mới
- `-m recent --set --name SSH`: Đặt một dấu hiệu **SSH** cho kết nối mới bằng cách sử dụng module *recent*. Điều này sẽ cho phép IpTables theo dõi các kết nối mới và đếm chúng
- `-j LOG --log-prefix "SSH connection: "`: Ghi log cho mỗi gói tin mới và thêm tiền tố "SSH connection: " vào dòng log.

==> Với cấu hình này, iptables sẽ đếm số lần kết nối SSH từ một địa chỉ IP trong vòng 1 ngày và ghi log cho mỗi kết nối. Điều này giúp quản trị viên hệ thống có thể theo dõi và giám sát các kết nối SSH đến máy chủ.

Tiếp đến, chúng ta cần thêm quy tắc để kích hoạt chain **SSH_COUNT** khi có kết nối SSH đến cổng 22
```
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -j SSH_COUNT
```
Giải thích một chút:
- `-m conntrack --ctstate NEW`: Sử dụng module *conntrack* để kiểm tra trạng thái của kết nối. Trong trường hợp này, chỉ áp dụng quy tắc cho các kết nối mới
- `-j SSH_COUNT`: Khi các điều kiện được định nghĩa trước đó đúng, chuyển gói tin đến chain SSH_COUNT

Sau khi thêm các rules hoàn tất, ta cần lưu và khởi động lại IpTables:
```
service iptables save
service iptables restart
```
Tiếp đó, ta cần một script bash để hiển thị số lần đã SSH cho người truy cập
```
vim ssh_count.sh
```
```
#!/bin/bash

ssh_logs=$(grep "sshd.*Accepted" /var/log/secure)

declare -A ssh_counts

while IFS= read -r line; do
    user=$(echo "$line" | awk '{print $NF}')

    ((ssh_counts[$user]++))
done <<< "$ssh_logs"

for user in "${!ssh_counts[@]}"; do
    echo "User: $user - SSH connections: ${ssh_counts[$user]}"
done
```
Giải thích một chút:
- `ssh_logs=$(grep "sshd.*Accepted" /var/log/secure)`:
  - Dòng này sử dụng lệnh grep để tìm kiếm các dòng trong file /var/log/secure chứa cụm từ "sshd" và "Accepted". Điều này phù hợp với các dòng log cho biết việc đăng nhập SSH đã được chấp nhận
  - Kết quả được lưu vào biến `ssh_logs`
- `declare -A ssh_counts`: Dòng này khai báo một mảng kết hợp có tên `ssh_counts`
- ```
    while IFS= read -r line; do
        user=$(echo "$line" | awk '{print $NF}')
        ((ssh_counts[$user]++))
    done <<< "$ssh_logs"
    ```
    - Vòng lặp này đọc từng dòng trong biến ssh_logs, mỗi dòng đại diện cho một kết nối SSH đã được chấp nhận.
    - Lệnh awk '{print $NF}' được sử dụng để lấy tên người dùng cuối cùng trong mỗi dòng, tức là người dùng đã thực hiện đăng nhập.
    - Sau đó, số lần kết nối của mỗi người dùng được tăng lên trong mảng ssh_counts.
- ```
    for user in "${!ssh_counts[@]}"; do
        echo "User: $user - SSH connections: ${ssh_counts[$user]}"
    done
    ```
    - Vòng lặp này đi qua mỗi cặp key-value trong mảng `ssh_counts`
    - Mỗi lần lặp, nó in ra thông tin về người dùng và số lần kết nối SSH của họ đã được ghi lại.
```
#Cấp quyền thực thi:
sudo chmod +x ssh_count.sh
```

Thêm dòng sau vào tệp cấu hình `~/.bashrc`
```
/home/ssh_count.sh

```

