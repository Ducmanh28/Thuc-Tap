# Introduction to Linux

## Lịch sử phát triển
### Năm 1969
Tất cả hệ điều hành hiện đại đều có nguồn gốc từ năm 1969

- Năm 1969 là khi mà Dennis Ritchie và Ken Thompson phát triển ngôn ngữ lập trình C và hệ điều hành Unix tại AT&T Bell Labs
- Họ đã chia sẻ mã nguồn của mình với phần còn lại của thế giới
![](/Anh/Screenshot_329.png)

Đến năm 1975, khi AT&T bắt đầu bán Unix thương mại, khoảng một nửa mã nguồn được viết bởi người khác. 
- Một số người cảm thấy không vui khi một công ty thương mại bán phần mềm do họ viết ra
- Điều trên đã dẫn đến một cuộc chiến pháp lý và kết quả là có 2 phiên bản Unix:
  - Unix AT&T chính thức
  - BSD Unix miễn phí
![](/Anh/Screenshot_330.png)

Sự phát triển của các hậu duệ BSD vẫn còn hoạt động cho đến ngày nay như
- FreeBSD, 
- OpenBSD, 
- NetBSD, 
- DragonFly BSD 
- PC-BSD 

### Giai đoạn 1980
Vào giai đoạn những năm 80, nhiều công ty bắt đầu phát triển Unix của riêng mình
- IBM tạo ra AIX, SUN SUNOS(Sau này là Solaris), HP HP-UX
- Và các công ty khác cũng làm tương tự như vậy

Và kết quả là một mớ hỗn độn các phương ngữ Unix xuất hiện

Đây chính là gốc rễ thực sự đầu tiên của Linux, khi Richard Stallman nhắm đến việc chấm dứt kỷ nguyên phân chia Unix và mọi người tái phát minh bằng cách bắt đầu dự án GNU
![](/Anh/Screenshot_331.png)

Mục tiêu của ông chính là tạo ra một hệ điều hành miễn phí cho mọi người, và là nơi mọi người cùng nhau làm việc như những năm 70

### Giai đoạn 1990 
Vào giai đoạn thập niên 90, Linus Torvalds - một sinh viên Phần Lan nói tiếng Thụy Điển, mua một chiếc máy tính 386 và viết một kernel tương thích POSIX hoàn toàn mới. 

Anh ta đưa mã nguồn lên mạng vì nghĩ nó không bao giờ hỗ trợ bất cứ thứ gì ngoài phần cứng của 386.

Là một hệ điều hành tương tự với Minix, Torvalds đã công bố hệ thống của mình vào 25/08/1991

Ban đầu, Torvalds muốn đặt tên cho phát minh của mình là Freax - một từ ghép của "free - tự do", "freak - quái dị", "x" như một ám chỉ đến Unix

Tuy nhiên sau đó, Torvalds đã đồng ý và sử dụng cái tên Linux cho hệ thống của mình. 

Torvalds tuyên bố vào năm 1996 rằng sẽ có một linh vật cho Linux, một chú chim cánh cụt. Điều này là do khi họ đang chuẩn bị để chọn linh vật thì Torvalds đã bị một chú chim cánh cụt cắn trong chuyên thăm sở thú. Và chú chim cánh cụt này có tên là Tux

![](/Anh/Screenshot_332.png)

### Giai đoạn từ 2015
Ngày nay, hơn 97% siêu máy tính trên thế giới (bao gồm cả top 10), hơn 80% điện thoại thông minh, nhiều triệu máy tính để bàn, khoảng 70% tổng số máy chủ web, một lượng lớn máy tính bảng và một số thiết bị ( đầu DVD, máy giặt, modem dsl, bộ định tuyến, xe tự lái, máy tính xách tay trạm vũ trụ...) chạy Linux. Linux cho đến nay là hệ điều hành được sử dụng phổ biến nhất trên thế giới.

![](/Anh/Screenshot_333.png)

Nhân Linux phiên bản 4.0 được phát hành vào tháng 4 năm 2015. Mã nguồn của nó đã tăng thêm vài trăm nghìn dòng (so với phiên bản 3.19 từ tháng 2 năm 2015) nhờ sự đóng góp của hàng nghìn nhà phát triển được trả lương bởi hàng trăm công ty thương mại bao gồm Red Hat, Intel, Samsung, Broadcom , Texas Instruments, IBM, Novell, Qualcomm, Nokia, Oracle, Google, AMD và thậm chí cả Microsoft (và nhiều hơn nữa).

## Các bản phân phối Linux
Bản phân phối Linux là một tập hợp phần mềm (thường là nguồn mở) trên nhân Linux. 

Một bản phân phối có thể gói: phần mềm máy chủ, công cụ quản lý hệ thống, tài liệu và nhiều ứng dụng máy tính để bàn vào kho lưu trữ phần mềm bảo mật trung tâm.

Một bản phân phối nhằm mục đích cung cấp giao diện chung, quản lý phần mềm an toàn và dễ dàng và thường là cho một mục đích hoạt động cụ thể.

### Red Hat
![](/Anh/Screenshot_334.png)

[Red Hat](https://www.redhat.com/en) là một công ty Linux thương mại trị giá hàng tỷ đô la, đã nỗ lực rất nhiều trong việc phát triển Linux. Họ có hàng trăm chuyên gia Linux và được biết đến với khả năng hỗ trợ tuyệt vời.

Họ tặng miễn phí các sản phẩm của mình (Red Hat Enterprise Linux và Fedora). Trong khi Red Hat Enterprise Linux (RHEL) đã được thử nghiệm kỹ lưỡng trước khi phát hành và được hỗ trợ tới bảy năm sau khi phát hành thì Fedora là một bản phân phối có các bản cập nhật nhanh hơn nhưng không được hỗ trợ.

### Ubuntu
![](/Anh/Screenshot_335.png)

[Ubuntu](https://ubuntu.com/) là một hệ điều hành dựa trên Linux, được phát triển bởi cộng đồng và được tài trợ bởi công ty Canonical Ltd. 

Ubuntu có nhiều phiên bản khác nhau, phù hợp với nhiều loại thiết bị và mục đích sử dụng, như máy tính để bàn, máy chủ, điện thoại thông minh và thiết bị IoT. 

Ubuntu là một hệ điều hành miễn phí, mã nguồn mở và an toàn, có nhiều tính năng và ứng dụng hữu ích, từ soạn thảo văn bản, trình duyệt web, đến phần mềm lập trình và máy chủ web. 

Ubuntu cũng có một cộng đồng người dùng và nhà phát triển lớn và năng động, hỗ trợ nhau trong việc sử dụng và cải tiến hệ điều hành này.

### Debian
![](/Anh/Screenshot_336.png)

Không có công ty nào đứng sau Debian. Thay vào đó, có hàng ngàn các nhà phát triển tốt tổ chức bầu ra một Lãnh đạo Dự án Debian hai năm một lần. 

[Debian](https://www.debian.org/) được xem là một trong những bản phân phối Linux ổn định nhất. Nó cũng là cơ sở của mọi bản phát hành của Ubuntu. 

Có ba phiên bản: ổn định, thử nghiệm và không ổn định. Mỗi bản phát hành Debian được đặt tên theo một nhân vật trong phim Toy Story.

### Một số bản phân phối khác
![](/Anh/Screenshot_337.png)

Các bản phân phối như CentOS, Oracle Enterprise Linux và Scientific Linux dựa trên Red Hat Enterprise Linux và chia sẻ nhiều nguyên tắc, thư mục và kỹ thuật quản trị hệ thống giống nhau. 

![](/Anh/Screenshot_339.png)

Linux Mint, Edubuntu và nhiều bản phân phối có tên *buntu khác dựa trên Ubuntu và do đó chia sẻ rất nhiều với Debian. 

![](/Anh/Screenshot_340.png)

Có hàng trăm bản phân phối Linux khác nữa.

## Cài đặt Linux:
Có hàng trăm bản phân phối Linux miễn phí để cho bạn có thể thoải mái lựa chọn. Tùy theo nhu cầu sử dụng của bạn để chọn cho mình một bản phân phối.

Tôi sẽ chọn hai bản, một của Debian và một của Red Hat. Có thể xem hướng dẫn chi tiết cách cài đặt và thao tác cơ bản với hai hệ điều hành:
- [Ubuntu Server](https://github.com/Ducmanh28/Thuc-Tap/tree/main/Linux/UbuntuServer)
- [CentOS 7](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/Red%20Hat%20Enterprise/Centos7.md)

## Tài liệu tham khảo:
- [Linux Fundamentals](https://www.bing.com/ck/a?!&&p=a186c80fd56fa8a8JmltdHM9MTcwNDkzMTIwMCZpZ3VpZD0yOWE3YmUyMC03NzQxLTZmMmItM2UwMi1iMTgyNzYzZTZlYzUmaW5zaWQ9NTIyNA&ptn=3&ver=2&hsh=3&fclid=29a7be20-7741-6f2b-3e02-b182763e6ec5&psq=linux+fundamentals+pdf&u=a1aHR0cHM6Ly93d3cubGVhcm5saW51eC5vcmcuemEvY291cnNlcy9idWlsZC9mdW5kYW1lbnRhbHMvZnVuZGFtZW50YWxzLnBkZg&ntb=1)
- [Wikipedia](https://www.wikipedia.org/)
