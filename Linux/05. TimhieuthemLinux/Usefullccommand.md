MỤC LỤC
- [Mục này tìm hiểu về 1 số câu lệnh hữu dụng khi sử dụng Linux](#mục-này-tìm-hiểu-về-1-số-câu-lệnh-hữu-dụng-khi-sử-dụng-linux)
  - [Lệnh `ss`](#lệnh-ss)
    - [Tổng quát](#tổng-quát)
    - [Các tùy chọn của lệnh `ss`](#các-tùy-chọn-của-lệnh-ss)
    - [Sử dụng lệnh `ss`](#sử-dụng-lệnh-ss)
      - [Hiển thị thông tin các kết nối TCP](#hiển-thị-thông-tin-các-kết-nối-tcp)
      - [Hiển thị rõ thông tin port](#hiển-thị-rõ-thông-tin-port)
  - [Lệnh `netstat`](#lệnh-netstat)
    - [Tổng quan:](#tổng-quan)
    - [Dùng để làm gì:](#dùng-để-làm-gì)
    - [Cấu trúc câu lệnh và cách sử dụng:](#cấu-trúc-câu-lệnh-và-cách-sử-dụng)
    - [Sử dụng lệnh](#sử-dụng-lệnh)
      - [Xem danh sách trạng thái các thiết bị:](#xem-danh-sách-trạng-thái-các-thiết-bị)
      - [Hoặc thực hiện lọc các kết nối cơ bản như sau:](#hoặc-thực-hiện-lọc-các-kết-nối-cơ-bản-như-sau)
      - [Xem bảng định tuyến](#xem-bảng-định-tuyến)
      - [So sánh](#so-sánh)
  - [Lệnh `nc`](#lệnh-nc)
    - [Tổng quan](#tổng-quan-1)
    - [Tác dụng của lệnh](#tác-dụng-của-lệnh)
    - [Cú pháp lệnh và cách sử dụng](#cú-pháp-lệnh-và-cách-sử-dụng)
    - [Một vài ví dụ về sử dụng lệnh `nc`](#một-vài-ví-dụ-về-sử-dụng-lệnh-nc)
      - [Gửi dữ liệu từ máy A sang B thông qua TCP/UDP](#gửi-dữ-liệu-từ-máy-a-sang-b-thông-qua-tcpudp)
      - [Kiểm tra kết nối:](#kiểm-tra-kết-nối)
  - [Tổng quan 3 câu lệnh:](#tổng-quan-3-câu-lệnh)


# Mục này tìm hiểu về 1 số câu lệnh hữu dụng khi sử dụng Linux

## Lệnh `ss`
### Tổng quát
Trong Linux, lệnh `ss` được sử dụng để hiển thị thông tin về các kết nối mạng, các port đang lắng nghe và các tiến trình mạng đang chạy trên hệ thống.
### Các tùy chọn của lệnh `ss`
Cấu trúc cơ bản của câu lệnh như sau:
```
ss [bộ lọc][tùy chọn]
```
Với các tùy chọn như sau:
- `-t`: Hiển thị thông tin về các kết nối **TCP**
- `-u`: Hiển thị thông tin về các kết nối **UDP**
- `-l`: Hiển thị danh sách các port đang lắng nghe
- `-p`: Hiển thị tiến trình liên quan đến các kết nối
- `-n`: Hiển thị địa chỉ IP và số cổng dưới dạng số(Không chuyển đổi sang tên miền hoặc tên dịch vụ)
- `-a`: Hiển thị tất cả các kết nối, bao gồm cả các kết nối không được lắng nghe
- .... Để biết thêm, các bạn có thể dùng lệnh `ss -h` hoặc `ss --help` để biết thêm các thông tin chi tiết

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

#### Hiển thị rõ thông tin port
Đôi khi lệnh `ss` sẽ tự động chuyển địa chỉ IP thành tên miền, port number sẽ bị chuyển thành tên dịch vụ. Để hiển thị rõ ràng các thông tin này, chúng ta sẽ sử dụng Options `-n` như sau:
```
ducmanh287@ubuntusv:~$ ss dst 192.168.217.1 -n
```
Kết quả sẽ được hiển thị rõ hơn trong ảnh sau:

![](/Anh/Screenshot_510.png)

## Lệnh `netstat`
### Tổng quan:
Lệnh `netstat` là một công cụ được sử dụng để hiển thị các kết nối mạng, bảng định tuyến, giao diện mạng và các thông tin liên quan khác trên hệ thống. 

==> Nó sẽ cung cấp một cái nhìn tổng quan về trạng thái mạng của hệ thống 
### Dùng để làm gì:
Lệnh `netstat` dùng để:
- Hiển thị các thông tin về kết nối mạng(TCP, UDP)
- Hiển thị danh sách các port đang lắng nghe
- Hiển thị các bảng định tuyến
- Hiển thị thông tin về giao diện mạng
- Hiện thị một vài thông tin khác liên quan đến mạng trên hệ thống
### Cấu trúc câu lệnh và cách sử dụng:
Cú pháp cơ bản của lệnh như sau:
```
netstat [tùy chọn]
```
Trong đó, các tùy chọn bao gồm như sau:
- `-t`: Hiển thị thông tin về các kết nối **TCP**
- `-u`: Hiển thị thông tin về các kết nối **UDP**
- `-l`: Hiển thị danh sách các port đang lắng nghe
- `-p`: Hiển thị tiến trình liên quan đến các kết nối
- `-n`: Hiển thị địa chỉ IP và số cổng dưới dạng số(Không chuyển đổi sang tên miền hoặc tên dịch vụ)
- `-a`: Hiển thị tất cả các kết nối, bao gồm cả các kết nối không được lắng nghe
- `-r` để hiện thị các bảng định tuyến

### Sử dụng lệnh
Mặc định `netstat` không được cài sẵn trên máy chủ, vì vậy nếu muốn sử dụng lệnh này, chúng ta cần thực hiện cài đặt câu lệnh như sau:
```
sudo apt install -y net-tools
```
#### Xem danh sách trạng thái các thiết bị:
```
root@ubuntusv:~# netstat device status
# Có thể thêm options `-n` để hiển thị rõ địa chỉ IP, cổng port
```
Bảng hiển thị kết quả sẽ trông như sau:

![](/Anh/Screenshot_511.png)

#### Hoặc thực hiện lọc các kết nối cơ bản như sau:
Hiển thị thông tin các kết nối TCP
```
root@ubuntusv:~# netstat -tn
```
Kết quả hiển thị:

![](/Anh/Screenshot_512.png)

Cũng có thể kết hợp với `grep` để bắt các kết nối qua port 22 như sau:
```
root@ubuntusv:~# netstat -ln | grep :22
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp6       0      0 :::22                   :::*                    LISTEN
```
#### Xem bảng định tuyến 
Để xem được bảng định tuyến thông qua lệnh `netstat` chúng ta làm như sau:
```
root@ubuntusv:~# netstat -r
```
Kết quả hiển thị sẽ trông như sau:
```
root@ubuntusv:~# netstat -rn
Kernel IP routing table
Destination     Gateway         Genmask          Flags   MSS Window    irtt   Iface
0.0.0.0         192.168.217.2   0.0.0.0          UG        0 0           0    ens33
192.168.217.0   0.0.0.0         255.255.255.0    U         0 0           0    ens33
192.168.217.2   0.0.0.0         255.255.255.255  UH        0 0           0    ens33
```
Trong đó:
- **Destination**: Địa chỉ mạng đích.
- **Gateway**: Gateway mà các gói tin được chuyển đến.
- **Genmask**: Mặt nạ mạng.
- **Flags**: Các cờ cho bảng định tuyến.
- **MSS**: Kích thước lớn nhất cho đoạn dữ liệu được truyền
- **Window**: Dung lương tối đa mà máy chủ hoặc máy tính chấp nhận
- **irtt**: Thời gian trung bình gói tin đi
- **Iface**: Interface mạng
#### So sánh
So với lệnh `ss` việc hiển thị các thông tin có vẻ dễ dàng thấy và đọc hiểu hơn nhưng việc tìm kiếm và lọc đôi khi có một vài bất tiện như sau:
- Việc trùng lặp 1 số phần trong địa chỉ IP khiến việc tìm kiếm tốn hơn

![](/Anh/Screenshot_513.png)

## Lệnh `nc`
### Tổng quan
`nc` hay còn gọi là *netcat* là một công cụ mạnh mẽ được sử dụng để thiết lập kết nối mạng, gửi và nhận dữ liệu trên giao thức TCP hoặc UDP. 

### Tác dụng của lệnh
Lệnh `nc` có tác dụng như sau:
- Tạo kết nối mạng TCP hoặc UDP
- Gửi và nhận dữ liệu qua mạng
- Lắng nghe kết nối đến cổng cụ thể
- Thực hiện các kiểm tra về mạng
### Cú pháp lệnh và cách sử dụng
Cú pháp cơ bản:
```
nc [tùy chọn] [địa chỉ] [cổng]
```
Trong đó, có các tùy chọn như:
- `-l`: Lắng nghe trên một cổng cụ thể
- `-p`: Xác định cổng sử dụng
- `-u`: Sử dụng giao thức UDP thay vì TCP
- `-v`: Hiển thị thông tin chi tiết

Để rõ hơn về cách sử dụng, chúng ta cùng đến phần sử dụng câu lệnh
### Một vài ví dụ về sử dụng lệnh `nc`
#### Gửi dữ liệu từ máy A sang B thông qua TCP/UDP 
- Ở cả máy gửi và nhận chúng ta đều cần phải cài đặt netcat nếu chưa có
- Thực hiện tắt tường lửa hoặc đồng thời ở cả 2 máy mở 1 port cho việc truyền
- Vì thực hiện trên 2 máy ảo nên tôi sẽ thực hiện tắt tường lửa. Còn đối với Server, các bạn nên chỉ thực hiện mở Port

Đối với bên gửi:
```
# Thực hiện câu lệnh sau để gửi dữ liệu đi
root@ubuntusv:~# echo "Hello, Client" | nc 192.168.217.132 12345
```
Đối với bên nhận:
```
# Sử dụng lệnh sau để lắng nghe trên cổng:
[root@localhost ducmanh287]# nc -l 12345
Hello, Client               # Kết quả hiển thị
```

#### Kiểm tra kết nối:
Để kiểm tra kết nối, chúng ta có thể sử dụng như sau:
```
root@ubuntusv:~# nc -zv 192.168.217.132 22
Connection to 192.168.217.132 22 port [tcp/ssh] succeeded!
# Như trong đoạn trên, kết nối tới port 22 là tcp/ssh thành công

root@ubuntusv:~# nc -zv myweb.com 80
Connection to myweb.com (50.6.160.97) 80 port [tcp/http] succeeded!
# Như đoạn trên, kết nối tới website: myweb.com thông qua port 80 đã thành công
```
## Tổng quan 3 câu lệnh:
| --|ss|netstat|nc|
|---|--|-------|--|
|**Tính năng chính**|Hiển thị thông tin các kết nối mạng, bảng định tuyến, các thông tin liên quan đến hệ thống|Hiển thị các thông tin về các kết nối mạng, bảng định tuyến, giao diện mạng và các thông tin liên quan trên hệ thống|Tạo và quản lý kết nối mạng, gửi và nhận dữ liệu trên giao thức TCP hoặc UDP|
|**Tính linh hoạt**|Có thể tinh chỉnh kết quả hiển thị qua bộ lọc và tùy chọn|Có thể tinh chỉnh kết quả hiển thị thông qua bộ lọc, tuy nhiên, không được tối ưu bằng ss|Có thể hoạt động như máy chủ(lắng nghe kết nối), hoặc máy khách(thiết lập kết nối)|
|**Tổng kết**|Phù hợp sử dụng khi bạn cần công cụ linh hoạt và mạnh mẽ để kiểm tra và hiển thị các kết nối mạng|Phù hợp sử dụng khi bạn cần công cụ đơn giản để kiểm tra các kết nối mạng cơ bản|Phù hợp sử dụng khi bạn cần thực hiện các thao tác trực tiếp với kết nối mạng|
