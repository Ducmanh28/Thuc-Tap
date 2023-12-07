# Tìm hiểu về InternetProtocol
MỤC LỤC

## 1. IP là gì?
- Là địa chỉ Logic, được sử dụng trong giao thức lớp IP của lớp Internet - mô hình TCP/IP(và ở lớp Network của mô hình OSI)
- Ví dụ trong 1 khu phố có rất nhiều nhà thì IP chính là địa chỉ của căn nhà
- Các thiết bị muốn giao tiếp được với nhau thì đều cần phải có địa chỉ IP. 
- Địa chỉ IP tại 1 thời điểm là duy nhất và không có trường hợp cùng 1 lúc tồn tại 2 thiết bị dùng chung 1 địa chỉ IP

## 2. Các loại địa chỉ IP
Tùy vào mục đích sử dụng mà ta thực hiện phân chia địa chỉ IP thành nhiều loại:
- IP Public/Private
- Static/Dynamic IP
- IPv4/IPv6 
### 2.1 Static IP(IP tĩnh)
- Là cách đặt IP thủ công và sẽ cố định gắn liền với thiết bị đã đặt, không bị thay đổi theo thời gian
- Thực hành cài đặt IP tĩnh cho thiết bị:
    - IP hiện tại: `192.168.68.78`
    - Điều kiện: Phải cùng trong dải IP `192.168.68.`, các số sau dấu '.' phải 1<x<254, và địa chỉ muốn đặt tĩnh hiện đang không có thiết bị nào sử dụng
    - VD: chọn địa chỉ `192.168.68.28` ta thực hiện ping để xem có thiết bị nào sử dụng địa chỉ này hay không ?
    - ![](/Anh/Screenshot_31.png)
    - có các gói tin phản hồi --> địa chỉ này đã bị sử dụng
    - Thử với 1 địa chỉ khác: `192.168.68.68`
    - ![](/Anh/Screenshot_32.png)
    - Không có sự phản hồi --> địa chỉ này có thể sử dụng
    - Để cài đặt IP tĩnh, ta truy cập phần cài đặt mạng của máy --> Chọn mạng đang sử dụng. Tôi dùng WIFI nên sẽ chọn WIFI
    - ![](/Anh/Screenshot_33.png)
    - Sau đó chọn `Properties` 
    - ![](/Anh/Screenshot_34.png)
    - Chọn IPv4/IPv6 tùy theo máy bạn đang sử dụng. Tôi sẽ chọn IPv4
    - ![](/Anh/Screenshot_35.png)
    - Tích vào ô cho phép thiết lập IP tĩnh:
    - ![](/Anh/Screenshot_36.png)
    - Tiến hành điền các thông tin về IP
    - ![](/Anh/Screenshot_37.png)
    - Phần Subnet mask sẽ do máy tự điền, Default Gateway bạn có thể xem bằng cách nhập `ipconfig` ở CMD
    - Sau khi hoàn thành, bạn chọn **OK** để kết thúc quá trình. Khi này, máy tính sẽ thực hiện kết nối lại mạng, bạn vào cmd và gõ `ipconfig` để kiểm tra lại kết quả:
    - ![](/Anh/Screenshot_38.png)
    - Khi này, IP máy tôi đã chuyển từ `192.168.68.78` thành `192.168.68.68`
### 2.2 Dynamic IP(IP động)
- Có nghĩa là địa chỉ IP có thể thay đổi theo thời gian. Địa chỉ IP này được cấp bởi DHCP và sẽ được quản lý bởi DHCP Server
- Tiến hành bật DHCP cho máy cá nhân:
  - IP hiện tại: IP tĩnh: `192.168.68.68`
  - Ta tiến hành truy cập cài đặt mạng
  - Chọn mạng đang sử dụng. Tôi dùng WIFI nên sẽ chọn WIFI
  - ![](/Anh/Screenshot_33.png)
  - Sau đó chọn `Properties` 
  - ![](/Anh/Screenshot_34.png)
  - Chọn IPv4/IPv6 tùy theo máy bạn đang sử dụng. Tôi sẽ chọn IPv4
  - ![](/Anh/Screenshot_35.png)
  - Chọn thiết lập địa chỉ IP tự động. Sau đó bấm `OK` để kết thúc quá trình
  - ![](/Anh/Screenshot_39.png)
  - Lúc này DHCP đã được bật và sẽ tự động cấp và quản lý địa chỉ IP cho máy cá nhân. 
  - Các bạn có thể truy cập WireShark để thấy DHCP đã hoạt động và địa chỉ IP mới là `192.168.68.78`:
  - ![](/Anh/Screenshot_40.png)
### 2.3 IP Public(IP công cộng)
Là địa chỉ IP được các nhà cung cấp dịch vụ internet như Viettel, FPT, VNPT,... cung cấp
- Mỗi thiết bị đang sử dụng Internet đều sử dụng địa chỉ IP duy nhất
- Trong thực tế, IP Public còn được gọi là IP Internet
- Là địa chỉ mà các nhà cung cấp dịch vụ Internet(ISP) sử dụng để chuyển tiếp các yêu cầu Internet đến một gia đình hoặc doanh nghiệp có địa chỉ cụ thể. Hay còn được gọi là định tuyến trên môi trường Internet
- Các dải IP Public không thể sử dụng trong môi trường mạng LAN
- Không thể ẩn IP Public khỏi ISP, vì tất cả lưu lượng truy cập của bạn phải đi qua ISP trước khi tới bất kì địa chỉ nào trên Internet. Tuy nhiên có thể ẩn khỏi các trang web bằng cách sử dụng VPN
- Cách tìm địa chỉ IP Public của bạn: 
  - Truy cập google gõ "what is my IP" 
  - Google sẽ cho bạn thấy IP Public của mình:
  - ![](/Anh/Screenshot_41.png)
### 2.4 IP Private(IP riêng tư)
- Là IP dành riêng cho việc sử dụng nội bộ trong vùng mạng của mình(ví dụ LAN) thông qua router hoặc thiết bị NAT khác, hoàn toàn cô lập với mạng bên ngoài
  - IP Private hay còn được gọi là IP cục bộ
  - IP Private không thể kết nối ra Internet, chỉ các thiết bị trong mạng mới có thể giao tiếp với nhau thông qua bộ định tuyến hay còn gọi là router
- Cách xem IP Private: 
- Vào CMD và gõ `ipconfig` để xem địa chỉ IP Private của máy
- ![](/Anh/Screenshot_38.png)
- IP Private nằm trong phạm vi sau và được bảo lưu bởi Internet Assigned Numbers Authority(IANA):
  - 10.0.0.0 đến 10.255.255.255
  - 172.16.0.0 đến 172.31.255.255
  - 192.168.0.0 đến 192.168.255.255
## 3. Internet Protocol version 4(IPv4)
- Giao thức Internet phiên bản thứ 4, là phiên bản thứ 4 trong quá trình phát triển của IP. Đây là phiên bản đầu tiên của IP được sử dụng rộng rãi. Đến nay, IPv4 vẫn đang được sử dụng rất nhiều
### 3.1 Cấu trúc địa chỉ IP
Được chia thành 2 phần: 
- Phần Network: là địa chỉ mạng, dùng để xác định mạng mà thiết bị kết nối vào. Dùng để phần biệt mạng này với mạng khác
- Phần Host: dùng để định danh các thiết bị trong từng vùng mạng. Hiểu đơn giản, trong 1 mạng LAN có rất nhiều thiết bị kết nối vào cùng 1 mạng thì phần Host này sẽ được dùng để phân biệt các thiết bị đó với nhau
- Gồm có 32 bit nhị phân và được chia làm 4 cụm bằng nhau, mỗi cụm được gọi là 1 octet, mỗi octet có 8 bit. Và có tổng cộng 2^32 ~~ 4,29 tỷ địa chỉ IP
- Để cho dễ nhớ thì cứ 8 bit nhị phân sẽ được chuyển thành 1 số thập phân và từ đó IPv4 ra đời 
VD: `192.168.68.78` là: `11000000.10101000.01000100.01001110`
- Một số quy tắc khi đặt địa chỉ IP:
  -  