# Hướng dẫn sử dụng Scripts tự động cài đặt NETBOX
MỤC LỤC
- [Hướng dẫn sử dụng Scripts tự động cài đặt NETBOX](#hướng-dẫn-sử-dụng-scripts-tự-động-cài-đặt-netbox)
  - [Trước khi cài đặt](#trước-khi-cài-đặt)
  - [Yêu cầu cần có trước khi sử dụng](#yêu-cầu-cần-có-trước-khi-sử-dụng)
  - [Hướng dẫn sử dụng](#hướng-dẫn-sử-dụng)
    - [Trước khi khởi chạy](#trước-khi-khởi-chạy)
      - [Tải xuống](#tải-xuống)
      - [Cấp quyền](#cấp-quyền)
    - [Khởi chạy](#khởi-chạy)
      - [Câu lệnh khởi chạy](#câu-lệnh-khởi-chạy)
      - [Thông báo khi khởi chạy](#thông-báo-khi-khởi-chạy)
      - [Quá trình chạy](#quá-trình-chạy)
        - [PostgreSQL Server](#postgresql-server)
        - [Redis](#redis)
        - [Python](#python)
        - [Netbox](#netbox)
        - [Nginx](#nginx)
      - [Quá trình kết thúc](#quá-trình-kết-thúc)
  - [Thông tin thêm](#thông-tin-thêm)

## Trước khi cài đặt
Scripts sử dụng các câu lệnh và cấu hình cơ bản để giúp các bạn chưa nắm rõ quy trình cài đặt NetBox hoặc muốn tiết kiệm thời gian cho việc cài đặt thủ công NETBOX có thể cài đặt NETBOX một cách tự động hóa. Tuy nhiên trong quá trình cài đặt sẽ có các đề mục yêu cầu nhập vào các thông tin cấu hình cho NETBOX.

Các đề mục được yêu cầu nhập sẽ được hướng dẫn cụ thể ở mục [Hướng dẫn sử dụng](#hướng-dẫn-sử-dụng)

## Yêu cầu cần có trước khi sử dụng
Thiết bị:
- Hiện tại, scripts chỉ hỗ trợ cho hệ điều hành Ubuntu. Centos sẽ được hỗ trợ sớm nhất có thể.
- Vẫn còn một số hàm chưa được tối ưu cho việc sử dụng nhiều lần trên cùng 1 thiết bị. Vậy nên để đảm bảo việc khởi chạy scripts một cách tốt nhất, các bạn nên chạy scripts trên một thiết bị chưa có bất kì cài đặt hoặc cấu hình nào cho NETBOX. Tôi sẽ cố gắng fix nó nhanh nhất có thể trong tương lai =))

Quyền:
- Scripts sẽ yêu cầu quyền root(sudo) để có thể khởi chạy. Bởi vì một số cấu hình hay đơn giản nhất là câu lệnh cài đặt ứng dụng cũng đã yêu cầu quyền sudo rồi. Vậy nên để không gặp lỗi trong quá trình cài đặt, các bạn sẽ cần quyền root để chạy
- Bạn cần cấp quyền chạy cho scripts bằng câu lệnh `chmod` sẽ được hướng dẫn ở dưới

Qúa trình chạy:
- Trong quá trình chạy, bạn cần theo dõi xem scripts chạy đến đâu và yêu cầu nhập vào những gì. Vui lòng nhập các thông tin cần thiết để scripts chạy tốt nhất có thể.
- Sẽ có thông báo trước khi khởi chạy và thông báo sử dụng chứng chỉ ssl để sử dụng. Nếu đã có chứng chỉ SSL, bạn có thể sẽ không cần chạy SSLconfig mà chỉ cần chạy phiên bản thường, sau đó hãy chỉnh sửa lại file `/etc/nginx/site-available/netbox.conf` 
- Các mục trong dấu `[]` sẽ là giá trị mặc định được điền nếu bạn không nhập gì

## Hướng dẫn sử dụng
Hướng dẫn tải xuống và sử dụng scripts `auto_install_netbox.sh`
### Trước khi khởi chạy
#### Tải xuống
Bạn có thể tải xuống bản Raw của file bằng Windows, sau đó sử dụng SFTP và đưa file vào máy chủ Ubuntu của mình

Hoặc bạn cũng có thể truy cập và tải xuống trực tiếp xuống máy chủ thông qua câu lệnh sau. File được tải xuống sẽ nằm trong thư mục hiện tại mà bạn đang ở:
```
# Sử dụng wget
wget https://raw.githubusercontent.com/Ducmanh28/Thuc-Tap/main/Linux/03.%20Linuxvagiaothucmang/NetBox/Install/auto_install_netbox.sh

# Sử dụng curl
curl -O https://raw.githubusercontent.com/Ducmanh28/Thuc-Tap/main/Linux/03.%20Linuxvagiaothucmang/NetBox/Install/auto_install_netbox.sh
```
#### Cấp quyền 
Để có thể chạy được bất kì một scripts nào, trước tiên bạn cũng đều cần phải cấp quyền khởi chạy cho scripts. Bạn sử dụng câu lệnh sau:
```
chmod +x /đường dẫn tới file scripts/auto_install_netbox.sh
```
### Khởi chạy
#### Câu lệnh khởi chạy
Để khởi chạy tiện nhất, vui lòng truy cập vào nơi chứa file scripts và khởi chạy như sau:
```
./auto_install_netbox.sh
```

#### Thông báo khi khởi chạy
Bạn sẽ nhận được một thông báo chỉ ra các công việc mà Scripts sẽ làm, cũng như các yêu cầu mà scripts cần có để khởi chạy. Nếu xác nhận cài đặt, các bạn chọn **yes**, nếu không các bạn chọn **no**
```
This Scripts is used to install NetBox and all the things need to run NetBox! To run this Scripts, you will need root permission.
You can access root permission by entering 'sudo su' and input your sudo password!
Before running this Scripts, please read README at: https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/README.md
Confirm to proceed (yes/no): # Nhập 'yes' hoặc 'no'
```
#### Quá trình chạy
Ban đầu, sẽ là các mục kiểm tra hệ điều hành và kiểm tra quyền root của bạn. Nếu các mục kiểm tra này không nhận được kết quả tốt, chương trình sẽ dừng lại

Sau khi chọn "yes", quá trình cài đặt sẽ bắt đầu. Trước tiên sẽ là cài đặt PostgreSQL Server
##### PostgreSQL Server
Quá trình cài đặt PostgreSQL Server sẽ diễn ra trong vài giây. Nếu cài đặt thành công, bạn sẽ nhận được thông báo. Cùng lúc đó, bạn cũng sẽ nhận được yêu cầu nhập vào một số thông tin để cấu hình PostgreSQL Server như sau:
```
PostgreSQL has been successfully installed!
Enter the PostgreSQL database name [netbox_db]: # Tên database
Enter the PostgreSQL username [netbox_user]: # Tên user
Enter the PostgreSQL password [netbox_pass]: # Mật khẩu
Starting create Database, user and grant permission
```
Nếu như quá trình này thành công, bạn sẽ nhận được thông báo như sau: 
```
CREATE DATABASE
CREATE ROLE
ALTER DATABASE
GRANT
Database, user, and permission have been successfully created and granted.
```
##### Redis
Phần cài đặt Redis rất đơn giản. Ở mục này, bạn không cần nhập vào gì. Đầu ra khi bắt đầu cài đặt và khi kết thúc cài đặt sẽ trông như sau:
```
# Kiểm tra Redis
Redis is not installed. Installing Redis...

# Khi cài đặt thành công 
Redis has been successfully installed.
```
Khi việc cài đặt bị lỗi thì bạn sẽ nhận được thông báo lỗi, ứng dụng sẽ dừng ngay lập tức để tránh việc cài đặt và cấu hình NetBox bị lỗi

##### Python
Tương tự như Redis. Việc cài đặt Python cũng rất đơn giản. Đầu ra mặc định của quá trình này sẽ trông như sau:
```
# Bắt đầu cài đặt
Installing Python....

# Khi cài đặt thành công
Python3 has been successfully installed.
```
##### Netbox
Khi Python đã được cài đặt thành công, chúng ta sẽ chuyển sang tải xuống NetBox. Bạn sẽ nhận được yêu cầu chọn phiên bản để tải xuống NetBox và yêu cầu nhập vào tên nhóm của NetBox như sau:
```
Enter the NetBox version [4.0.5]: # Nhập vào phiên bản. Ví dụ: 3.7.8
Enter the group name for NetBox [netbox]: # Nhập vào tên group
Downloading Netbox...
```
Nếu quá trình giải nén thành công, bạn sẽ nhận được thông báo như sau:
```
Extracting Netbox...
Creating Symbolic link...
Add user and create group
Adding system user `netbox' (UID 119) ...
Adding new group `netbox' (GID 124) ...
Adding new user `netbox' (UID 119) with group `netbox' ...
Creating home directory `/home/netbox' ...
Change Owner of netbox to netbox
Netbox version 3.7.8 has been successfully installed.
```

Tiếp đến là phần cấu hình NetBox để có thể cài đặt. Bạn sẽ nhận được yêu cầu nhập vào 1 số thông tin như sau:
```
Enter the DNS for NetBox configuration [localhost]: # Nhập tên miền netbox
Enter the IP for NetBox configuration [127.0.0.1]: # Nhập địa chỉ IP netbox
Enter the PostgreSQL username for NetBox configuration [netbox_user]: # Nhập là user PostgreSQL
Enter the PostgreSQL password for NetBox configuration [netbox_pass]: # Nhập lại mật khẩu PostgreSQL
```
Sau khi hoàn tất sẽ là quá trình tạo `Secret_key` và chỉnh sửa cấu hình file `configuration.py` để kết nối và cài đặt netbox. Nếu thành công, bạn sẽ nhận được thông báo sau:
```
Apply all migrations: account, admin, auth, circuits, contenttypes, core, dcim, django_rq, extras, ipam, sessions, social_django, taggit, tenancy, users, virtualization, vpn, wireless
```
Sau đó, quá trình kiểm tra và cài đặt sẽ bắt đầu. Đầu ra cho việc cài đặt thành công sẽ là như sau:
```
Upgrade complete! Don't forget to restart the NetBox services:
  > sudo systemctl restart netbox netbox-rq
NetBox has been successfully installed on your system!
Install Completed. Now you need to create superuser
```
Tiếp đến là quá trình tạo superuser. Bạn sẽ được yêu cầu nhập vào một số thông tin như sau:
```
Enter the NetBox superuser username [admin]: # Tên superuser
Enter the NetBox superuser password [admin_pass]: # Mật khẩu
Enter the NetBox superuser email [admin@example.com]: # Email
```
Nếu quá trình này hoàn tất, các bạn sẽ nhận được thông báo như sau:
```
Access Virtual Enviroment...
Create SuperUser
Superuser created successfully.
```
Khi mọi quá trình hoàn tất thành công, bạn sẽ nhận được đầu ra như sau:
```
NetBox configuration and startup completed successfully!.
```
##### Nginx
Trước khi cài đặt Nginx, sẽ có quá trình kiểm tra sự tồn tại của Apache2. Nếu có thì sẽ thực hiện tắt và disable nó.

Sau đó, quá trình cài đặt Nginx sẽ diễn ra tự động mà không yêu cầu bạn nhập vào gì. Dưới đây là mẫu đầu ra:
```
# Tắt apache2
Found Apache2 on your Server. Turning off....

# Bắt đầu cài đặt nginx
Nginx is not installed. Installing Nginx...

# Cài đặt thành công
Nginx has been successfully installed.
```
Sau khi cài đặt thành công, chúng ta chuyển qua giai đoạn cấu hình nginx. Quá trình này sẽ yêu cầu nhập vào một số thông tin như mẫu dưới:
```
Enter the Nginx hosts for NetBox configuration [localhost]: # Nhập lại domain netbox
Enter the Nginx IP for NetBox configuration [127.0.0.1]: # Nhập lại địa chỉ IP netbox
Do you want to use SSL?[yes/no]: # Chọn 'yes' để cấu hình SSL, 'no' để cấu hình mà không có SSL
```
Nếu bạn chọn yes, sẽ có một số thông tin cần nhập vào như sau:
```
Country Name[VN]: # Nhập vào tên nước
State or Province Name: # Tên tỉnh
Locality Name: # Tên thành phố
Organization Name: # Tên tổ chức
Organizational Unit Name: # Tên công ty
Email Address[netbox@example.com]: # Email
```
Nếu quá trình tạo thành công, sẽ có thông báo sau: 
```
Certificate request self-signature ok
subject=C = VN, ST = HANOI, L = HANOI, O = Suncloud, OU = Viettelco, CN = netbox.example.com
Completed!SSL has been created!
```
Kể cả khi bạn chọn ***yes*** hay ***no*** đối với chứng chỉ SSL. Kết quả khi cấu hình nginx thành công cũng đều sẽ là:
```
Editing main config file of Nginx
Creat Virtual Host of Nginx and making it to Reverse Proxy
Enable new config...
Restarting Nginx
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
Nginx configuration test successful. Reloading Nginx...
Synchronizing state of nginx.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable nginx
```
#### Quá trình kết thúc
Khởi điểm của quá trình này sẽ là việc cấu hình mở tường lửa và hiển thị tổng thời gian chạy. Kết quả mẫu trông như sau:
```
Allowing port in UFW....
Rule added
Rule added (v6)
Skipping adding existing rule
Skipping adding existing rule (v6)
Rule added
Rule added (v6)
Rule added
Rule added (v6)
Complete allow Port
Finished in: 0 hours, 29 minutes and 37 seconds
NetBox installation and configuration complete!
```
Vậy là bạn đã hoàn tất cài đặt Nginx trên hệ thống Ubuntu của mình.
## Thông tin thêm
Trước khi bạn có thể truy cập vào trang chủ netbox thông qua tên miền đã cấu hình, bạn cần cấu hình DNS trả về ip khi nhập vào tên miền của Netbox trên máy truy cập. Ví dụ đối với windows, các bạn thực hiện chỉnh sửa file `hosts` ở đường dẫn sau: `C:\Windows\System32\drivers\etc\hosts`

Thêm vào nội dung sau:
```
<IP của máy chủ NetBox> <tên miền>
# ví dụ
# 172.16.66.81 netbox.example.com
```
Sau khi hoàn tất, bạn có thể truy cập vào trang chủ netbox trên một ứng dụng duyệt web nào đó khi nhập vào ô tìm kiếm tên miền hoặc ip netbox mà bạn đã cấu tạo. Để tối ưu kết quả hiển thị, bạn nên truy cập bằng Trang Web riêng tư.

![](/Anh/Screenshot_719.png)

![](/Anh/Screenshot_720.png)

![](/Anh/Screenshot_721.png)

![](/Anh/Screenshot_722.png)

Để biến trang web trở nên secure với local ssl, các bạn thực hiện như sau:
- Tải xuống file có tên `CA.pem` nằm ở trong `/etc/ssl/certs`
- Mở trình duyệt, vào mục **Settings** và tìm kiếm mục **Certificate**.
- Sau đó, các bạn cấu hình như sau: 

![](/Anh/Screenshot_726.png)

![](/Anh/Screenshot_727.png)

- Cuối cùng, kết quả hiển thị như sau:

![](/Anh/Screenshot_730.png)





