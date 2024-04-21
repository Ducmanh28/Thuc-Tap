# Mục này tìm hiểu về giao thức DNS trong Linux
## DNS là gì?
DNS(Domain Name Sýteam) là 1 hệ thống giúp con người và máy tính giao tiếp dễ hơn. DNS giúp biên dịch tên website hay hostname thành ngôn ngữ mà máy tính có thể hiểu được

Cơ bản thì DNS là 1 hệ thống biến đổi tên miền, tên website thành địa chỉ IP. Thông tin của từng tên miền ứng với địa chỉ IP nào thì được ghi lại trong 1 "thư viện danh bạ", và thư viện này được lưu trên các server DNS

**Miền phân cấp**: DNS cài đặt không gian tên phân cấp dùng cho các đối tượng trên Internet. Các tên DNS được xử lý từ trái sang phải, sử dụng dấu chấm để ngăn cách. Mỗi quốc gia có 1 tên miền, ngoài ra còn có 6 tên miền lớn gồm: edu, com, gov, org và net. 6 miền lớn này nằm ở Mỹ. Những tên miền không chỉ ra tên nước một cách tường minh thì mặc nhiên nằm ở Mỹ

## Các loại Server tham gia vào hệ thống DNS
### DNS Recursor
Đóng vai trò liên lạc với các server khác để thay nó làm nhiệm vụ phản hồi cho client. Nó như 1 nhân viên nhận nhiệm vụ lấy và trả thông tin cho client để tìm đúng thông tin chúng ta cần. Để tìm được thông tin, **DNS recursor** sẽ cần gọi đến **Root DNS Server**
### Local Nameserver
Dùng ể chứa thông tin để truy xuất và tìm kiếm máy chủ tên miền. Và thường được duy trì và phát triển bởi các doanh nghiệp hay các nhà cung cấp dịch vụ Internet
### Root Nameserver
Cũng thường được gọi là nameserver, là server quan trong nhất trong hệ thống cấp bậc của DNS. Nó không có tên cụ thể, bạn có thể hiểu nó là 1 thưc việc để định hướng tìm kiếm

Trên thực tế, **DNS recursive resolver** sẽ chuyển yêu cầu tới **Root Nameserver**, sau đó server sẽ phản hồi rằng nó cần tìm trong các *top-level domain name servers*(**TLD nameserver**) cụ thể nào.
### TLD Nameserver
Khi muốn truy cập Google hay Facebook, thường phần mở rộng sẽ là `.com`. Đây ,là 1 trong các *top-level domain*. Nó sẽ chịu trách nhiệm quản lý toàn bộ thông tin của 1 phần mở rộng tên miền chung
Ví dụ khi gõ `www.google.com` trên trình duyệt, TLD.**com** sẽ phản hồi từ 1 **DNS resolver** để giới thiệu cho nó 1 nơi chính thức chứa nguồn dữ liệu của tên miền(**Authoritative DNS server**)
### Authiritative Nameserver
Khi 1 DNS resolver tìm thấy 1 authoritative nameserver, đây là việc phân giải tên miền diễn ra. AN có chứa thông tin tên miền gắn với địa chỉ nào. Nó sẽ đưa cho recursive resolver địa chỉ IP cần thiết tìm thấy trong danh mục các bản ghi của nó