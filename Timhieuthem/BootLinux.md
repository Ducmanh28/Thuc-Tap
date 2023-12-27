# Tìm hiểu quá trình Boot Linux
MỤC LỤC
- [Tìm hiểu quá trình Boot Linux](#tìm-hiểu-quá-trình-boot-linux)
  - [Tổng quát quá trình](#tổng-quát-quá-trình)
  - [Giải thích chi tiết hơn từng thành phần trong từng quá trình:](#giải-thích-chi-tiết-hơn-từng-thành-phần-trong-từng-quá-trình)
    - [BIOS/UEFI là gì?](#biosuefi-là-gì)
      - [Tìm hiểu về BIOS](#tìm-hiểu-về-bios)
      - [Tìm hiểu về UEFI](#tìm-hiểu-về-uefi)
      - [So sánh giữa BIOS và UEFI:](#so-sánh-giữa-bios-và-uefi)
    - [BootDevice là gì](#bootdevice-là-gì)
    - [GRUB Boot Loader là gì](#grub-boot-loader-là-gì)
  - [Execute systemd first process in user space là gì](#execute-systemd-first-process-in-user-space-là-gì)
    - [Systemd là gì?](#systemd-là-gì)
  - [".target" file và Startup scripts](#target-file-và-startup-scripts)


## Tổng quát quá trình
- ![](/Anh/Screenshot_186.png)

- Khởi Động Máy Tính: Bước đầu tiên khi khởi động máy tính là bật nguồn
- BIOS/UEFI: BIOS (Basic Input/Output System) hoặc UEFI (Unified Extensible Firmware Interface) được tải từ bộ nhớ không biến mất và chạy POST (Power-On Self-Test). POST là quá trình kiểm tra phần cứng cơ bản của máy tính để đảm bảo rằng tất cả đều hoạt động đúng
- Phát Hiện Thiết Bị: BIOS/UEFI sau đó phát hiện các thiết bị phần cứng của máy tính
- Chọn Thiết Bị Khởi Động: Người dùng chọn thiết bị để khởi động, thường là ổ đĩa cứng chứa hệ điều hành 
- GRUB Boot Loader: GRUB (GRand Unified Bootloader) được khởi động. GRUB là một trình khởi động cho phép bạn chọn giữa nhiều hệ điều hành và phiên bản kernel khác nhau
  - Đọc /etc/grub2.cfg: GRUB đọc cấu hình từ file này để biết kernel nào cần tải và các tùy chọn khởi động khác
  - Thực Thi Kernel: Kernel Linux được tải và chạy. Kernel là lõi của hệ điều hành, quản lý tất cả các tài nguyên hệ thống
  - Tải Thư Viện Hỗ Trợ: Các thư viện cần thiết được tải để hỗ trợ các chức năng của kernel
- Thực Thi Quá Trình Đầu Tiên Trong Không Gian Người Dùng: Hệ thống chạy systemd, quá trình đầu tiên trong không gian người dùng
- Chạy File .target và Script Khởi Động: Các file .target như default.target, multi-user.target, basic.target, getty.target và các dịch vụ như ssh.service được chạy, cùng với các script khởi động như /systemd-logind, /etc/profile, /.bashrc. 
  - Các file .target đại diện cho một trạng thái mà bạn muốn hệ thống đạt được sau khi khởi động 
  - Các script khởi động là các đoạn mã được thực thi trong quá trình khởi động hệ thống
- Đăng Nhập: Sau khi tất cả các dịch vụ cần thiết đã được khởi động, người dùng có thể đăng nhập vào hệ thống
## Giải thích chi tiết hơn từng thành phần trong từng quá trình:
### BIOS/UEFI là gì?
#### Tìm hiểu về BIOS
- BIOS hay Basic Input/Output System: là một loại firmware được lưu trữ trên một chip trên bo mạch chủ của máy tính
  - firmware là "một loại chương trình máy tính cung cấp kiểm soát mức thấp cho phần cứng cụ thể của thiết bị
- BIOS chịu trách nhiệm cho việc khởi động phần cứng của máy tính, đảm bảo chúng hoạt động đúng cách và sau đó chạy trình tải khởi động hệ điều hành. BIOS cũng sẽ thực hiện một kiểm tra tự động khi khởi động POST trước khi khởi động hệ điều hành
  - POST hay Power On Self Test: là một loạt các kiểm tra mà máy tính của bạn thực hiện khi bạn bật nó. Quá trình POST đảm bảo rằng tất cả các phần cứng được kết nối đúng cách và hoạt động đúng trước khi tải hệ điều hành. Nếu phát hiện lỗi, POST sẽ thông báo dưới dạng: 
    - đèn LED nhấp nháy
    - tiếng bíp 
    - thông báo trên màn hình
- BIOS hoạt động như sau:
  - Đầu tiên, BIOS kiểm tra thông tin được lưu trữ trong một lượng nhỏ RAM(64 byte) nằm trên một chíp bán dẫn kim loại(CMOS). Cài đặt CMOS sẽ cung cấp thông tin chi tiết đặc biệt cho hệ thống của bạn và có thể được thay đổi khi hệ thống thay đổi
    - CMOS là con chip máy tính nằm trên bảng mạch hay cụ thể hơn là chip RAM, nghĩa là thường nó sẽ mất đi các thiết lập đã lưu trữ khi tắt máy tính. Tuy vậy, pin CMOS được dùng để cung cấp nguồn điện ổn định cho con chip.Khi máy tính khởi động lần đầu, BIOS lấy thông tin từ CMOS để hiểu được các thiết lập phần cứng, thời gian…
  - Sau đó, BIOS tải các trình xử lý ngắt và các trình điều khiển thiết bị. 
    - Trình xử lý ngắt là các phần mềm nhỏ hoạt động như các bộ dịch giữa các thành phần cứng và hệ điều hành
    - Trình điều khiển thiết bị là những phần mềm nhận dạng các thành phần cứng cơ bản như bàn phím, chuột, ổ cứng, ổ đĩa mềm,...
  - Cuối cùng, BIOS tải trình tải khởi động hoặc hệ điều hành
- BIOS bao gồm: 
  - Firmware: 
  - Trình xử lý ngắt
  - Trình điều khiển thiết bị
- Nếu không có BIOS, máy tính sẽ không thể khởi động và không thể tải được hệ điều hành. BIOS là một thành phần quan trọng trong máy tính để máy có thể hoạt động đúng cách

#### Tìm hiểu về UEFI
- UEFI hay Unified Extensible Firmware Interface: là một phần mềm cấp thấp bắt đầu hoạt động khi bạn khởi động máy tính trước khi hệ điều hành khởi động. 
- UEFI hoạt động tương tự như một hệ điều hành nhỏ, cung cấp các tính năng như Secure Boot, có khả năng kết nối mạng,,,
- Khi máy tính được khởi động, UEFI sẽ khởi tạo và kiểm tra các phần cứng của hệ thống. Sau đó, tải trình khởi động từ một thiết bị lưu trữ hàng loạt hoặc thông qua kết nối mạng
- UEFI bao gồm: 
  - Dịch vụ khởi động: Xác định cách phần cứng khởi tạo phần mềm hoặc hệ điều hành để tải
  - Dịch vụ thời gian chạy: Bỏ qua bộ xử lý khởi động và tải các ứng dụng trực tiếp từ UEFI
- UEFI tương tự như BIOS, nếu không có nó, máy tính sẽ không thể khởi động. Tuy nhiên ta có thể lựa chọn 1 trong 2 phiên bản để sử dụng tùy theo nhu cầu cá nhân

#### So sánh giữa BIOS và UEFI:
- Ngôn ngữ: BIOS được viết bằng Assembler, trong khi UEFI được viết bằng ngôn ngữ C đơn giản hơn.
- Ổ được hỗ trợ: UEFI hỗ trợ ổ cứng HDD và SDD lớn hơn. Giới hạn kích thước lý thuyết của UEFI đối với ổ có khả năng boot là hơn 9 zettabyte, trong khi BIOS chỉ có thể boot từ ổ 2,2 terabyte hoặc nhỏ hơn.
- Driver: UEFI có driver phức tạp nhưng rời rạc, trong khi BIOS sử dụng driver trong ROM tùy chọn (bộ nhớ chỉ đọc). Với BIOS, việc cập nhật phần cứng yêu cầu điều chỉnh lại các ROM để tương thích. Thông số kỹ thuật này áp dụng cho các driver UEFI có thể nâng cấp, được ghi riêng.
- Thời gian boot: Trong hầu hết các trường hợp, UEFI cung cấp thời gian boot hệ điều hành nhanh hơn.
- Bảo mật: UEFI cung cấp các tính năng bảo mật được cải thiện. Secure Boot ngăn máy tính boot từ các ứng dụng chưa được ký hoặc trái phép. Hệ điều hành phải chứa một key có thể nhận dạng được. Nếu không bật Secure Boot, - PC sẽ dễ bị phần mềm độc hại làm hỏng quá trình khởi động.
- Trình xử lý dữ liệu: UEFI chạy ở chế độ 32-bit hoặc 64-bit. BIOS chỉ chạy ở chế độ 16-bit và chỉ có thể sử dụng 1MD của bộ nhớ thực thi.
- GUI: UEFI cung cấp giao diện người dùng đồ họa trực quan hơn mà bạn có thể điều hướng bằng chuột và bàn phím, không giống như BIOS.
- BIOS là lựa chọn lý tưởng nếu bạn không yêu cầu kiểm soát quá chặt chẽ cách máy tính của mình hoạt động.
- BIOS cũng đủ nếu bạn chỉ có ổ hoặc phân vùng nhỏ. Mặc dù nhiều ổ cứng mới hơn vượt quá giới hạn 2 terabyte của BIOS, nhưng không phải người dùng nào cũng yêu cầu dung lượng đó.
- Tính năng Secure Boot của UEFI có thể dẫn đến việc các nhà sản xuất OEM ngăn người dùng cài đặt hệ điều hành khác trên phần cứng của họ. Nếu gắn bó với BIOS, bạn phải giải quyết vấn đề này.
- BIOS cung cấp quyền truy cập vào thông tin phần cứng trong giao diện, trong khi không phải mọi triển khai của UEFI đều làm được như vậy. Tuy nhiên, thông số kỹ thuật phần cứng có thể truy cập được trong hệ điều hành

==> Qua những so sánh trên, bạn sẽ biết rõ được nên dùng UEFI hay BIOS. Để kiểm tra máy tính cá nhân đang sử dụng phiên bản nào, bạn đơn giản truy cập vào  `Start` --> Tìm kiếm `System Infomation` --> `System Sumary` --> `Bios mode`
![](/Anh/Screenshot_187.png)

### BootDevice là gì
- Là bất kỳ thiết bị lưu trữ phần cứng nào chứa các tệp mà máy tính cần để khởi động.
- Nó có thể là một ổ đĩa cứng, ổ đĩa mềm, ổ CD-ROM, ổ DVD hay ổ USB
- Khi máy tính khởi động, nó sẽ tìm kiếm thiết bị khởi động và nạp hệ điều hành từ đó. 
- Nếu không có thiết bị khởi động nào được tìm thấy, máy tính sẽ không thể khởi động

### GRUB Boot Loader là gì
- GRUB hay GRand Unified Bootloader là một chương trình khởi động máy tính được phát triển bởi dự án GNU
- GRUB cung cấp cho người dùng một lựa chọn cho phép người dùng khởi động một trong nhiều hệ điều hành được cài trên một máy tính hoặc lựa chọn một cấu hình cụ thể ó sẵn trên các phân vùng của một hề điều hành cụ thể
- Các tính năng của GRUB:
  - Hỗ trợ nhiều hệ điều hành - bằng cách khởi động trực tiếp nhân hệ điều hành hoặc bằng cách nạp chuỗi(chain-loading)
  - Hỗ trợ nhiều hệ thống tập tin(BSD, DOS FAT16 và FAT32, Minix fs, Linux ext2fs và ext3fs, ReiserFS, JSF, XFS, và VSTa fs)
  - Cung cấp giao diện dòng lệnh linh hoạt lẫn giao diện menu, đồng thời cũng hỗ trợ tập tin cấu hình
- Có 2 phiên bản của GRUB đang được sử dụng phổ biến:
  - GRUB Legacy: chỉ phổ biến ở các phiên bản cũ của các bản phân phối Linux, trong đó có một số vẫn đang được sử dụng và hỗ trợ như CentOS 5
  - GRUB 2: Được viết lại từ phiên bản đầu và có ý định thay thế phiên bản đầu. Hiện nay, phiên bản này được sử đụng đa số trên các bản phân phối Linux
- Cách hoạt động của GRUB:
- ![](/Anh/Screenshot_188.png)
- Quá trình hoạt động của GRUB Boot Loader có thể được phân tích thành các bước sau:
  - **Giai đoạn 1 (Stage 1)**: Giai đoạn này được cài đặt vào MBR (Master Boot Record) hoặc vào sector khởi động của phân vùng. Giai đoạn 1 mã hoá vị trí của Giai đoạn 2 hoặc Giai đoạn 1.5 ở dạng danh sách khối, nên nó không hiểu bất cứ cấu trúc hệ thống tập tin nào.
  - **Giai đoạn 1.5 (Stage 1.5)**: Giai đoạn này là cầu nối giữa Giai đoạn 1 và Giai đoạn 2. Giai đoạn 1.5 được Giai đoạn 1 nạp và Giai đoạn 1.5 nạp Giai đoạn 2. Giai đoạn 1.5 hiểu một hệ thống tập tin, cho phép Giai đoạn 2 có thể được nạp từ một hệ thống tập tin bằng đường dẫn thông thường mà không cần phải dùng danh sách khối.
  - **Giai đoạn 2 (Stage 2)**: Giai đoạn này được đặt trên một hệ thống tập tin. Giai đoạn 2 có thể nạp tập tin cấu hình từ bất cứ nơi đâu trên đĩa cứng
  - ==> Tất cả công việc mà Giai đoạn 1 phải làm là tải Giai đoạn 2 hoặc Giai đoạn 1.51. Một số phần cứng cần bước trung gian để nạp Giai đoạn 2, chẳng hạn như khi phân vùng /boot nằm ở vị trí quá 1024 cylinder đầu của ổ cứng hoặc khi sử dụng chế độ LBA1

- Có 2 cách để cài GRUB làm trình khởi động cho máy tính:
  - Dùng môi trường nguyên thủy của GRUB: cần tạo usb hoặc đĩa khởi động GRUB
  - Cài đặt môi trường hệ điều hành UNIX: sử dụng `grub-install` hoặc `shell grub`. Tuy nhiên cách này có thể khiến chúng ta thăm dò sai BIOS

## Execute systemd first process in user space là gì
- Hiểu đơn giản nghĩa là nó sẽ bắt đầu khởi chạy **systemd**, quá trình đầu tiên trong không gian người dùng sau khi **kernel** đã được tải từ GRUB
- Từ đó, systemd tiếp quản và bắt đầu khởi động các dịch vụ hệ thống khác cần thiết để đưa hệ thống lên và hoạt động. Điều này bao gồm như dịch vụ mạng, trình quản lý đăng nhập, và bất kỳ dịch vụ nào khác cần thiết cho hệ thống hoạt động. Systemd khởi động các dịch vụ này song song, thay vì tuần tự như với hệ thống init truyền thống, cho phép hệ thống khởi động nhanh hơn và phản hồi nhanh hơn
- Một khi tất cả các dịch vụ cần thiết đã được khởi động, hệ thống sẵn sàng để sử dụng và trình quản lý đăng nhập được hiển thị, cho phép người dùng đăng nhập và bắt đầu sử dụng hệ thống. Systemd tiếp tục chạy ở nền, quản lý và kiểm soát các dịch vụ hệ thống khi cần. Điều này cho phép hệ thống duy trì ổn định và phản hồi ngay cả khi các dịch vụ hệ thống đang được khởi động, dừng lại, hoặc được chỉnh sửa

### Systemd là gì?
- Systemd hay System daemon, là chương trình để quản lý hệ thống, chạy dưới nền(chạy ngầm)
- Nó là một nhóm các chương trình đặc biệt sẽ quản lý, vận hành và theo dõi các tiến trình khác hoạt động
- Systemd đóng vai trò quan trọng trong quá trình khởi động hệ thống
- Systemd cung cấp một chương trình đặc biệt là `/sbin/init` và nó sẽ là chương trình đầu tiên được khởi động trong hệ đống(PID=1). Và khi hoạt động, `/sbin/init` sẽ giữ vai trò kích hoạt các file cấu hình cần thiết cho hệ thống. 
- Các thành phần của Systemd:
  - `systemctl`: dùng để quản lý trạng thái của các dịch vụ hệ thống (bắt đầum kết thúc, khởi động lại hoặc kiểm tra trạng thái hiện tại)
  - `journald`: dùng để quản lý nhật ký hoạt động của hệ thống(hay còn gọi là ghi log)
  - `logind`: dùng để quản lý và theo dõi việc đăng nhập/ đăng xuất của người dùng
  - `networkd`: dùng để quản lý các kết nối mạng thông qua các cấu hình mạng
  - `timedated`: dùng để quản lý thời gian hệ thống hoặc thời gian mạng
  - `udev`: dùng để quản lý các thiết bị và firmware
- Unit File: Tất cả các chương trình được quản lý bởi systemd đều được thực thi dưới dạng daemon hay background bên dưới nền và được cấu hình thành 1 file configuration gọi là unit file. Các unit file này sẽ bao gồm 12 loại:
  - service: các file quản lý hoạt động của 1 số chương trình
  - socket: quản lý các kết nối
  - device: quản lý thiết bị
  - mount: gắn thiết bị
  - automount: tự đống gắn thiết bị
  - swap: vùng không gian bộ nhớ trên đĩa cứng
  - target: quản lý tạo liên kết
  - path: quản lý các đường dẫn
  - timer: dùng cho cron-job để lập lịch
  - snapshot: bản sao lưu
  - slice: dùng cho việc quản lý tiến trình
  - scope: quy định không gian hoạt động 
- Nhưng quan trọng nhất có lẽ là service. Loại này sẽ được khởi động khi bật máy và luôn chạy ở chế độ nền. Các service thường sẽ được cấu hình trong các file riêng biệt và được quản lý thông qua câu lệnh systemctl

## ".target" file và Startup scripts
- Việc chạy 2 mục này liên quan đến cách hệ thống khởi động và quản lý các dịch vụ hệ thống
- `.target` file: Trong systemd, một file `.target` đại diện cho một trạng thái mà bạn muốn hệ thống đạt được sau khi khởi động.
  - Multi-user.target là một trạng thái mà hệ thống sẽ khởi động vào chế độ đa người dùng
  - graphical.target: sẽ khởi động hệ thống vào chế độ đồ họa
  - Nói chung các file `.target` giúp tổ chức các dịch vụ và các nhóm dịch vụ lại với nhau, giúp cho việc quản lý quá trình khởi động trở nên dễ dàng hơn
- `Startup Scripts`: là các đoạn mã được thực thi trong quá trình khởi động hệ thống, các scripts này có thể thực hiện nhiều tác vụ khác nhau, từ việc khởi động các dịch vụ hệ thống đến việc thực hiện các tác vụ quản lý như kiểm tra không gian đĩa hoặc tạo bản sao lưu
