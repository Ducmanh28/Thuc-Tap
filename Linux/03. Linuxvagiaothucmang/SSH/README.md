# Cài đặt và sử dụng **Permissions_SSH**
## Yêu cầu hệ thống
Có thể sử dụng trên các hệ thống Linux hoặc Unix như Ubuntu và CentOS đều được

Một máy Linux cơ bản là có thể sử dụng Scripts này

## Hướng dẫn cài đặt và sử dụng
### Hướng dẫn tải xuống
Chạy lệnh sau ở terminal của bạn, FILE được tải xuống sẽ nằm trong thư mục hiện tại bạn đan ở và có thể được kiểm tra bằng lệnh `pwd`
```
# Sử dụng curl để tải xuống
curl -O https://raw.githubusercontent.com/Ducmanh28/Thuc-Tap/main/Linux/03.%20Linuxvagiaothucmang/SSH/permissions_ssh.sh
# Sử dụng wget
wget https://raw.githubusercontent.com/Ducmanh28/Thuc-Tap/main/Linux/03.%20Linuxvagiaothucmang/SSH/permissions_ssh.sh
```

### Hướng dẫn sử dụng
Trước tiên bạn cần cấp quyền cho file có thể chạy
```
chmod +x permission_ssh.sh
```
Trước khi chạy file: Bạn cần có sẵn User, nếu chưa có, bạn có thể thao khảo cách tạo User tại [đây](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/SSH/SSH.md)

Chạy file với câu lệnh sau:
```
./permissions_ssh.sh
```
### Ví dụ
Ví dụ mẫu 1:
```
root@MANH-U22-Server:/home/suncloud/ducmanh# ./permissions_ssh.sh
This script is used to add SSH login permits for users and allow root SSH login for your server.
To run this script, you will need root permissions. This script also creates a backup file for your sshd_config.
Confirm to proceed (yes/no): yes
Checking root permissions of current user!
Root permissions check complete!
Checking Backup file!
Backup file check completed.
Username: user3
Checking sudo privileges of user3
user3 does not have sudo privileges.
Adding sudo privileges for user3...
Adding user `user3' to group `sudo' ...
Adding user user3 to group sudo
Done.
Successfully added sudo privileges for user3.
Checking SSH permissions for user3
user3 does not have SSH access.
Adding SSH access for user3...
Editing SSH configuration to grant SSH access for user user3...
Restarting SSH service...
Do you want to allow Root Login: yes
Checking Root Login Permissions
Root login permitted.
Successfully granted SSH access for user3.
```
Ví dụ mẫu 2
```
root@MANH-U22-Server:/home/suncloud/ducmanh# ./permissions_ssh.sh
This script is used to add SSH login permits for users and allow root SSH login for your server.
To run this script, you will need root permissions. This script also creates a backup file for your sshd_config.
Confirm to proceed (yes/no): yes
Checking root permissions of current user!
Checking root permissions complete!
Checking Backup file!
Backup file check completed.
Username: user3
Checking sudo privileges of user3
user3 already has sudo privileges.
Checking SSH permissions for user3
user3 does not have SSH access.
Adding SSH access for user3...
Editing SSH configuration to grant SSH access for user user3...
Restarting SSH service...
Do you want to allow Root Login: no
Checking Root Login Permissions
Disenableing root login...
Complete disallow Root Login Permissions. Restarting SSH...
Successfully granted SSH access for user3.
```