# Tìm hiểu quá trình Boot Linux

## Hiểu đơn giản quá trình
- ![](/Anh/Screenshot_186.png)

- Bước 1: **Power On** - Khi máy tính được bật lên, quá trình khởi động bắt đầu.
- Bước 2: **BIOS/UEFI** - BIOS hoặc UEFI được tải từ bộ nhớ không biến mất và thực hiện POST để kiểm tra phần cứng và phát hiện các thiết bị kết nối.
- Bước 3: **Choose a Boot Device** - Người dùng hoặc hệ thống chọn thiết bị khởi động, như ổ cứng hoặc USB.
- Bước 4: **GRUB Boot Loader** - GRUB được tải và đọc cấu hình từ /etc/grub2.cfg, sau đó thực hiện kernel và tải các thư viện hỗ trợ.
- Bước 5: **Execute systemd first process in user space** – systemd, quy trình đầu tiên trong không gian người dùng, được thực thi để khởi động các dịch vụ hệ thống.
- Bước 6 và 7: **Run .target Files and Startup Scripts** - Các file .target và script khởi đầu như /etc/profile và ~/.bashrc được chạy để thiết lập môi trường người dùng.
- Bước 8: **Users Can Login Now** - Quá trình khởi động hoàn tất và người dùng có thể đăng nhập vào hệ thống.

## Giải thích những chỗ vướng mắc:
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