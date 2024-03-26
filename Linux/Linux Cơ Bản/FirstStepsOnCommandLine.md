# Các bước khởi đầu với dòng lệnh

MỤC LỤC

- [Các bước khởi đầu với dòng lệnh](#các-bước-khởi-đầu-với-dòng-lệnh)
  - [Lệnh tìm kiếm trợ giúp (man)](#lệnh-tìm-kiếm-trợ-giúp-man)
    - [Tác dụng của lệnh man](#tác-dụng-của-lệnh-man)
    - [Cấu trúc của lệnh man](#cấu-trúc-của-lệnh-man)
    - [Một số tùy chọn của lệnh man](#một-số-tùy-chọn-của-lệnh-man)
      - [--all](#--all)
      - [--whatis](#--whatis)
      - [--apropose](#--apropose)
      - [--where](#--where)
      - [--help](#--help)
    - [Một số ví dụ về lệnh man](#một-số-ví-dụ-về-lệnh-man)
    - [Thông tin thêm về lệnh man - mandb](#thông-tin-thêm-về-lệnh-man---mandb)
  - [Làm việc với các thư mục](#làm-việc-với-các-thư-mục)
    - [Lệnh pwd](#lệnh-pwd)
    - [Lệnh cd](#lệnh-cd)
    - [Lệnh ls](#lệnh-ls)
    - [Lệnh mkdir](#lệnh-mkdir)
    - [rmdir](#rmdir)
  - [Làm việc với Files](#làm-việc-với-files)
    - [Lệnh file](#lệnh-file)
    - [Lệnh touch](#lệnh-touch)

## Lệnh tìm kiếm trợ giúp (man)
### Tác dụng của lệnh man
Là một lệnh rất hữu ích trong Linux, giúp bạn tra cứu thông tin chi tiết, các options, các file chứa của một lệnh trong Linux
### Cấu trúc của lệnh man
`man [tùy_chọn] [tên_lệnh]`

Trong đó:
- [tùy_chọn] là các tham số tùy chọn để điều chỉnh cách hiển thị trang hướng dẫn
- [tên_lệnh] là tên của lệnh muốn tra cứu

### Một số tùy chọn của lệnh man
#### --all
`-a ` hay `-all` sẽ hiển thị tất cả các trang hướng dẫn có liên quan đến tên lệnh, không chỉ trang đầu tiên

#### --whatis
`-f` hay `--whatis` sẽ hiển thị một dòng mô tả ngắn gọn về lệnh, tương đương với lệnh `whatis`

#### --apropose
`-k` hay `--apropose` sẽ hiển thị các trang hướng dẫn có chứa từ khóa trong tên lệnh, tương đương với lệnh `apropose`

#### --where
`-w` hay `--where` sẽ hiển thị đường dẫn đến tệp hướng dẫn của tên lệnh

#### --help
`-h` hay `--help` sẽ hiển thị các trợ giúp về lệnh `man`


### Một số ví dụ về lệnh man
`man ls` sẽ hiển thị thông tin về lệnh `ls`

![](/Anh/Screenshot_341.png)

`man -k file` sẽ hiển thị các trang hướng dẫn có chứa từ khóa `file`

![](/Anh/Screenshot_342.png)

`man -w ping` sẽ hiển thị đường dẫn của lệnh `ping`

![](/Anh/Screenshot_343.png)

### Thông tin thêm về lệnh man - mandb
`mandb` dùng dể khởi tạo hoặc cập nhật các cơ sở dữ liệu bộ nhớ đệm cho các trang hướng dẫn

Cú pháp của lệnh là `mandb [tùy_chọn]`

Có các tùy chọn như là:
- `-c` hoặc `--create`:  khởi tạo cơ sở dữ liệu bộ nhớ đệm mới, bỏ qua cái cũ
- `-u` hoặc `--update`: cập nhật cơ sở dữ liệu bộ nhớ đệm hiện có, chỉ xử lý các trang hướng dẫn đã thay đổi hoặc mới
- `-t` hoặc `test`: Kiểm tra tính đúng đắn của các trang hướng dẫn mà không thay đổi nội dung
- `-f` hoặc `--filename`: Xử lý một tệp hướng dẫn cụ thể
- `-h` hoặc `--help`: Hiển thị trợ giúp về lệnh `mandb`

Một số ví dụ sử dụng:

`mandb -u`
![](/Anh/Screenshot_344.png)

`mandb -c`
![](/Anh/Screenshot_345.png)

`mandb -f`
![](/Anh/Screenshot_346.png)

## Làm việc với các thư mục
### Lệnh pwd
`pwd` hay có nghĩa là Print Working Directory

Tác dụng của lệnh `pwd`: Hiển thị ra đường dẫn tới thư mục hiện tại mà bạn đang làm việc

Cấu trúc lệnh: Nhập `pwd`

Ví dụ sử dụng:
![](/Anh/Screenshot_347.png)

### Lệnh cd
`cd` hay có nghĩa là Change Directory 

Tác dụng của lệnh `cd`: Như tên của nó, lệnh này sẽ thay đổi thư mục làm việc của bạn

Cấu trúc lệnh: `cd [tùy_chọn] [đường_dẫn]`

Các tùy chọn của lệnh:
- `-L` hoặc `--logical`: Theo dõi các liên kết khi thay đổi thư mục. Đây là tùy chọn mặc định
- `-P` hoặc `--physical`: Khi tùy chọn này được xác định, và bạn cố gắng thay đổi vào một liên kết tượng trưng, lệnh cd sẽ thay đổi vào thư mục gốc của liên kết.
- `-e` hoặc `--ignore-errors`: Không báo lỗi
- `-h` hoặc `--help`: Các trợ giúp về lệnh `cd`

Một số ví dụ về sử dụng lệnh:
- `cd ..` sẽ đưa bạn vào thư mục cha
  - ![](/Anh/Screenshot_348.png)

- `cd /` hay `cd ` sẽ đưa bạn về thư mục gốc
  - ![](/Anh/Screenshot_349.png)

- `cd -` sẽ đưa bạn về thư mục trước đó
  - ![](/Anh/Screenshot_350.png)

Lưu ý khi nhập đường dẫn: 

Bạn có thể vừa nhập vừa bấm `Tab` và `Tab Tab` sẽ hiển thị ra các trợ giúp đường dẫn cho bạn. Nếu không hiển thị gì thì khả năng cao là bạn đã nhập sai :-)

### Lệnh ls
Bạn có thể xem danh sách các tệp nằm trong một thư mục bằng cách dùng lệnh `ls`

Cấu trúc lệnh: `ls [tùy_chọn] [thư_mục]`

Các tùy chọn của lệnh `ls`:
- `-a`: liệt kê tất cả các tập tin, bao gồm các tập tin bị ẩn
- `-l`: liệt kê với định dạng dài, hiển thị các thông tin chi tiết như
  - quyền
  - người sở hữu
  - ngày giờ sửa đổi tệp
  - tên tệp
- `-h`: liệt kê với định dạng dài và hiển thị kích thước theo đơn vị người đọc được như kB, mB, gB
- `-r`: liệt kê theo thứ tự ngược lại (từ Z đến A hoặc từ mới nhất đến cũ nhất)
- `-R`: liệt kê tất cả tệp tin và thư mục con trong thư mục hiện tại và các thư mục con của nó 
- `-S` hay `--sort=size`: liệt kê và sắp xếp theo kích thước tập tin từ lớn đến nhỏ
- `-t` hay `--sort=time`: liệt kê và sắp xếp theo thời gian sửa đổi tập tin, từ mới nhất đến cũ nhất
- `-X` hay `--sort=extension`: liệt kê và sắp xếp theo tên phần mở rộng(`*.pdf`,`*.conf`,`*.sh`,...)
- `-F`: liệt kê và thêm vào một ký tự đặc biệt giúp nhận dạng tệp
  - `/` cho thư mục
  - `*` cho tệp tin thực thi
  - `@` cho liên kết tượng trưng
- `-i`: liệt kê và hiển thị số inode của tập tin - là số duy nhất xác định tập tin trong hệ thống tập tin
- `-d`: liệt kê chỉ tên thư mục, không hiển thị các tập tin và thư mục con của nó
- `-f`: liệt kê mặc định, giữ nguyên thứ tự của hệ thống tập tin
- `-?` hoặc `--help`: liệt kê các tùy chọn có sẵn và cách sử dụng lệnh `ls`

Một số ví dụ về sử dụng lệnh `ls`:
- `ls`
  - ![](/Anh/Screenshot_351.png)
- `ls -l`
  - ![](/Anh/Screenshot_352.png)
- `ls -f`
  - ![](/Anh/Screenshot_353.png)
- `ls -i`
  - ![](/Anh/Screenshot_354.png)
- `ls -R`
  - ![](/Anh/Screenshot_355.png)

### Lệnh mkdir
Tác dụng lệnh: Tạo một thư mục mới

Cấu trúc lệnh: `mkdir [tùy_chọn] [tên_thư_mục]`

Các tùy chọn của lệnh:
- `-p`: Tạo các thư mục cha nếu chúng chưa tồn tại
- `-v`: Hiển thị quá trình tạo thư mục
- `-m`: Cấp quyền cho thư mục khi tạo
  - Cấu trúc lệnh: `mkdir -m [number_chmod] [tên_thư_mục hoặc đường_dẫn]`
- `-d`: Tạo các thư mục đơn giản nếu chúng không tồn tại

Một số ví dụ sử dụng:
- `mkdir ducmanh287333`
  - ![](/Anh/Screenshot_356.png)
- `mkdir -v ducmanh28733333`
  - ![](/Anh/Screenshot_357.png)
- `mkdir -m 755 heloohehe`
  - ![](/Anh/Screenshot_358.png)

### rmdir
Tác dụng của lệnh: Dùng để xóa một thư mục rỗng

Cấu trúc của lệnh: `rmdir [tùy_chọn] [tên_thư_mục]`

Các tùy chọn của `rmdir`
- `--ignore-fail-on-non-empty`: Bỏ qua lỗi khi xóa thư mục còn dữ liệu
- `-p`: Xóa thư mục hiện tại và cả thư mục cha của nó
- `-v`: Hiển thị quá trình xóa thư mục
- `--help`: Hiển thị trợ giúp
- `--version`: Xem phiên bản của lệnh

Một số ví dụ về dùng lệnh:
- `rmdir -v `
  - ![](/Anh/Screenshot_359.png)
- `rmdir `
  - ![](/Anh/Screenshot_360.png)

## Làm việc với Files
Tất cả các tập tin đều phân biệt chữ hoa - chữ thường

Mọi thứ đều là file
### Lệnh file
Tác dụng của lệnh: Xác định loại tệp của một hoặc nhiều tệp được chỉ định. Lệnh này sẽ phân tích nội dung của tệp và trả về một thông tin mô tả về loại tệp đó

Cú pháp của lệnh: `file [tùy_chọn] [tên_file]`

Các tùy chọn của lệnh:
- `-b`: Chỉ hiển thị thông tin về loại tệp, không hiển thị tên tệp
- `-c`: Kiểm tra tính hợp lệ của các tệp cơ sở dữ liệu mà lệnh file sử dụng
- `-f`: Đọc danh sách các tên tệp từ một tệp văn bản và xác định loại tệp của chúng
- `-i`: Hiển thị thông tin về loại tệp theo định dạng MIME
- `-k`: Tiếp tục xác định loại tệp cho các tệp được chỉ định, ngay cả khi gặp lỗi
- `-l`: Liệt kê các tệp cơ sở dữ liệu mà lệnh file sử dụng
- `-s`: Xác định loại tệp cho các các loại tệp đặc biệt
- `-z`: Xác định loại tệp cho các tệp nén

Một số ví dụ về sử dụng lệnh:
- `file`
  - ![](/Anh/Screenshot_361.png)
- `file -b`
  - ![](/Anh/Screenshot_362.png)
- `file -i`
  - ![](/Anh/Screenshot_363.png)
- `file -l`
  - ![](/Anh/Screenshot_364.png)
### Lệnh touch
- 