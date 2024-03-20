# Mục này tìm hiểu về tcpdump
Nếu như bạn sử dụng các phiên bản của hệ điều hành Unix/Linux, `tcpdump` sẽ là công cụ giúp bạn kiểm tra lưu lượng mạng và lưu lại những gói tin bắt được.

## TCPdump là gì?
Là công cụ hỗ trợ phân tích các gói dữ liệu mạng theo dòng lệnh.

Cho phép người sử dụng chặn và lọc các gói tin TCP/IP được truyền đi hoặc được nhận trên một mạng mà máy tính có tham gia.

Tcpdump sẽ lưu lại những gói tin đã bắt được, sau đó sẽ được dùng để phân tích

==> Nôm na hiểu đơn giản thì Tcpdump là một công cụ dò mạng, có vai trò trong việc gỡ rối và kiểm tra các vấn đề liên quan đến bảo mật và kết nối mạng

## TCPdump có thể được dùng để làm những gì?
- Kiểm tra và ghi lại lưu lượng mạng để phát hiện sự cố mạng
- Phân tích lưu lượng mạng để xác định vấn đề bảo mật hoặc hiệu suất
- Giám sát và kiểm tra hiệu suất mạng
- Điều tra và phân tích giao thức mạng

## Tcpdump cấu trúc như thế nào?
Thường được triển khai dưới dạng một ứng dụng dòng lệnh.
- Giao diện dòng lệnh: Cung cấp cho người dùng cú pháp và tùy chọn để chỉ định các yêu cầu cụ thể
- Bộ lọc: Cho phép người dùng lọc và chỉ định loại lưu lượng mạng cụ thể mà họ muốn theo dõi
- Giao diện lập trình ứng dụng(API): Cung cấp khả năng tích hợp TCPdump vào các ứng dụng mạng khác

Để lựa chọn gói tin phù hợp với nhu cầu của người sử dụng, tcpdump sẽ xuất ra màn hình một gói tin chạy trên card mạng mà máy chủ đang lắng nghe

Tùy vào các lựa chọn khác nhau mà người sử dụng có thể xuất mô tả ra một gói tin thành một file "`pcap`" để phân tích và có thể đọc nội dung "`pcap`" đó với tcpdump, hoặc sử dụng phần mềm khác như: WireShark trên Windows.

Đối với những trường hợp không có lựa chọn nào, lệnh `tcpdump` sẽ được chạy cho đến khi có tín hiệu ngắt từ người sử dụng. Sau khi dừng bắt các gói tin, `tcpdump` sẽ báo về các cột sau:
- **Packet Capture**: số lượng gói tin bắt được và xử lý
- **Packet Received by filter**: số lượng gói tin bắt được bởi bộ lọc
- **Packet dropped by kernel**: số lượng gói tin đã bị dropped bởi cơ chế bắt gói tin của hệ điều hành

Cấu trúc dòng lệnh của `tcpdump`:
```
tcpdump [options] [filter]
```
- Options: Các cờ được sử dụng để chỉ định cách thức hoạt động của `tcpdump`. Trong đó một số tùy chọn phổ biến như:
  - `-i <interface>`: Chỉ định giao diện mạng để lắng nghe
  - `-n`: Không giải quyết địa chỉ IP hoặc tên miền
  - `-v`: Hiển thị thông tin chi tiết hơn
  - `-c <count>`: Chỉ định số lượng gói tin sẽ được ghi lại trước khi `tcpdump` dừng
  - `-w <file>`: Lưu lưu lượng gói tin vào 1 file
  - `-r <file>`: Đọc lưu lượng gói tin từ 1 tập tin
  - .........
- Filter: Được sử dụng để chỉ định các điều kiện để `tcpdump` chỉ ghi lại hoặc hiển thị các gói tin cụ thể. Các bộ lọc có thể áp dụng cho các thuộc tính như địa chỉ nguồn/đích, cổng, giao thức, và nhiều thuộc tính khác. Bộ lọc có thể là một biểu thức đơn giản hoặc là kết hợp của nhiều biểu thức. Filter có thể là:
  - hostname
  - network
  - ports
  - source
  - destination
  - protocols
- Một vài ví dụ:
```
# Ghi lại tất cả lưu lượng mạng trên giao diện mạng ens33
tcpdump -i ens33

# Ghi lại lưu lượng TCP từ địa chỉ nguồn đến địa chỉ đích
tcpdump tcp and src host 192.168.217.128 and dst host 8.8.8.8

# Ghi lại lưu lượng ICMP đến hoặc đi từ địa chỉ IP
tcpdump icmp and host 192.168.217.128

# Hiển thị thông tin chi tiết hơn
tcpdump -i ens33 -v

.......
``` 

Cấu trúc `ouput tcpdump`: Các bạn có thể dùng lệnh sau để bắt các gói tin đi qua một giao diện mạng: `tcpdump -i ens33`. Bây giờ chúng ta cùng đi phân tích kết quả đầu ra: 
```
13:38:22.830259 IP 192.168.217.1.52122 > localhost.localdomain.ssh: Flags [.], ack 80, win 4104, length 0

#Time-stamp src>dst: flags data-seqno ack window urgent options
```
- `13:38:22.830259`: Thời gian bắt được gói tin. Ở đây là 13:38:22.830259
- Phần đầu của gói tin sẽ mô tả thông tin về giao thức, địa chỉ và các thông tin kết nối mạng, bao gồm:
  - `IP`: Giao thức IP
  - `192.168.217.1.52122`: Địa chỉ nguồn của gói tin là `192.168.217.1` với cổng nguồn là 52122
  - `localhost.localdomain.ssh`: Địa chỉ đích của gói tin là `localhost.localdomain` với giao thức SSH
- Phần còn lại là phần mô tả các cờ và một số thông tin khác về gói tin
  - `Flags[.], ack 80`: Đây là cờ được đặt trong gói tin. Trong trường hợp này cờ được thiết lập là `.`(ACK), và số thứ tự của gói tin mà gói tin này đang xác nhận là 80 
  - `win 4104`: Đây là cửa sổ nhận của đích, có giá trị là 4104
  - `length 0`: Chiều dài của gói tin, ở đây là 0 byte

Tổng quát:
- **Time-stamp**: hiển thị thời gian gói tin được capture.
- **Src và dst**: hiển thị địa IP của người gửi và người nhận.
- Cờ **Flag** thì bao gồm các giá trị sau:
  - `S(SYN)`:  Được sử dụng trong quá trình bắt tay của giao thức TCP.
  - `.(ACK)`:  Được sử dụng để thông báo cho bên gửi biết là gói tin đã nhận được dữ liệu thành công.
  - `F(FIN)`: Được sử dụng để đóng kết nối TCP.
  - `P(PUSH)`: Thường được đặt ở cuối để đánh dấu việc truyền dữ liệu.
  - `R(RST)`: Được sử dụng khi muốn thiết lập lại đường truyền.
- **Data-sqeno**: Số sequence number của gói dữ liệu hiện tại.
- **ACK**: Mô tả số sequence number tiếp theo của gói tin do bên gởi truyền (số sequence number mong muốn nhận được).
- **Window**: Vùng nhớ đệm có sẵn theo hướng khác trên kết nối này.
- **Urgent**: Cho biết có dữ liệu khẩn cấp trong gói tin.

## Một chút so sánh giữa Tcpdump và WireShark
### TCPDump:
Ưu điểm:
- Dòng lệnh: TCPDump hoạt động dựa trên dòng lệnh, điều này làm cho việc sử dụng nó trên các hệ thống không có giao diện đồ họa trở nên dễ dàng hơn.
- Tính nhẹ nhàng: Vì TCPDump hoạt động trên dòng lệnh và không có giao diện đồ họa phức tạp như Wireshark, nên nó có thể chạy trên các hệ thống với tài nguyên hạn chế.
Hiệu suất: Do không có giao diện đồ họa, TCPDump thường có thể xử lý lưu lượng mạng lớn một cách hiệu quả hơn.

Nhược điểm:
- Khó sử dụng cho người mới: TCPDump hoạt động dựa trên các lệnh dòng lệnh và cú pháp phức tạp, vì vậy nó có thể khó sử dụng cho người mới bắt đầu hoặc người không quen với việc làm việc trên dòng lệnh.
- Khó đọc kết quả: Kết quả được xuất ra bởi TCPDump thường là văn bản không định dạng, và có thể khó hiểu hoặc khó đọc đối với người không chuyên về mạng.
### Wireshark:
Ưu điểm:
- Giao diện đồ họa: Wireshark cung cấp một giao diện đồ họa thân thiện, giúp người dùng dễ dàng theo dõi và phân tích lưu lượng mạng.
- Phân tích chi tiết: Wireshark cung cấp nhiều công cụ và tính năng để phân tích chi tiết các gói tin mạng, bao gồm cả phân tích giao thức và phân tích dữ liệu.
- Hiển thị đồ họa: Wireshark có khả năng hiển thị dữ liệu theo các biểu đồ và đồ thị, giúp người dùng dễ dàng hơn trong việc hiểu và phân tích thông tin.

Nhược điểm:
- Tài nguyên hệ thống: Do có giao diện đồ họa phức tạp, Wireshark có thể đòi hỏi nhiều tài nguyên hệ thống hơn so với TCPDump.
- Khả năng phân tích trên cùng một giao diện: Wireshark thường phải xử lý lưu lượng mạng trên cùng một giao diện người dùng, điều này có thể làm giảm hiệu suất khi phải xử lý lưu lượng mạng lớn.