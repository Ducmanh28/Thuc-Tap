# Mục này tìm hiểu về 1 số câu lệnh hữu dụng khi sử dụng Linux

## Lệnh `ss`
### Tổng quát
Trong Linux, lệnh `ss` được sử dụng để hiển thị thông tin về các kết nối mạng, các port đang lắng nghe và các tiến trình mạng đang chạy trên hệ thống.
### Các tùy chọn của lệnh `ss`
Cấu trúc cơ bản của câu lệnh như sau:
```
ss [tùy chọn][bộ lọc]
```
Với các tùy chọn như sau:
- `-t`: Hiển thị thông tin về các kết nối **TCP**
- `-u`: Hiển thị thông tin về các kết nối **UDP**
- `-l`: Hiển thị danh sách các port đang lắng nghe
- `-p`: Hiển thị tiến trình liên quan đến các kết nối
- `-n`: Hiển thị địa chỉ IP và số cổng dưới dạng số(Không chuyển đổi sang tên miền hoặc tên dịch vụ)
- `-a`: Hiển thị tất cả các kết nối, bao gồm cả các kết nối không được lắng nghe

Và các bộ lọc tìm kiếm như:
- `state`: Lọc theo trạng thái kết nối
  - **ESTAB**: Trạng thái đã thiết lập
  - **LISTEN**: Đang lắng nghe
  - **SYN-SENT**: Gửi cờ SYN
  - **SYN-RECV**: Nhận cờ SYN
  - **TIME-WAIT**: Đang chờ
  - .....
- `dst`: Lọc theo địa chỉ đích của kết nối
- `src`: Lọc theo địa chỉ nguồn
- `dport`: Theo cổng đích
- `sport`: Theo cổng nguồn
- `daddr`: Theo địa chỉ IP đích
- `saddr`: Theo địa chỉ IP nguồn
### Sử dụng lệnh `ss`
#### Hiển thị thông tin các kết nối TCP
Với options `-t`, chúng ta sẽ xem được các kết nối **TCP** ở máy chủ như sau:
```
ducmanh287@ubuntusv:~$ ss -t
State    Recv-Q      Send-Q         Local Address:Port      Peer Address:Port             Process
ESTAB       0          0          192.168.217.128:ssh      192.168.217.1:52777
ESTAB       0          0          192.168.217.128:ssh      192.168.217.1:52782
```
Trong đó:
- **State**: Đây là trạng thái của kết nối
  - LISTEN: Đang lắng nghe
  - ESTAB: Đã thiết lập,....
- **Recv-Q**: Số lượng byte trong hàng đợi đang chờ để được nhận bởi quá trình ứng dụng
- **Send-Q**: Số lượng byte trong hàng đợi đang chờ để được gửi bởi quá trình của ứng dụng
- **Local Address:Port**: Địa chỉ IP và cổng mà kết nối đang được liên kết trên máy chủ. 
- **Peer Address:Port**: Địa chỉ IP và cổng của máy chủ đích hoặc máy khách mà kết nối đang giao tiếp với