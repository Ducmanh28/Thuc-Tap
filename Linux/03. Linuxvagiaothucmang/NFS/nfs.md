# Mục này tìm hiểu về NFS
MỤC LỤC
- [Mục này tìm hiểu về NFS](#mục-này-tìm-hiểu-về-nfs)
- [Lý thuyết:](#lý-thuyết)
  - [NFS là gì?](#nfs-là-gì)
  - [Chức năng của NFS?](#chức-năng-của-nfs)
  - [Lịch sử hình thành và phát triển của NFS](#lịch-sử-hình-thành-và-phát-triển-của-nfs)
  - [Hệ thống NFS bao gồm những gì?](#hệ-thống-nfs-bao-gồm-những-gì)
  - [Cách mà NFS hoạt động](#cách-mà-nfs-hoạt-động)
    - [Mount Request/Response](#mount-requestresponse)
    - [Read File data:](#read-file-data)
    - [Close File](#close-file)
  - [Ưu điểm và Nhược điểm khi sử dụng NFS](#ưu-điểm-và-nhược-điểm-khi-sử-dụng-nfs)
    - [Ưu điểm](#ưu-điểm)
    - [Nhược điểm](#nhược-điểm)
  - [Thực tế và một số giao thức tương tự NFS](#thực-tế-và-một-số-giao-thức-tương-tự-nfs)
    - [Thực tế](#thực-tế)
    - [Một số giao thức tương tự NFS](#một-số-giao-thức-tương-tự-nfs)
- [Thực hành](#thực-hành)
  - [Cài đặt NFS](#cài-đặt-nfs)
  - [Cấu hình NFS để chia sẻ](#cấu-hình-nfs-để-chia-sẻ)
    - [Cấu hình bên phía Server](#cấu-hình-bên-phía-server)
    - [Cấu hình bên phía Client](#cấu-hình-bên-phía-client)
    - [Kiểm tra](#kiểm-tra)

# Lý thuyết:
## NFS là gì?
NFS - Network File System(Hệ thống tệp mạng), là một giao thức mạng cho phép người dùng trên một máy tính(Client) truy cập và thao tác với các tệp tin và thư mục trên một máy tính khác(Server) thông qua mạng.

## Chức năng của NFS?
NFS được sử dụng chủ yếu để chia sẻ tệp và thư mục giữa các máy tính trong cùng một mạng. Các ứng dụng phổ biến của NFS bao gồm:
- Chia sẻ tài liệu và tệp tin trong doanh nghiệp: Cho phép các máy Client kết nối tới 1 Server tập trung để lấy dữ liệu
- Lưu trữ tập trung: Các dữ liệu quan trọng được lưu dữ tập trung trên một máy chủ để dễ dàng quản lý và sao lưu
- Hệ thống phát triển phần mềm: Các lập trình viên có thể chia sẻ dữ liệu, tài liệu dễ dàng thông qua NFS
- Quản lý các ứng dụng và dịch vụ mạng: NFS giúp các hệ thống máy chủ và dịch vụ mạng chia sẻ dữ liệu hiệu quả

## Lịch sử hình thành và phát triển của NFS
- **1984**: NFS được phát triển lần đầu tiên bởi **Sun Microsystems**. Ý tưởng ban đầu là tạo ra một hệ thống cho phép các máy tính trong cùng một mạng có thể chia sẻ tệp tin một cách dễ dàng và liền mạch. 
- **1985**: NFSv2 ra đời, sử dụng giao thức **RPC**(Remote Procedure Call) để có thể thực hiện được các thao tác từ xa. NFSv2 chỉ hỗ trợ giao thức **UDP**, giảm độ trễ nhưng hạn chế về độ tin cậy và bảo mật
- **1989**: NFSv3 được phát hành với một số tính năng mới như:
  - Hỗ trợ giao thức **TCP**
  - Tăng kích thước tối đa của tệp tin và thư mục
  - Hỗ trợ các thao tác không đồng bộ để cải thiện hiệu suất
- **2000**: NFSv4 được cho ra đời, nó đã mang lại nhiều cải tiến quan trọng:
  - Tích hợp các tính năng bảo mật như **Kerberos** và **LIPKEY**
  - Hỗ trợ tốt hơn cho môi trường Internet và Firewall
  - Tăng cường khả năng hoạt động liên tục và quản lý trạng thái kết nối
- **2010** - nay: Phát triển NFSv4.1 và NFSv4.2 cải thiện các tính năng mở rộng và hiệu suất

## Hệ thống NFS bao gồm những gì?
Một hệ thống DNS sẽ bao gồm các thành phần chính như sau:
  - Server NFS: Đây chính là máy chủ cung cấp các tệp tin và thư mục để chia sẻ qua mạng
  - Client NFS: Đây chính là máy tính kết nối đến Server NFS để truy cập và thao tác với các tệp tin và thư mục
  - Giao thức RPC: Được sử dụng để liên lạc giữa máy khách và máy chủ
    - Remote Procedure Call (RPC) được biết đến như một mô hình kỹ thuật mạng, là phương thức giao tiếp phần mềm mà chương trình nào đó dùng để yêu cầu dịch vụ từ chương trình khác trong máy tính.
    - Nói một cách dễ hiểu hơn thì RPC chính là cơ chế giao tiếp phát sinh giữa hai tiến trình khác nhau. Nó áp dụng một mô hình chính là máy khách và máy chủ. Trong đó:
      - Máy chủ là chương trình cung cấp dịch vụ 
      - Máy khách là chương trình yêu cầu dịch vụ.
    - Mô hình kỹ thuật mạng RPC là một quá trình mang tính đồng bộ, theo đó chương trình yêu cầu bị tạm dừng đến thời điểm trả như mong muốn. Nhiều RPC được quyền hoạt động cùng lúc.
  - Mount Protocol: Được sử dụng để gắn kết hệ thống tệp từ máy chủ NFS lên máy khách

## Cách mà NFS hoạt động
Về cơ bản thì cách hoạt động sẽ như sau:
- Cấu hình máy chủ NFS: Máy chủ NFS được cấu hình để chia sẻ các thư mục. Điều này thường bao gồm cài đặt phần mềm NFS và thiết lập các quyền truy cập.
- Máy khách gắn kết thư mục: Máy khách sử dụng lệnh mount để gắn kết thư mục chia sẻ từ máy chủ NFS vào hệ thống tệp của mình.
- Truy cập tệp tin: Sau khi gắn kết, người dùng trên máy khách có thể truy cập và thao tác với các tệp tin trong thư mục chia sẻ như thể chúng nằm trên máy tính của mình.

Để hiểu hơn cách NFS hoạt động, các bạn có thể tham khảo mô hình dưới đây về một ví dụ khi có yêu cầu đọc file

![](/Anh/Screenshot_653.png)

### Mount Request/Response
- Client gửi yêu cầu mount tới Server để gắn kết thư mục chia sẻ
- Server phản hồi thông tin với Mount
### Read File data:
- Client gửi yêu cầu RPC để đọc 1 file 
- Server trả về 1 File Handle
  - File handle có thể được xem như một con trỏ hoặc một địa chỉ dạng số học, được máy chủ NFS sử dụng để xác định tệp tin hoặc thư mục mà máy khách yêu cầu truy cập. Bản chất của file handle thường được ẩn đi và không thể trực tiếp thao tác từ phía người dùng hoặc ứng dụng.
- Client gửi yêu cầu đọc file
- Server trả về nội dung file

### Close File
- Client gửi yêu cầu đóng File
- Server gửi lại gói tin ACK đã xác nhận

## Ưu điểm và Nhược điểm khi sử dụng NFS
### Ưu điểm
- Chia sẻ tệp tin dễ dàng: Cho phép nhiều người dùng truy cập và làm việc trên cùng một bộ tệp tin
- Quản lý tập trung: Dữ liệu được quản lý và Sao lưu tập trung, giảm thiểu rủi ro mất dữ liệu
- Hỗ trợ đa nền tảng: Hoạt được trên nhiều hệ điều hành như: Linux, Unix và Windows
### Nhược điểm
- Hiệu suất: Hiệu suất có thể bị ảnh hưởng bởi tốc độ và độ tin cậy của mạng
- Bảo mật: NFS không có các tính năng bảo mật mạnh mẽ như một số hệ thống chia sẻ tệp khác, dễ bị tấn công nếu không được cấu hình đúng
- Phụ thuộc vào mạng: Khả năng truy cập vào tệp tin phụ thuộc vào tình trạng của mạng

## Thực tế và một số giao thức tương tự NFS
### Thực tế
Trong thực tế, người ta thường dùng NFS khi ở trong môi trường Unix, Linux. Đặc biệt là khi cần hiệu suất cao, tính linh hoạt và tính toàn vẹn dữ liệu

### Một số giao thức tương tự NFS
- **SMB/CIFS** (Server Message Block/Common Internet File System): SMB/CIFS là một giao thức chia sẻ tệp tin phổ biến trong các môi trường Windows và được hỗ trợ bởi nhiều hệ điều hành khác nhau. Nó cho phép người dùng chia sẻ tệp tin và thư mục giữa các máy tính trong mạng LAN hoặc qua Internet.
- **AFP** (Apple Filing Protocol): AFP là giao thức chia sẻ tệp tin được phát triển bởi Apple và được sử dụng chủ yếu trong môi trường macOS và hệ thống file sharing giữa các máy tính Mac.
- **FTP/SFTP** (File Transfer Protocol/SSH File Transfer Protocol): FTP và SFTP là các giao thức truyền tải tệp tin thông qua mạng Internet. FTP không bảo mật, trong khi SFTP sử dụng SSH để mã hóa dữ liệu và xác thực, làm cho nó trở thành lựa chọn an toàn hơn.
- **WebDAV** (Web Distributed Authoring and Versioning): WebDAV là một giao thức mở rộng HTTP cho phép người dùng tạo, sửa đổi và xóa tệp tin trên máy chủ từ xa. Nó thường được sử dụng cho việc quản lý tài liệu trên các hệ thống web và điện toán đám mây.

# Thực hành
Sử dụng NFS trên Ubuntu22

Mô hình thực hành trên 2 máy Ubuntu và Centos 9 như sau:

![](/Anh/Screenshot_654.png)
## Cài đặt NFS
Mặc định, NFS sẽ không được cài sẵn trên Ubuntu22 và Centos9. Bạn có thể thực hiện như sau để cài đặt:
Cài đặt trên Ubuntu22
```
# Cập nhật
sudo apt update
sudo apt upgrade

# Cài đặt NFS
sudo apt install -y nfs-kernel-server

# Kiểm tra trạng thái dịch vụ
sudo systemctl status nfs-kernel-server
```

Cài đặt trên Centos9
```
# Cập nhật
sudo yum update
sudo yum upgrade

# Cài đặt NFS
sudo yum install -y nfs-utils

# Kiểm tra trạng thái dịch vụ
systemctl status nfs-utils
```
## Cấu hình NFS để chia sẻ
### Cấu hình bên phía Server
Tạo thư mục để tiến hành chia sẻ, thực hiện cấp quyền:
```
sudo mkdir -p /mnt/shared
sudo chown nobody:nogroup /mnt/shared
sudo chmod 777 /mnt/shared
```
Chỉnh sửa nội dung trong file `/etc/exports` như sau
```
/mnt/shared 192.168.1.0/24(rw,sync,no_subtree_check)
```
Áp dụng cấu hình
```
sudo exportfs -ra
```
```
# Khởi động lại dịch vụ NFS
sudo systemctl restart nfs-kernel-server

# Kiểm tra trạng thái
sudo systemctl status nfs-kernel-server
```
```
# Mở cổng trên FireWall
sudo ufw allow nfs
```
### Cấu hình bên phía Client
Tạo thư mục Mount
```
sudo mkdir -p /mnt/nfs_shared
```
Mount thư mục NFS
```
sudo mount 192.168.217.130:/mnt/shared /mnt/nfs_shared
```
Kiểm tra việc Mount
```
df -h /mnt/nfs_shared
```
![](/Anh/Screenshot_673.png)

### Kiểm tra
Trên Server

![](/Anh/Screenshot_674.png)

Trên Client
- Tạo File thử nghiệm
```
sudo touch /mnt/nfs_shared/testfile
```
- Kiểm tra sự tồn tại của File trên Server

![](/Anh/Screenshot_675.png)

