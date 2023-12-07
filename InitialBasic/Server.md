# Tổng quan về Server vật lý

- Mô hình Server thực tế
-  ![](/Anh/Screenshot_42.png)
-  Mô hình Server tổng quát:
-  ![](/Anh/Screenshot_43.png)

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
