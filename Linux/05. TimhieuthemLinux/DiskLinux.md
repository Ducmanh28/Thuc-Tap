# Mục này tìm hiểu các thông số liên quan đến ổ cứng

## Một số khái niệm liên quan đến ổ cứng

**Latency** : Là thời gian cần thiết để ổ cứng phản hồi một yêu cầu Input hoặc Output. 
- Độ trễ tổng cộng được chia thành:
  - Seek Time: Thời gian để đầu đọc/ghi di chuyển đến vị trí cụ thể trên bề mặt đĩa
  - Rotational Latency: Thời gian cần để đĩa quay đến đúng vị trí mà dữ liệu cần đọc/ghi được đặt
  - Command Overhead: Thời gian xử lý lệnh: Thời gian cần để xử lý và chuẩn bị cho việc đọc hoặc ghi
  - Data Transfer Time: Thời gian để thực sự truyền dữ liệu giữa ổ cứng và hệ thống
- Đơn vị đo: Milliseconds(ms), microseconds đối với ổ SSD
- Ý nghĩa: Độ trễ càng thấp thì ổ cứng phản hồi càng nhanh, cải thiện hiệu suất tổng thể của hệ thống

**IOPS** (Input/Output Operations Per Second): Đo lường khẳ năng của ổ cứng trong việc xử lý các yêu cầu nhập xuất trong một giây. Nó bao gồm các hoạt động đọc và ghi.
- Đơn vị đo: actions/s
- Yếu tố ảnh hưởng: IOPS phụ thuộc vào nhiều yếu tố như kích thước khối dữ liệu, mẫu truy cập(ngẫu nhiên hay tuần tự), và loại thiết bị
- Ý nghĩa: IOPS cao nghĩa là ổ cứng có thể xử lý nhiều yêu cầu I/O hơn trong cùng một khoảng thời gian, điều này đặc biệt quan trọng đối với các hệ thống cần xử lý nhiều tác vụ động thời, chẳng hạn như là 1 máy chủ Database

**Bandwidth** (Băng thông): Là tốc độ tối đa mà dữ liệu có thể được truyền từ hoặc đến ổ cứng trong 1 khoảng thời gian xác định. 
- Đơn vị đo: Mb/s hoặc Gb/s
- Ý nghĩa: Băng thông càng cao thì tốc độ truyền dữ liệu càng nhanh. Điều này quan trọng đối với các ứng dụng cần xử lý hoặc truyền tải lượng dữ liệu lớn, chăng hạn như video chất lượng cao, sao lưu dữ liệu, ....

Một số khái niệm khác như:
- **Capacity**(Dung lượng): Khả năng lưu trữ tối đa mà ổ cứng có thể lưu trữ, thường sẽ đo bằng GB hoặc TB
- **Access Speed**(Tốc độ truy cập): Là thời gian mà ổ cứng cần để truy cập và đọc hoặc ghi dữ liệu. Thường được đo bằng đơn vị (ms) hoặc (ns)
- **Sequential Read/ Write Speed**(Tốc độ đọc/ghi tuần tự): Tốc độ tối đa mà ổ cứng có thể đọc và ghi dữ liệu liên tục. Thương được đo bằng (Mb/s) 
- **Random Read/ Write Speed**(Tốc độ đọc/ghi ngẫu nhiên): Đo bằng số lần đọc/ghi trên 1 giây(IOPS)
- **Cache**: Số lượng bộ nhớ cache trên ổ cứng, giúp cải thiên tốc độ truy cập dữ liệu tạm thời
- **Reliability/Lifespan**: Tuổi thọ dự kiến của ổ cứng, thường được đo bằng giờ hoạt động(MTBF)
- **Interface**: Loại cổng giao tiếp mà ổ cứng sử dụng để kết nối với máy tính. Có thể là: SATA, NVMe, USB,...
- **Drive Type**: Có thể là ổ HDD hoặc SSD
- **Form Factor**: Kích thước ổ cứng: 2.5 inch, 3.5 inch, M.2,...
- **Rotational Speed**(Tốc độ quay): Tốc độ quay của đĩa trong ổ cứng, đo bằng vòng quay mỗi phút (RPM). Ổ cứng có tốc độ quay cao hơn (như 7200 RPM so với 5400 RPM) thường có hiệu suất tốt hơn.
- **Seek Time**(Thời gian tìm kiếm): Thời gian trung bình cần thiết để đầu đọc/ghi di chuyển đến vị trí cần thiết trên đĩa, đo bằng milliseconds (ms).


## Thực hành đo tốc độ ổ cứng
### Hướng dẫn cài đặt và sử dụng HD Sentinal
Tải file từ trang web chính của HD Sentinal tại [đây](https://www.hdsentinel.com/download.php)

Có thể giải nén trên PC, sau đó sử dụng SFTP gửi sang máy Linux, hoặc chuyển trực tiếp file zip sang máy Linux và thực hiện Unzip

Hoặc tải trưc tiếp file zip từ máy Ubuntu: 
```
wget https://www.hdsentinel.com/hdslin/hdsentinel-020b-x64.zip
```

Sử dụng:
- Giải nén, cấp quyền chạy cho file
```
unzip hdsentinel-020b-x64.zip

chmod +x HDSentinal
```
Một số tùy chọn:
- **-h**: Hiển thị thông tin trợ giúp và hướng dẫn sử dụng.
- **-r [report file]**: Tự động lưu báo cáo vào tệp được chỉ định. Nếu không có tệp được chỉ định, báo cáo sẽ được lưu vào tệp report.txt theo mặc định.
- **-html**: Sử dụng cùng với -r để lưu báo cáo dưới định dạng HTML.
- **-mht**: Sử dụng cùng với -r để lưu báo cáo dưới định dạng MHT.
- **-autosd**: Tự động nhận dạng loại thẻ nhớ SD công nghiệp và lưu tệp cờ. Xem thêm chi tiết trong hướng dẫn "How to: monitor (micro) SD card health and status".
- **-dev /dev/sdX**: Chỉ định một thiết bị cụ thể để phân tích, không truy cập vào các thiết bị khác.
- **-devs d1,d2**: Phát hiện các thiết bị được chỉ định (cách nhau bằng dấu phẩy) ngoài các thiết bị mặc định.
- **-onlydevs d1,d2**: Phát hiện chỉ các thiết bị được chỉ định (cách nhau bằng dấu phẩy), không phát hiện các thiết bị mặc định.
- **-nodevs d1,d2**: Loại bỏ phát hiện của các thiết bị được chỉ định (cách nhau bằng dấu phẩy), không phát hiện các thiết bị này.
- **-dump**: In báo cáo ra stdout (có thể sử dụng cùng với -xml để in ra định dạng XML thay vì văn bản).
- **-xml**: Tạo và lưu báo cáo dưới định dạng XML thay vì TXT.
- **-solid**: Đầu ra cố định, bao gồm thông tin về ổ đĩa, nhiệt độ (Celsius), sức khỏe (%), giờ bật, mô hình, S/N, kích thước.
- **-verbose**: Thông tin phát hiện chi tiết và lưu các tệp tạm thời (chỉ cho mục đích gỡ lỗi).
- **-aam**: Hiển thị cài đặt quản lý âm thanh hiện tại và khuyến nghị (nếu có).
- **-setaam drive_num|ALL level(hex)80-FE|QUIET|LOUD**: Đặt cấp độ âm thanh trên ổ đĩa hoặc tất cả các ổ đĩa. Hex từ 80 đến FE hoặc các giá trị QUIET hoặc LOUD có thể được sử dụng.


Ví dụ đầu ra khi khởi chạy:
```
root@MANH-U22-Server:/home/suncloud/ducmanh# ./HDSentinel
Hard Disk Sentinel for LINUX console 0.20b-x64.10851 (c) 2023 info@hdsentinel.com
Start with -r [reportfile] to save data to report, -h for help

Examining hard disk configuration ...

HDD Device  0: /dev/sda
HDD Model ID : VMware  Virtual disk
HDD Serial No: ?
HDD Revision : 2.0
HDD Size     : 16383 MB
Interface    : SCSI
Temperature  : Unknown °C
Highest Temp.: Unknown °C
Health       : Unknown %
Performance  : Unknown %
Power on time:
Est. lifetime:
```
### Hướng dẫn sử dụng các câu lệnh của Linux để thực hiện kiểm tra các ổ cứng, phân vùng và thực hiện đo tốc độ
#### List ra danh sách các ổ cứng
Chúng ta có thể sử dụng một số câu lệnh như sau để kiểm tra:
```
lsblk
```
- Lệnh này sẽ hiển thị danh sách các ổ đĩa và các phân vùng tương ứng
- Mẫu kết quả khi khởi chạy:
```
root@MANH-U22-Server:/home/suncloud/ducmanh# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0                       7:0    0 63.9M  1 loop /snap/core20/2264
loop1                       7:1    0 63.9M  1 loop /snap/core20/2318
loop2                       7:2    0   87M  1 loop /snap/lxd/27948
loop3                       7:3    0   87M  1 loop /snap/lxd/28373
loop4                       7:4    0 38.7M  1 loop /snap/snapd/21465
loop5                       7:5    0 38.8M  1 loop /snap/snapd/21759
sda                         8:0    0   16G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0  1.8G  0 part /boot
└─sda3                      8:3    0 14.2G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 14.2G  0 lvm  /
```
- loop devices: Được sử dụng để gắn các ứng dụng snap.
- sda: Thiết bị đĩa chính, có các phân vùng sda1, sda2, sda3.
- LVM: sda3 chứa một logical volume `ubuntu--vg-ubuntu--lv` được gắn kết tại thư mục gốc 

Hoặc đơn giản, bạn tìm kiếm các chỉ mục `sd...` trong `/dev/`
```
ls /dev/sd*
```
### Đo tốc độ với dd
Đơn giản nhất để đo tôc độ, các bạn sử dụng lệnh dd:
```
# Đo tốc độ đọc:
sudo dd if=/dev/sda of=/dev/null bs=1M count=1000

# Đo tốc độ ghi:
sudo dd if=/dev/zero of=/dev/sda bs=1M count=1000
```
Giải mã câu lệnh:
- if: Tệp nguồn
- of: Tệp đích
- bs: kích thước khối dữ liệu
- count: số lượng khối dữ liệu được sao chép hoặc ghi

Tóm lại, câu lệnh này sẽ tạo ra một tệp dữ liệu trống có kích thước 1000 megabytes và ghi nó vào ổ đĩa vật lý được chỉ định. Trong quá trình này, mọi dữ liệu hiện tại trên ổ đĩa sẽ bị ghi đè. Điều này thường được sử dụng để kiểm tra hiệu suất của ổ đĩa hoặc xóa dữ liệu một cách an toàn.

## Đo tốc độ sử dụng công cụ fio
fio là một công cụ được sử dụng để hiển thị các thông số liên quan đến ổ cứng

Cài đặt fio:
```
sudo apt-get install fio
```
Câu lệnh tổng quát:
```
sudo fio --name=... --filename=.... --rw=.... --bs=.... --iodepth=.... --size=.... --runtime=.... --time_based --end_fsync=....
```
- `--name`: Đặt tên cho quá trình thử nghiệm. Tên này sẽ được sử dụng để xác định quá trình thử nghiệm trong kết quả.
- `--filename`: Chỉ định thiết bị lưu trữ mà dữ liệu sẽ được đọc từ. 
- `--rw`: Xác định loại hoạt động I/O,(write) hoặc (read). Công cụ sẽ thực hiện các thao tác đọc trên thiết bị được chỉ định.
- `--bs`=: Đặt kích thước block dữ liệu. Đây là kích thước mặc định của một block dữ liệu.
- `--iodepth`=: Xác định số lượng công việc I/O được gửi đồng thời.
- `--size`: Đặt kích thước dữ liệu để đọc.
- `--runtime`: Đặt thời gian chạy của quá trình thử nghiệm.
- `--time_based`: Chỉ định rằng thời gian chạy được sử dụng thay vì kích thước dữ liệu để xác định khi nào kết thúc quá trình thử nghiệm.
- `--end_fsync=1`: Yêu cầu fio đảm bảo rằng tất cả các hoạt động ghi đã được đồng bộ hoàn toàn trước khi kết thúc thử nghiệm.

Ví dụ Câu lệnh test đọc:
```
sudo fio --name=read_test --filename=/dev/sda --rw=read --bs=4k --iodepth=64 --size=1G --runtime=60 --time_based --end_fsync=1
```
Kết quả đầu ra:

![](/Anh/Screenshot_717.png)

Đánh giá kết quả trên:
- Tốc độ đọc và IOPS:
  - Tốc độ đọc (read) đạt khoảng 582 MiB/s, đồng thời có khoảng 149k IOPS (Input/Output Operations Per Second). Đây là các chỉ số quan trọng đo lường khả năng xử lý dữ liệu của ổ đĩa.
  - Số liệu này cho thấy rằng hệ thống đang có hiệu suất đọc khá cao, có thể xử lý một lượng lớn dữ liệu một cách hiệu quả.
- Độ trễ:
  - Độ trễ trung bình (average latency) cho các hoạt động đọc là khoảng 6.50 microseconds, đồng nghĩa với việc thời gian phản hồi từ ổ đĩa là rất ngắn.
  - Độ biến động của độ trễ cũng khá thấp, điều này cho thấy rằng hệ thống đang duy trì được sự ổn định trong việc xử lý I/O.
- Chi phí tính toán (CPU Utilization):
  - Phần trăm sử dụng CPU trong quá trình thử nghiệm là 13.61% cho người dùng (usr) và 74.88% cho hệ thống (sys).
  - Điều này cho thấy mức độ tải CPU tương đối cao trong quá trình thử nghiệm, đặc biệt là với phần sử dụng hệ thống.

## BashScripts
