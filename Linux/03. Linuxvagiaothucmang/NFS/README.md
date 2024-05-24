# Cách cài đặt và sử dụng **NFS Auto**
## Yêu cầu hệ thống
**NFS Auto** mới chỉ được tạo ra để sử dụng cho các thiết bị chạy hệ điều hành Ubuntu.

Một máy Ubuntu với cấu hình cơ bản là có thể sử dụng **NFS Auto**
## Hướng dẫn cài đặt và sử dụng:
Tất cả những gì liên quan tới cài đặt đều đã được thiết lập sẵn trong **NFS Auto**

### Hướng dẫn tải xuống
```
# Sử dụng curl 
curl -O https://raw.githubusercontent.com/Ducmanh28/Thuc-Tap/main/Linux/03.%20Linuxvagiaothucmang/NFS/nfs_auto.sh

# Sử dụng wget
wget https://raw.githubusercontent.com/Ducmanh28/Thuc-Tap/main/Linux/03.%20Linuxvagiaothucmang/NFS/nfs_auto.sh

```
### Hướng dẫn sử dụng
Để thao tác được, trước tiên bạn sẽ cần quyền Root đối với hệ thống của mình.
```
sudo su
```
#### Cấp quyền sử dụng cho file
```
chmod +x nfs_auto.sh
```
#### Chạy file:
```
./nfs_auto.sh
```
#### Ví dụ mẫu 1
Chỉ cài đặt NFS Client
```
Do you want to install NFS Server or Client? (1 for Server / 2 for Client): 2
# Chọn 1 nếu bạn muốn cài Server, chọn 2 nếu bạn muốn cài Client

Do you just want to install or also auto-connect to the server? (a for just install / b for install and connect): a
# Chọn a nếu bạn chỉ muốn cài đặt. 
# Chọn b để thực hiện cài đặt và tự động mount
nfs-common is already installed
```
#### Ví dụ mẫu 2
Cài đặt và tự động Mount
```
root@MANH-U22-client:/home/ducmanh/test# ./nfs_auto.sh
Do you want to install NFS Server or Client? (1 for Server / 2 for Client): 2
Do you just want to install or also auto-connect to the server? (a for just install / b for install and connect): a
nfs-common is already installed.
root@MANH-U22-client:/home/ducmanh/test# ./nfs_auto.sh
Do you want to install NFS Server or Client? (1 for Server / 2 for Client): 2
Do you just want to install or also auto-connect to the server? (a for just install / b for install and connect): b
nfs-common is already installed.
Input your NFS Server IP: 172.16.66.81
Input your mount directory on the client: /mnt
Directory /mnt exists.
Port 2049 (NFS) on 172.16.66.81 is open.
Mounting directory /mnt/shared from NFS Server 172.16.66.81 to /mnt...
Successfully mounted /mnt/shared to /mnt.
Mounted directories:
Filesystem                Size  Used Avail Use% Mounted on
172.16.66.81:/mnt/shared   14G  6.1G  7.1G  47% /mnt
root@MANH-U22-client:/home/ducmanh/test#
```
#### Ví dụ mẫu 3
Cài đặt trên Server
```
root@MANH-U22-Server:/home/suncloud/ducmanh# ./nfs_auto.sh
Do you want to install NFS Server or Client? (1 for Server / 2 for Client): 1
nfs-kernel-server is already installed.
Currently shared directories:
/mnt/shared     172.16.66.0/24(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)
root@MANH-U22-Server:/home/suncloud/ducmanh#
```
## Thông tin
Để biết thêm thông tin về NFS, các bạn có thể tham khảo tại
- [NFS](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NFS/nfs.md)
- [NFS là gì?](https://suncloud.vn/nfs-la-gi)
