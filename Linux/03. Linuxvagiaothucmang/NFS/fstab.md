# Mục này tìm hiểu về Fstab
## Giới thiệu
### FSTab là gì?
Fstab hay còn gọi là File System Table - là một tệp tin ở trong hệ thống Linux, được sử dụng để xác định các hệ thống tập tin và các thiết bị lưu trữ được gắn kết tự động và được tự động mount khi hệ thống khởi động. 

Cụ thể, fstab chứa thông tin về các phân vùng đĩa cứng, ổ đĩa mạng, hoặc các thiết bị lưu trữ khác cần được mount và cách mount chúng
### Cấu trúc của FSTAB và cách hoạt động
Cấu trúc của 1 fstab thường bao gồm những thành phần sau:
- Device: Đường dẫn hoặc tên thiết bị lưu trữ
- Mount Point: Đường dẫn tới nơi mà thiết bị sẽ được mount
- File System Type: Loại hệ thống tệp tin(ext4, ntfs, vfat,...)
- Options: Các tùy chọn cho quá trình mount(auto, noauto, rw, ro)
- Dump: Có nên sao lưu thiết bị này không(mặc định là 0)
- Pass: Thứ tự kiểm tra và sửa chữa cho hệ thống tệp tin khi hệ thống khởi động.

Fstab hoạt động bằng cách đọc thông tin trong tệp và tự động mount các thiết bị được chỉ định khi hệ thống khởi động

### Cách sử dụng NFS:
Bạn cần tuân theo cấu trúc của fstab như trên. Bạn sẽ thực hiện tạo 1 `file /etc/fstab` và thêm và các câu lệnh khởi chạy. Dưới đây là một ví dụ

```
172.16.66.81:/mnt/shared /mnt/nfs_shared nfs defaults 0 0
```
Trong đó:
- 172.16.66.81: Địa chỉ IP của Server
- /mnt/shared: Đường dẫn tới file mà Server chia sẻ
- /mnt/nfs_shared: Local file
- nfs: Sử dụng loại tệp nfs
- default: Tùy chọn default rw
- 0: dump mặc định
- 0: pass mặc định

### Cấu hình nfs tự động mount
#### Trên Server:
Tải và cài đặt NFS server:
- Tự động theo file sh ở trên

Cấu hình thư mục chia sẻ là `/mnt/shared`
```
mkdir -p /mnt/shared
```
Thay đổi quyền sở hữu thư mục và cấp quyền truy cập cho thư mục
```
chown nobody:nobody /mnt/shared
chmod 777 /mnt/shared
```
Cấu hình UFW mở port
```
sudo ufw allow nfs
```
#### Trên Client:
Tải và cài đặt tự động

Cấu hình thư mục mount là `/mnt/nfs_shared`

Tạo file: `/etc/fstab`

Chèn vào nội dung sau:
```
172.16.66.81:/mnt/shared /mnt/nfs_shared nfs defaults 0 0
```
```
# Bây giờ bạn khởi động lại máy để kiểm tra quá trình. Hoặc sử dụng lệnh sau:
sudo mount -a
```
Kiểm tra khi vừa khởi động lại thiết bị:

![](/Anh/Screenshot_694.png)
