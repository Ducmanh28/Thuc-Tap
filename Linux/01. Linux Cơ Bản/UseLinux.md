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
      - [Nén file với 'tar'](#nén-file-với-tar)
      - [Các câu lệnh liên quan đến Service](#các-câu-lệnh-liên-quan-đến-service)
      - [Các câu lệnh liên quan đến người dùng](#các-câu-lệnh-liên-quan-đến-người-dùng)
      - [LAMP](#lamp)
      - [Tee command](#tee-command)
      - [GnuPG](#gnupg)
      - [Cấu hình mạng](#cấu-hình-mạng)
      - [CHROOT](#chroot)
      - [Package Managers](#package-managers)
      - [Lệnh cURL:](#lệnh-curl)


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
  - Hoặc xem nội dung file `cpuinfo`
  - `cat /proc/cpuinfo`
  - ![](/Anh/Screenshot_270.png)
  - Xem thông tin các chương trình đang chạy trên nhân cpu
  - `grep -c processor /proc/cpuinfo`
  - ![](/Anh/Screenshot_271.png)
- `lstopo`: Show thông tin Topo phần cứng
- ![](/Anh/Screenshot_220.png)
- `lshw`: Show thông tin phần cứng thiết bị
  - ![](/Anh/Screenshot_266.png)
  - Có thể kết hợp với `grep` để lấy thông tin về phần cứng cần biết
  - ![](/Anh/Screenshot_267.png)
- `lspci -tv`: Xem thông tin PCI
- `lsusb -tv`: Xem thông tin USB
- `dmidecode -q`: Xem thôn tin BIOS:
  - ![](/Anh/Screenshot_269.png)
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
- `df -h`: Kiểm tra ổ đĩa:
  - ![](/Anh/Screenshot_263.png)
- `du -sh *`: Kiểm tra dung lượng các file trong thư mục hiện tại 
  - ![](/Anh/Screenshot_264.png)
- `du -sh .[!.]* *`: Kiểm tra dung lượng các file trong thư mục hiện tại(bao gồm cả các file bị ẩn)
  - ![](/Anh/Screenshot_265.png)
  - Có thể thêm tính tổng bằng cách thêm options `-c`
- `apt list --installed | grep <package_name`: Để kiểm tra xem package nào đã được cài trên máy
  - Ví dụ kiểm tra package về ssh:
  - ![](/Anh/Screenshot_279.png)
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
  - ![](/Anh/Screenshot_272.png)
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
- Shell, còn được gọi là giao diện dòng lệnh(CLI), giống như một trung gian giữa người dùng và hệ điều hành máy tính. Khi bạn gõ một lệnh vào Shell, nó sẽ ***biên dịch*** lệnh đó và yêu cầu hệ điều hành thực hiện lệnh. 
- Ví dụ:
  - Khi gõ `ls` để liệt kê các tệp và thư mục, Shell sẽ yêu cầu hệ điều hành thực hiện công việc này. 
- Shell cũng cho phép người dùng viết và chạy các tập lệnh. Đây là một cách hiệu quả để tự động hóa các tác vụ lặp đi lặp lại
- Cách kiểm tra Shell và đổi Shell:
  - Đa số các bản phân phối Linux hiện đại sẽ có **BASH**(**B**ourne **A**gain **SH**ell) được cài sẵn làm Shell mặc định
  - Câu lệnh để đổi Shell sẽ là `chsh` - Change Shell
    - Nhưng tùy mỗi hệ điều hành sẽ có tùy chọn `chsh -l` để xem. Đối với những phiên bản không hỗ trợ tùy chọn `-l`, ta có thể xem Shell bằng cách xem nội dung file có đường dẫn: `/etc/shells`
    - ![](/Anh/Screenshot_259.png)
    - Nhập lệnh `chsh -h` để xem các trợ giúp về lệnh này
    - Ta có thể thấy được, `chsh -s` sẽ được dùng để đổi shell cho user
  - Trường hợp gặp lỗi khi change shell: Khi bạn sử dụng quyền user để changes shells sau đó lại vào shells mới dùng quyền roots để changes shells tiếp sẽ khiến việc thay đổi bị lỗi và dẫn đến việc không thể đăng nhập `sudo su`. 
  - Fix: Sử dụng `sudo` kết hợp với lệnh `chsh` để đưa shell dưới quyền root về 1 loại shell
      - Sử dụng quyền user đưa shell về cùng loại shell với shell quyền roots

- Một số tiện ích về Shell
  - Có thể đổi biến PS1 để đổi dấu nhắc lệnh
  - Các shortcut trong terminal vẫn được áp dụng trong shells 
- Tạo phím tắt lệnh của riêng mình
  - Sử dụng lệnh `alias` để tạo bí danh cho lệnh của mình
  - Cấu trúc lệnh: `alias [bí danh]=['tên_lệnh']`
  - VD: `alias lietke='ls -l'`
  - ![](/Anh/Screenshot_260.png)
- Tìm kiếm một file theo cách dễ dàng
  - Lệnh `locate` sẽ được dùng trong trường hợp này:
  - Cấu trúc lệnh như sau: `locate [text...]`
  - VD: Bạn muốn tìm file `00-installer-config.yaml` nhưng bạn chỉ nhớ **installer**
  - Nhập lệnh `locate installer` sẽ hiển thị những file có `installer`
  - ![](/Anh/Screenshot_262.png)

#### Nén file với 'tar'
- Các Options thường dùng:
  - `-c`: Tạo 1 kho lưu trữ ***tar*** mới
  - `-x`: Giải nén file trong kho lưu trữ
  - `-t`: Liệt kê danh sách của 1 kho lưu trữ
  - `-f`: Sử dụng tệp lưu trữ hoặc dir ARCHIVE
  - `-v`: Liệt kê chi tiết các tệp đã được xử lý lên màn hình
- Tùy chọn nén:
  - `-a`: Nén tự động
  - `-j`: Tạo kho lưu trữ dạng bzip2
  - `-J`: Tạo kho lưu trữ dạng xz
  - `-z`: Tạo kho lưu trữ dạng gzip
- Cấu trúc câu lệnh:
  - `tar [options] [file_name] [folder_name]` 
- VD: 
  - Tạo 1 kho lưu trữ đơn giản
  - `tar -cf archive.tar ducmanh287`
  - Giải nén đơn giản
  - `tar -xf archive_name.tar`
  
#### Các câu lệnh liên quan đến Service
- Kiểm tra danh sách service:
  - `service --status-all`
  - ![](/Anh/Screenshot_273.png)
    - Dấu `+` nghĩa là dịch vụ đang hoạt động
    - Dấu `-` nghĩa là dịch vụ không hoạt động
- Các câu lệnh làm việc với **Systemd**
  - `systemctl`: Hiển thị danh sách các dịch vụ đang chạy
  - ![](/Anh/Screenshot_274.png)
  - `systemctl --failed`: Sẽ hiển thị danh sách các dịch vụ chạy thất bại
  - ![](/Anh/Screenshot_275.png)
  - `systemctl get-default`: Để xem file `.target` nào đang được chạy ở **Systemd**
  - ![](/Anh/Screenshot_276.png)
  - `systemctl set-default [name_file.target]`: Để tiến hành sử dụng 1 file .target khác khi reboot lại máy
  - `systemctl start [tên dịch vụ]`: Để bắt đầu một dịch vụ
  - `systemctl stop [tên dịch vụ]`: Để dừng dịch vụ
  - `systemctl restart [tên dịch vụ]`: Để khởi động lại dịch vụ
  - `systemctl reload [tên dịch vụ]`: Để yêu cầu dịch vụ tải lại cấu hình của nó
  - `systemctl status [tên dịch vụ]`: Để hiển thị trạng thái hiện tại của dịch vụ
  - `systemctl được bật [tên dịch vụ]`: Để hiển thị liệu dịch vụ có được bật khi khởi động hệ thống hay không
  - `systemctl is-active [tên dịch vụ]`: Để cho biết liệu một dịch vụ hiện có đang hoạt động hay không (đang chạy)
  - `systemctl Enable [tên dịch vụ]`: Để kích hoạt dịch vụ khi khởi động hệ thống
  - `systemctl vô hiệu hóa [tên dịch vụ]`: Để vô hiệu hóa dịch vụ khi khởi động hệ thống 
  - `systemctl Mask [tên dịch vụ]`: Để che giấu một dịch vụ (Khó khăn khi khởi động nhầm dịch vụ)
  - `systemctl vạch mặt [tên dịch vụ]`: Để ngừng giấu một dịch vụ
  - `systemctl daemon-reload`: Khởi động lại **Systemd**
 
#### Các câu lệnh liên quan đến người dùng
- Đổi mật khẩu: `passwd`
- Đổi mật khẩu cho User khác: `passwd [user_name]`
- Thêm 1 user: `useradd [user_name]`
- Xóa 1 user: `userdel [user_name]`
- Xóa user và xóa luôn thư mục home của user ấy: `userdel -r user_name`
- Liệt kê danh sách mà user hiện tại đang ở và user bất kì ở: `groups` và `groups username`

#### LAMP
- LAMP là một gói phần mềm mã nguồn mở phổ biến. Bao gồm:
  - Linux - hệ điều hành
  - Apache - máy chủ web
  - MySQL - hệ thống quản lý cơ sở dữ liệu
  - PHP - ngôn ngữ lập trình
- Thường được sử dụng để phát triển ứng dụng web
- Chi tiết về các thành phần của LAMP
  - Linux: Là hệ điều hành mà trên đó, các thành phần khác của LAMP được chạy
  - Apache: Là máy chủ trang web, nơi các trang web được lưu trữ và phục vụ cho người dùng
  - MySQL: Là hệ thống quản lý cơ sở dữ liệu, nơi mà dữ liệu của trang web được lưu trữ
  - PHP: Đây là ngôn ngữ lập trình được sử dụng để xây dựng các ứng dụng Web
- Cách LAMP hoạt động:
  - Khi một người dùng truy cập vào máy chủ trang web, máy chủ Apache sẽ xử lý yêu cầu và trả về trang web mà người dùng cần
  - Trong quá trình này, Apache có thể sẽ cần truy vấn cơ sở dữ liệu MySQL để lấy dữ liệu trang web
  - Dữ liệu trang web sau đó sẽ được xử lý bằng ngôn ngữ lập trình PHP
- Cài đặt LAMP trên Ubuntu Server
  - Cài đặt Apache
    - Sử dụng câu lệnh `sudo apt install -y apache2` để cài đặt Apache trên Ubuntu Server
      - ![](/Anh/Screenshot_310.png)
    - Bật dịch vụ và khởi chạy apache2
      - `systemctl start apache2`
      - `systemctl enable apache2`
      - ![](/Anh/Screenshot_311.png)
    - Cho phép gói tin apache2 thông qua tường lửa:
      - `sudo ufw allow in "Apache"`
      - ![](/Anh/Screenshot_312.png)
    - Kiểm tra lại xem dịch vụ đã bật hay chưa
      - `systemctl status apache2`
      - ![](/Anh/Screenshot_313.png)
    - Trang web chứa địa chỉ IP của máy đã cài Apache sẽ hiển thị như sau:
      - ![](/Anh/Screenshot_314.png)
  - Cài đặt MySQL
    - Sử dụng câu lệnh `sudo apt-get install mysql-server`
      - ![](/Anh/Screenshot_315.png)
    - Bật dịch vụ và tự khởi động:
      - `systemctl start mysql`
      - `systemctl enable mysql`
      - ![](/Anh/Screenshot_316.png)
    - Kiểm tra trạng thái:
      - `systemctl status`
      - ![](/Anh/Screenshot_317.png)
    - Phân quyền hệ thống `mysql_secure_installation`
  - Cài đặt PHP
    - Sử dụng câu lệnh `sudo apt install php php-mysql -y` 
    - Kiểm tra phiên bản sau khi cài đặt: `php -v`
    - ![](/Anh/Screenshot_318.png)
#### Tee command
- Dùng để đọc từ stdin và ghi vào cả stdout và một hoặc nhiều tệp hơn cùng một lúc. 
- Lệnh này chủ yếu được sử dụng kết hợp với các lệnh khác thông qua pipeline
- Cú pháp lệnh `tee`
  - `tee [Options] [File]`
- Các options:
  - `-a`: Không ghi đè lên một file mà nối thêm vào
  - `-i`: Bỏ qua các tín hiệu ngắt
- Ví dụ:
  - `df -h | tee disk_usage.txt`
    - ![](/Anh/Screenshot_319.png)
  - `echo "New line" | tee -a /etc/file.conf`
    - ![](/Anh/Screenshot_320.png)
#### GnuPG
- GnuPG là một hệ thống quản lý khóa phức tạp cho phép ký hoặc mã hóa dữ liệu một cách an toàn. GPG là công cụ dòng lệnh được sử dụng để tạo và thao tác các khóa GnuPG.
- GnuPG được sử dụng rộng rãi nhất để có kết nối SSH (Secure Shell) mà không cần mật khẩu hoặc bất kỳ phương tiện xác thực tương tác nào, giúp cải thiện đáng kể mức độ bảo mật.
- Tạo GPG key nhanh:
  - `gpg --gen-key`
  - ![](/Anh/Screenshot_321.png)
  - `gpg --list-keys`
  - ![](/Anh/Screenshot_322.png)
- Mã hóa tệp: Để mã hóa một tệp, bạn có thể sử dụng lệnh sau:
`gpg --encrypt --output file.gpg --recipient [email protected] file`
- Trong đó, file là tên tệp bạn muốn mã hóa, file.gpg là tên tệp đầu ra sau khi mã hóa, và [email protected] là email được liên kết với khóa công khai

- Giải mã tệp: Để giải mã tệp, bạn có thể sử dụng lệnh sau:
`gpg --output file --decrypt file.gpg`
- Trong đó, file.gpg là tên tệp bạn muốn giải mã, và file là tên tệp đầu ra sau khi giải mã

#### Cấu hình mạng
- Kiểm tra IP
  - Có rất nhiều câu lệnh để có thể xem dược IP của bạn
    - `ip a`
    - `ip addr show`
    - `ifconfig`
    - `ip link show`
    - ...
- Xem và thao tác với Route:
  - `route`: Danh sách Route
  - `route -n`: Danh sách Route mà không phân giải tên máy chủ
  - `ip route show`
  - ![](/Anh/Screenshot_323.png)
- Truy vấn trình điều khiển mạng và phần cứng
  - `ethtool <connection>`
  - ![](/Anh/Screenshot_324.png)
#### CHROOT
- Thay đổi root (chroot) là một thao tác thay đổi thư mục gốc rõ ràng cho tiến trình đang chạy hiện tại và các tiến trình con của chúng. Một chương trình chạy trong môi trường được sửa đổi như vậy không thể truy cập các tệp và lệnh bên ngoài cây thư mục môi trường đó.
- Yêu cầu:
    - đặc quyền root
    - một môi trường Linux đang hoạt động khác, chẳng hạn như Live CD boot hoặc bản phân phối hiện có
    - kết hợp kiến trúc môi trường của nguồn và đích chroot (kiểm tra kiến trúc môi trường hiện tại bằng uname -m)
    - các mô-đun hạt nhân mà bạn có thể cần trong môi trường chroot phải được tải (ví dụ: với modprobe)
- Thay đổi root cơ bản:
  - Tạo môi trường hoạt động của chroot (tạo thư mục chỉ định chroot hoạt động)

  ```
  chr=/home/ducmanh287/testroot
  mkdir -p $chr
  ```
  - Tạo các thư mục con để làm thư viện hỗ trợ bên trong môi trường chroot

  ```
  mkdir -p $chr/{bin,lib,lib64}
  ```
  - Copy các file chứa câu lệnh vào môi trường chroot

  ```
  cp -v /bin/{bash,ls} $chr/bin
  ```
  
  - Các câu lệnh cũng cần có các thư viện hỗ trợ để chạy nên ta cần tìm và copy vào. Để xem các thư viện hỗ trợ cho file nào ta sẽ dùng câu lệnh `ldd`

  ```
  ldd /bin/bash
  ldd /bin/ls
  ```
  ![Alt](/anh/Screenshot_325.png)

  - Ta cần copy các file này vào môi trường chroot để hỗ trợ các lệnh (từ 2 hình trên ta nhận thấy chỉ cần copy 5 file là đủ)

  ```
  sudo cp -v --parents /lib/x86_64-linux-gnu/libtinfo.so.6 $chr
  sudo cp -v --parents /lib/x86_64-linux-gnu/libdl.so.2 $chr
  sudo cp -v --parents /lib/x86_64-linux-gnu/libc.so.6 $chr
  sudo cp -v --parents /lib64/ld-linux-x86-64.so.2 $chr
  sudo cp -v --parents /lib/x86_64-linux-gnu/libpcre2-8.so.0 $chr

  ```
  ![](/Anh/Screenshot_327.png)
  kết quả :

  ![](/Anh/Screenshot_328.png)

  - Bây giờ ta tiến hành thử nghiệm với lệnh `chroot` . Lệnh này thiết lập thư mục gốc của môi trường chroot và chỉ định ứng dụng nào sẽ chạy dưới dạng shell

  ```
  sudo chroot $chr /bin/bash
  ```
  - Muốn thoát khỏi môi trường chroot ta sẻ dụng lệnh `exit`
- Lý do nên dùng CHROOT
  - cài đặt lại bộ nạp khởi động
  - xây dựng lại hình ảnh initramfs
  - nâng cấp hoặc hạ cấp gói
  - đặt lại mật khẩu đã quên
  - xây dựng phần mềm trong môi trường root sạch
#### Package Managers
- Update:
  - `sudo apt-get update`
- Upgrade:
  - `sudo apt-get upgrade`
- Dis Upgrade
  - `sudo apt-get dist-upgrade`

#### Lệnh cURL:
Lệnh curl là một công cụ dòng lệnh và thư viện được sử dụng để truyền dữ liệu thông qua nhiều giao thức khác nhau, như HTTP, HTTPS, FTP, SCP, SFTP, và nhiều hơn nữa12. Lệnh curl có thể gửi các yêu cầu HTTP với tất cả các phương thức hiện có, như GET, POST, PUT, DELETE, và nhiều hơn nữa2.

Để sử dụng lệnh curl, bạn cần biết cú pháp của nó:

`curl [OPTIONS] [URL]`

Bạn có thể thiết lập các tùy chọn cho lệnh curl bằng hàm curl_setopt hoặc curl_setopt_array trong PHP23. Một số tùy chọn phổ biến là:

- `CURLOPT_RETURNTRANSFER`: TRUE để curl_exec() trả về chuỗi chứ không xuất thẳng ra màn hình.
- `CURLOPT_CONNECTTIMEOUT`: Thời gian cho phép curl cố gắng kết nối (giây), 0 vô tận.
- `CURLOPT_USERAGENT`: Nội dung của dòng User-Agent: trong header của HTTP khi gửi yêu cầu.
- `CURLOPT_URL`: URL mà curl gửi yêu cầu.
- `CURLOPT_POST`: TRUE – Thiết lập yêu cầu gửi theo phương thức POST.
- `CURLOPT_POSTFIELDS`: Mảng dữ liệu để POST.

Sau khi thiết lập xong các tùy chọn, bạn có thể thực thi lệnh curl bằng hàm `curl_exec` và đóng lệnh curl bằng hàm `curl_close`.