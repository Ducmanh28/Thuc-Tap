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
  - [2. VIM/VI](#2-vimvi)
    - [2.1 Tổng quát:](#21-tổng-quát)
    - [2.2 Kiểm tra phiên bản và cài đặt VIM](#22-kiểm-tra-phiên-bản-và-cài-đặt-vim)
    - [2.3 Các chế độ của VIM](#23-các-chế-độ-của-vim)
    - [2.4 Một số thao tác cơ bản trong các chế độ:](#24-một-số-thao-tác-cơ-bản-trong-các-chế-độ)
      - [2.4.1 Insert mode](#241-insert-mode)
      - [2.4.2 Normal mode](#242-normal-mode)
      - [2.4.3 Visual Mode](#243-visual-mode)

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

## 2. VIM/VI
### 2.1 Tổng quát:
- Vi là một trình chỉnh sửa dành cho Linux, Unix và các hệ điều hành giống Unix khác. Vi là viết tắt của visual instrument. 
- Nó là một trình soạn thảo văn bản mặc định được sử dụng rộng rãi cho các hệ thống dựa trên Unix và đi kèm với tất cả các phiên bản Unix. 
- Nó chỉ sử dụng bàn phím và cung cấp một giao diện rất hiệu quả để chỉnh sửa những chương trình và script.
- So với một chương trình xử lý text chung chung, VI được điều chỉnh cho phù hợp với một cấu hình cụ thể hơn về cách sử dụng và người dùng - những người lập trình của các hệ thống dựa trên UNIX.
-  VI không cung cấp bất kỳ khả năng định dạng nào.
-  VIM là phiên bản nâng cấp của VI(VI Improved)
### 2.2 Kiểm tra phiên bản và cài đặt VIM
- VI đã được tích hợp sẵn trong CentOS7 hoặc Ubuntu
- Để cài đặt VIM, bạn nhập:
  - `sudo yum install vim` trên CentOS 7
  - `sudo apt-get vim` trên Ubuntu
- Để kiểm tra version, giống như với NANO, bạn nhập: `vim --version`

### 2.3 Các chế độ của VIM
- Khác với các trình soạn thảo văn bản Linux truyền thống, VIM tuân theo triết lí UNIX, chỉ làm một việc và làm thật tốt. VIM cung cấp các chế độ để người dùng làm việc. Bao gồm:
  - Normal mode: Là chế độ mặc định khi bạn bắt đầu vào VIM. Trong chế độ này, có thể thực hiện các thao tác như di chuyển con trỏ, thay thế văn bản, cắt, sao chép, dán, xóa,... 
  - Insert mode: Là chế độ cho phép bạn chèn văn bản vào trong tệp giống như hầu hết các trình soạn thảo văn bản khác. Có thể chuyển từ chế độ khác sang chế độ chèn bằng cách bấm các phím như `a,i,o` hoặc `A,I,O`
  - Visual mode: Chế độ này cho phép chọn đoạn văn bản để thực hiện các thao tác như cắt, sao chép, dán, xóa,...Để vào được chế độ này, ta nhập `v` từ bàn phím
  - Command mode: Chế độ này cho phép nhập vào các lệnh. Gõ `:` ở chế độ bình thường để có thể vào chế độ lệnh

### 2.4 Một số thao tác cơ bản trong các chế độ:
#### 2.4.1 Insert mode
- Thao tác chèn văn bản vào 1 tệp là một thao tác cơ bản mà trình soạn thảo nào cũng phải có.
- Để vào **Insert mode** từ **Normal mode**, ta thực hiện bấm phím `a,o,i` để có thể vào chế độ chèn. 
- Để thoát chế độ chèn, quay về **Normal mode**, ta chỉ đơn giản bấm `Esc` từ bàn phím
- Khi nào thì sử dụng `a,o,i` hoặc `A,O,I`
  - Dùng `i`, sẽ chèn văn bản ngay tại vị trí con trỏ
  - Dùng `o`, sẽ chèn văn bản ngay dưới dòng chứa con trỏ
  - Dùng `a`, để nối văn bản sau con trỏ
  - Dùng `I`, để chèn văn bản vào đầu dòng hiện tại
  - Dùng `O`, để chèn văn bản ngay trên dòng chứa con trỏ
  - Dùng `A`, để thêm văn bản vào cuối dòng

#### 2.4.2 Normal mode
- Đây là chế độ mặc định của VIM. Khi vào VIM, chế độ này là chế độ hiện ra đầu tiên. 
- Đây cũng là chế độ mà ta sẽ sử dụng nhiều nhất trong VIM
- Nhần phím `Esc` ở một chế độ mất kì để có thể trở về **Normal mode**
- Thay vì dùng các phím mũi tên tiêu chuẩn như các trình soạn thảo văn bản khác, VIM sử dụng các phím `h,j,k,l` để thực hiện di chuyển con trỏ
  - `h` sẽ dịch con trỏ sang bên trái
  - `j` sẽ dịch con trỏ xuống dưới
  - `k` sẽ dịch con trỏ lên trên
  - `l` sẽ dịch con trỏ sang bên phải
  - Nhưng ta cũng có thể dùng các phím mũi tên nếu không quen với thao tác này
- Một số thao tác cơ bản trong Normal mode:
  - `w` sẽ di chuyển con trỏ đến đầu từ tiếp theo
  - `b` sẽ di chuyển con trỏ đến đầu từ hiện tại
  - `e` sẽ di chuyển con trỏ đến cuối từ hiện tại
  - `0` sẽ di chuyển con trỏ đến đầu dòng hiện tại
  - `$` sẽ di chuyển con trỏ đến cuối dòng hiện tại
  - `H` sẽ đưa con trỏ lên đầu văn bản
  - `M` sẽ đưa con trỏ đến giữa văn bản
  - `L` sẽ đưa con trỏ đến cuối cùng văn bản
  - Có thể kéo lên, kéo xuống bằng cách bấm tổ hợp `Ctrl U` và `Ctrl D`'
  - Bấm `gg` để di chuyển con trỏ lên trên cùng và `G` để di chuyển con trỏ xuống cuối cùng
  - Sử dụng `x` để xóa một ký tự
  - `s` để thay thế
  - Xóa văn bản bằng cách sử dụng toán tử `d`
    - `dw` sẽ xóa từ hiện tại
    - `d$` sẽ xóa từ cuối cho đến vị trí con trỏ của dòng
    - `d0` sẽ xóa từ đầu cho tới vị trí con trỏ
    - `dd` để xóa toàn bộ dòng
  - Toán tử `c` cho phép thực hiện các thay đổi mà không cần vào **Insert mode** 
    - `cw`, VIM sẽ xóa từ hiện tại và đưa bạn vào chế độ chèn để thay thế từ đó
    - `ciw` thực hiện thay đổi bên trong từ hiện tại
    - `cc` để thay đổi toàn bộ dòng
  - Sử dụng toán tử `y` để thực hiện các sao chép
    - `yw` để sao chép từ hiện tại
    - `yy` để sao chép toàn bộ dòng
  - Sử dụng `p` để dán những gì có trong clipboard
  - Lặp lại lệnh trước đó bằng cách sử dụng `.` 
  - Hoàn tác sử dụng `u` và thực hiện lại chúng sử dụng `Ctrl U`
  - Và còn nhiều thao tác khác nữa...
#### 2.4.3 Visual Mode
- Chế độ này cho phép ta chọn một đoạn trong cả văn bản để có thể thực hiện các thao tác như cắt, sao chép, dán,...
  - Có thể bấm `Ctrl V` để vào chế độ khối trực quan