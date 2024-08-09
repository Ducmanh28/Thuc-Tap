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