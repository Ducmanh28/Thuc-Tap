# Mục này tìm hiểu về IP Tables

## Giới thiệu về IP Table:
Trước khi tìm hiểu về IP Table, chúng ta cần hiểu rõ tường lửa là gì.
- Tường lửa (Firewall) là một phần quan trọng trong hệ thống bảo mật mạng, được sử dụng để kiểm soát và giám sát lưu lượng mạng đi và đến từ một mạng hoặc máy tính cụ thể. 
- Chức năng chính của tường lửa là ngăn chặn hoặc cho phép lưu lượng mạng dựa trên các quy tắc được thiết lập trước.

Trong hệ điều hành Linux
- Tường lửa được thực thi tốt nhất bằng cách sử dụng netfilter. Đây là một kernel module quyết định packet nào được phép đi vào (input) hoặc đi ra bên ngoài (output).
- iptables chỉ là interface cho netfilter và cả hai thường được coi là tương tự nhau. Một cách nhìn dễ hiểu hơn là nghĩ về nó như một backend và một frontend.

==> IP Tables là một công cụ mạnh mẽ được sử dụng trên hệ điều hành Linux để quản lý tường lửa và quy tắc mạng. 

## Dùng để làm gì?

Bảo vệ hệ thống Linux bằng cách kiểm soát lưu lượng mạng.

Ngăn chặn hoặc cho phép giao tiếp mạng dựa trên các quy tắc bạn định nghĩa.

Thực hiện chuyển hướng lưu lượng mạng từ các nguồn đến các đích khác nhau.

Quản lý cấu hình tường lửa trên hệ thống.

## Tại sao chúng ta cần sử dụng Ip Table?
Như chúng ta đã biết, Linux có các tường lửa đơn giản cho người dùng sử dụng như Firewalld hoặc UFW.

Tuy nhiên, chính do sự đơn giản này khiến cho chúng bị giảm tính linh hoạt và không thể tận dụng được hết các tính năng của IPtable
- Firewalld và UFW chỉ cho phép bạn chấp nhận hoặc từ chối một gói tin. Nhưng còn rất nhiều việc mà bạn có thể làm được với một gói tin như
  - NAT
  - ghi Log
  - Forward,....

## Vậy cách IP Tables hoạt động ra sao?
IP Tables hoạt động dựa trên các quy tắc (rules) bạn đặt ra trước. 

Khi một gói tin mạng đi qua hệ thống, IP Tables kiểm tra gói tin này và áp dụng các quy tắc tương ứng. Nếu gói tin phù hợp với một quy tắc, IP Tables sẽ thực hiện hành động được chỉ định trong quy tắc đó (ví dụ: chấp nhận, từ chối hoặc chuyển hướng gói tin).

## Các thành phần cơ bản của IPtables
Iptables hoạt động dựa trên các dòng lệnh để tương tác với Packet Filtering vủa Netfilter Framework.

Cơ chế lọc gói tin của Iptables được xây dựng hoạt động dựa trên 3 thành phần cơ bản khác nhau:
- Tables: Các bảng trong IPtables
- Chains
- Targets

### Các bảng trong IPtables:
Là một trong những thành phần xử lý các gói tin theo những cách cụ thể khác nhau

Nếu không được chỉ định một công việc nào đó cụ thể thì các bảng tính này sẽ mặc định làm việc với filter table
#### Filter Table
Là một trong những bảng được sử dụng nhiều nhất

Được tích hợp với nhiệm vụ chính là quyết định việc một gói tin có được đi đến đích dự kiến hay không?

Hoặc nó sẽ quyết định từ chối yêu cầu của gói tin một cách chắc chắn và nhanh chóng

#### NAT Table
Sẽ dùng các rules về NAT

Chịu trách nhiệm chỉnh sửa các Source hay còn gọi là IP nguồn.

Hoặc nó sẽ chỉnh các IP đích của gói tin. 

Với sự hiện diện của bảng NAT, việc chỉnh sửa thông tin gói tin khi thực hiện cơ chế NAT trở nên đơn giản, dễ dàng hơn

#### Mangle Table
Là một trong những bảng quan trọng của IPtables

Có nhiệm vụ chỉnh sửa Header của gói tin.

Sự hiện diện của bảng này còn cho phép chỉnh sửa các giá trị của các trường: **TTL**, **MTL**, **Type of Service**

#### RAM Table
Dựa theo bản chất của Iptables thì Iptables là một stateful firewall với các gói tin. Các gói tin này được kiểm tra liên quan đến trạng thái State.

RAM Tablet sẽ là bảng giúp người dùng dễ dàng làm việc với các gói tin trước khi kernel bắt đầu kiểm tra trạng thái

Bảng RAM cũng chức năng loại bỏ một số gói tin khỏi việc tracking vì vấn đề hiệu năng của hệ thống

#### Sercurity Table
Một số Kernel có thể hỗ trợ thêm cho Security Table, được dùng bởi Selinux từ đó giúp thiết lập các chính sách bảo mật hiệu quả.

Vậy nên Security Table luôn là một trong những bảng quan trọng trong các bảng của Iptables.

### Chains 
Thành phần này được tạo ra với một số lượng nhất định ứng với mỗi bảng trong Iptables.

Công dụng chính của thành phần này chính là giúp lọc gói tin tại điểm khác nhau.

![](/Anh/Screenshot_445.png)

Có các loại Chains như sau:
- **Chain Prerouting**: Chain tồn tại trong NAT Table, Mangle Table và Raw Table. Các rules trong Chain sẽ được thực thi ngay khi gói tin vào đến giao diện Network Interface
- **Chain Input**: Chain chỉ có ở Mangle Table và Nat Table. Các rules trong Chain này được cung cấp nhiệm vụ thực thi trước khi gói tin tiến vào tiến trình
- **Chain Output**: Chain này tồn tại ở các bảng quen thuộc như Raw Table, Mangle Table và Filter. Các rules ở đây được thực thi sau khi gói tin tiến trình được tạo ra
- **Chain Forward**: Tồn tại trong các bảng Mangle Table và Filter Table. Các rules cung cấp nhiệm vụ thực thi cho các gói tin được định tuyến qua host hiện đại
- **Chain Postrouting**: Chỉ tồn tại ở bảng Mangle Table và NAT Table. Các rules trong Chain được thực thi khi gói tin rời giao diện Internet.

### Target
Bộ phận cuối cùng chính là **Target** - hành động sử dụng dành cho các gói tin khi các gói tin thỏa mãn các rules đặt ra
- **ACCEPT**: Hành động chấp nhận và cho phép gói tin đi vào hệ thống
- **DROP**: Hành động loại gói tin, không có gói tin trả lời.
- **REJECT**: Hành động loại gói tin nhưng vẫn cho phép gói tin trả lời Table gói tin khác. 
- **LOG**: Hành động chấp thuận gói tin nhưng có ghi lại log

Target là hành động dành cho gói tin được phép đi qua tất cả các rules đặt ra mà không dừng lại ở bất kỳ rules nào. Trong trường hợp gói tin không khớp với yêu cầu của reles thì mặc định sẽ được chấp thuận

## Ưu và Nhược điểm của IP Tables
Ưu điểm:
- Mạnh mẽ và linh hoạt, cho phép bạn thiết lập các quy tắc theo nhiều tiêu chí khác nhau.
- Phổ biến và được tích hợp sẵn trên hầu hết các bản phân phối Linux.
- Có khả năng xử lý lưu lượng mạng lớn với hiệu suất tốt.

Nhược điểm:
- Cấu hình phức tạp và khó hiểu đối với người mới sử dụng.
- Dễ gặp lỗi khi thiết lập quy tắc không đúng cách có thể dẫn đến lỗi mạng.
- Không có giao diện đồ họa, chỉ có giao diện dòng lệnh.
## Sử dụng IP Tables
### Các tuỳ chọn khi sử dụng IP Tables
#### Những tuỳ chọn để chỉ định thông số IpTables
- Chỉ định tên: `-t`
- Loại giao thức: `-p`
- Card mạng vào: `-i`
- Card mạng ra: `-o`
- Chỉ định IP nguồn: `-s <địa_chỉ_IP_nguồn>`
- Chỉ định IP đích: `-d <địa_chỉ_IP_đích>`
- Chỉ định cổng nguồn: `-sport`
- Chỉ định cổng đích: `-dport`
#### Những tuỳ chọn để thao tác với chain
- Tạo chain mới: `Iptables -N`
- Xoá hết các rule đã có trong chain: `Iptables -X`
- Đặt danh sách cho các chain: ‘built-in’(INPUT, OUTPUT & FORWARD): `Iptables – p`
- Liệt kê các rules trong chain: `Iptables -L`
- Xoá các rule trong chain: `Iptalbes -F`
- Reset bộ đếm Packet về 0: `Iptables -Z`
#### Những tuỳ chọn để thao tác với Rule
- Thêm rule: `-A`
- Xoá rule: `-D`
- Thay thế rule: `-R`
- Chèn thêm rule: `-I`

### Các lệnh cơ bản
#### Tạo một rule mới:
```
iptables -A INPUT -i Io -j ACCEPT
```
Có nghĩa là:
  - `A` nghĩa là Append. `A INPUT` nghĩa là kiểu kết nối sẽ được áp dụng
  - `I` nghĩa là Internet. `I Io` nghĩa là khai báo thiết bị mạng được áp dụng
  - `J` nghĩa là Jump. `J ACCEPT` nghĩa là khai báo hành động sẽ được áp dụng cho quy tắc này

Sau đó bạn gõ lệnh dưới thì sẽ thấy ngay 1 rule mới đã xuất hiện
```
iptables -L -v
```
Sau khi thêm rules thành công, bạn thực hiện lưu và reset lại IP tables:
```
service iptables save
service iptables restart
```
Nếu tiếp tục thêm rule để được phép lưu lại quá trình kết nối hiện tại cũng như tránh các hiện tượng tự Block ra khỏi máy chủ thì hãy thực hiện đúng lệnh quy định.
```
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
``` 
Để các cổng được phép truy cập từ bên ngoài vào qua giao thức tcp thì hãy thực hiện theo lệnh.
```
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
```
Trong đó:
- `-p tcp`: giao thức được áp dụng
- `-dport 22`: Cổng được cho phép áp dụng

Để ngăn chặn tất cả các kết nối truy cập theo hướng từ bên ngoài vào không thỏa mãn những rule trên
```
iptables -A INPUT -j DROP
```
#### Bổ sung một rule mới
Để chèn 1 rule mới vào trong 1 vị trí nào đó thì việc sử dụng các lệnh bổ sung thêm rule là điều quan trọng. Trong đó người dùng chỉ cần thay tham số `-A` table bằng tham số INSERT `–l` là xong. 

Cấu trúc lệnh bổ sung 1 rule mới:
```
IPtables -I INPUT 2 -p tcp --dport 8080 -j ACCEPT 
```
#### Xoá một rule:
Để thực hiện xóa 1 rule trong Iptables mà đã tạo ra tại vị trí 4, bạn có thể sử dụng lệnh xóa với tham số -D. Cấu trúc lệnh xóa 1 rule chi tiết như sau:
```
IPtables -D INPUT 4
```
Trong trường hợp bạn muốn thực hiện thao tác xóa toàn bộ các rule chứa hành động DROP có trong Iptables rất đơn giản. Bạn chỉ cần thực hiện lệnh với cấu trúc như sau sẽ dễ dàng loại bỏ tất cả các rule này.
```
IPtables -D INPUT -j DROP
```
### Cài đặt IP Tables trên Ubuntu Server
Mặc định Ubuntu Server đã được cài đặt sẵn IP Table nên chúng ta cần kiểm tra xem máy đã có IpTables hay chưa rồi mới tiến hành cài đặt. Sử dụng lệnh sau để kiểm tra:
```
dpkg -l | grep iptables
```
Nếu kết quả hiện như sau nghĩa là đã có IpTables rồi
![](/Anh/Screenshot_449.png)

Nếu thực sự chưa có IpTables, ta tiến hành cài đặt bằng lệnh sau:
```
sudo apt update
sudo apt install -y iptables
```
### Một vài thao tác cơ bản sử dụng IP Tables
Xem danh sách các Rule: `sudo iptables -L`

![](/Anh/Screenshot_450.png)

Tạo và sửa đổi các luật
- Bạn có thể tạo và sửa đổi các luật trong iptables bằng các lệnh như `iptables -A`, `iptables -D`, `iptables -I`, v.v.
- Để lưu các thay đổi để chúng tồn tại qua các lần khởi động lại hệ thống, bạn cần sử dụng lệnh `iptables-save` để lưu cấu hình iptables vào một tệp tin và sau đó khôi phục nó bằng lệnh `iptables-restore`.

Xoá các luật:
- Để xóa một luật, bạn có thể sử dụng lệnh `iptables -D`.

Chọn hành động mặc định cho các chain
- Bạn có thể xác định hành động mặc định cho các chuỗi bằng lệnh iptables -P.
- Ví dụ: để chặn tất cả các gói tin đến chuỗi INPUT
```
iptables -P INPUT DROP
```
## Tài liệu tham khảo:
[FPT Cloud](https://fptcloud.com/iptables/)
