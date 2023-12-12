# Tổng quan về Server vật lý
MỤC LỤC
- [Tổng quan về Server vật lý](#tổng-quan-về-server-vật-lý)
  - [1. CPU](#1-cpu)
  - [2. RAM](#2-ram)
  - [3. Ổ cứng](#3-ổ-cứng)
  - [4. Raid](#4-raid)
  - [5. Card Mạng](#5-card-mạng)
  - [6. Nguồn](#6-nguồn)
  - [7. Một số lưu ý khi lắp server](#7-một-số-lưu-ý-khi-lắp-server)
  - [8. Tiến hành cài win trên server Vật Lý](#8-tiến-hành-cài-win-trên-server-vật-lý)

## 1. CPU
- ![](/Anh/Screenshot_45.png)
- Nên chọn những CPU có nhiều nhân cho máy chủ
- Càng nhiều nhân CPU thì quá trình xử lý càng nhanh
- Một CPU có xung nhịp cao sẽ không bằng một CPU có nhiều nhân
- Các loại CPU Server phổ biến hiện nay: 
  - Intel Xeon: Phù hợp cho các máy chủ doanh nghiệp
  - AMD EPYC: Được đánh giá cao về hiệu suất
  - Intel Core: Phù hợp cho các máy chủ cá nhân, có khả năng xử lý đa nhiệm tốt
## 2. RAM
- ![](/Anh/Screenshot_44.png)
- RAM server là một loại bộ nhớ đặc biệt được thiết kế để sử dụng trong các máy chủ và hệ thống công nghiệp với yêu cầu cao về tốc độ xử lý dữ liệu và khả năng chịu tải
- Hoạt động theo nguyên tắc tương tự như RAM máy tính thông thường
- Một số loại RAM Server:
  - RAM Unbuffered
  - RAM Registered
- Quan trọng đối với máy chủ vì nó ảnh hưởng đến vận hành và hiệu suất làm việc của hệ thống
## 3. Ổ cứng
- ![](/Anh/Screenshot_46.png)
- Giúp và quyết định tốc độ đọc dữ liệu của bạn
- Có hai loại ổ cứng cho server:
  -  HDD (Hard Disk Drive): các ổ cứng có chuẩn giao tiếp SCSI hoặc SAS nên được lựa chọn
  -  SSD (Solid-State Drive): ưu tiên lựa chọn những loại có hiệu năng tốt
## 4. Raid
- ![](/Anh/Screenshot_49.png)
- Là một hệ thống ổ đĩa cứng được ghép từ nhiều đĩa vật lý lại với nhau
- Nếu có 1 ổ cứng thì chỉ có thể cấu hình Raid 0
- Nếu có trên 2 ổ thì phải cấu hình Raid 1 vì Raid 0 không có dự phòng
- Nó giúp đảm bảo an toàn cho dữ liệu nhớ khả năng sao lưu, chống lỗi
- Hiện đại nhất là Raid 10. Tuy nhiên Raid càng cao càng tốn tiền
## 5. Card Mạng
- ![](/Anh/Screenshot_47.png)
- Card mạng Server là một thiết bị phần cứng được cài đặt trên máy tính để nó có thể được kết nối với internet
- Dù cho cấu hình server của bạn có cao đến mức nào cũng bị phụ thuộc vào hệ thống mạng
- Các server vật lý luôn cần có băng thông cao cho kết nối internet để tránh trường hợp tắc nghẽn

## 6. Nguồn 
- ![](/Anh/Screenshot_48.png)
- Nguồn Server hay còn được biết đến với cái tên Power Supply Unit (PSU) là thiết bị chuyên dụng cung cấp năng lượng cho các thiết bị khác bên trong, giữ vài trò quan trọng trong quá trình hoạt động của Server
- Có đa dạng các loại nguồn Server, nên chọn các nguồn phù hợp với máy chủ của bạn
- Thường 1 server sẽ chạy cùng lúc 2 nguồn

## 7. Một số lưu ý khi lắp server
- Đọc kĩ hướng dẫn trước khi Lắp
- Nên chọn và lắp các ổ cứng phù hợp, phụ thuộc vào độ to, bé của ổ cứng(2,5/3,5 inch)
- Lắp RAM theo hướng dẫn của nhà sản xuất, lắp các thanh ưu tiên hoặc lắp cho 1/2 CPU, nếu lắp sai có thể xảy ra trường hợp các thanh RAM hoạt động không hết công suất hoặc không hoạt động
- Lắp CPU chú ý chiều để lắp
- Lắp sử dụng lực vừa đủ, cẩn thận, không cần quá nhanh 

## 8. Tiến hành cài win trên server Vật Lý
Hôm nay, tôi thực hiện cài thử Window 10 trên Server vật lý, sử dụng USB
Ban đầu, màn hình Server hiển thị đang được bật như sau:
- ![](../Anh/10.jpg)

Chờ khi màn hình hiển thị các nút để vào BIOS, tiến hành bấm `F11` để truy cập vào Boot Manager
- Tiến hành chọn `One-shot UEFI Boot Menu` khi Server đã có sẵn 1 hệ điều hành và ta muốn cài 1 hệ điều hành mới
- ![](../Anh/Screenshot_61.png)
- Tiến hành chọn USB có lưu trữ hệ điều hành cần cài:
- ![](../Anh/Screenshot_62.png)
- Sau đó, tiến hành cài Window như trên máy tính cá nhân.
Một số lưu ý khi cài:
- Chọn mục này nếu như bạn không có Key Windows bản quyền:
- ![](../Anh/Screenshot_63.png)
- Khi chọn phiên bản, nên chọn phiên bản Desktop để có đồ họa. Phiên bản Server sẽ chỉ có các câu lệnh
- ![](../Anh/Screenshot_63.png)
- Thực hiện phân vùng ổ cứng, nếu như không có dữ liệu quan trọng ở hệ điều hành cũ, thực hiện xóa hết các ổ cứng và phân vùng lại. Sau đó, chọn ổ để cài hệ điều hành:
- ![](../Anh/Screenshot_65.png)
-Sau đó, quá trình cài đặt dường như đã hoàn tất, màn hình sẽ hiện thị Windows:
- ![](../Anh/8.jpg)
Tiến hành cài User cho Server:
- ![](../Anh/7.jpg)
Sau khi bấm `Finish`, quá trình cài đặt đã hoàn tất. Ta tiến đến màn hình đăng nhập:
- ![](../Anh/5.jpg)

Sau khi đăng nhập xong, giao diện của Window Server sẽ hiển thị như sau:
- ![](/Anh/Screenshot_66.png)
- Tiến hành kiểm tra dung lượng ổ cứng:
- ![](/Anh/Screenshot_67.png)
- Tiến hành cài IP tĩnh cho server:
- ![](/Anh/6.jpg)
- Tiến hành test Ping thử sang một máy khác cùng kết nối cổng Ethernet:
- ![](/Anh/3.jpg)