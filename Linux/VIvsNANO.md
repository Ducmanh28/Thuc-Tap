# Trình soạn thảo văn bản trong Linux

Cũng tương tự như ở Desktop có Notepad hay Word (các trình soạn thảo văn bản nổi tiếng) thì tương tự Linux cũng có cho mình các trình soạn thảo văn bản. Ở đây, phổ biến nhất là 2 trình soạn thảo VIM/VI và NANO

Notepad hay Notepad++ ở Desktop làm được những gì thì VIM/VI và NANO ở server cũng sẽ làm được như thế.

Ta tiến hành đi tìm hiểu chi tiết về 2 trình soạn thảo văn bản này

## NANO
### Tổng quát:
- GNU Nano là một trình soạn thảo văn bản dòng lệnh dễ sử dụng cho các hệ điều hành Unix và Linux. 
- Bao gồm tất cả các chức năng cơ bản của một trình soạn thảo văn bản thông thường.
- Ở Nano, các thao tác được đưa vào các phím tắt và các phím mũi tên, không dùng chuột và đồ họa
### Kiểm tra phiên bản và cài đặt NANO:
- Để cài đặt NANO trên Ubuntu Server:
  - `sudo apt install nano`
- Để cài đặt NANO trên CentOS 7:
  - `yum install nano`
  - Tiến hành cài
  - ![](/Anh/Screenshot_147.png)
  - Bấm `y` sau đó bấm `Enter`
  - Cài đặt hoàn thành:
  - ![](/Anh/Screenshot_148.png)
- Để kiểm tra xem NANO có tồn tại trên máy chưa và nếu có thì đang ở phiên bản nào:
  - `nano --version`
  - Như thế này là chưa cài đặt NANO
  - ![](/Anh/Screenshot_146.png)
  - Như thế này là đã cài đặt và có phiên bản
  - ![](/Anh/Screenshot_149.png)

### Cách dùng NANO:
Không giống như các trình soạn thảo văn bản trên DeskTop, ở NANO, mọi thao tác của các bạn đều sử dụng các *tổ hợp phím* để làm việc với dữ liệu và các *phím mũi tên* để di chuyển
#### Để mở một file dùng NANO:
- Rất đơn giản, ta chỉ cần nhập `nano [tên file]` hoặc `nano [đường dẫn đến file]`
- Nếu như file đó chưa tồn tại, NANO sẽ thực hiện tạo mới file có tên đã nhập
- Thao tác này sẽ mở ra 1 cửa sổ mới và bạn sẽ làm việc trên cửa sổ này.
- VD: Nhập `nano new_file.txt` để tạo 1 file mới 
- Màn hình làm việc sẽ hiển thị ra như sau:
- ![](/Anh/Screenshot_150.png)
#### Các phím tắt chính, hay sử dụng:
`^G` nghĩa là bấm `Ctrl G`: Tổ hợp phím này cho phép chúng ta xem toàn bộ các tổ hợp phím, phím tắt và định nghĩa của các tổ hợp phím ấy trong NANO

Bảng **Help** sẽ hiện ra với rất nhiều tổ hợp phím tắt cùng với định nghĩa:
![](/Anh/Screenshot_151.png)

Một số lưu ý:
- Ở đây:
  - Cột đầu tiên sẽ hiển thị tổ hợp phím:
    - `^G` nghĩa là bấm `Ctrl G`
    - `M-\` nghĩa là bấm `Alt \`
  - Cột thứ 2 sẽ hiển thị các phím tắt hoặc tổ hợp khác có thể dùng
  - Cột cuối cùng sẽ hiển thị định nghĩa các tổ hợp phím hay phím tắt đấy dùng để làm gì.
  
Tiến hành dùng thử :

##### Ctrl O
- Dùng để lưu file hiện tại vừa chỉnh sửa mà không thoát khỏi NANO
- Hoặc dùng để ghi đè nội dung file hiện tại lên một file khác 
- VD:
- Tôi có 1 file txt có tên "new_file.txt" với nội dung như sau. Tôi đã sử dụng lệnh `cat new_file.txt` để thực hiện việc đọc nội dung file:
- ![](/Anh/Screenshot_153.png)
- Bây giờ tôi sẽ dùng NANO để thực hiện chỉnh sửa file và `Ctrl O` để lưu file thử
- Truy cập vào file bằng NANO sử dụng câu lệnh: `nano new_file.txt`
- Thực hiện nhập vào 1 dòng như sau:
- ![](/Anh/Screenshot_154.png)
- Sau khi bấm `Ctrl O`, khung thông báo và các tùy chọn sẽ được hiện ra:
- ![](/Anh/Screenshot_155.png)
- Sẽ có 2 trường hợp xảy ra:
  - Bạn muốn lưu file: Chỉ cần viết đúng tên file hiện tại(Để nguyên mặc định và bấm `Enter`)
  - Bạn muốn ghi đè lên 1 file khác: Nhập tên file bạn muốn ghi đè
  - VD: Tôi* sẽ ghi đè lên file *new_file.txt~*
    - File *new_file.txt~* đang có nội dung như sau:  
    - ![](/Anh/Screenshot_152.png)
    - Sau khi thực hiện ghi đè:
    - ![](/Anh/Screenshot_156.png)
    - Sử dụng lệnh `cat new_file.txt~` và nội dung file đã thay đổi 
    - ![](/Anh/Screenshot_157.png)