MỤC LỤC:
- [Trình soạn thảo văn bản trong Linux](#trình-soạn-thảo-văn-bản-trong-linux)
  - [1. NANO](#1-nano)
    - [1.1 Tổng quát:](#11-tổng-quát)
    - [1.2 Kiểm tra phiên bản và cài đặt NANO:](#12-kiểm-tra-phiên-bản-và-cài-đặt-nano)
    - [1.3 Cách dùng NANO:](#13-cách-dùng-nano)
      - [1.4 Để mở một file dùng NANO:](#14-để-mở-một-file-dùng-nano)
      - [1.5 Các phím tắt chính, hay sử dụng:](#15-các-phím-tắt-chính-hay-sử-dụng)
        - [1.5.1 Ctrl O](#151-ctrl-o)
        - [1.5.2 Ctrl R](#152-ctrl-r)
        - [1.5.3 Ctrl Y và Ctrl V:](#153-ctrl-y-và-ctrl-v)
        - [1.5.4 Copy, Cut và Paste](#154-copy-cut-và-paste)
        - [1.5.5 Ctrl C](#155-ctrl-c)
        - [1.5.6 Ctrl W](#156-ctrl-w)
        - [1.5.7 Thao tác Select All](#157-thao-tác-select-all)
  - [VIM/VI](#vimvi)

# Trình soạn thảo văn bản trong Linux

Cũng tương tự như ở Desktop có Notepad hay Word (các trình soạn thảo văn bản nổi tiếng) thì tương tự Linux cũng có cho mình các trình soạn thảo văn bản. Ở đây, phổ biến nhất là 2 trình soạn thảo VIM/VI và NANO

Notepad hay Notepad++ ở Desktop làm được những gì thì VIM/VI và NANO ở server cũng sẽ làm được như thế.

Ta tiến hành đi tìm hiểu chi tiết về 2 trình soạn thảo văn bản này

## 1. NANO
### 1.1 Tổng quát:
- GNU Nano là một trình soạn thảo văn bản dòng lệnh dễ sử dụng cho các hệ điều hành Unix và Linux. 
- Bao gồm tất cả các chức năng cơ bản của một trình soạn thảo văn bản thông thường.
- Ở Nano, các thao tác được đưa vào các phím tắt và các phím mũi tên, không dùng chuột và đồ họa
### 1.2 Kiểm tra phiên bản và cài đặt NANO:
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

### 1.3 Cách dùng NANO:
Không giống như các trình soạn thảo văn bản trên DeskTop, ở NANO, mọi thao tác của các bạn đều sử dụng các *tổ hợp phím* để làm việc với dữ liệu và các *phím mũi tên* để di chuyển
#### 1.4 Để mở một file dùng NANO:
- Rất đơn giản, ta chỉ cần nhập `nano [tên file]` hoặc `nano [đường dẫn đến file]`
- Nếu như file đó chưa tồn tại, NANO sẽ thực hiện tạo mới file có tên đã nhập
- Thao tác này sẽ mở ra 1 cửa sổ mới và bạn sẽ làm việc trên cửa sổ này.
- VD: Nhập `nano new_file.txt` để tạo 1 file mới 
- Màn hình làm việc sẽ hiển thị ra như sau:
- ![](/Anh/Screenshot_150.png)
#### 1.5 Các phím tắt chính, hay sử dụng:
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

##### 1.5.1 Ctrl O
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

##### 1.5.2 Ctrl R
Tiếp theo tôi sẽ nói đến chức năng đọc file. Để kiểm tra chức năng này, tôi sẽ thực hiện như sau:
- Trước tiên, tạo một file mới với tên "*testtext.txt*" sử dụng NANO. Thực hiện bằng cách dùng câu lệnh: `nano testtext.txt`
- ![](/Anh/Screenshot_158.png)
- Sau khi bấm `Ctrl R`, bảng thông báo và các options hiện ra:
- ![](/Anh/Screenshot_159.png)
- Tôi chọn `CTRL T` để thực hiện việc lựa chọn file
- ![](/Anh/Screenshot_160.png)
- Thực hiện chọn file *new_file.txt~*
- Ngay lúc này, nội dung file *new_file.txt* đã được hiện ra trên file *testtext.txt*
- ![](/Anh/Screenshot_161.png)

##### 1.5.3 Ctrl Y và Ctrl V:
Hai tổ hợp phím này chỉ đơn giản dùng cho việc di chuyển giữa các trang

##### 1.5.4 Copy, Cut và Paste
- Có lẽ chức năng thiết yếu nhất mà 1 trình soạn thảo văn bản nên có chính là khả năng Copy-Paste của nó
- Đối với Word hay Vim hay NANO, mỗi ứng dụng đều có những cách riêng để thực hiện các thao tác này
- Ta cùng đi thực hiện dùng thử khẳ năng này ở NANO
- Đối với NANO, việc COPY và Paste sẽ hơi phức tạp một chút
- Sẽ có thêm một vài tổ hợp phím mà bạn cần phải nhớ để thực hiện chức năng Copy.
  - `Ctrl 6` để thực hiện việc Mark điểm đầu của đoạn dữ liệu mà bạn muốn copy
  - ![](/Anh/Screenshot_162.png)
  - Di chuyển con trỏ đến nơi cuối cùng của đoạn dữn liệu mà bạn muốn copy bằng các phím mũi tên
  - ![](/Anh/Screenshot_163.png)
  - Sau khi hoàn thành, `Alt 6` để thực hiện việc copy đoạn dữ liệu
- Đối với việc Paste dữ liệu sẽ đơn giản hơn.
  - Chọn nơi bạn cần Paste sau đó bấm tổ hợp phím `Ctrl U` để hoàn thành việc Paste
  - ![](/Anh/Screenshot_164.png)
- Đối với việc Cut. Bạn cũng có thể bôi đen vùng dữ liệu cần Cut, sau đó bấm `Crl K` để cut và `Ctrl U`để paste vùng dữ liệu ấy
##### 1.5.5 Ctrl C
- Đừng nhầm khi sử dụng Windows hay các phiên ản desktop rằng `Ctrl C` là copy và `Ctrl V` là Paste dữ liệu
- Ở trong NANO, `Ctrl C` sẽ show ra vị trí con trỏ hiện tại.
- Sau khi bấm `Ctrl C`, bảng thông báo sẽ hiện ra với các nội dung chỉ rõ vị trí nơi con trỏ đang ở như số dòng, số cột,...
- ![](/Anh/Screenshot_165.png)

##### 1.5.6 Ctrl W
- Chức năng tìm kiếm và thay thế có lẽ cũng là 1 yếu tố quan trọng cần thiết trong các ứng dụng soạn thảo văn bản
- Với tổ hợp phím `Ctrl W`, ta sẽ có thể thực hiện thao tác tìm kiếm và thay thế(nếu cần)
- ![](/Anh/Screenshot_166.png)
- Ngay sau khi bạn bấm `Enter`, con trỏ sẽ ngay lập tức trỏ tới vị trí đầu tiên chứa từ mà bạn tìm kiếm
- Và nếu bạn muốn bật chức năng tìm kiếm và thay thế, hãy bấm thêm `Ctrl R` 
- ![](/Anh/Screenshot_167.png)
- Sẽ có các lựa chọn như:
  - Thay thế tất cả (`A`)
  - Thay thế từ đầu tiên tìm được (`Y`)
  - Tôi sẽ thử thay thế tất cả để thấy rõ quá trình
  - ![](/Anh/Screenshot_168.png)
  - Ta đã thấy, các kí tự **text** đã được thay thế bằng **nomore** (Kể cả chữ **texts** cũng được thay bằng **nomores**)
##### 1.5.7 Thao tác Select All
- Theo như tôi tìm hiểu được, thao tác Select All này cũng không quá phức tạp để có thể thực hiện được.
- Ví dụ bạn muốn Select All dữ liệu đã nhập vào:
  - B1: `Alt \` để đưa con trỏ về đầu trang
  - B2: `Ctrl ^` để Mark vị trí con trỏ
  - B3: `Alt /` để đưa con trỏ tới cuối trang
- Với 3 bước đơn giản này, bạn đã hoàn thành việc Select All dữ liệu
- Khi này, bạn có thể chọn xóa nhanh bằng cách bấm `Ctrl K` hoặc Copy bằng cách bấm `Alt ^`...

## VIM/VI