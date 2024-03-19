MỤC LỤC
- [Mục này cấu hình SSH trên Ubuntu 22](#mục-này-cấu-hình-ssh-trên-ubuntu-22)
  - [OpenSSH: Xác thực mật khẩu](#openssh-xác-thực-mật-khẩu)
    - [SSH Server](#ssh-server)
    - [SSH Client](#ssh-client)
      - [SSH Client: Ubuntu](#ssh-client-ubuntu)
      - [SSH Client: Windows](#ssh-client-windows)
  - [SSH File Transfer](#ssh-file-transfer)
    - [Ubuntu](#ubuntu)
    - [Windows](#windows)
  - [SSH xác thực Key-Pair](#ssh-xác-thực-key-pair)

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
Cấu hình SSH cho việc kết nối an toàn giữa máy chủ và máy khách. Máy khách sẽ thực hiện tạo 1 cặp khóa private và public key, trong đó:
- Private key sẽ là khóa chỉ nằm ở máy khách và không đem đi chia sẻ
- Public key sẽ là khóa được chia sẻ tới các máy chủ để có thể SSH vào Server

Mô tả quá trình theo sơ đồ sẽ trông như sau:

![](/Anh/Screenshot_497.png)

Tôi sẽ sử dụng máy client là máy khách CentOS 9, máy chủ sẽ là máy UbuntuSV 22.

Qúa trình sẽ được thực hiện như sau:
- Thực hiện tạo cặp khóa trên máy Client: 
```
[root@localhost ducmanh287]# ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
Created directory '/root/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:pyOZyguDwFiUaiBKif/nEIeVg4XOdc0Lm+epzTAuFyY root@localhost.localdomain
The key's randomart image is:
......
------
......
```
- Sau khi đã tạo khóa xong, copy khóa công khai tới Server:
```
[root@localhost .ssh]# scp id_rsa.pub ducmanh287@192.168.217.128:/home/.ssh
ducmanh287@192.168.217.128's password:    # Nhập password
id_rsa.pub                      100%  408   332.7KB/s   00:00
[root@localhost .ssh]#
```
- Thực hiện SSH vào Server bằng cách nhập Password
```
[root@localhost .ssh]# ssh ducmanh287@192.168.217.128
ducmanh287@192.168.217.128's password:
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-100-generic x86_64)

ducmanh287@ubuntusv:~$
```
- Tạo thư mục `.ssh` và file `authorized_keys`, sau đó copy nội dung file `id_rsa.pub` vào file `authorized_keys`. Cuối cùng là thực hiện cấp quyền:
```
# Tạo thư mục và file
root@ubuntusv:/home# mkdir .ssh
root@ubuntusv:/home# cd .ssh
root@ubuntusv:/home/.ssh# touch authorized_keys
# Cấp quyền
root@ubuntusv:/home/.ssh# chmod 700 /home/.ssh
root@ubuntusv:/home/.ssh# chmod 600 /home/.ssh/authorized_keys
# Chuyển nội dung file
root@ubuntusv:/home/.ssh# cat id_rsa.pub >> authorized_keys
```
- Tắt tính tăng đăng nhập bằng mật khẩu trong ssh_config
```
root@ubuntusv:/home/.ssh# vim /etc/ssh/ssh_config
PasswordAuthentication no
:wq
root@ubuntusv:/home/.ssh# systemctl restart sshd
```
Vậy còn SSH giữa máy Windows và Server Ubuntu thì làm như thế nào? Ở đây, tôi sử dụng phần mềm trung gian là MobaXterm. Mô hình hoạt động sẽ trông như sau:

![](/Anh/Screenshot_498.png)

Cách làm sẽ trông như sau:
- Trước tiên, ta dùng Tools trên MobaXterm để tạo cặp khóa:
  - Vào **Tools** --> **MobaKeyGen** --> **Generate**
  - ![](/Anh/Screenshot_499.png)
  - Sau khi chọn nơi lưu file, chúng ta được 2 file trong đó 1 là Public Key, 1 là Private Key
  - ![](/Anh/Screenshot_500.png)
- Truy cập vào Server thông qua cách đăng nhập bằng Password,
- Tạo file `.ssh/authorized_keys` và paste nội dung khóa Public vào file đấy.
- Khi đăng nhập bằng MobaXterm, lúc này chúng ta chọn **Advanced SSH settings**
- Tích vào ô **Use private key**, chọn đường dẫn tới file chứa **Private key**, sau đó kết nối. Lúc này, chúng ta không cần sử dụng Password nữa
- ![](/Anh/Screenshot_501.png)