# Mục này tìm hiểu về IP Tables

## Giới thiệu về IP Table:
Trước khi tìm hiểu về IP Table, chúng ta cần hiểu rõ tường lửa là gì.
- Tường lửa (Firewall) là một phần quan trọng trong hệ thống bảo mật mạng, được sử dụng để kiểm soát và giám sát lưu lượng mạng đi và đến từ một mạng hoặc máy tính cụ thể. 
- Chức năng chính của tường lửa là ngăn chặn hoặc cho phép lưu lượng mạng dựa trên các quy tắc được thiết lập trước.

Trong hệ điều hành Linux
- Tường lửa được thực thi tốt nhất bằng cách sử dụng netfilter. Đây là một kernel module quyết định packet nào được phép đi vào (input) hoặc đi ra bên ngoài (output).
- iptables chỉ là interface cho netfilter và cả hai thường được coi là tương tự nhau. Một cách nhìn dễ hiểu hơn là nghĩ về nó như một backend và một frontend.

==> IP Tables là một công cụ mạnh mẽ được sử dụng trên hệ điều hành Linux để quản lý tường lửa và quy tắc mạng. 

## Tại sao chúng ta cần sử dụng Ip Table?
Như chúng ta đã biết, Linux có các tường lửa đơn giản cho người dùng sử dụng như Firewalld hoặc UFW.

Tuy nhiên, chính do sự đơn giản này khiến cho chúng bị giảm tính linh hoạt và không thể tận dụng được hết các tính năng của IPtable
- Firewalld và UFW chỉ cho phép bạn chấp nhận hoặc từ chối một gói tin. Nhưng còn rất nhiều việc mà bạn có thể làm được với một gói tin như
  - NAT
  - ghi Log
  - Forward,....

