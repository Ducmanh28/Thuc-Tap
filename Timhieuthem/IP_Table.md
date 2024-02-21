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


## Tài liệu tham khảo:
[FPT Cloud](https://fptcloud.com/iptables/)
