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
  - [Cấu hình SFTP only Chroot](#cấu-hình-sftp-only-chroot)
  - [SSH - Agent](#ssh---agent)
  - [Sử dụng SSHPass](#sử-dụng-sshpass)
  - [Sử dụng SSHFS](#sử-dụng-sshfs)
  - [SSH Port Forwarding](#ssh-port-forwarding)
  - [Parallel SSH](#parallel-ssh)

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
- Thử đăng nhập:
```
[ducmanh287@localhost ~]$ ssh ducmanh287@192.168.217.128
Enter passphrase for key '/home/ducmanh287/.ssh/id_rsa':

ducmanh287@ubuntusv:~$        # Thành công
```
Hoặc chúng ta cũng có thể sử dụng trực tiếp ứng dụng của SSH để thực hiện chuyển khóa như sau:
```
ducmanh287@ubuntusv:~$ ssh-copy-id ducmanh287@192.168.217.132
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/ducmanh287/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
ducmanh287@192.168.217.132's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'ducmanh287@192.168.217.132'"
and check to make sure that only the key(s) you wanted were added.
```
Kết quả:
```
ducmanh287@ubuntusv:~$ ssh ducmanh287@192.168.217.132
Enter passphrase for key '/home/ducmanh287/.ssh/id_rsa':
Activate the web console with: systemctl enable --now cockpit.socket

Last login: Tue Mar 26 15:00:00 2024 from 192.168.217.1
[ducmanh287@localhost ~]$
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

## Cấu hình SFTP only Chroot
Phân quyền cho một vài users - những người được cấp quyền chỉ có thể truy cập SFTP và một số đường dẫn Chroot

"SFTP only chroot" thường ám chỉ việc cấu hình một máy chủ SFTP để hạn chế người dùng đăng nhập chỉ vào một môi trường chroot, có nghĩa là họ chỉ có thể truy cập vào các tệp và thư mục nằm trong phạm vi của một thư mục cụ thể, hạn chế bất kỳ truy cập nào ra ngoài thư mục này. Điều này tạo ra một môi trường cực kỳ an toàn khi cung cấp dịch vụ truyền tệp từ xa.

Quá trình thực hiện như sau:
```
# Thực hiện tạo một group dành cho SFTP
root@ubuntusv:/home/ducmanh287# groupadd sftp_users

# Thêm user ducmanh287 vào nhóm SFTP
root@ubuntusv:/home/ducmanh287# usermod -aG sftp_users ducmanh287

# Thực hiện chỉnh sửa file cấu hình ssh như sau:
# Comment dòng 115:Subsystem      sftp    /usr/lib/openssh/sftp-server

# Thêm vào dưới dòng sau:
Subsystem sftp internal-sftp
# Thêm vào dưới cùng đoạn sau:
Match Group sftp_users
    X11Forwarding no
    AllowTcpForwarding no
    ChrootDirectory /home
    ForceCommand internal-sftp

# Thoát khỏi Vim và thực hiện lưu file, sau đó khởi động lại ssh và sshd
root@ubuntusv:/home/ducmanh287# systemctl restart ssh
root@ubuntusv:/home/ducmanh287# systemctl restart sshd
```
Giải thích:
- **Dòng 115**: Định nghĩa một "subsystem" được gọi là "sftp" và chỉ định rằng nó sẽ sử dụng `/usr/lib/openssh/sftp-server` như là tiện ích con để xử lý các yêu cầu **SFTP** từ các máy khách
- **Match Group sftp_users**: Đây là một điều kiện Match trong tệp cấu hình của máy chủ SSH. Nó áp dụng các cài đặt được liệt kê dưới đây chỉ cho các người dùng thuộc nhóm "sftp_users".
- **X11Forwarding no**: Tắt chức năng chuyển tiếp X11 (X Window System) từ máy chủ SSH đến máy khách. Điều này ngăn chặn người dùng từ việc chạy các ứng dụng GUI trên máy khách thông qua kết nối SSH.
- **AllowTcpForwarding no**: Vô hiệu hóa chuyển tiếp TCP từ máy chủ SSH đến máy khách. Điều này ngăn chặn người dùng từ việc sử dụng các dịch vụ như port forwarding.
- **ChrootDirectory /home**: Đặt thư mục chroot cho các người dùng trong nhóm "sftp_users" là "/home". Điều này có nghĩa là họ sẽ bị hạn chế truy cập đến chỉ một phần nhất định của hệ thống tệp, cụ thể là thư mục "/home".
- **ForceCommand internal-sftp**: Yêu cầu sử dụng chỉ tiện ích `internal-sftp` để xử lý các yêu cầu **SFTP** từ nhóm người dùng "sftp_users". Điều này giúp đảm bảo rằng các người dùng trong nhóm sftp_users chỉ có thể sử dụng **SFTP** và không thể truy cập vào shell thực sự trên máy chủ.

Thực hiện kiểm tra kết quả:
```
[ducmanh287@localhost ~]$ ssh ducmanh287@192.168.217.128
ducmanh287@192.168.217.128's password:
This service allows sftp connections only.
Connection to 192.168.217.128 closed.

# Như đã cài đặt nó sẽ từ chối SSH
# Nhưng nếu chúng ta sử dụng sftp thì sao

[ducmanh287@localhost ~]$ sftp ducmanh287@192.168.217.128
ducmanh287@192.168.217.128's password:
Connected to 192.168.217.128.
sftp>

# Vậy là đã kết nối thành công
```

Kiểm tra quyền truy cập thư mục:
- Trước khi thêm nhóm, có thể truy cập và mở bất kì

![](/Anh/Screenshot_516.png)

- Sau khi thêm nhóm, sẽ báo lỗi không tìm thấy khi truy cập một đường dẫn ngoài đường dẫn được cấp phép:

![](/Anh/Screenshot_517.png)

## SSH - Agent
Là một chương trình chạy dưới dạng một dịch vụ nền (background service) trên hệ thống Unix và tương tự, chịu trách nhiệm quản lý các khóa SSH cho người dùng

Khi bạn kết nối vào một máy chủ từ xa bằng SSH và cần xác thực bằng cách sử dụng một khóa SSH, ssh-agent giúp lưu trữ 
và quản lý các khóa này trong một thời gian nhất định.

Cơ chế hoạt động:
- **Khởi động ssh-agent**: Người dùng thường khởi động ssh-agent bằng cách chạy lệnh `ssh-agent` từ dòng lệnh. Sau khi khởi động, ssh-agent sẽ tạo ra một môi trường và in ra các biến môi trường cần thiết để thiết lập môi trường làm việc cho các phiên làm việc sau này.

- **Thêm khóa SSH vào ssh-agent**: Người dùng sau đó thêm các khóa riêng tư SSH vào ssh-agent bằng cách sử dụng lệnh ssh-add. Khi thêm khóa, ssh-agent yêu cầu mật khẩu của khóa (nếu có) và sau đó lưu trữ khóa trong bộ nhớ.

- **Sử dụng khóa từ ssh-agent**: Khi người dùng thực hiện một kết nối SSH đến một máy chủ từ xa, ssh-agent sẽ cung cấp các khóa riêng tư mà nó lưu trữ để xác thực với máy chủ từ xa. Người dùng không cần phải nhập mật khẩu mỗi lần kết nối với máy chủ từ xa.

- **Kết thúc ssh-agent**: Sau khi người dùng kết thúc phiên làm việc, họ có thể kết thúc ssh-agent bằng cách sử dụng lệnh ssh-agent -k để xóa tất cả các khóa khỏi bộ nhớ và kết thúc quá trình ssh-agent.

Dưới đây là cách để sử dụng SSH - Agent
```
# Bắt đầu SSH - Agent
ducmanh287@localhost: ~$ evel $(ssh-agent)
Agent pid 1040

# Thêm khóa
ducmanh287@localhost: ~$ ssh-add
Enter passphrase for /home/ducmanh287/.ssh/id_rsa:
Identity added: /home/ducmanh287/.ssh/id_rsa (ducmanh287@192.168.217.128)

# Xác nhận
ducmanh287@localhost: ~$ ssh-add -l
3072 SHA256:Sy81HjIIQhqVHeVoxBxfV/JEflv16yS7wl3TXBafBaw ducmanh287@192.168.217.128 (RSA)

# Thử kết nối với SSH - mà không cần dùng mật khẩu
ducmanh287@localhost: ~$ ssh ducmanh287@192.168.216.128
ducmanh287@ubuntusv: ~# 

# Thoát khỏi SSH-Agent
ducmanh287@localhost: ~$ evel $(ssh-agent -k)
Agent pid 1040 killed
```

## Sử dụng SSHPass
Chúng ta có thể sử dụng SSHPass để tự động nhập mật khẩu khi xác thực mật khẩu.

Mặc dù điều này thuận tiện, tuy nhiên nó lại có các rủi ro bảo mật như rò rỉ mật khẩu, cần đặc biệt cẩn trọng khi sử dụng nó

Nếu bạn chắc chắn khả năng quản lý của mình, chúng ta cùng tiến hành cài đặt và sử dụng SSHPass
```
# Cài đặt SSHPass
ducmanh287@ubuntusv:~$ sudo apt install -y sshpass
[sudo] password for ducmanh287:

# Tiến hành sử dụng SSHPass
# '-p' Sử dụng từ đối số nhập vào
# Nếu sử dụng lần đầu thì thêm [StrictHostKeyChecking=no]
ducmanh287@ubuntusv:~$ sshpass -p 28072003 ssh -o StrictHostKeyChecking=no 192.168.217.132 hostname
ducmanh287

# Hoặc '-f': Lấy từ file
ducmanh287@ubuntusv:~$ echo '28072003' > sshpass.txt
ducmanh287@ubuntusv:~$ chmod 600 sshpass.txt
ducmanh287@ubuntusv:~$ sshpass -f sshpass.txt ssh ducmanh287@192.168.217.132 hostname
ducmanh287

# Hoặc '-e': Lấy từ biến môi trường
ducmanh287@ubuntusv:~$ sshpass -e ssh ducmanh287@192.168.217.132 ls -a
```
Kiểm tra các kết quả hiển thị

![](/Anh/Screenshot_518.png)

## Sử dụng SSHFS
SSHFS - SSH File System là một công cụ giúp bạn gắn kết một thư mục từ một máy chủ từ xa qua SSH vào hệ thống tệp cục bộ của bạn

Bằng cách sử dụng `sshfs`, bạn có thể truy cập và làm việc với các tệp và thư mục trên máy chủ từ xa một cách dễ dàng như là chúng đang nằm trên hệ thống cục bộ của bạn

Cách sử dụng SSHFS trên Ubuntu 22 như sau:
```
# Trước tiên, chúng ta cần cài đặt sshfs
ducmanh287@ubuntusv:~$ sudo apt install -y sshfs

# Tiến hành sử dụng
## Tạo một thư mục tạm thời để chứa các thư mục điều khiển
ducmanh287@ubuntusv:~$ mkdir ~/remote_mount
## Gắn kết với sshfs
ducmanh287@ubuntusv:~$ sshfs ducmanh287@192.168.217.132:/home/ducmanh287 ~/remote_mount
ducmanh287@192.168.217.132's password:
ducmanh287@ubuntusv:~$
## Kiểm tra kết quả sử dụng lệnh sau:
ducmanh287@ubuntusv:~$ df -hT
Filesystem                                  Type        Size  Used Avail Use% Mounted on
tmpfs                                       tmpfs       193M  1.3M  192M   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv           ext4        9.8G  5.7G  3.7G  61% /
tmpfs                                       tmpfs       965M     0  965M   0% /dev/shm
tmpfs                                       tmpfs       5.0M     0  5.0M   0% /run/lock
/dev/sda2                                   ext4        1.8G  251M  1.4G  16% /boot
tmpfs                                       tmpfs       193M  4.0K  193M   1% /run/user/1000
ducmanh287@192.168.217.132:/home/ducmanh287 fuse.sshfs   17G  1.9G   16G  11% /home/ducmanh287/remote_mount

## Sau khi thực hiện các chỉnh sửa hoàn tất, bạn có thể dùng lệnh sau để gỡ kết nối. Lúc này file remote_mount cũng sẽ biến mất
ducmanh287@ubuntusv:~$ fusermount -u ~/remote_mount
```
Khi bạn sử dụng `sshfs` để gắn kết thư mục thì mọi thay đổi bạn thực hiện trên các tệp thư mục được gắn kết khi ở trên máy local sẽ được truyền lại bên server và lưu trữ trên server

Điều này làm cho việc làm việc với các tệp từ xa trở nên thuận tiện, vì bạn có thể chỉnh sửa chúng trên máy tính cục bộ của mình nhưng thay đổi sẽ được tự động đồng bộ hóa với máy chủ từ xa thông qua kết nối SSH.

## SSH Port Forwarding
SSH Port Forwarding hay còn được gọi là SSH Tunneling là một kỹ thuật trong mạng máy tính cho phép chuyển tiếp lưu lượng truy cập mạng từ một cổng port trên máy tính cục bộ của bạn tới một máy chủ từ xa thông qua một kết nối SSH an toàn.
- Bảo mật kết nối: Sử dụng SSH để chuyển tiếp dữ liệu giữa các máy tính, giúp bảo vệ dữ liệu khỏi bị đánh cắp hoặc thay đổi từ bên thứ 3
- Truy cập vào các dịch vụ từ xa: Cho phép bạn truy cập vào các dịch vụ, máy chủ hoặc ứng dụng từ xa mà không cần mở các cổng truy cập trực tiếp trên mạng Internet, tăng cường bảo mật

Mô tả sơ đồ quá trình như sau

![](/Anh/Screenshot_526.png)

Ví dụ về cách sử dụng: Đặt SSH Port Forwarding để các gói tin đến cổng 8081 trên 192.168.217.132 sẽ được chuyển tiếp đến cổng 80 trên 192.168.217.128
```
# SSH Login:
[ducmanh287@localhost ~]$ ssh -L 192.168.217.132:8081:192.168.217.128:80 ducmanh287@192.168.217.128
# Trong đó: `-L` là option của SSH giúp chỉ định kết nối chuyển tiếp cổng 
ducmanh287@192.168.217.128's password:
ducmanh287@ubuntusv: ~$

# Xác nhận:
ducmanh287@ubuntusv:~$ ssh 192.168.217.132 "ss -napt | grep 8081"
# Lắng nghe trên cổng 8081
# Giữ lại phiên đăng nhập
ducmanh287@192.168.217.132's password:
LISTEN 0      128    192.168.217.132:8081          0.0.0.0:*     users:(("ssh",pid=23945,fd=4))
```
Kiểm thử kết quả:

![](/Anh/Screenshot_521.png)

Lúc này, `192.168.217.128:80` đã được chuyển tiếp sang `192.168.217.132:8081`

## Parallel SSH
PSSH là một công cụ được sử dụng để thực hiện các lệnh trên nhiều máy tính đồng thời thông qua SSH. Điều này giúp tiết kiệm thời gian và tăng hiệu suất khi cần thực hiện cùng một tác vụ trên nhiều máy tính

Cách sử dụng PSSH: Tôi có 3 máy để thực hiện bài Lab này
- Máy đóng vai trò sử dụng PSSH: ubuntusv-`192.168.217.128`
- Máy PC1: Centos7-`192.168.217.131`
- Máy PC2: Centos9-`192.168.217.132`
```
# Cài đặt PSSH
ducmanh287@ubuntusv:~$ sudo apt install -y pssh

# Kết nối trực tiếp tới 2 PC để thực hiện lệnh:
ducmanh287@ubuntusv:~$ parallel-ssh -H "192.168.217.131 192.168.217.132" -i "hostname"
[1] 09:04:18 [SUCCESS] 192.168.217.131
ducmanh287
[2] 09:04:18 [SUCCESS] 192.168.217.132
ducmanh287

# Chúng ta cũng có thể ghi các id vào 1 file rồi thực hiện kết nối như sau:
## Tạo 1 file host.txt (Tạo ở đâu thực hiện lệnh ở đó)
## Nội dung file
ducmanh287@192.168.217.131
ducmanh287@192.168.217.132

## Thực hiện câu lệnh như sau:
ducmanh287@ubuntusv:~$ parallel-ssh -h host.txt -i "uname -a"
[1] 09:04:18 [SUCCESS] 192.168.217.131
5.14.0-391.el7.x86_64
[2] 09:04:18 [SUCCESS] 192.168.217.132
3.10.0-1160.el9.x86_64

# Lưu ý rằng phần này chỉ thực hiện được khi bạn không cài passphrase cho các khóa hoặc đã sử dụng phần mềm để đăng nhập ssh mà không cần mật khẩu
```
```
# Hoặc bạn cũng có thể sử dụng parallel ssh với mật khẩu. Tuy nhiên, mật khẩu ở 2 máy phải như nhau.
ducmanh287@ubuntusv:~$ parallel-ssh -h host.txt -A -O PreferredAuthentications=password -i "uname -r"
Warning: do not enter your password if anyone else has superuser
privileges or access to your account.
Password:
[1] 09:05:20 [SUCCESS] 192.168.217.131
5.14.0-391.el7.x86_64
[2] 09:05:20 [SUCCESS] 192.168.217.132
3.10.0-1160.el9.x86_64
ducmanh287@ubuntusv:~$
```
Giải thích về câu lệnh:
- `-h host.txt`: Tùy chọn này chỉ định một tệp tin (host.txt) chứa danh sách các máy tính mục tiêu mà lệnh sẽ thực hiện trên chúng
- `-A`: Tùy chọn này yêu cầu xác thực bằng cách sử dụng một phương thức xác thực mà người dùng đã được xác định sẵn, thường là mật khẩu.