# Mục này show ra quá trình sử dụng Linux thực tế, kiến thức tìm hiểu được trong quá trình sử dụng trên Ubuntu Server
MỤC LỤC
- [Mục này show ra quá trình sử dụng Linux thực tế, kiến thức tìm hiểu được trong quá trình sử dụng trên Ubuntu Server](#mục-này-show-ra-quá-trình-sử-dụng-linux-thực-tế-kiến-thức-tìm-hiểu-được-trong-quá-trình-sử-dụng-trên-ubuntu-server)
  - [Basic Shorcuts(Các phím tắt cơ bản)](#basic-shorcutscác-phím-tắt-cơ-bản)
    - [Di chuyển con trỏ:](#di-chuyển-con-trỏ)
    - [Các thao tác với văn bản:](#các-thao-tác-với-văn-bản)
    - [Truy cập lịch sử:](#truy-cập-lịch-sử)
    - [Điều khiển Terminal:](#điều-khiển-terminal)
    - [Các kí tự đặc biệt:](#các-kí-tự-đặc-biệt)
  - [Các câu lệnh:](#các-câu-lệnh)
    - [Cơ bản với Linux:](#cơ-bản-với-linux)
      - [Phân tích cấu trúc 1 câu lệnh của Linux:](#phân-tích-cấu-trúc-1-câu-lệnh-của-linux)
      - [Các câu lệnh hỗ trợ hiểu biết về hệ thống:](#các-câu-lệnh-hỗ-trợ-hiểu-biết-về-hệ-thống)
      - [Các câu lệnh làm quen với chương trình:](#các-câu-lệnh-làm-quen-với-chương-trình)
      - [Trợ giúp của Linux:](#trợ-giúp-của-linux)
    - [Các câu lệnh làm việc](#các-câu-lệnh-làm-việc)
      - [Làm việc với File](#làm-việc-với-file)
        - [Làm việc với đường dẫn File](#làm-việc-với-đường-dẫn-file)
        - [Show ra danh sách file trong 1 thư mục](#show-ra-danh-sách-file-trong-1-thư-mục)
        - [Tạo, Sao chép, Xóa File hoăc Đường dẫn](#tạo-sao-chép-xóa-file-hoăc-đường-dẫn)
        - [Quyền tập tin/thư mục và nhóm Lệnh](#quyền-tập-tinthư-mục-và-nhóm-lệnh)
        - [In text ra màn hình:](#in-text-ra-màn-hình)
        - [Tìm kiếm tệp](#tìm-kiếm-tệp)
        - [Một số thao tác thêm với file](#một-số-thao-tác-thêm-với-file)
      - [Shell và làm việc với Shell](#shell-và-làm-việc-với-shell)


## Basic Shorcuts(Các phím tắt cơ bản)
### Di chuyển con trỏ:
- `Ctrl A`: Đưa con trỏ tới vị trí đầu dòng mà bạn đang nhập dữ liệu
  - Ví dụ khi nhập xong một câu lệnh, vị trí con trỏ sẽ ở cuối dòng nhưng sau khi bạn bấm `Ctrl A`, con trỏ sẽ quay trở về đầu dòng
  - ![](/Anh/Screenshot_189.png)
- `Ctrl E`: Đưa con trỏ tới vị trí cuối dòng mà bạn đang nhập dữ liệu
  - Ví dụ khi nhập một câu lệnh, nhưng phát hiện ở giữa có từ viết sai, bạn đưa con trỏ trở về vị trí sai để chỉnh sửa. Sau khi sửa xong, muốn quay về vị trí cuối dòng nhanh để tiếp tục viết thì có thể sử dụng `Ctrl E`
  -  ![](/Anh/Screenshot_190.png)
  -  Sau khi nhập `Ctrl E`
  -  ![](/Anh/Screenshot_191.png)
- `Ctrl X`: Bôi trắng khoảng giữa vị trí con trỏ trước và sau:
  - ![](/Anh/Screenshot_192.png)
- `Alt F`: Đưa con trỏ về phía trước 1 từ
- `Alt B`: Đưa con trỏ về phía sau 1 từ
- `Ctrl F`: Đưa con trỏ về phía trước 1 chữ cái
- `Ctrl B`: Đưa con trỏ về phía sau 1 chữ cái
### Các thao tác với văn bản:
- Tôi có 1 đoạn văn bản gốc như sau:
- ![](/Anh/Screenshot_193.png)
- `Ctrl U`: Cắt dòng từ vị trí con trỏ tới đầu dòng
- ![](/Anh/Screenshot_194.png)
- `Ctrl K`: Cắt dòng từ vị trí con trỏ tới cuối dòng
- ![](/Anh/Screenshot_195.png)
- `Ctrl Y`: Dán những văn bản trong Clipboard
- `Alt T`: Đổi vị trí 2 từ trước con trỏ 
- ![](/Anh/Screenshot_196.png)
- `Alt L`: Để dạng chữ in thường từ vị trí con trỏ đến cuối từ
- ![](/Anh/Screenshot_197.png)
- `Alt U`: Để dạng chữ in hoa từ vị trí con trỏ đến cuối từ
- ![](/Anh/Screenshot_198.png)
- `Alt C`: Viết hoa chữ cái tại vị trí con trỏ, sau đó đưa con trỏ đến cuối từ
- ![](/Anh/Screenshot_199.png)
- `Alt D`: Xóa phần còn lại của từ, bắt đầu từ vị trí con trỏ(Nếu vị trí con trỏ ở đầu từ, sẽ xóa toàn bộ từ)
- ![](/Anh/Screenshot_200.png)
- `Alt .`: In ra từ cuối cùng của câu lệnh ngay trước đó
- ![](/Anh/Screenshot_201.png)
- `Ctrl T`: Đổi vị trí 2 chữ cái trước con trỏ
- ![](/Anh/Screenshot_202.png)

### Truy cập lịch sử:
- `Ctrl R`: Cho phép bạn tìm kiếm thông qua các lệnh đã sử dụng trước đó.
- ![](/Anh/Screenshot_203.png)
- `Ctrl G`: Cho phép bạn hủy tìm kiếm mà không cần dùng lệnh
- `Ctrl J`: Có tác dụng như 1 phím Enter
- ![](/Anh/Screenshot_204.png)
- `Alt R`: Hoàn nguyên mọi thay đổi đối với lệnh bạn đã lấy từ lịch sử của mình, nếu bạn đã chỉnh sửa lệnh đó.
  - Khi bạn chạy 1 lệnh, lệnh đó sẽ được lưu trong History
  - Vd chạy lệnh `ip a`
  - ![](/Anh/Screenshot_205.png)
  - Bấm phím mũi tên lên để lấy lại lệnh đó trong lịch sử
  - ![](/Anh/Screenshot_206.png)
  - Thực hiện các chỉnh sửa, đổi lệnh thành `ip addr show`
  - ![](/Anh/Screenshot_207.png)
  - Bấm `Alt R`, lệnh sẽ trở về `ip a`
  - ![](/Anh/Screenshot_206.png)
- `Ctrl P`: Hoàn lại lệnh cuối cùng từng chạy(giống phím mũi tên lên)
- `Ctrl N`: Chỉ ra lệnh tiếp theo trong lịch sử lệnh đã chạy(giống phím mũi tên xuống)

### Điều khiển Terminal:
- `Ctrl L`: Làm sạch màn hình
- `Ctrl S`: Dừng màn hình hiển thị(Nhưng không dừng câu lệnh)
- `Ctrl Q`: Tiếp tục chạy màn hình hiển thị(khi đã bấm `Ctrl S` để dừng màn hình)
- `Ctrl C`: Dừng quá trình chạy lệnh và quay trở về nơi nhập lệnh
  - VD: `Ctrl C` dừng quá trình Ping: 
  - ![](/Anh/Screenshot_208.png)
- `Ctrl D`: Log out khỏi shell hiện tại
  - VD: Đang từ quyền Roots, Log out về quyền User:
  - ![](/Anh/Screenshot_209.png)
- `Ctrl Z`: Tạm dừng tiến trình hiện tại
  - ![](/Anh/Screenshot_210.png)
  - Với quá trình này, bạn có thể dùng lệnh `bg` để chương trình tiếp tục chạy trong nền. Nhưng lưu ý, tiến trình này sẽ chạy mãi, `Ctrl C` cũng không thể dừng
  - ![](/Anh/Screenshot_211.png)
  - ![](/Anh/Screenshot_212.png)
  - Để có thể dừng qúa trình này, bạn cần đưa nó thoát khỏi chạy nền bằng lệnh `fg`, sau đó mới có thể `Ctrl C` để dừng quá trình Ping
  - ![](/Anh/Screenshot_213.png)
- `Tab`: Để hoàn thành nốt câu lệnh
- `Tab Tab`: Để hiện thị các lệnh có thể có

### Các kí tự đặc biệt:
- `Ctrl + H` Giống như Backspace.
- `Ctrl + J` Giống như Return 
- `Ctrl + M` Giống như Return 
- `Ctrl + I` Giống như Tab.
- `Ctrl + G` Kí tự Bell
- `Ctrl + @` Kí tự Null
- `Esc` Giống `Alt`

## Các câu lệnh:
### Cơ bản với Linux:
#### Phân tích cấu trúc 1 câu lệnh của Linux:
- ![](/Anh/Screenshot_214.png)
- Command: Câu lệnh gì
- Options: Các điều kiện thêm vào
  - Bao gồm cả đường dẫn (`/etc`)
- Pipe: Đường ống
- Argument: Điều kiện
- ![](/Anh/Screenshot_215.png)

#### Các câu lệnh hỗ trợ hiểu biết về hệ thống:
- `id`: Cho biết bạn là ai
- ![](/Anh/Screenshot_216.png)
- `w` và `w -f`: Cho biết ai đang đăng nhập và đăng nhập ở đâu
- ![](/Anh/Screenshot_217.png)
- `lsblk`: Liệt kê các thiết bị lưu trữ
- `hostname`: Show ra host name
- `passwd`: Thay đổi mật khẩu của user hiện tại
- `last`,`last root`, `last tb`: show last
- ![](/Anh/Screenshot_218.png)
  - **NAME**: Tên thiết bị hoặc tên phân vùng
  - **MAJ:MIN**: Số lượng kernel được sử dụng để nhận dạng các thiết bị nội bộ
  - **RM**: Để nhận biết xem thiết bị có thể tháo rời hay không
    - *1* là có thể
    - *0* là không thể
  - **Size**: Dung lượng tối đa của thiết bị
  - **RO**: Mục này cho biết thiết bị có phải loại chỉ cho phép đọc hay không ?
    - *1* là phải
    - *0* là không phải
  - **Type**: Phân loại thiết bị
  - **Mount Points**: Thông tin về đường dẫn thiết bị hiện tại
- `lscpu`: Show thông tin về CPU
- ![](/Anh/Screenshot_219.png)
- `lstopo`: Show thông tin Topo phần cứng
- ![](/Anh/Screenshot_220.png)
- `free`: Show thông tin Memory
- ![](/Anh/Screenshot_221.png)
  - Total: Tổng dung lượng
  - Used: Đã sử dụng
  - Free: Còn trống
  - Shared: Dung lượng được chia sẻ
  - Buff/cache: Tổng dung lượng được sử dụng cho vùng lưu trữ tạm thời
  - Available: Dung lượng có sẵn để khởi động một tiến trình
- `lsb_release (-a)`: Hiện thông tin phân phối
- ![](/Anh/Screenshot_222.png)
- `uname`: Hay chính là viết tắt của unix-name
  - Cách dùng:  `uname [Options]`
  - ![](/Anh/Screenshot_258.png)
  - Các options:
    - `-a`: in ra tất cả thông tin
    - `-s`: in ra tên kernel
    - `-n`: in ra tên nốt mạng
    - `-r`: in ra bản phát hành kernel
    - `-v`: in ra phiên bản kernel
    - `-m`: in ra tên máy móc phần cứng
    - `-p`: in ra loại chương trình, hoặc ***unknown***
    - `-i`: in ra nền tảng phần cứng, hoặc ***unknown***
- Lưu ý:
  - `Ctrl C`: Để dừng lệnh đang chạy
  - `Which <cmdname>`: Để kiểm tra lệnh có tồn tại hay không

#### Các câu lệnh làm quen với chương trình:
- `ps`: Show ra danh sách các chương trình
- ![](/Anh/Screenshot_223.png)
  - Thường đi kèm với tùy chọn `aux`
  - ![](/Anh/Screenshot_224.png)
  - Hoặc `-ef` để hiện thị tất cả các tiến trình
  - ![](/Anh/Screenshot_225.png)
  - Hoặc `-f`, `-u` để hiện cá tiến trình với quyền root
  - ![](/Anh/Screenshot_226.png)
    - UID: User ID
    - PID: Process ID
    - PPID: Parent Process ID
    - C: CPU sử dụng của Process
    - STIME và TIME: Thời điểm và thời gian chạy của tiến trình
    - TTY:  Loại Terminal
    - CMD: Câu lệnh khởi tạo tiến trình
- `nice <options> <number> <name process>`: Chạy tiến trình với độ ưu tiên(number càng thấp, ưu tiên càng cao)
- Có thể sử dụng `top`, `htop` (htop sẽ phải cài đặt thêm), `atop`(atop cũng phải cài đặt thêm) để hiện các tiến trình rõ ràng hơn. Phần này sẽ giống như ***Task Manager*** ở trong Desktop
  - TOP: 
  - ![](/Anh/Screenshot_227.png)
    - Dòng đầu tiên sẽ hiển thị: 
      - Thời gian thực 
      - Thời gian hoạt động
      - Số user
      - Thông tin về [load average](https://blogd.net/linux/giai-thich-ve-loadavg-tren-linux/)
    - Dòng thứ 2:
      - Số tiến trình
      - Số tiến trình đang chạy
      - Số tiến trình đang ngủ
      - Số tiến trình đã dừng
      - Số tiến trình chạy ở chế độ zombie
    - Dòng thứ 3: Hiển thị về thông tin CPU
      - us: Thông tin người dùng
      - sy: Kernel
      - ni: Mức độ ưu tiên
      - id: Chế độ không tải
      - wa: Công việc đang chờ
      - hi: Ngắt phần cứng
      - si: Ngắt phần mềm
      - st - steal time: thường sử dụng với các máy ảo
    - Dòng 4 và 5: Hiển thị các thông tin về Memory như trong mục Free 
    - Thông tin chính trong các cột hiển thị:
      - PID: Process ID
      - User: Người sử dụng
      - PR: Mức độ ưu tiên
      - NI: Mức độ nice(gọi một tệp lệnh shell với độ ưu tiên cụ thể)
      - VIRT: Virtual
      - RES: Physical
      - SHR: Bộ nhớ chia sẻ
      - S - Status: Trạng thái
      - %CPU: Tỷ lệ % của CPU
      - %MEM: Tỷ lệ % của bộ nhớ được sử dụng
      - TIME+: Thời gian thực hiện
      - command: Câu lệnh sử dụng
  - `htop` và `atop` trình chiếu thông tin tương tự `top` nhưng sẽ đẹp hơn
- `kill <pid>`: Ngắt một tiến trình sử dụng pid của tiến trình đó

#### Trợ giúp của Linux:
- `man`: trong Linux `man` sẽ hiển thị hướng dẫn sử dụng ***manual*** của bất kỳ lệnh nào mà chúng ta có thể chạy trên terminal
  - Cung cấp cho chúng ta cái nhìn chi tiết về câu lệnh:
    - Tên
    - Cú pháp
    - Mô tả
    - Tùy chọn
    - Trạng thái thoát
    - Gía trị trả về
    - Lỗi
    - Tệp
    - Phiên bản
    - Ví dụ
    - Tác giả
    - Thông tin thêm
  - Cú pháp câu lệnh:
    - `man [options] <command_name>`
  - Một số tùy chọn:
    - No Option: Hiển thị toàn bộ thông tin
    - Section-num: Hiển thị chỉ 1 phần cụ thể của hướng dẫn
    - `-f` hiển thị 1 phần cụ thể
    - `-a` hiển thị tất cả các trang liên tiếp
    - `-k` tìm kiếm lệnh được chỉ định dưới dạng biểu thức chính quy trong tất cả các trang hướng dẫn và trả về các trang hướng dẫn cùng với số phần chứa lệnh
    - `w` trả về vị trí mà trang hướng dẫn của lệnh được chỉ định đang nằm
    - `I` xem xét lệnh như một chuỗi phân biệt chữ hoa chữ thường
- `apropose`: Hiển thị tất cả các lệnh có chứa chuỗi đã nhập. Nên dùng khi không nhớ rõ lệnh
  - `apropose <chuỗi 1 phần của 1 lệnh nào đó>`
- `dpkg`: là một phần mềm quản lý tệp tin.
  - Sử dụng `dpkg -l` để show ra thông tin toàn bộ các tệp
- `whatis`: show ra thông tin về 1 lệnh xem lệnh đó dùng để làm gì


### Các câu lệnh làm việc   
#### Làm việc với File
Đối với Linux, ta sẽ làm việc với các câu lệnh và các file dữ liệu. Bất kể khi nào bạn sử dụng câu lệnh, câu lệnh đó sẽ được lấy từ một file trong hệ thống. Và đứng ở vị trí của bạn, bạn cũng đang làm việc ở trong 1 thư mục
![](/Anh/Screenshot_228.png)

Ví dụ như trong ảnh trên, tôi đang ở trong đường dẫn `/home/ducmanh287`, nghĩa là tôi đang làm việc trong thư mục `ducmanh287`, và ở trong mục `home`
##### Làm việc với đường dẫn File
- `pwd`: Chỉ ra đường dẫn chi tiết dẫn tới thư mục đang làm việc hiện tại
- ![](/Anh/Screenshot_230.png)
- `cd -`: Đưa bạn về thư mục làm việc trước đó
- ![](/Anh/Screenshot_229.png)
- `cd `: Đưa bạn về thư mục làm việc chính của người dùng
- ![](/Anh/Screenshot_231.png)
- `cd /.../.../...`: Đưa bạn đến vị trí đường dẫn bạn đã nhập
- ![](/Anh/Screenshot_232.png)
##### Show ra danh sách file trong 1 thư mục
Ta sử dụng `ls` để show ra danh sách file

Bảng dưới đây sẽ là các options để sử dụng với `ls`

- `ls -l`: Show ra danh sách các file trong 1 bảng dài(Khuyến cáo nên sử dụng vì sẽ dễ nhìn và đọc)
- ![](/Anh/Screenshot_233.png)
- `ls -ld /.../.../...`: Hiển thị thông tin đường dẫn đã nhập
- ![](/Anh/Screenshot_234.png)
- `ls -a`: Hiển thị tất cả file bao gồm cả những file bị giấu(Các file bắt đầu bằng `.` là những file bị giấu)
- ![](/Anh/Screenshot_235.png)
- `ls -F`: Nối thêm một biểu tượng vào cuối tên tệp để cho biết loại tệp
  - `*` có nghĩa là thực thi
  - `/` có nghĩa là thư mục
  - `@` có nghĩa là liên kết tượng trưng
  - `=` có nghĩa là ổ cắm
  - `|` có nghĩa là ống được đặt tên 
  - `>` có nghĩa là cửa
- `ls -lt`: Liệt kê các tệp theo thời gian sửa đổi. Các tệp mới được sửa sẽ được hiển thị ở trên cùng
- `ls -lh`: Liệt kê kích thước file ở chế độ đọc được
- ![](/Anh/Screenshot_237.png)
- `ls -lR`: Hiển thị tất cả thư mục con
- `tree`: Hiển thị theo sơ đồ cây
- ![](/Anh/Screenshot_236.png)

##### Tạo, Sao chép, Xóa File hoăc Đường dẫn
- `cp` dùng để sao chép file 
  - Có 2 cách để thực hiện việc sao chép:
    - `cp <tên file> <đường dẫn đến vị trí>`: Sao chép file trong thư mục hiện tại đến vị trí bất kì
    - ![](/Anh/Screenshot_238.png)
    - `cp <đường dẫn tới file> <đường dẫn đến vị trí>`: Sao chép file từ đường dẫn bất kì đến vị trí bất kì 
    - ![](/Anh/Screenshot_239.png)
  - Có thể thêm các options như `-p` hoặc `-R`
- `mv <name file 1> <name file 2>` dùng để di chuyển và đổi tên file
- ![](/Anh/Screenshot_240.png)
- `rm` - remove: Xóa file/đường dẫn
  - `rm -i <filename>`: Xóa file, hỏi trước khi xóa
  - ![](/Anh/Screenshot_241.png)
  - `rm -R <dirname>`: Xóa 1 đường dẫn(1 thư mục)
  - `rm -rf <dirname>`: Xóa 1 đường dẫn(1 thư mục) mà không có cảnh báo gì(Cái này rất nguy hiểm)
  - ![](/Anh/Screenshot_245.png)
  - `rmdir <dir-name>`: Xóa 1 thư mục trống
- `mkdir <dir-name>`: Tạo 1 thư mục mới
- ![](/Anh/Screenshot_242.png)
  - `mkdir -p <dir-name>/<dir-name>`: Tạo cấu trúc phân cấp thư mục. Tạo thư mục mẹ nếu cần, nếu chúng không tồn tại. Bạn có thể chỉ định nhiều thư mục
  - ![](/Anh/Screenshot_243.png)
- `touch <filename>`: Tạo 1 file mới
- ![](/Anh/Screenshot_244.png)

##### Quyền tập tin/thư mục và nhóm Lệnh
- `chmod`: là viết tắt của ***change mode*** dùng để thay đổi hoặc gán quyền truy cập cho các tệp và thư mục 
  - Sử dụng `chmod`:
  - `chmod [options] [permissions] <file_name> `
    - class : u,g,o - user,group,other
    - (+) để thêm quyền, (-) để xóa quyền
    - permissions: r,w,x- read, write, execute
  - Ở đây, `[permissions]` có thể được viết dưới dạng kí tự số hoặc chữ:
  - Kiểu chữ: Gồm 10 ký tự, Một ký tự dại diện cho loại file và 9 ký tự đại diện cho các quyền đọc(**r**), ghi(**w**), và thực thi(**x**) của file theo thứ tự của chủ sở hữu --> nhóm --> người khác. Nếu không được phép, biểu tượng (**-**) sẽ được sử dụng.
    - Ví dụ: 
    - ![](/Anh/Screenshot_246.png)

    - ![](/Anh/Screenshot_247.png)
  - Kiểu số: Mỗi chữ số trong khoảng từ 0 ~ 7 và mỗi giá trị cuả chữ số có được bằng cách tính tổng các quyền của lớp. 
    - Quy luật như sau: 
      - 0 là không có bất kỳ quyền gì
      - +1 nếu có thể thực thi file
      - +2 nếu có thể ghi file
      - +4 nếu có thể đọc file
    - Vậy ý nghĩa của từng con số trong khoảng 0 ~ 7 như sau:
      - 0: Không có quyền gì
      - 1: Thực thi file
      - 2: Viết file
      - 3: Viết và thực thi file
      - 4: Đọc file
      - 5: Đọc và thực thi file
      - 6: Đọc và viết file
      - 7: Đọc, ghi, thực thi file
  - ![](/Anh/Screenshot_248.png)
  - Khi nào dùng kiểu kí tự, khi nào dùng kiểu số:
    - Ta nên dùng kiểu kí tự khi muốn phân từng quyền cho từng lớp. Kiểu số nên dùng khi muốn phân quyền cho tất cả các lớp cùng 1 lúc.
  - Các Options:
    - `-c` changes: Báo cáo khi có thay đổi
    - `-f` silent,quiet: Không hiển thị hầu hết các thông báo lỗi
    - `-v` verbose: Hiển thị thông tin cho mỗi tệp được xử lý
    - `--no-preserve-root`: Không đặc biệt xử lý(sẽ có các thay đổi quyền đến thư mục mẹ và các thư mục con bên trong hệ thống)
    - `--preserve-root`: Đặc biệt xử lý(Đặc biệt ở đây liên quan đến việc sửa đổi file, thư mục gốc-thư mục mẹ- việc thay đổi quyền truy cập của các thư mục mẹ sẽ có ảnh hưởng đến toàn bộ hệ thống-ta nên dùng thêm options này)
    - `--reference`: Sử dụng chế độ của RFILE thay vì MODE
      - Theo như tìm hiểu, RFILE nghĩa là tham chiếu đến 1 file khác thay vì chỉ định MODE cụ thể
      - Cách sử dụng:
        - Giả sử bạn có 2 file: filename1 và filename2
        - `chmod --reference=filename1 filename2`
        - Lệnh này sau khi được thực hiện thì file 2 sẽ có quyền như file 1
      - `-R, --recursive`:Thay đổi quyền của một thư mục đệ quy. Để thay đổi quyền của một thư mục và mọi thứ trong thư mục đó, hãy sử dụng lệnh này
      - `--help`: hiển thị trợ giúp và thoát
      - `--version`: hiển thị phiên bản và thoát
  - Cách sử dụng chi tiết:
    - Kiểu kí tự:
      - `chmod [options] [class(+,-)permissions] <file_name> `
        - class : u,g,o - user,group,other
        - (+) để thêm quyền, (-) để xóa quyền
        - permissions: r,w,x- read, write, execute
      - Thêm quyền r,w,x cho user đối với file: newfile.txt
      - `chmod u+rwx newfile.txt`
      - ![](/Anh/Screenshot_249.png)
      - Thu hồi các quyền đó:
      - `chmod u-rwx newfile.txt`
      - ![](/Anh/Screenshot_250.png)
      - Phân quyền cho cả user,group và other:
      - `chmod ug+wx,o+x newfile.txt`
      - ![](/Anh/Screenshot_251.png)
    - Kiểu số:
      - `chmod [options] [number] <file_name>`
        - number: 3 nums for 3 classes
      - Ví dụ:
        - Cấp tất cả quyền cho mọi người(user, group, other)
        - `chmod 777 newfile.txt`
        - ![](/Anh/Screenshot_252.png)

- `chown` và `chgrp`: Thay đổi quyền sở hữu của thư mục hoặc tệp tin
  - Cách sử dụng:
    - `chown/chgrp [Options] [Owner/Group name] [filename]` 

##### In text ra màn hình:
- Để thực hiện điều này, ta sử dụng lệnh `echo`
- `echo "text"`
- VD:
  - ![](/Anh/Screenshot_253.png)

##### Tìm kiếm tệp
- Sử dụng `find`
  - Tìm kiếm tệp theo tên: Để tìm kiếm tệp theo tên, bạn sử dụng cờ -name với lệnh find. 
    - Ví dụ, để tìm kiếm tệp có tên là filename.txt trong thư mục /home, bạn sẽ sử dụng lệnh sau:
    - `find /home -type f -name filename.txt`
    - ![](/Anh/Screenshot_254.png)
  - Tìm kiếm tệp theo phần mở rộng (extension): Để tìm kiếm tệp theo phần mở rộng, bạn sẽ sử dụng biểu thức chính quy sau với cờ -name hoặc -iname. 
    - Ví dụ, để tìm kiếm tất cả các tệp có phần mở rộng .pdf, bạn sẽ sử dụng lệnh sau:
    - `find /home -type f -name "*.pdf"`
    - ![](/Anh/Screenshot_255.png)
  - Tìm kiếm tệp theo ký tự đại diện: Bạn có thể sử dụng các ký tự đại diện shell cơ bản để mở rộng tìm kiếm của mình. 
    - Ví dụ, dấu hoa thị (*) đại diện cho bất kỳ số hoặc ký tự nào:
    - `find ~ -iname "foo*"`
  - Hoặc đơn giản, bạn nhập lệnh `find`, sau đó nhấn `Tab Tab` sẽ hiển thị ra các thư mục và file
- Sử dụng `grep`
  - Để tìm 1 nội dung text trong 1 file hoặc 1 thư mục
  - Ví dụ tìm trong file: `grep <text> [đường dẫn]`
    - ![](/Anh/Screenshot_256.png)
  - Ví dụ tìm trong thư mục: `grep -R <text> [đường dẫn]`
    - ![](/Anh/Screenshot_257.png)
##### Một số thao tác thêm với file
- Lệnh `head`:
  - Cú pháp: `head [OPTION]... [FILE]...`
  - Mặc định, lệnh head sẽ in ra 10 dòng đầu tiên của các tệp được chỉ định.
  - Các tùy chọn chính:
    - `-n num`: In ra num dòng đầu tiên thay vì 10 dòng đầu.
    - `-c num`: In ra num byte đầu tiên từ tệp được chỉ định.
    - `-q`: Nếu có nhiều hơn 1 tệp được cung cấp, tùy chọn này sẽ không in tên tệp trước mỗi tệp1.
    - `-v`: Dữ liệu từ tệp được chỉ định luôn đi kèm với tên tệp1.
- Lệnh tail:
  - Cú pháp: tail [OPTION]... [FILE]...
  - Mặc định, lệnh tail sẽ in ra 10 dòng cuối cùng của các tệp được chỉ định.
  - Các tùy chọn chính:
    - `-n num`: In ra num dòng cuối cùng thay vì 10 dòng cuối5.
    - `-c num`: In ra num byte cuối cùng từ tệp được chỉ định5.
    - `-q`: Nếu có nhiều hơn 1 tệp được cung cấp, tùy chọn này sẽ không in tên tệp trước mỗi tệp
    - `-v`: Dữ liệu từ tệp được chỉ định luôn đi kèm với tên tệp
    - `-f`: Hiển thị lịch sử phát triển của file. Thường là tệp nhật ký theo thời gian thực. Tail -f sẽ hiển thị nội dung thay đổi của file theo thời gian thực(thường sẽ là 10 dòng cuối)
- Lệnh `cat [đường dẫn tới file]`: để xem nội dung file 

#### Shell và làm việc với Shell

  


  