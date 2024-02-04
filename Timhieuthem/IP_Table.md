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

## Ưu và Nhược điểm của IP Tables
Ưu điểm:
- Mạnh mẽ và linh hoạt, cho phép bạn thiết lập các quy tắc theo nhiều tiêu chí khác nhau.
- Phổ biến và được tích hợp sẵn trên hầu hết các bản phân phối Linux.
- Có khả năng xử lý lưu lượng mạng lớn với hiệu suất tốt.

Nhược điểm:
- Cấu hình phức tạp và khó hiểu đối với người mới sử dụng.
- Dễ gặp lỗi khi thiết lập quy tắc không đúng cách có thể dẫn đến lỗi mạng.
- Không có giao diện đồ họa, chỉ có giao diện dòng lệnh.
