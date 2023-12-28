# Mục này show ra quá trình sử dụng Linux thực tế, kiến thức tìm hiểu được trong quá trình sử dụng

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
- `lsb_release (-a)`: Hiện thông tin phân phối
- ![](/Anh/Screenshot_222.png)
- Lưu ý:
  - `Ctrl C`: Để dừng lệnh đang chạy
  - `Which <cmdname>`: Để kiểm tra lệnh có tồn tại hay không