# Mục này cấu hình SSH trên Ubuntu 22
Cấu hình SSH Server để quản lý máy chủ từ xa thông qua Port 22
## OpenSSH: Xác thực mật khẩu
### SSH Server
Xác thực mật khẩu cho máy chủ OpenSSH trên Ubuntu được bật theo mặc định. Vì vậy, bạn có thể đăng nhập mà không cần thay đổi bất kỳ cài đặt nào. DefaultSetting là tốt để sử dụng, tuy nhiên nếu bạn muốn chặn quyền truy cập root, thay đổi như sau:
```
root@ubuntusv:/home/ducmanh287# apt install -y openssh-server
root@ubuntusv:/home/ducmanh287# vim /etc/ssh/sshd_config

# Chỉnh sửa dòng 33 như sau:
PermitRootLogin no

# Khởi động lại SSH:
root@ubuntusv:/home/ducmanh287# systemctl restart ssh
```
### SSH Client
#### SSH Client: Ubuntu
Cài đặt:
```
root@ubuntusv:/home/ducmanh287# apt install -y openssh-client
```
Kết nối tới SSH Server
```
root@ubuntusv:/home/ducmanh287# ssh root@192.168.217.132
The authenticity of host '192.168.217.132 (192.168.217.132)' can't be established.
ED25519 key fingerprint is SHA256:ZSliUPU881QPQ6ncLCSrCNISSBiDP8pd80BYJRuIldc.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.217.132' (ED25519) to the list of known hosts.
root@192.168.217.132's password:
Activate the web console with: systemctl enable --now cockpit.socket

Last login: Fri Mar 15 15:10:41 2024
[root@localhost ~]#
```
#### SSH Client: Windows
Có thể sử dụng các phần mềm như Putty, MobaXterm,... Bài thực hành ở đây sẽ sử dụng phần mềm MobaXterm
- Màn hình làm việc chính của MobaXterm:
- ![](/Anh/Screenshot_492.png)
- Có thể đăng nhập trực tiếp từ terminal của MobaXterm như sau
- ![](/Anh/Screenshot_493.png)
- Hoặc cũng có thể chọn cách tạo mới 1 Session:
- ![](/Anh/Screenshot_494.png)

Hoặc cũng có thể thao tác trực tiếp từ WindowsPowerShell

![](/Anh/Screenshot_495.png)

## SSH File Transfer
### Ubuntu
Trên Ubuntu, chúng ta có thể truyền tệp tin với SSH
- Sử dụng SCP(Secure Copy)
```
# Kiểm tra đường dẫn và tạo file test.txt
ducmanh287@ubuntusv:~$ pwd
/home/ducmanh287
ducmanh287@ubuntusv:~$ touch test.txt

# Thực hiển chuyển file từ UbuntuServer sang 192.168.217.132
ducmanh287@ubuntusv:~$ scp ./test.txt root@192.168.217.132:~/
The authenticity of host '192.168.217.132 (192.168.217.132)' can't be established.
ED25519 key fingerprint is SHA256:ZSliUPU881QPQ6ncLCSrCNISSBiDP8pd80BYJRuIldc.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.217.132' (ED25519) to the list of known hosts.
root@192.168.217.132's password:
test.txt                    100%    0     0.0KB/s   00:00

# Thực hiển chuyển file từ 192.168.217.132 sang UbuntuServer
# Kiểm tra số file ban đầu
ducmanh287@ubuntusv:~$ ll

total 36
drwxr-x--- 4 ducmanh287 ducmanh287 4096 Mar 15 08:39 ./
drwxr-xr-x 3 root       root       4096 Mar 15 06:56 ../
-rw------- 1 ducmanh287 ducmanh287  188 Mar 15 08:26 .bash_history
-rw-r--r-- 1 ducmanh287 ducmanh287  220 Jan  6  2022 .bash_logout
-rw-r--r-- 1 ducmanh287 ducmanh287 3771 Jan  6  2022 .bashrc
drwx------ 2 ducmanh287 ducmanh287 4096 Mar 15 06:56 .cache/
-rw-r--r-- 1 ducmanh287 ducmanh287  807 Jan  6  2022 .profile
drwx------ 2 ducmanh287 ducmanh287 4096 Mar 15 08:34 .ssh/
-rw-r--r-- 1 ducmanh287 ducmanh287    0 Mar 15 06:57 .sudo_as_admin_successful
-rw------- 1 ducmanh287 ducmanh287   54 Mar 15 08:21 .Xauthority

# Thực hiện truyền
ducmanh287@ubuntusv:~$ scp root@192.168.217.132:/home/ducmanh287/test.txt ./test.txt
root@192.168.217.132's password:
test.txt                        100%    0     0.0KB/s   00:00

# Kiểm tra lại sau khi truyền

ducmanh287@ubuntusv:~$ ll

total 36
drwxr-x--- 4 ducmanh287 ducmanh287 4096 Mar 15 08:40 ./
drwxr-xr-x 3 root       root       4096 Mar 15 06:56 ../
-rw------- 1 ducmanh287 ducmanh287  188 Mar 15 08:26 .bash_history
-rw-r--r-- 1 ducmanh287 ducmanh287  220 Jan  6  2022 .bash_logout
-rw-r--r-- 1 ducmanh287 ducmanh287 3771 Jan  6  2022 .bashrc
drwx------ 2 ducmanh287 ducmanh287 4096 Mar 15 06:56 .cache/
-rw-r--r-- 1 ducmanh287 ducmanh287  807 Jan  6  2022 .profile
drwx------ 2 ducmanh287 ducmanh287 4096 Mar 15 08:34 .ssh/
-rw-r--r-- 1 ducmanh287 ducmanh287    0 Mar 15 06:57 .sudo_as_admin_successful
-rw-r--r-- 1 ducmanh287 ducmanh287    0 Mar 15 08:40 test.txt
-rw------- 1 ducmanh287 ducmanh287   54 Mar 15 08:21 .Xauthority
# Như đã thấy, ban đầu không hề có file test.txt và sau khi truyền tải xong thì đã có file
```
- Sử dụng SFTP(SSH File Transfer Protocol). SFTP đã được cài và bật mặc định. Tuy nhiên, bạn cũng có thể bật thủ công
```
systemctl start sftp
systemctl enable sftp 
```
- Sử dụng sftp
```
# Đăng nhập vào 192.168.217.132
ducmanh287@ubuntusv:~$ sftp root@192.168.217.132
root@192.168.217.132's password:
Connected to 192.168.217.132.
sftp> 

# Kiểm tra đường dẫn hiện tại ở 192.168.132
sftp> pwd
Remote working directory: /root

# Kiểm tra đường dẫn hiện tại ở UbuntuSV
sftp> !pwd
/home/ducmanh287

# Hiển thị các file ở thư mục trên FTP Server
sftp> ls -l
-rw-------    1 root     root          886 Mar  1 15:53 anaconda-ks.cfg
-rw-r--r--    1 root     root            0 Mar 15 15:34 test.txt

# Hiển thị các file ở thư mục trên UbuntuSV
sftp> !ls -l
total 0
-rw-r--r-- 1 ducmanh287 ducmanh287 0 Mar 15 08:40 test.txt

# upload file đến 192.168.217.132
sftp> put test.txt ubuntu.txt
Uploading test.txt to /root/ubuntu.txt
test.txt                        100%    0     0.0KB/s   00:00
sftp> ls -l
-rw-------    1 root     root          886 Mar  1 15:53 anaconda-ks.cfg
-rw-r--r--    1 root     root            0 Mar 15 15:34 test.txt
-rw-r--r--    1 root     root            0 Mar 15 16:41 ubuntu.txt

# download file từ remote server
sftp> get ubuntu.txt
Fetching /root/ubuntu.txt to ubuntu.txt
sftp> get test.txt
Fetching /root/test.txt to test.txt
sftp> get *.txt
Fetching /root/test.txt to test.txt
Fetching /root/ubuntu.txt to ubuntu.txt

# exit
sftp> quit
```
### Windows
Bạn cũng có thể sử dụng MobaXterm hoặc Putty để sử dụng SFTP giữa Windows và UbuntuServer

![](/Anh/Screenshot_496.png)

## SSH xác thực Key-Pair
Cấu hình máy chủ SSH để đăng nhập bằng Xác thực cặp khóa.
Tạo một khóa riêng cho máy khách và một khóa công khai để máy chủ thực hiện.
- Tạo Key-Pair theo từng người dùng, vì vậy hãy đăng nhập với một người dùng thông thường trên SSH Server Host và hoạt động như sau.
```
ducmanh287@ubuntusv:~$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/ducmanh287/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/ducmanh287/.ssh/id_rsa
Your public key has been saved in /home/ducmanh287/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:H9fLOk6/71G+WGujssj82Vg1szS7A4nh3VU5IdrpOSI ducmanh287@ubuntusv
The key's randomart image is:
...
...
ducmanh287@ubuntusv:~$ cd .ssh/
ducmanh287@ubuntusv:~/.ssh$ ll
total 24
drwx------ 2 ducmanh287 ducmanh287 4096 Mar 15 10:00 ./
drwxr-x--- 4 ducmanh287 ducmanh287 4096 Mar 15 09:44 ../
-rw------- 1 ducmanh287 ducmanh287    0 Mar 15 06:56 authorized_keys
-rw------- 1 ducmanh287 ducmanh287 2602 Mar 15 10:00 id_rsa
-rw-r--r-- 1 ducmanh287 ducmanh287  573 Mar 15 10:00 id_rsa.pub
-rw------- 1 ducmanh287 ducmanh287  978 Mar 15 08:34 known_hosts
-rw-r--r-- 1 ducmanh287 ducmanh287  142 Mar 15 08:34 known_hosts.old
```
- Chuyển khóa từ Server đến Client
```

```