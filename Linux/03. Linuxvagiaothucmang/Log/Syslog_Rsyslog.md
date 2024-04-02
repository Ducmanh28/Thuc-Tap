# Mục này tìm hiểu giao thức Syslog và ứng dụng Rsyslog
Trước khi tìm hiểu về Syslog và Rsyslog, chúng ta cần hiểu Log là gì?
## Log
### Log là gì? Dùng để làm gì?
Log Systems hay Log File là một tệp tin hoặc một phần của hệ thống ghi lại các sự kiện, hoạt động và thông tin khác liên quan đến hoạt động của một ứng dụng, hệ thống máy tính hoặc thiết bị. 

Đối với Linux, các file log này sẽ chứa các thông báo về máy chủ, bao gồm kernel, dịch vụ và các ứng dụng đang chạy trên nó. File log sẽ cung cấp thời gian của các sự kiện cho hệ điều hành, ứng dụng và hệ thống Linux. Nó đóng vai trò là một công cụ quan trọng giúp chúng ta kiểm tra và khắc phục sự cố.

Mỗi ứng dụng được cài trên hệ thống đều có cơ chế tạo ra log khác nhau. Trên Linux thì nơi lưu trữ các file log thường nằm ở trong đường dẫn `var/log`, nó sẽ chứa hầu hết các file log như:
- **access log**: File log truy cập
- **error log**: File log lỗi
- **app log**: File log của các ứng dụng
- **service log**: File log của các dịch vụ
- **system log**: File log hệ thống
- .......
### Cấu trúc cơ bản của một log:
Cấu trúc của một log file thường bao gồm các mục sau:
- Time: Thời gian xảy ra sự kiện
- LogLevel: Loại sự kiện
- Source: Ứng dụng hoặc thành phần gây ra sự kiện
- Message: Nội dung Log
- Và một số thông tin bổ sung khác như: thông tin người dùng, dữ liệu kỹ thuật,... tùy theo loại sự kiện và ứng dụng mà các thông tin này sẽ được hiển thị

### Một số file log trong thư mục `/var/log`
Thư mục `/var/log` là nơi gần như chứa hầu hết các file log. Để truy cập vào thư mục này và hiển thị tất cả các file log, chúng ta làm như sau:
```
ducmanh287@ubuntusv:~$ cd /var/log
ducmanh287@ubuntusv:~$ ls -a
```
![](/Anh/Screenshot_527.png)

Một số file log thông dụng trong thư mục này:
- `messages`: Đây là một trong những file log chính trên hệ thống Linux. Nó chứa các thông điệp hệ thống tổng quát từ các ứng dụng và dịch vụ trên hệ thống. 
  - Thông thường, ở Ubuntu sẽ không có file này, thay vào đó Ubuntu sẽ sử dụng file `syslog` để lưu trữ các thông điệp hệ thống. Tuy nhiên, tùy vào phiên bản Ubuntu mà file `messages` sẽ được cài đặt
  - Nội dung file `messages` trên CentOS 9 cơ bản sẽ trông như sau:

![](/Anh/Screenshot_528.png)
- `syslog`: Syslog hay cũng có thể được hiểu là Systemlog, đây là nơi chứa các thông điệp từ kernel và các ứng dụng của hệ thống. Nó sẽ cung cấp thông tin chi tiết về hoạt động của hệ thống và các sự kiện liên quan đến hệ thống

![](/Anh/Screenshot_529.png)
- `auth.log`: Hay chính là Authentication, đây là nơi chứa các thông tin liên quan đến xác thực và quản lý người dùng, bao gồm các hoạt động như: đăng nhập, đăng xuất, cũng như là các thay đổi quyền truy cập

![](/Anh/Screenshot_530.png)
- `secure`: File log này chứ các thông tin về xác thực trên hệ thống. Và có thể lưu trữ tất cả các thông tin liên quan đến bảo mật, các lỗi xác thực. 
  - Đối với Ubuntu thường không mặc định tồn tại file này, file tương đương với File này trên Ubuntu chính là `auth.log`
  - Nội dung file trên CentOS 9 sẽ trông như sau:

![](/Anh/Screenshot_531.png)
- `boot.log`: Lưu trữ tất cả thông tin liên quan đến khởi động và mọi thông báo được ghi lại trong quá trình khởi động bao gồm tập lệnh khởi tạo hệ thống, /etc/init.d/bootmisc.sh,…
- `kern.log`: Chứa các thông điệp log từ kernel của hệ thống, bao gồm các thông báo lỗi và cảnh báo từ kernel.
- `dmesg`: Chứa các thông điệp log về quá trình khởi động của kernel và các thông báo liên quan đến phần cứng.
- `cron`: File log này chứa các thông điệp từ cron jobs, bao gồm các hoạt động được lên lịch tự động trên hệ thống.
- `wtmp`: Chứa tất cả các đăng nhập và đăng xuất lịch sử.
- `btmp`: Thông tin đăng nhập không thành công.
- `utmp`: Thông tin log trạng thái đăng nhập hiện tại của mỗi người dùng.
- ...........
## Syslog
### Syslog là gì? Dùng để làm gì?
**Syslog** là một giao thức và một chuẩn ghi log mà hầu hết các hệ điều hành Unix và Linx sử dụng để ghi log các thông điệp hệ thống. Nó cũng là tên của một dịch vụ hoặc tiến trình đang chạy trên hệ thống để ghi log theo giao thức syslog

**Syslog** sẽ chịu trách nhiệm cho việc ghi log các sự kiện hệ thống từ nhiều nguồn khác nhau, bao gồm kernel, các ứng dụng, dịch vụ, và các quá trình hệ thống khác. Nó là một cơ chế quan trọng để theo dõi và phân tích hoạt động của hệ thống, phát hiện lỗi và xác định các vấn đề bảo mật

**Syslog** hoạt động dựa trên mô hình gửi và nhận. Các bên gửi là các ứng dụng hoặc dịch vụ trên hệ thống gửi các thông điệp log đến một máy chủ syslog, thông thường sẽ chạy trên một máy hoặc trên một máy chủ log trung tâm. Máy chủ syslog sau đó có thể lưu trữ, phân tích, xử lý và chuyển tiếp các log theo cấu hình được thiết lập

Một số công dụng chính của Syslog có thể bao gồm: 
- Giám sát hệ thống
- Phát hiện lỗi, debug
- Bảo mật: Cung cấp thông tin về các sự kiện bảo mật
- Phân tích và thống kê các dữ liệu liên quan đến hệ thống
- ...

### Lịch sử hình thành và phát triển
Được phát triển vào năm 1980 bởi Eric Allman, là một phần của dự án **Sendmail**, ban đầu nó chỉ được sử dụng duy nhất cho **Sendmail**, lúc này, nó chỉ được thiết kế để cung cấp cơ chế ghi log đơn giản. Tuy nhiên, nó đã thể hiện rõ được giá trị của mình khiến cho các ứng dụng khác cũng bắt đầu sử dụng nó

Năm 1986, **Syslog** được Eric Allman thêm vào phiên bản **4.3BSD** của Sendmail và trở thành một dịch vụ ghi log chính thức trong hệ thống **BSD**. Tại thời điểm này, syslog đã trở thành 1 phần của các hệ điều hành Unix, Linux phổ biến

Sau 1986, **Syslog** được mở rộng và phát triển bởi cộng đồng Unix và Linux, cung cấp khả năng ghi log từ nhiều nguồn khác nhau trên hệ thống. Nó trở thành một công cụ quan trọng trong việc quản lý hệ thống và giám sát hoạt động của hệ thống.

Trong năm 2009, Internet Engineering Task Forec (IETF) đưa ra chuẩn *syslog* trong **RFC 5424**.
### Cấu trúc của Log trong Syslogs
Thông điệp log trong syslog thường chứa các thông tin quan trọng sau:

- **Thời gian**: Thời gian xảy ra sự kiện.
- **Mức độ quan trọng** (**log level**): Loại của sự kiện (ví dụ: debug, info, warning, error).
- **Nguồn** (**source**): Ứng dụng hoặc thành phần gây ra sự kiện.
- **Nội dung** (**message**): Mô tả chi tiết về sự kiện.

==> Cấu trúc này giúp cho việc đọc và phân tích log trở nên dễ dàng và rõ ràng.

### Định dạng tin nhắn của Syslog
Ví dụ một dòng Log:
```
Apr  2 08:17:01 ubuntusv CRON[31812]: (root) CMD (   cd / && run-parts --report /etc/cron.hourly)
``` 
- `Apr 2 08:17:01`: Đây là thời gian xảy ra sự kiện
- `ubuntusv`: Đây là tên máy chủ
- `CRON[31812]`: Đây là tên Process và số PID
- `root) CMD (   cd / && run-parts --report /etc/cron.hourly)`: Đây là nội dung thông báo

Các cấp độ facility Syslog:
|Facility Number|Nguồn tạo log|Ý nghĩa|
|---------------|-------------|-------|
|0|	kernel	|Những log mà do kernel sinh ra|
|1	|user	|Log ghi lại cấp độ người dùng|
|2|	mail	|Log của hệ thống mail|
|3	|daemon	|Log của các tiến trình trên hệ thống|
|4|	auth	|Log từ quá trình đăng nhập hệ hoặc xác thực hệ thống|
|5|	syslog|	Log từ chương trình syslogd|
|6	|lpr	|Log từ quá trình in ấn|
|7|	news	|Thông tin từ hệ thống|
|8	|uucp	|Log UUCP subsystem|
|9|	solaris-cron	|Clock deamon|
|10|	authpriv	|Quá trình đăng nhập hoặc xác thực hệ thống|
|11	|ftp	|Log của FTP deamon|
|12|	ntp	|Log từ dịch vụ NTP của các subserver|
|13|	security	|Kiểm tra đăng nhập|
|14|	console	|Log cảnh báo hệ thống|
|15	|cron	|Log từ clock daemon|
|16 - 23|	local 0 -local 7|	Log dự trữ cho sử dụng nội bộ|

Các mức cảnh báo:
|Code|	Mức cảnh báo|	Ý nghĩa|
|----|--------------|--------|
|0	|emerg	|Thông báo tình trạng khẩn cấp|
|1	|alert	|Hệ thống cần can thiệp ngay|
|2	|crit	|Tình trạng nguy kịch|
|3|	error|	Thông báo lỗi đối với hệ thống|
|4	|warn	|Mức cảnh báo đối với hệ thống|
|5|	notice|	Chú ý đối với hệ thống|
|6	|info	|Thông tin của hệ thống|
|7	|debug|	Quá trình kiểm tra hệ thống|

### Cách thức hoạt động
Thu thập Log từ nhiều nguồn khác nhau

Xử lý và lọc Log: Xử lý và lọc log theo các severity level, lọc theo nguồn, hoặc các tiêu chí khác để lưu trữ các thông điệp log cần thiết

Lưu trữ Log: Các thông điệp log lúc này sẽ được lưu trữ trong các tệp log hoặc ghi vào cơ sở dữ liệu log, tùy thuộc vào cấu hình của hệ thống

Chuyển tiếp Log: Syslog có khả năng chuyển tiếp các thông điệp Log đến các máy chủ syslog từ xa hoặc các dịch vụ giám sát Log từ xa để phân tích và quản lý

## RSyslog
### Là gì?
Là một hệ thống quản lý log phổ biến trên hệ điều hành Linux. Nó được cải tiến của syslog, với nhiều tính năng và hiệu suất tốt hơn. 

Rsyslog sử dụng giao thức syslog để giao tiếp và truyền tải các thông điệp log giữa các máy chủ syslog và các thiết bị ghi log khác nhau trên mạng. 

Rsyslog có khả năng giao tiếp sử dụng cả UDP và TCP và còn hỗ trợ cả các phiên bản mới nhất của giao thức syslog để đảm bảo tính tương thích và hiệu suất tốt nhất khi truyền tải dữ liệu log trên mạng
### Các tính năng chính
Thu thập log: Cho phép thu thập các thông điệp log từ nhiều nguồn khác nhau trên hệ thống, bao gồm kernel, ứng dụng, dịch vụ và quá trình hệ thống khác

Xử lý log: Có khẳ năng xử lý và lọc các thông điệp log theo các tiêu chí mà người dùng đề ra

Lưu trữ log: Có thể lưu trữ các thông điệp log vào các tệp cục bộ hoặc ghi vào cơ sở dữ liệu log, giúp người quản trị 

Chuyển tiếp log: Chuyển tiếp các thông điệp log đến các máy chủ syslog từ xa 

Hỗ trợ các tính năng bảo mật như mã hóa log, xác thực và kiểm soát truy cập

Cung cấp các công cụ giám sát và báo cáo log để theo dõi và phân tích hoạt động và hiệu suất của hệ thống 

### Cấu trúc của RSyslog
**Input Modules**:
- Mô đun đầu vào là các thành phần của Rsyslog cho phép thu thập các thông điệp từ log từ các nguồn khác nhau trên hệ thống. 
- Rsyslog cung cấp nhiều input modules khác nhau, bao gồm:
  - `imuxsock`: Thu thập log từ Unix socket
  - `imklog`: Thu thập log từ kernel
  - `imfile`: Thu thập log từ các tệp log
  - `imtcp` và `imudp`: Thu thập log qua TCP và UDP
  - Và còn nhiều Input khác nữa.

**Message Modification and Filtering**:
- Rsyslog cung cấp các công cụ để sửa đổi và lọc log dựa trên các tiêu chí như:
  - Log level
  - Message
  - Source,...
- Điều này cho phép người quản lý điều chỉnh thông điệp log trước khi lưu trữ hoặc chuyển tiếp

**Output Modules**
- Là các thành phần của Rsyslog cho phép lưu trữ hoặc chuyển tiếp các thông điệp log đến các đích đến khác nhau. 
- Rsyslog hỗ trợ nhiều output modules, bao gồm: 
  - `omfile`: Lưu trữ log vào các tệp log cục bộ 
  - `omfwd`: Chuyển tiếp log đến máy chủ syslog từ xa
  - `omelasticsearch` và `omkafka`: Gửi log đến Elasticsearch hoặc kafka
  - `omstdout`: In thông điệp log ra STDOUT
  - Và nhiều output modules khác.

**Action Queue**: Rsyslog hỗ trợ hàng đợi hành động để xử lý thông điệp log một cách hiệu quả và đảm bảo không gây mất mát dữ liệu trong trường hợp tải cao hoặc lỗi hệ thống

**Configuration Files**: Cấu hình của Rsyslog thường được lưu trữ trong các tệp cấu hình, trong đó:
- `/etc/rsyslog.conf`: Là tệp cấu hình chính của Rsyslog
- `/etc/rsyslog.d`: Thư mục chứa tệp cấu hình bổ sung

### Tìm hiểu về file cấu hình của Rsyslog
Có 2 file cấu hình mà chúng ta cần tìm hiểu
#### File cấu hình chính
Tại file này, bạn có thể cấu hình thiết lập toàn cục và các thiết lập chung cho Rsyslog. Nó chứa các cấu hình như định nghĩa các đường dẫn đến các tệp log, các quy tắc lọc và xử lý log, cấu hình kết nối mạng và nhiều thiết lập khác.

Nội dung file cấu hình chính trông như sau:
```
module(load="imklog" permitnonkernelfacility="on") 
# Kích hoạt module `imklog`. Tham số permitnonkernelfacility="on" cho phép Rsyslog thu thập các thông điệp log từ các facility không phải là kernel.


$ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat
# Thiết lập mẫu mặc định cho các tệp log được tạo ra bởi Rsyslog

$RepeatedMsgReduction on
#  Bật chế độ giảm thông điệp lặp lại

$FileOwner syslog               # Thiết lập chủ sở hữu của các tệp log
$FileGroup adm                  # Thiết lập nhóm quyền
$FileCreateMode 0640            # Thiết lập quyền truy cập cho các tệp log mới được tạo
$DirCreateMode 0755             # Thiết lập quyền truy cập cho các thư mục chứa tệp log mới được tạo
$Umask 0022                     # Thiết lập umask mặc định cho các quyền truy cập vào tệp log và thư mục chứa chúng
$PrivDropToUser syslog          # Thiết lập user và group mà Rsyslog sẽ thực hiện việc giảm quyền truy cập khi hoạt động
$PrivDropToGroup syslog         # ...

$WorkDirectory /var/spool/rsyslog   # Định nghĩa thư mục làm việc cho Rsyslog

$IncludeConfig /etc/rsyslog.d/*.conf    # Định nghĩa thư mục chứa các tệp cấu hình phụ (*.conf)
```