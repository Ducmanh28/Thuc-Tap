# Mục này tìm hiểu về giao thức DNS trong Linux
MỤC LỤC
- [Mục này tìm hiểu về giao thức DNS trong Linux](#mục-này-tìm-hiểu-về-giao-thức-dns-trong-linux)
  - [DNS là gì?](#dns-là-gì)
  - [Lịch sử phát triển của DNS](#lịch-sử-phát-triển-của-dns)
    - ["Hosts" file](#hosts-file)
    - [1983:](#1983)
    - [1984:](#1984)
    - [1987:](#1987)
    - [1995:](#1995)
    - [1999:](#1999)
    - [2008:](#2008)
    - [2010:](#2010)
    - [2016:](#2016)
    - [2019:](#2019)
    - [2020:](#2020)
  - [Lưu lượng DNS](#lưu-lượng-dns)
  - [Các loại Server tham gia vào hệ thống DNS](#các-loại-server-tham-gia-vào-hệ-thống-dns)
    - [Máy chủ DNS cục bộ(Local Server DNS)](#máy-chủ-dns-cục-bộlocal-server-dns)
    - [Máy chủ DNS Gốc(Root DNS Server)](#máy-chủ-dns-gốcroot-dns-server)
    - [Máy chủ DNS cấp độ cao nhất(Top-Level Domain - TLD Server)](#máy-chủ-dns-cấp-độ-cao-nhấttop-level-domain---tld-server)
    - [Máy Chủ DNS Cung Cấp(Authoritative DNS Server)](#máy-chủ-dns-cung-cấpauthoritative-dns-server)
    - [Các Máy Chủ DNS Cơ Sở Khác (Recursive DNS Server, Forwarding DNS Server):](#các-máy-chủ-dns-cơ-sở-khác-recursive-dns-server-forwarding-dns-server)
  - [Mô hình và cách thức hoạt động của DNS](#mô-hình-và-cách-thức-hoạt-động-của-dns)
  - [DNS Caching và các loại bản ghi DNS](#dns-caching-và-các-loại-bản-ghi-dns)
  - [Cấu trúc gói tin DNS:](#cấu-trúc-gói-tin-dns)
    - [Header (Phần Đầu):](#header-phần-đầu)
    - [Câu Hỏi (Question Section):](#câu-hỏi-question-section)
    - [Câu Trả Lời (Answer Section):](#câu-trả-lời-answer-section)
    - [Bản Quản Lý (Authority Section):](#bản-quản-lý-authority-section)
    - [Bản Ghi Bổ Sung (Additional Section):](#bản-ghi-bổ-sung-additional-section)
  - [Các loại truy vấn DNS](#các-loại-truy-vấn-dns)

## DNS là gì?
DNS (Domain Name System) là một hệ thống dùng để chuyển đổi các tên miền (như example.com) thành địa chỉ IP tương ứng và ngược lại. Nó giúp máy tính và các thiết bị truy cập internet dễ dàng tìm kiếm và kết nối với các máy chủ và dịch vụ thông qua tên miền thay vì phải ghi nhớ địa chỉ IP số.

Cơ bản thì DNS là 1 hệ thống biến đổi tên miền, tên website thành địa chỉ IP và ngược lại. Thông tin của từng tên miền ứng với địa chỉ IP nào thì được ghi lại trong 1 "thư viện danh bạ", và thư viện này được lưu trên các server DNS.

**Miền phân cấp**: DNS cài đặt không gian tên phân cấp dùng cho các đối tượng trên Internet. Các tên DNS được xử lý từ trái sang phải, sử dụng dấu chấm để ngăn cách. Mỗi quốc gia có 1 tên miền, ngoài ra còn có 6 tên miền lớn gồm: edu, com, gov, org và net. 6 miền lớn này nằm ở Mỹ. Những tên miền không chỉ ra tên nước một cách tường minh thì mặc nhiên nằm ở Mỹ

## Lịch sử phát triển của DNS
Trước khi DNS được phát triển, các hệ thống sử dụng một phương tiện khác để ánh xạ tên miền vào địa chỉ IP. Trong thời khì sơ khai của Internet, việc quản lý, cung cấp thông tin về tên miền được thực hiện thông qua một tập hợp các tệp tin cục bộ được gọi là "hosts" file. Vậy thì "Hosts" file là gì?

### "Hosts" file
Là một tập tin văn bản cục bộ mà mỗi máy tính trong mạng lưu trữ để ánh xạ tên miền vào địa chỉ IP. Khi một máy tính cố gắng kết nối đến một máy chủ hoặc dịch vụ thông qua tên miền, hệ điều hành sẽ tra cứu trong tập tin "hosts" trước khi thực hiện truy vấn. Nếu tên miền được tìm thấy trong "hosts" file, hệ thống sẽ sử dụng địa chỉ IP được chỉ định trong tập tin này để thiết lập kết nối.

Tuy nhiên việc quản lý và cập nhật "hosts" file trở nên không khả thi khi Internet phát triển và có hàng ngàn hoặc thậm chí hàng triệu tên miền. Do đó, DNS được phát triển nhằm tạo ra một cơ chế phân phối, tự động và linh hoạt hơn để ánh xạ tên miền thành địa chỉ IP, giúp Internet trở nên quy mô lớn và dễ quản lý

Ngày nay, "Host" file vẫn còn tồn tại và đang được sử dụng. Nếu bạn sử dụng Windows, bạn có thể tìm thấy "Hosts" file ở đường dẫn sau: `C:\Windows\System32\drivers\etc\hosts`

### 1983: 
DNS được đề xuất trong RFC 882 và RFC 883 bởi **Paul Mockapetris** và **Jon Postel**. Đây là phiên bản DNS ban đầu.
### 1984: 
DNS được triển khai trong môi trường thực tế cho Internet.
### 1987: 
RFC 1034 và RFC 1035 được phát hành, mô tả một số cải tiến và mở rộng của DNS.
### 1995: 
RFC 2065 mô tả DNSSEC (DNS Security Extensions), một bản mở rộng của DNS để cung cấp tính toàn vẹn và xác thực cho thông tin DNS.
### 1999: 
RFC 2782 giới thiệu SRV (Service) records, mở ra khả năng định tuyến các dịch vụ cụ thể dựa trên tên miền.
### 2008: 
DNSSEC được triển khai rộng rãi và được coi là một phần quan trọng trong việc cải thiện bảo mật của hệ thống DNS.
### 2010: 
RFC 5966 mô tả **Happy Eyeballs**, một cơ chế để cải thiện khả năng kết nối khi sử dụng IPv6.
### 2016: 
RFC 7873 mô tả EDNS Client Subnet, một cơ chế để cung cấp thông tin về địa chỉ IP của máy khách cho máy chủ DNS, giúp cải thiện hiệu suất và khả năng chọn lựa của DNS.
### 2019: 
RFC 8484 mô tả DNS over HTTPS (DoH), một phương thức để bảo vệ quyền riêng tư và bảo mật khi truy vấn DNS bằng cách sử dụng HTTPS.
### 2020: 
RFC 8936 mô tả URI-RR, mở rộng khả năng sử dụng các kiểu URI trong hệ thống DNS.
## Lưu lượng DNS
Lưu lượng DNS (DNS traffic) là lượng dữ liệu truyền tải giữa máy tính của người dùng và các máy chủ DNS khi thực hiện việc phân giải tên miền thành địa chỉ IP. Khi một người dùng truy cập một trang web hoặc gửi email, máy tính của họ sẽ gửi yêu cầu DNS đến máy chủ DNS để phân giải tên miền thành địa chỉ IP. 

Sau đó, máy tính sẽ kết nối đến địa chỉ IP để truy cập trang web hoặc gửi email. Quá trình này sử dụng lưu lượng DNS và lưu lượng này phụ thuộc vào số lần truy cập trang web hoặc gửi email của người dùng. Vì vậy, các công ty và tổ chức cần phải quản lý lưu lượng DNS của mình để đảm bảo DNS server của họ hoạt động hiệu quả và đáp ứng được nhu cầu sử dụng của người dùng.

## Các loại Server tham gia vào hệ thống DNS
Có rất nhiều Server tham gia vào hệ thống DNS. Mỗi Server có một vai trò và chức năng cụ thể trong quá trình phân giải.
### Máy chủ DNS cục bộ(Local Server DNS)
**Vai trò**: Là máy chủ DNS mà các thiết bị trong mạng cục bộ kết nối trực tiếp đến

**Chức năng**: 
- Xử lý các truy vấn DNS từ các máy tính trong mạng cục bộ và gửi các truy vấn đến các máy chủ DNS khác khi cần thiết. 
- Lưu trữ các thông tin DNS đã truy vấn gần đây vào trong bộ nhớ cache để tăng tốc độ truy cập

### Máy chủ DNS Gốc(Root DNS Server)
**Vai trò**: Là máy chủ DNS ở cấp độ cao nhất trong hệ thống DNS

**Chức năng**: 
- Giữ các thông tin về các máy chủ DNS của các Tên Miền Cấp Độ Cao Nhất(TLDs)
- Cung cấp thông tin, định hướng tìm kiếm về các máy chủ DNS TLD cho các máy chủ cấp thấp hơn

Hiện nay có khoảng 13 máy chủ định danh gốc trên toàn cầu được duy trì bởi các tổ chức và cơ quan liên quan đến quản lý hệ thống tên miền

### Máy chủ DNS cấp độ cao nhất(Top-Level Domain - TLD Server) 
**Vai trò**: Là các máy chủ DNS chịu trách nhiệm cho các tên miền ở cấp độ cao nhất trong cấu trúc tên miền

**Chức năng**:
- Duy trì thông tin về các máy chủ DNS cung cấp cho các tên miền cụ thể trong TLD.
- Điều hướng truy vấn đến máy chủ DNS cung cấp cho các tên miền cụ thể

### Máy Chủ DNS Cung Cấp(Authoritative DNS Server)
**Vai Trò**: Là các máy chủ DNS duy trì thông tin chính xác và chi tiết nhất về tên miền cụ thể.

**Chức Năng**: 
- Duy trì các bản ghi DNS cho tên miền cụ thể, bao gồm A records (địa chỉ IPv4), AAAA records (địa chỉ IPv6), MX records (thông tin về mail server) và các loại bản ghi khác. 
- Phản hồi cho các truy vấn DNS với thông tin chính xác về tên miền.

### Các Máy Chủ DNS Cơ Sở Khác (Recursive DNS Server, Forwarding DNS Server):
**Vai Trò**: Được sử dụng để thực hiện các truy vấn DNS cho người dùng.

**Chức Năng**: 
- Thực hiện các truy vấn DNS cho người dùng, duyệt qua các máy chủ DNS cấp cao nhất để tìm kiếm thông tin tên miền được yêu cầu. 
- Có thể lưu trữ thông tin truy vấn gần đây trong bộ nhớ cache để tăng tốc độ truy cập.

## Mô hình và cách thức hoạt động của DNS
Mô hình hoạt động của DNS sẽ trông như sau:

![](/Anh/Screenshot_558.png)

Chi tiết về cách thức hoạt động:
- Ban đầu, khi **USER** thực hiện tìm kiếm tên miền `example.com` trên **PC**
- Lúc này, **PC** sẽ thực hiện gửi truy vấn DNS cho **Local Name Server**. **Local Name Server** sẽ tìm tên miền trong bảng tên miền của mình xem có chứa `example.com` hay không. Nếu có sẽ trả về cho **PC**.
- Nếu trong bảng tên miền của **Local Name Server** không chứa `example.com`, thì lúc này, nó sẽ chuyển tiếp truy vấn DNS cho **ROOT NAME SERVER**. 
- **Root Name Server** sẽ thực hiện tìm ra **TLD Server** quản lý đuôi `.com`, sau đó trả lại thông tin **TLD Server** chứa đuôi `.com` cho **Local Name Server**
- **Local Name Server** khi này sẽ chuyển tiếp truy vấn DNS tới **TLD Server** chứa đuôi `.com`. **TLD Server** sẽ tìm kiếm **Authoritative Server** chứa `example.com` và trả về cho **Local Name Server**.
- Sau khi nhận được thông tin về **Authoritative** Server chứa tên miền cần tìm, **Local Name Server** sẽ chuyển tiếp truy vấn DNS đến **Authoritative Server**. 
- **Authoritative Server** khi nhận được truy vấn sẽ tìm IP ứng với tên miền `example.com` và thực hiện trả về cho **Local Name Server**
- Sau khi đã nhận được địa chỉ IP ứng với `example.com`, **Local Name Server** sẽ thực hiện trả về địa chỉ IP cho **PC**. 
- **PC** thực hiện kết nối tới địa chỉ IP vừa nhận - chính là IP của trang web `example.com` và hiển thị ra trang web cho **USER**

## DNS Caching và các loại bản ghi DNS
Lưu trữ lại kết quả truy xuất nhằm tránh mất thời gian phải truy xuất nhiều lần cho 1 tên miền

Bộ nhớ đệm DNS, một tính năng quan trọng của hệ thống DNS
Các phản hồi được lưu vào bộ nhớ đệm
DNS servers sẽ loại bỏ thông tin được lưu trong bộ nhớ cache sau 1 khoảng thời gian(thường sẽ là 2 ngày)

Các loại bản ghi DNS:
- **A Record**: 
  - Bản ghi A ánh xạ một tên miền vào một địa chỉ IPv4 (32-bit). 
  - Ví dụ: `example.com` có thể ánh xạ thành `192.0.2.1`.
- **AAAA Record**: 
  - Bản ghi AAAA ánh xạ một tên miền vào một địa chỉ IPv6 (128-bit). Đây là phiên bản IPv6 của bản ghi A. 
  - Ví dụ: `example.com` có thể ánh xạ thành `2001:0db8:85a3:0000:0000:8a2e:0370:7334`.
- **CNAME Record**: 
  - Bản ghi CNAME tạo một bí danh (alias) cho một tên miền khác (tên thật sự). 
  - Ví dụ: www có thể là một CNAME cho `example.com`.
- **MX Record**: 
  - Bản ghi MX chỉ định máy chủ email (mail server) xử lý email cho một tên miền cụ thể. 
  - Ví dụ: `example.com` có thể có một bản ghi MX chỉ định máy chủ email là `mail.example.com`.
- **TXT Record**: 
  - Bản ghi TXT chứa thông tin văn bản tùy chọn liên quan đến tên miền. Nó thường được sử dụng để lưu trữ các thông tin như chứng thực, chính sách bảo mật, hoặc hướng dẫn cấu hình. 
  - Ví dụ: SPF (Sender Policy Framework) được triển khai bằng cách sử dụng bản ghi TXT.
- **PTR Record**: 
  - Bản ghi PTR được sử dụng để thực hiện ngược lại của một bản ghi A hoặc AAAA. Nó ánh xạ một địa chỉ IP thành một tên miền. 
  - Bản ghi PTR thường được sử dụng trong việc tạo các bản ghi đảo ngược trong miền ARPA (in-addr.arpa cho IPv4 hoặc ip6.arpa cho IPv6).
- **NS Record**: 
  - Bản ghi NS chỉ định các máy chủ DNS chịu trách nhiệm cho một tên miền cụ thể. 
  - Ví dụ: `example.com` có thể có các bản ghi NS chỉ định máy chủ DNS là `ns1.example.com` và `ns2.example.com`.
- **SOA Record**: 
  - Bản ghi SOA chứa thông tin quản lý cho một miền. 
  - Nó xác định máy chủ chính (primary name server) cho miền, địa chỉ email của quản trị viên miền, và các thông tin về cập nhật và làm mới.

## Cấu trúc gói tin DNS:
### Header (Phần Đầu):
- ID (16-bit): Mã nhận dạng duy nhất của gói tin.
- Flags (16-bit): Bao gồm một loạt các cờ (flags) để chỉ định loại gói tin, loại truy vấn hoặc phản hồi, và các tùy chọn khác.
- Questions (16-bit): Số lượng câu hỏi trong gói tin.
- Answer RRs (16-bit): Số lượng bản ghi câu trả lời trong gói tin.
- Authority RRs (16-bit): Số lượng bản ghi quản lý trong gói tin.
- Additional RRs (16-bit): Số lượng bản ghi bổ sung trong gói tin.
### Câu Hỏi (Question Section):
Mỗi câu hỏi bao gồm:
- Tên miền (Domain Name): Tên miền mà truy vấn DNS được thực hiện.
- Loại (Type): Loại truy vấn DNS (ví dụ: A, AAAA, MX, TXT, ...).
- Lớp (Class): Lớp của truy vấn DNS (thường là IN cho Internet).
### Câu Trả Lời (Answer Section):
Mỗi bản ghi câu trả lời bao gồm:
- Tên miền (Domain Name): Tên miền tương ứng với câu hỏi.
- Loại (Type): Loại bản ghi DNS (ví dụ: A, AAAA, MX, ...).
- Lớp (Class): Lớp của bản ghi DNS (thường là IN cho Internet).
- TTL (Time To Live): Thời gian sống của bản ghi DNS.
- Dữ Liệu (Data): Dữ liệu tương ứng với loại bản ghi.
### Bản Quản Lý (Authority Section):
Chứa thông tin về các máy chủ DNS quản lý cho tên miền trong câu hỏi.
### Bản Ghi Bổ Sung (Additional Section):
Chứa các thông tin bổ sung, thường là các địa chỉ IP của các máy chủ DNS.

## Các loại truy vấn DNS
- **Recursive query**: DNS client gửi 1  yêu cầu máy của DNS(thường là recursive DNS resolver). Máy chủ sẽ trả lời máy khách bằng bản ghi tài nguyên được yêu cầu. Hoặc thông báo lỗi nếu resolver không thể tìm thấy bản ghi
- **Iterative query**: Client sẽ cho phép máy chủ trả về câu trả lời tốt nhất có thể. Nếu máy chủ được truy vấn không có kết quả trùng khớp với tên truy vấn, nó sẽ trả về 1 giới thiệu đến máy chủ có thẩm quyền cho mức thấp hơn. Client sau đó sẽ thực hiện một truy vấn đến địa chỉ được giới thiệu. Qúa trình này tiếp tục với các máy chủ DNS bổ sung cho đến khi xảy ra lỗi hoặc hết thời gian
- **Non-recursive query**: Xảy ra khi DNS resolver client truy vấn máy chủ DNS một record mà server có quyền truy cập bản ghi tồn tại bên trong bộ đệm của server. Thông thường, 1 máy chủ DNS sẽ lưu các bản ghi DNS để ngăn chặn việc tiêu thụ thêm bằng thông và giảm tải cho các DNS khác