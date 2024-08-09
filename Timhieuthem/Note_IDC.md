# Note lại thông tin lên IDC ngày 08/08/2024

## Mục đích:
Lên IDC với mục đích như sau:
- Kiểm tra trạng thái các thiết bị
- Nâng cấp, lắp đặt thêm cho thiết bị

## Chuẩn bị trước khi đi:
Cần đem theo:
- Các linh kiện cần lắp đặt
  - RAM: 10 thanh 32GB
  - CPU: 2 CPU chip Intel Xeon
  - Backplane: 01 cái
  - Linh kiện thêm: Ốc, tua vít, keo tản nhiệt, giấy chùi
- Căn cước công dân
- Giấy giới thiệu của công ty(Nếu giấy giới thiệu ban đầu đã hết hiệu lực)
- Laptop, chuột,...

## Các mốc thời gian làm việc
Bắt đầu khởi hành lúc 15h

15h35' có mặt tại trung tâm IDC

15h45' bắt đầu thực hiện các công việc

18h hoàn thành công việc và ra về

## Các thiết bị cần kiểm tra:
- Server Dell R730: nâng cấp RAM - Máy nằm ở phòng 2B
- CEPH Dell R730xd: lắp thêm 1 Backplane - Máy nằm ở phòng 2A
- .... 

## Chi tiết quá trình làm việc
### Lắp thêm RAM:
Trước khi thực hiện tháo thiết bị khỏi tủ rack, chúng ta cần tháo hệ thống dây đằng sau trước. Lưu ý để ý các giấy Note xem dây là dây gì, có tác dụng gì để thực hiện cắm lại cho đúng, hoặc có thể chụp ảnh lại để sau này lắp lại cho chuẩn

![](/Anh/IDC05.jpg)

Kiểm tra mặt trước của thiết bị và tiến hành lấy thiết bị ra khỏi khay

![](/Anh/IDC07.jpg)

Chú ý thực hiện các thao tác 1 cách nhẹ nhàng, cẩn thận tránh làm rơi gây ra hỏng thiết bị

Tiến hành lắp lần lượt các thanh RAM theo như bảng hướng dẫn sau:

![](/Anh/IDC08.jpg)

Xác định được lắp cho 1 CPU đang hoạt động thì sẽ lắp theo thứ tự A1 - A12. 
- Tổng cộng thanh RAM đem đi: 10 thanh 32GB
- Tổng cộng thanh RAM có sẵn trong máy: 01 thanh 32GB
- Tổng số thanh Ram đã lắp: 11 thanh ==> 352GB RAM

Sau khi đã lắp đặt thiết bị xong, thực hiện để thiết bị lại tủ Rack và lắp lại dây

![](/Anh/IDC04.jpg)

Tiến hành kiểm tra xem máy đã nhận được đủ RAM chưa thông qua IDRAC

![](/Anh/IDC01.jpg)

Như vậy là máy đã nhận đủ RAM, tiến hành xếp gọn dây và ra đóng tủ chứa thiết bị

### Lắp thêm Backplane:
Các bước kiểm tra dây, tháo thiết bị như ở trên.

Bắt đầu giai đoạn lắp đặt:
- Trước tiên, chúng ta kiểm tra khu vực lắp đặt Backplane 2 ở đâu trên bảng hướng dẫn sử dụng của Server
- Thực hiện tháo dỡ các nơi cần thiết để thuận tiện cho việc lắp hơn. Lưu ý nhớ từng nơi và thứ tự của các bộ phận được lắp như thế nào, kết nối dây ra sao,.... Để an toàn, hãy thực hiện chụp ảnh hoặc quay video quá trình tháo rời

![](/Anh/IDC03.jpg)

- Tiến hành quá trình lắp đặt. Lưu ý để ý các khớp, lắp dùng lực đúng lúc, tránh để thiết bị bị gãy, hỏng hóc hoặc gây ảnh hưởng tới khu vực khác.

![](/Anh/IDC02.jpg)

- Sau khi lắp đặt hoàn tất, cất lại thiết bị và nối lại dây thật cẩn thận.
- Thực hiện kiểm tra. Đảm bảo quá trình như sau để an toàn nhất
  - Xác nhận các ổ cứng hoạt động đầy đủ
  - Khi thay đổi vị trí 1 ổ cứng thì màn hình báo ổ cứng thay đổi

### Thiết bị thứ 3
Hiện tại bị hacker hack và thông tin bị mã hóa

Hướng giải quyết: Restore lại thiết bị

![](/Anh/IDC06.jpg)

## Tổng kết
Sau 1 buổi đi IDC:
- Được tiếp xúc với các thiết bị vật lý cụ thể
- Được lắp đặt và tiến hành kiểm thử chi tiết
- Có thêm kiến thức về lắp đặt thiết bị, nâng cấp và nắm được các thông tin cơ bản về 1 Server