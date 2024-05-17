Mục lục
- [Mục này Show ra quá trình Lab DNS trên cụm máy lab của công ty](#mục-này-show-ra-quá-trình-lab-dns-trên-cụm-máy-lab-của-công-ty)
  - [RDP](#rdp)
    - [RDP là gì?](#rdp-là-gì)
    - [Cách sử dụng RDP](#cách-sử-dụng-rdp)
      - [Dùng trực tiếp qua Windows](#dùng-trực-tiếp-qua-windows)
      - [Dùng thông qua MobaXterm](#dùng-thông-qua-mobaxterm)
  - [Thực hành các bài lab về DNS Server Local trên hệ thống Lab công ty](#thực-hành-các-bài-lab-về-dns-server-local-trên-hệ-thống-lab-công-ty)
    - [Bài Lab 1: Cấu hình DNS Server Local giữa 2 máy Windows.](#bài-lab-1-cấu-hình-dns-server-local-giữa-2-máy-windows)
    - [Bài Lab 2: Cấu hình DNS Server Local sao cho Windows Client trỏ tới được 1 WebSite trên UbuntuWebServer](#bài-lab-2-cấu-hình-dns-server-local-sao-cho-windows-client-trỏ-tới-được-1-website-trên-ubuntuwebserver)
    - [Bài Lab 3: Cấu hình DNS Server Local sao cho Ubuntu Client trỏ tới được 1 trang web Public](#bài-lab-3-cấu-hình-dns-server-local-sao-cho-ubuntu-client-trỏ-tới-được-1-trang-web-public)

# Mục này Show ra quá trình Lab DNS trên cụm máy lab của công ty
Để có thể triển khai được mô hình trên cụm máy Lab của công ty, trước tiên chúng ta cần tìm hiểu về giao thức sẽ sử dụng để truy cập vào hệ thống lab. Ở đây, giao thức được sử dụng là RDP(Remote Desktop Protocol)

## RDP
### RDP là gì? 
Giao thức RDP (Remote Desktop Protocol) là một giao thức mạng được Microsoft phát triển, cho phép người dùng kết nối và điều khiển máy tính từ xa thông qua giao diện đồ họa. Dưới đây là tóm tắt về RDP:
- **Chức năng chính**: RDP cho phép người dùng truy cập vào một máy tính từ xa qua mạng, như thể họ đang ngồi trực tiếp trước máy tính đó. Giao thức này hỗ trợ nhiều phiên làm việc đồng thời, cho phép nhiều người dùng kết nối vào một máy chủ cùng lúc.
- **Cách hoạt động**: Khi sử dụng RDP, máy tính người dùng (client) gửi các thao tác như bàn phím và chuột tới máy tính từ xa (server). Máy chủ xử lý các thao tác này và gửi lại hình ảnh giao diện đồ họa tới máy khách. Điều này giúp người dùng thực hiện công việc từ xa mà không cần phải có mặt tại nơi đặt máy tính.
- **Bảo mật**: RDP hỗ trợ các biện pháp bảo mật như mã hóa dữ liệu, xác thực người dùng, và sử dụng giao thức TLS để bảo vệ dữ liệu truyền tải. Tuy nhiên, vì là một mục tiêu phổ biến của các cuộc tấn công mạng, việc bảo mật RDP yêu cầu cấu hình và giám sát cẩn thận.
- **Các tính năng**: RDP hỗ trợ truyền tải dữ liệu như âm thanh, đồ họa, in ấn từ xa, và chuyển đổi thiết bị ngoại vi. Nó cũng cho phép chia sẻ clipboard giữa máy chủ và máy khách, hỗ trợ các phiên làm việc đa màn hình, và khả năng điều chỉnh chất lượng kết nối dựa trên băng thông mạng.
- **Ứng dụng**: RDP thường được sử dụng trong các môi trường doanh nghiệp để quản lý máy chủ, hỗ trợ kỹ thuật từ xa, và làm việc từ xa. Ngoài ra, các phiên bản RDP cũng có sẵn trên nhiều hệ điều hành khác nhau, không chỉ trên Windows mà còn trên macOS, Linux, và thiết bị di động.
- **Phiên bản**: Phiên bản đầu tiên của RDP ra mắt vào năm 1996 và liên tục được cập nhật qua các phiên bản Windows. Phiên bản mới nhất (tính đến năm 2023) đi kèm với nhiều cải tiến về hiệu suất, bảo mật và các tính năng nâng cao.

### Cách sử dụng RDP
Có 2 cách để bạn có thể sử dụng RDP để điều khiển 1 máy windows khác trong mạng nội bộ.
- Dùng trực tiếp Remote Desktop trên Windows
- Dùng thông qua ứng dụng bên thứ 3 như MobaXterm

#### Dùng trực tiếp qua Windows
Truy cập `Search --> Remote Desktop Connection`

![](/Anh/Screenshot_643.png)
- Mục Computer: Sẽ là nơi bạn nhập tên thiết bị hoặc địa chỉ IP của máy mà bạn muốn kết nối tới
- Mục Username: Sẽ là nơi bạn nhập tên tài khoản để truy cập vào thiết bị muốn kết nối

Bạn cũng có thể cấu hình RDP để gửi file bằng cách trỏ vào ô `Local Resources --> Local Devices and Resources --> More` và tick chọn như sau:

![](/Anh/Screenshot_644.png)

Sau khi hoàn tất cấu hình, các bạn chọn `Connect` để kết nối

#### Dùng thông qua MobaXterm
Truy cập vào `MobaXterm --> New Session --> RDP`

Các bạn có thể cấu hình theo như bên dưới để tối ưu hóa kết nối RDP hơn

![](/Anh/Screenshot_646.png)

## Thực hành các bài lab về DNS Server Local trên hệ thống Lab công ty 
Trước khi thực hành các bài Lab, chúng ta cần thực hiện cài đặt lại tên máy chủ sao cho dễ nhận biết và sử dụng
- Bấm tổ hợp phím `Windows+R` để mở hộp thoại **Run** sau đó nhập vào `sysdm.cpl` để mở hộp thoại Systems Properties 
- Thực hiện đổi tên thành **WINSVM19**

![](/Anh/Screenshot_647.png)

Tiếp đó chúng ta thực hiện cài IP tĩnh cho hệ thống DNS như sau:

![](/Anh/Screenshot_648.png)

Cài đặt AD DS và DNS Server cho máy. Mục này đã làm ở **Lab_DNS_Windows**. Nếu các bạn chưa biết có thể tìm kiếm file và xem
### Bài Lab 1: Cấu hình DNS Server Local giữa 2 máy Windows.
Ban đầu khi thực hiện nslookup, không rõ máy chủ tên gì, không phân giải được gì:

![](/Anh/Screenshot_649.png)

Truy cập vào DNS Manager và thực hiện cấu hình. Tiến hành tạo 1 Reverse Look Up Zone.

![](/Anh/Screenshot_650.png)

Tạo bản ghi Reverse cho bản ghi A của DNS Server

![](/Anh/Screenshot_651.png)

Sau khi đã có bản ghi Reverse, chúng ta đã có cho mình 1 DNS Server. Bạn có thể sử dụng lệnh `nslookup` để kiểm tra. Server có thể phân giải được từ tên miền --> IP và ngược lại.

### Bài Lab 2: Cấu hình DNS Server Local sao cho Windows Client trỏ tới được 1 WebSite trên UbuntuWebServer
### Bài Lab 3: Cấu hình DNS Server Local sao cho Ubuntu Client trỏ tới được 1 trang web Public
