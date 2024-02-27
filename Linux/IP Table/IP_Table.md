# Mục này tìm hiểu về IP Tables
Mục Lục
- [Mục này tìm hiểu về IP Tables](#mục-này-tìm-hiểu-về-ip-tables)
  - [Giới thiệu về IP Table:](#giới-thiệu-về-ip-table)
  - [Dùng để làm gì?](#dùng-để-làm-gì)
  - [Tại sao chúng ta cần sử dụng Ip Table?](#tại-sao-chúng-ta-cần-sử-dụng-ip-table)
  - [Vậy cách IP Tables hoạt động ra sao?](#vậy-cách-ip-tables-hoạt-động-ra-sao)
  - [Các thành phần cơ bản của IPtables](#các-thành-phần-cơ-bản-của-iptables)
    - [Các bảng trong IPtables:](#các-bảng-trong-iptables)
      - [Filter Table](#filter-table)
      - [NAT Table](#nat-table)
      - [Mangle Table](#mangle-table)
      - [RAM(RAW) Table](#ramraw-table)
      - [Sercurity Table](#sercurity-table)
    - [Chains](#chains)
    - [Rule:](#rule)
  - [Thứ tự các bảng mà một gói tin phải đi qua](#thứ-tự-các-bảng-mà-một-gói-tin-phải-đi-qua)
  - [Quy trình xử lý gói tin của IP Table](#quy-trình-xử-lý-gói-tin-của-ip-table)
    - [Quyết định bảng:](#quyết-định-bảng)
    - [Chọn Chain:](#chọn-chain)
    - [Kiểm tra Rule](#kiểm-tra-rule)
    - [Áp dụng rule](#áp-dụng-rule)
    - [Xử lý tiếp theo:](#xử-lý-tiếp-theo)
    - [Kết thúc quy trình](#kết-thúc-quy-trình)
  - [Ưu và Nhược điểm của IP Tables](#ưu-và-nhược-điểm-của-ip-tables)
  - [Sử dụng IP Tables](#sử-dụng-ip-tables)
    - [Các tuỳ chọn khi sử dụng IP Tables](#các-tuỳ-chọn-khi-sử-dụng-ip-tables)
      - [Những tuỳ chọn để chỉ định thông số IpTables](#những-tuỳ-chọn-để-chỉ-định-thông-số-iptables)
      - [Những tuỳ chọn để thao tác với chain](#những-tuỳ-chọn-để-thao-tác-với-chain)
      - [Những tuỳ chọn để thao tác với Rule](#những-tuỳ-chọn-để-thao-tác-với-rule)
    - [Các lệnh cơ bản](#các-lệnh-cơ-bản)
      - [Tạo một rule mới:](#tạo-một-rule-mới)
      - [Bổ sung một rule mới](#bổ-sung-một-rule-mới)
      - [Xoá một rule:](#xoá-một-rule)
    - [Cài đặt IP Tables trên Ubuntu Server](#cài-đặt-ip-tables-trên-ubuntu-server)
    - [Một vài thao tác cơ bản sử dụng IP Tables](#một-vài-thao-tác-cơ-bản-sử-dụng-ip-tables)
  - [Tìm hiểu thêm?](#tìm-hiểu-thêm)
    - [Một gói tin có cần phải đi qua tất cả các bảng hay không?](#một-gói-tin-có-cần-phải-đi-qua-tất-cả-các-bảng-hay-không)
    - [Khi các rule bị mâu thuẫn với nhau thì điều gì xảy ra?](#khi-các-rule-bị-mâu-thuẫn-với-nhau-thì-điều-gì-xảy-ra)
  - [Tài liệu tham khảo:](#tài-liệu-tham-khảo)


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
- Chains: Hay còn gọi là các Chuỗi
- Rules: Các quy tắc
  - Targets: Các hành động

Mỗi bảng chứa nhiều chuỗi, mỗi chuỗi chứa nhiều Rule và Target
- Mỗi bảng sẽ định nghĩa một không gian tên để lưu trữ các quy tắc 
- Các chuỗi sẽ quy định các điều kiện và hành động được áp dụng cho các gói tin
- Các quy tắc sẽ xác định cách mà gói tin cụ thể sẽ được xử lý

### Các bảng trong IPtables:
Là một trong những thành phần xử lý các gói tin theo những cách cụ thể khác nhau

Nếu không được chỉ định một công việc nào đó cụ thể thì các bảng tính này sẽ mặc định làm việc với filter table
#### Filter Table
Là một trong những bảng được sử dụng nhiều nhất

Được tích hợp với nhiệm vụ chính là quyết định việc một gói tin có được đi đến đích dự kiến hay không?

Hoặc nó sẽ quyết định từ chối yêu cầu của gói tin một cách chắc chắn và nhanh chóng

Các chain trong bảng Filter:
- `Chain INPUT`: Được sử dụng để xác định các quy tắc áp dụng cho các gói tin đang đi vào hệ thống
- `Chain FORWARD`: Được sử dụng để xác định các quy tắc áp dụng cho các gói tin được chuyển tiếp qua hệ thống
- `Chain OUTPUT`: Được sử dụng để xác định các quy tắc áp dụng cho các gói tin đi ra khỏi hệ thống

#### NAT Table
Sẽ dùng các rules về NAT

Chịu trách nhiệm chỉnh sửa các Source hay còn gọi là IP nguồn.

Hoặc nó sẽ chỉnh các IP đích của gói tin. 

Với sự hiện diện của bảng NAT, việc chỉnh sửa thông tin gói tin khi thực hiện cơ chế NAT trở nên đơn giản, dễ dàng hơn

Các chain trong bảng NAT:
- `Chain PREROUTING`: Được sử dụng để điều chỉnh các gói tin trước khi chúng được định tuyến
- `Chain POSTROUTING`: Được sử dụng để điều chỉnh các gói tin sau khi chúng đã được định tuyến và trước khi ra khỏi hệ thống
- `Chain OUTPUT`: Được sử dụng để xác định các quy tắc áp dụng cho các gói tin được tạo ra từ chính hệ thống này

#### Mangle Table
Là một trong những bảng quan trọng của IPtables

Có nhiệm vụ chỉnh sửa Header của gói tin.

Sự hiện diện của bảng này còn cho phép chỉnh sửa các giá trị của các trường: **TTL**, **MTL**, **Type of Service**

Các chain trong bảng Mangle:
- `Chain PREROUTING`: Được sử dụng để thay đổi thông tin trong header của gói tin trước khi kernel xác định quy tắc định tuyến cho chúng
- `Chain INPUT`: Được sử dụng để xác định các quy tắc áp dụng cho gói tin đi vào hệ thống
- `Chain FORWARD`: Được sử dụng để xác định các quy tắc áp dụng cho gói tin được chuyển tiếp qua hệ thống
- `Chain OUTPUT`: Được sử dụng để xác định các quy tắc áp dụng cho gói tin đi ra khỏi hệ thống
- `Chain POSTROUTING`: Được sử dụng để thay đổi thông tin trong header của gói tin sau khi kernel xác định quy tắc định tuyến cho chúng

#### RAM(RAW) Table
Dựa theo bản chất của Iptables thì Iptables là một stateful firewall với các gói tin. Các gói tin này được kiểm tra liên quan đến trạng thái State.

RAM Tablet sẽ là bảng giúp người dùng dễ dàng làm việc với các gói tin trước khi kernel bắt đầu kiểm tra trạng thái

Bảng RAM cũng chức năng loại bỏ một số gói tin khỏi việc tracking vì vấn đề hiệu năng của hệ thống

Các chain trong bảng RAM:
- `Chain PREROUTING`: Chain này được sử dụng để xác định các quy tắc áp dụng cho các gói tin ngay khi chúng đến hệ thống, trước khi các quy tắc cụ thể khác được áp dụng
- `Chain OUTPUT`: Được sử dụng để xác định các quy tắc áp dụng cho các gói tin được tạo ra từ hệ thống

#### Sercurity Table
Một số Kernel có thể hỗ trợ thêm cho Security Table, được dùng bởi Selinux từ đó giúp thiết lập các chính sách bảo mật hiệu quả.

Vậy nên Security Table luôn là một trong những bảng quan trọng trong các bảng của Iptables.

Các chain trong bảng Sercurity
- `Chain INPUT`: Được sử dụng để xác định các quy tắc áp dụng cho các gói tin đang đi vào hệ thống, với sự kết hợp với các cơ chế kiểm soát truy cập như SELinux
- `Chain OUTPUT`: Được sử dụng để xác định quy tắc cho các gói tin đi ra khỏi hệ thống
- `Chain FORWARD`: Được sử dụng để  xác định các quy tắc áp dụng cho các gói tin được chuyển tiếp qua hệ thống, với sự kết hợp với các cơ chế kiểm soát truy cập như SELinux

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
### Rule:
Trong iptables, một rule là một tập hợp các điều kiện được xác định để kiểm tra các gói tin khi chúng đi qua tường lửa. Nếu gói tin khớp với các điều kiện được chỉ định trong rule, một hành động cụ thể sẽ được thực hiện trên gói tin đó.

Mỗi rule bao gồm các phần chính sau:
- **Matches**: Điều kiện mà gói tin cần phải thỏa mãn để được xem xét bởi rule. Các điều kiện này có thể bao gồm địa chỉ nguồn và đích, cổng nguồn và đích, giao thức, các thông tin trong header của gói tin (ví dụ: các thông tin TCP hoặc UDP), các dấu vết (marking), vv.
- **Target**: Hành động sẽ được thực hiện nếu gói tin khớp với rule. Các mục tiêu phổ biến bao gồm 
  - **ACCEPT** (chấp nhận gói tin), 
  - **DROP** (từ chối gói tin), 
  - **REJECT** (từ chối và gửi thông báo từ chối trở lại cho người gửi), 
  - **LOG** (ghi log về gói tin), 
  - **REDIRECT** (chuyển hướng) 
  - **MARK** (đánh dấu gói tin).
## Thứ tự các bảng mà một gói tin phải đi qua 
- Bảng RAW: Gói tin được xử lý trong bảng này trước tiên. Bảng này thường được sử dụng để cấu hình các quy tắc để ảnh hưởng đến gói tin trước khi các quy tắc trong các bảng khác được áp dụng
- Bảng Mangle: Bảng này thường được sử dụng để thay đổi các trường trong header của gói tin, nhưng cũng có thể được sử dụng để áp dụng các quy tắc tùy chỉnh khác.
- Bảng NAT: Gói tin được xử lý trong bảng nat để thực hiện các chức năng NAT (Network Address Translation) như chuyển đổi địa chỉ IP và cổng.
- Bảng Filter: Cuối cùng, gói tin đi qua bảng filter để kiểm tra và quyết định liệu gói tin đó có được chấp nhận (accept), từ chối (drop), hay xử lý theo các quy tắc khác được định nghĩa trong bảng này

## Quy trình xử lý gói tin của IP Table
### Quyết định bảng:
Khi một gói tin đến, kernel sẽ xác định bảng mà gói tin sẽ được xử lý. Quyết định này sẽ dựa trên mục đích của gói tin

Ví dụ: định tuyến, tường lửa, NAT, vv...

### Chọn Chain:
Trong bảng đã quyết định ở trên, kernel sẽ xác định các chain trong bảng đó mà gói tin sẽ phải đi qua.

Tất nhiên, quy trình sẽ theo thứ tự vào trước ra sau.

### Kiểm tra Rule
Gói tin sẽ được so khớp với các rules ở trong chain tương ứng. Mỗi rule sẽ định rõ một tập hợp các điều kiện mà gói tin cần thoả mãn để rule được áp dụng

### Áp dụng rule
Khi một gói tin khớp với một rule, hành động được chỉ định trong rule đó sẽ được thực hiện. 

### Xử lý tiếp theo:
Sau khi gói tin được xử lý bởi một rule, quá trình này có thể kết thúc(Nếu gói tin đã đáp ứng một rule cuối cùng)

Hoặc gói tin có thể được chuyển tiếp đến chain khác trong cùng bảng, hoặc sang bảng khác để tiếp tục quá trình xử lý

### Kết thúc quy trình
Khi gói tin đã đi qua tất cả các bước xử lý, quá trình xử lý kết thúc và gói tin được gửi đến kernel để định tuyến (nếu cần) hoặc được xử lý bởi ứng dụng đích đến
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
## Tìm hiểu thêm?
### Một gói tin có cần phải đi qua tất cả các bảng hay không?
Không, một gói tin không nhất thiết phải đi qua hết tất cả các bảng trong iptables. Thực tế, mỗi bảng trong iptables có mục đích và chức năng riêng, và một gói tin chỉ cần đi qua các bảng cần thiết để thực hiện các chức năng mong muốn.

Ví dụ, một gói tin có thể chỉ cần đi qua bảng filter để kiểm tra và quyết định liệu nó có được chấp nhận (accept) hay từ chối (drop) dựa trên các quy tắc tường lửa. Các gói tin không cần phải đi qua các bảng như nat, mangle, hoặc raw nếu không có yêu cầu cụ thể nào được áp dụng cho chúng.

Tuy nhiên, trong một số trường hợp, gói tin có thể đi qua nhiều bảng, đặc biệt là khi cần thực hiện các chức năng như NAT hoặc khi cần thay đổi header của gói tin trong bảng mangle. Nhưng không phải tất cả các gói tin đều cần đi qua mọi bảng. Quyết định về việc một gói tin đi qua các bảng nào được dựa trên cấu hình và các quy tắc được định nghĩa trong iptables.
### Khi các rule bị mâu thuẫn với nhau thì điều gì xảy ra?
Khi có hiện tượng mâu thuẫn giữa các rule trong cùng một bảng của iptables, quyết định về cách xử lý gói tin sẽ được áp dụng theo một số nguyên tắc ưu tiên:
- **Thứ tự của các rule trong chain**: Rule ở phía trên trong chain sẽ được áp dụng trước. Do đó, nếu có nhiều rule khớp với gói tin, rule ở trên cùng sẽ được áp dụng trước, và các rule ở dưới cùng sẽ được áp dụng sau.
- **Hành động mặc định của chain**: Nếu không có rule nào khớp với gói tin, hoặc nếu không có quy tắc nào được đặc biệt áp dụng, thì iptables sẽ thực hiện hành động mặc định cho chain đó. 
  - Ví dụ, trong chain filter, hành động mặc định thường là ACCEPT hoặc DROP tùy thuộc vào cấu hình của hệ thống.
- **Cơ chế quyết định xung đột**: Trong trường hợp có mâu thuẫn giữa các rule, iptables có các cơ chế quyết định xung đột để xác định rule nào sẽ được áp dụng. Các cơ chế này có thể bao gồm "First Match Wins" (rule đầu tiên khớp được áp dụng) hoặc "Last Match Wins" (rule cuối cùng khớp được áp dụng).

Trong một số trường hợp, việc xác định rõ ràng các quy tắc và ưu tiên giữa chúng là rất quan trọng để đảm bảo hệ thống iptables hoạt động như mong đợi và tránh các hiện tượng mâu thuẫn không mong muốn.
## Tài liệu tham khảo:
[FPT Cloud](https://fptcloud.com/iptables/)
