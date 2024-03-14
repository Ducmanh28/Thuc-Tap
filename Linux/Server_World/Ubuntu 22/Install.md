# Mục này tìm hiểu quá trình cài đặt và Setting cho Ubuntu Server
MỤC LỤC:
- [Mục này tìm hiểu quá trình cài đặt và Setting cho Ubuntu Server](#mục-này-tìm-hiểu-quá-trình-cài-đặt-và-setting-cho-ubuntu-server)
  - [Cài đặt Ubuntu Server](#cài-đặt-ubuntu-server)
    - [Tùy chọn cách cài đặt của Ubuntu Server](#tùy-chọn-cách-cài-đặt-của-ubuntu-server)
      - [Cài đặt thủ công](#cài-đặt-thủ-công)
      - [Máy ảo Ubuntu tức thì](#máy-ảo-ubuntu-tức-thì)
      - [Cung cấp máy chủ tự động](#cung-cấp-máy-chủ-tự-động)
      - [Chọn phiên bản:](#chọn-phiên-bản)
    - [Tiến hành cài đặt](#tiến-hành-cài-đặt)
      - [Tạo máy ảo](#tạo-máy-ảo)
      - [Cài hệ điều hành cho máy ảo](#cài-hệ-điều-hành-cho-máy-ảo)
  - [Các Setting cơ bản](#các-setting-cơ-bản)
    - [Thêm 1 user](#thêm-1-user)
    - [Bật roots user account](#bật-roots-user-account)
    - [Cài đặt mạng cho UbuntuServer](#cài-đặt-mạng-cho-ubuntuserver)
    - [Cài đặt hệ thống](#cài-đặt-hệ-thống)
    - [Cập nhật hệ thống:](#cập-nhật-hệ-thống)
    - [VIM Setting](#vim-setting)
    - [Sudo Setting](#sudo-setting)

## Cài đặt Ubuntu Server
Mục này sẽ gồm các tùy chọn cài đặt và cách cài đặt Ubuntu Server trên máy ảo VMW
### Tùy chọn cách cài đặt của Ubuntu Server
#### Cài đặt thủ công
Cài đặt vật lý dựa trên USB hoặc DVD

Bảo mật hệ điều hành được đảm bảo đến tháng 4 năm 2027

Mở rộng bảo trì an ninh cho đến tháng 4 năm 2032

#### Máy ảo Ubuntu tức thì
Cung cấp máy chủ một cách tự động và nhanh chóng

Không yêu cầu cài đặt vật lý

#### Cung cấp máy chủ tự động
Phù hợp cho việc triển khai siêu quy mô

Được chứng nhận trên chipset ARM và IBM POWER

#### Chọn phiên bản:
Tôi sẽ cài đặt mặc định thủ công 

![](/Anh/Screenshot_478.png)

Sau khi tải xong, các bạn sẽ được 1 file như thế này

![](/Anh/Screenshot_479.png)

### Tiến hành cài đặt
Ở đây, tôi sẽ cài đặt trên 1 con máy ảo của VMW
#### Tạo máy ảo
Trước tiên, tiến hành vào VMW và tạo 1 máy ảo như sau
-  Chọn `File` --> `New Virtual Machine` hoặc bạn có thể ấn trực tiếp tổ hợp phím `Ctrl N`, hoặc đơn giản ở giao diện **Home**, click chọn `Create a New Virtual Machine` ở màn hính chính
-  ![](/Anh/Screenshot_480.png)

- Tiếp đến, chúng ta sẽ tùy chọn cách cài đặt máy ảo, sẽ có 2 lựa chọn là 
  - Typical: Cài đặt đơn giản với 1 vài bước
  - Custom: Cài đặt máy ảo với các tùy chọn nâng cao
  - Tôi chỉ cần 1 máy ảo đơn giản nên sẽ chọn `Typical`
- ![](/Anh/Screenshot_481.png)
- Tiếp đến là phần chọn file hệ thống, chọn đường dẫn tới file OS UbuntuServer đã tải ở trên
- ![](/Anh/Screenshot_482.png)

- Sau đó, thực hiện đặt tên và tìm nơi lưu trữ máy ảo. Cuối cùng là bấm `Next` cho tới khi chuyển thành `Finished` là thành công, bạn đã có 1 máy ảo chạy hệ điều hành UbuntuServer

#### Cài hệ điều hành cho máy ảo
Việc cài đặt Ubuntu rất đơn giản, chỉ cần làm theo các bước sau:
- Chọn ngôn ngữ, English sẽ là mặc định:
- ![](/Anh/Screenshot_483.png)
- Tiếp đó là màn hình Update
- ![](/Anh/Screenshot_484.png)
- Chọn ngôn ngữ Keyboard
- ![](/Anh/Screenshot_485.png)
- Chọn phiên bản cài đặt:
  - Ubuntu Server: Phiên bản mặc định với đầy đủ các chức năng
  - Minimized: Phiên bản nhỏ tối thiểu giảm bớt các chức năng
  - Hoặc cũng có thể cài đặt thêm bởi 1 bên thứ 3
- ![](/Anh/Screenshot_486.png)
- Cài đặt mạng, bạn có thể trực tiếp cài mạng cho máy ảo tại đây, có thể tùy chọn IPv4 hoặc bật DHCP để cấu hình IPv4 tự động
- ![](/Anh/Screenshot_487.png)
- Set Proxy Server URL nếu bạn cần. Nếu không, nó cũng không sao khi Enter mà không nhập gì.
- ![](/Anh/Screenshot_488.png)
- `Enter` liên tục cho tới bước cài Admin user account
- ![](/Anh/Screenshot_489.png)
- Enter cho khi tới tiến trình cài đặt:
- ![](/Anh/Screenshot_490.png)
- Sau khi cài đặt xong, chọn `Reboot now` để khởi động lại máy
- Cuối cùng, khi máy đã khởi động lại thành công, đăng nhập và chúng ta đã hoàn tất
- ![](/Anh/Screenshot_491.png)

## Các Setting cơ bản
### Thêm 1 user
Sau khi cài đặt hệ thống Ubuntu thành công, Server chỉ có 1 User mà bạn đã khởi tạo trong quá trình cài đặt. Không tính Adminuser(roots). Nếu muốn add thêm user, chúng ta thực hiện theo sau:

Ví dụ, thêm user: abcd
```
ducmanh287@ducmanhhost:~$ sudo adduser abcd
[sudo] password for ducmanh287: # Nhập password của tài khoản
Adding user `abcd' ...
Adding new group `abcd' (1001) ...
Adding new user `abcd' (1001) with group `abcd' ...
Creating home directory `/home/abcd' ...
Copying files from `/etc/skel' ...
New password:           #  Nhập password cho user
Retype new password:    #  Nhập lại password
passwd: password updated successfully
Changing the user information for abcd
Enter the new value, or press ENTER for the default
        Full Name []: DUC MANH   # Nhập thông tin, để trống cũng được
        Room Number []:
        Work Phone []:
        Home Phone []: 0925940864
        Other []:
Is the information correct? [Y/n] Y     # Nhập Y để xác nhận
# Sau bước này, bạn đã thành công thêm 1 User
```
Sau khi đã có User, ta có thể cấp quyền cho user theo sau:
```
ducmanh287@ducmanhhost:~$ sudo usermod -aG sudo abcd 
ducmanh287@ducmanhhost:~$ su - abcd
Password:                           # Nhập password cho abcd
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

abcd@ducmanhhost:~$ sudo ls -l /root
[sudo] password for abcd:           # Nhập password cho abcd
total 4
drwx------ 3 root root 4096 Mar 14 08:14 snap
```
Với các bước đơn giản như trên, ta đã có thể cấp quyền roots cho user abcd. Cuối cùng, có thể xóa đi user nếu muốn

Ví dụ, xóa user abcd vừa tạo ở trên
- Chỉ xóa user account
```
ducmanh287@ducmanhhost:~$ sudo deluser abcd
[sudo] password for ducmanh287:
Removing user `abcd' ...
Warning: group `abcd' has no more members.
Done.
```
- Xóa user và đường dẫn thư mục home
```
ducmanh287@ducmanhhost:~$ sudo deluser abcd --remove-home
Looking for files to backup/remove ...
Removing files ...
Removing user `abcd' ...
Warning: group `abcd' has no more members.
Done.
```
### Bật roots user account
Tài khoản roots trong Ubuntu bị tắt mặc định bởi vì nó chưa có mật khẩu riêng. Để sử dụng quyền roots, đơn giản nhất vẫn là sử dụng `sudo` với tài khoản. Tuy nhiên, nếu bạn muốn sử dụng tài khoản sudo vì 1 lý do nào đó, thì nó cũng rất dễ để sử dụng
- Tài khoản được thêm vào lúc khởi tạo máy chủ được tạo với quyền admin với Sudo, vậy nên rất dễ để vào sudo shell như sau:
```
ducmanh287@ducmanhhost:~$ sudo -s
[sudo] password for ducmanh287:         # Nhập password tài khoản
root@ducmanhhost:/home/ducmanh287#      # vậy là nó đã thay đổi
```
- Hoặc cũng có thể chuyển đổi sang tài khoản roots với lệnh `su` để cài đặt password cho roots
```
ducmanh287@ducmanhhost:~$ sudo passwd root
[sudo] password for ducmanh287:       # Nhập password
New password:                         # Nhập password cho root
Retype new password:                  # Nhập lại
passwd: password updated successfully

ducmanh287@ducmanhhost:~$ su -
Password:                             # Nhập password roots
root@ducmanhhost:~#                   # Và nó đã thay đổi
```
- Để hạn chế lệnh `su`, có thể làm như sau
```
root@ducmanhhost:~# vi /etc/pam.d/su
# Gỡ comment và chỉnh sửa nội dung dòng này thành như sau:
auth       required   pam_wheel.so allow group=adm

# Thêm user mà bạn muốn có thể sử dụng quyền su vào group adm
root@ducmanhhost:~# usermod -aG adm ducmanh287
```

### Cài đặt mạng cho UbuntuServer
Bạn nên sử dụng IP tĩnh nếu muốn đặt máy ảo Ubuntu làm 1 máy chủ. Vì đối với máy chủ, thường sẽ được đặt ở nơi xa và chúng ta đứng từ xa SSH vào để điều khiển máy chủ. Vậy nên IP của máy chủ là thứ không nên thay đổi.
- Chúng ta có thể thực hiện cài Ip Tĩnh như sau:
```
# Thực hiện đổi tên để tắt cấu hình mặc định
root@ducmanhhost:~# mv /etc/net
netconfig            netplan/             network/             networkd-dispatcher/ networks
root@ducmanhhost:~# mv /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.org

# Thêm vào 1 file cấu hình mới
root@ducmanhhost:~# vi /etc/netplan/00-installer-config.yaml

# Nội dung file như sau:
# This is the network config written by 'subiquity'
network:
  ethernets:
    ens33:
      dhcp4: false
      addresses: [192.168.217.129/24]
      routes:
        - to: default
          via: 192.168.217.2
          metric: 100
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
      dhcp6: false
  version: 2

# Thực hiện lưu file: Esc --> :wq

# Chấp nhận các thay đổi
root@ducmanhhost:/home/ducmanh287# netplan apply

# Kiểm tra lại ip
root@ducmanhhost:/home/ducmanh287# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:0c:29:4c:39:28 brd ff:ff:ff:ff:ff:ff
    altname enp2s1
    inet 192.168.217.129/24 brd 192.168.217.255 scope global ens33
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe4c:3928/64 scope link
       valid_lft forever preferred_lft forever
```
- Nếu bạn không dùng đến Ipv6, có thể làm như sau:
```
# Tắt Ipv6
root@ducmanhhost:/home/ducmanh287# echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
# Kiểm tra lại
root@ducmanhhost:/home/ducmanh287# sysctl -p
net.ipv6.conf.all.disable_ipv6 = 1

# Kiểm tra Ip
root@ducmanhhost:/home/ducmanh287# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:0c:29:4c:39:28 brd ff:ff:ff:ff:ff:ff
    altname enp2s1
    inet 192.168.217.129/24 brd 192.168.217.255 scope global ens33
       valid_lft forever preferred_lft forever
```
### Cài đặt hệ thống
Để xem, tắt/bật các dịch vụ hệ thống, có thể làm theo sau:
- Để xem các dịch vụ:
  - Chỉ ra các dịch vụ đang chạy
  - Có thể thêm `--all` sẽ hiển thị tất cả các dịch vụ có
  - Có thể thêm `--no-pager` hiển thị mà không sử dụng trình phân trang như **less/more**
```
root@ducmanhhost:/home/ducmanh287# systemctl -t service
  UNIT                         LOAD   ACTIVE SUB     DESCRIPTION                                      
  apparmor.service             loaded active exited  Load AppArmor profiles
  apport.service               loaded active exited  LSB: automatic crash report generation
  blk-availability.service     loaded active exited  Availability of block devices
......

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.
57 loaded units listed. Pass --all to see loaded but inactive units, too.
To show all installed unit files use 'systemctl list-unit-files'.
# LOAD: Hiển thị trạng thái tải của dịch vụ. Cho biết dịch vụ có được tải khi hệ thống khởi động hay không
# ACTIVE: Cho biết trạng thái hoạt động của dịch vụ. Nó chỉ ra xem liệu dịch vụ có đang hoạt động(running) hay không
# SUB: Trạng thái con của dịch vụ, nếu một dịch vụ đang chờ đợi(waiting) hoặc bị lỗi(failed), thì thông tin sẽ được hiển thị ở cột này
# DESCRIPTION: Mô tả ngắn gọn về dịch vụ như chức năng hoặc một số thông tin khác liên quan
```
- Danh sách trạng thái của services
```
root@ducmanhhost:/home/ducmanh287# systemctl list-unit-files -t service
UNIT FILE                               STATE           VENDOR PRESET
apparmor.service                        enabled         enabled
apport-autoreport.service               static          -
apport-forward@.service                 static          -
apport.service                          generated       -
apt-daily-upgrade.service               static          -
apt-daily.service                       static          -
apt-news.service                        static          -
autovt@.service                         alias           -
blk-availability.service                enabled         enabled
```
- Tắt bật các services
```
# Bật Services
root@ducmanhhost:/home/ducmanh287# systemctl start nginx
root@ducmanhhost:/home/ducmanh287# systemctl enable nginx

# Tắt Services
root@ducmanhhost:/home/ducmanh287# systemctl stop nginx
root@ducmanhhost:/home/ducmanh287# systemctl disable ngix
```

### Cập nhật hệ thống:
Cập nhật Ubuntu Server của bạn:
- Cập nhật danh sách các gói phần mềm có sẵn trước
```
root@ducmanhhost:/home/ducmanh287# apt update
Hit:1 http://vn.archive.ubuntu.com/ubuntu jammy InRelease
Get:2 http://vn.archive.ubuntu.com/ubuntu jammy-updates InRelease [119 kB]
Hit:3 http://vn.archive.ubuntu.com/ubuntu jammy-backports InRelease
Get:4 http://vn.archive.ubuntu.com/ubuntu jammy-updates/main amd64 Packages [1,462 kB]
Get:5 http://security.ubuntu.com/ubuntu jammy-security InRelease [110 kB]
Get:6 http://vn.archive.ubuntu.com/ubuntu jammy-updates/universe amd64 Packages [1,056 kB]
Fetched 2,747 kB in 1s (1,832 kB/s)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
59 packages can be upgraded. Run 'apt list --upgradable' to see them.
```
- Cập nhật cho mỗi gói phần mềm và phụ thuộc đã lỗi thời trên hệ thống của bạn.:
```
root@ducmanhhost:/home/ducmanh287# apt -y upgrade
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Calculating upgrade... Done
The following packages have been kept back:
  ubuntu-advantage-tools
The following packages will be upgraded:
  apparmor apt apt-utils base-files cloud-init coreutils cryptsetup cryptsetup-bin cryptsetup-initramfs distro-info distro-info-data dpkg git git-man
  initramfs-tools initramfs-tools-bin initramfs-tools-core iptables irqbalance kpartx libapparmor1 libapt-pkg6.0 libcryptsetup12 libgpgme11 libip4tc2 libip6tc2
  libmm-glib0 libnetplan0 libnss-systemd libpam-systemd libsgutils2-2 libsystemd0 libudev1 libxtables12 modemmanager motd-news-config multipath-tools netplan.io
  open-vm-tools python-apt-common python3-apt python3-distro-info python3-distupgrade python3-software-properties python3-update-manager sg3-utils sg3-utils-udev
  software-properties-common sosreport systemd systemd-hwe-hwdb systemd-sysv systemd-timesyncd tcpdump ubuntu-drivers-common ubuntu-release-upgrader-core udev
  update-manager-core
58 upgraded, 0 newly installed, 0 to remove and 1 not upgraded.
Need to get 23.8 MB of archives.
After this operation, 542 kB disk space will be freed.
Get:1 http://vn.archive.ubuntu.com/ubuntu jammy-updates/main amd64 motd-news-config all 12ubuntu4.6 [4,352 B]
Get:2 http://vn.archive.ubuntu.com/ubuntu jammy-updates/main amd64 base-files amd64 12ubuntu4.6 [62.5 kB]
.... 
```

### VIM Setting
VIM là một trình soạn thảo nâng cấp của VI. Hay còn gọi là VI Improved. Để cài đặt và chỉnh sửa một số settings cho VIM, làm theo sau:

```
# Cài đặt VIM
root@ducmanhhost:/home/ducmanh287# apt install -y vim

# Một số chỉnh sửa cho VIM
root@ducmanhhost:/home/ducmanh287# vi ~/.vimrc

# Thêm nội dung như sau:
set nocompatible                # Sử dụng tính năng mở rộng của Vim (không tương thích với VI)
set encoding=utf-8              # Chỉ định mã hóa ký tự
set fileencodings=utf-8         # Xác định các mã ký tự sử dụng trong các tập tin là UTF-8.
set fileformats=unix,dos        #  Xác định định dạng của các tập tin là Unix hoặc DOS.
set backup                      # Tạo bản sao lưu của tập tin.
set backupdir=~/backup          #  Xác định thư mục lưu trữ bản sao lưu.
set history=50                  # Xác định số lượng lịch sử tìm kiếm.
set ignorecase                  # Bỏ qua việc phân biệt chữ hoa và thường trong tìm kiếm.
set smartcase                   # Sử dụng phân biệt chữ hoa/thường trong trường hợp tìm kiếm có sử dụng ký tự in hoa.
set hlsearch                    # Tô sáng các từ được tìm thấy.
set incsearch                   # Tìm kiếm tăng dần khi gõ.
set number                      # Hiển thị số dòng.
set list                        #  Hiển thị ký tự đặc biệt cho các ký tự đặc biệt như dấu `$` và tab.
set showmatch                   # Tô sáng cặp ngoặc đối xứng.
set binary noeol                # Không chèn ký tự xuống dòng cuối cùng của tập tin.
set autoindent                  #  Bật tự động thụt vào khi thêm dòng mới.
syntax on                       # Hiển thị màu
highlight Comment ctermfg=LightCyan # Tùy chỉnh màu của các ý kiến.
set wrap                        # Xuống dòng tự động khi cần thiết 
```
### Sudo Setting
Cấu hình Sudo để phân quyền người dùng
- Cài đặt Sudo
```
root@ducmanhhost:/home/ducmanh287# apt -y install sudo
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
sudo is already the newest version (1.9.9-1ubuntu2.4).
sudo set to manually installed.
0 upgraded, 0 newly installed, 0 to remove and 1 not upgraded.
```
- Phân quyền người dùng
```
root@ducmanhhost:/home/ducmanh287# 

# Thêm vào dòng cuối cùng để user
```