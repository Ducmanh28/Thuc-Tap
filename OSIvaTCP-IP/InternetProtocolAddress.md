# Tìm hiểu về InternetProtocol
MỤC LỤC
- [Tìm hiểu về InternetProtocol](#tìm-hiểu-về-internetprotocol)
  - [1. IP là gì?](#1-ip-là-gì)
  - [2. Các loại địa chỉ IP](#2-các-loại-địa-chỉ-ip)
    - [2.1 Static IP(IP tĩnh)](#21-static-ipip-tĩnh)
    - [2.2 Dynamic IP(IP động)](#22-dynamic-ipip-động)
    - [2.3 IP Public(IP công cộng)](#23-ip-publicip-công-cộng)
    - [2.4 IP Private(IP riêng tư)](#24-ip-privateip-riêng-tư)
    - [2.5 IP Private và IP Public](#25-ip-private-và-ip-public)
  - [3. Internet Protocol version 4(IPv4)](#3-internet-protocol-version-4ipv4)
    - [3.1 Cấu trúc địa chỉ IP](#31-cấu-trúc-địa-chỉ-ip)
  - [3.2 Các lớp địa chỉ IP](#32-các-lớp-địa-chỉ-ip)
    - [3.2.1 Lớp A](#321-lớp-a)
    - [3.2.2 Lớp B](#322-lớp-b)
    - [3.2.3 Lớp C](#323-lớp-c)
    - [3.2.4 Lớp D](#324-lớp-d)
    - [3.2.5 Lớp E](#325-lớp-e)
  - [3.3 Địa chỉ Broadcast](#33-địa-chỉ-broadcast)
  - [3.4 SubnetMask](#34-subnetmask)
  - [3.5 Prefix](#35-prefix)
  - [3.6 Nguyên lý cơ bản của chia Subnet:](#36-nguyên-lý-cơ-bản-của-chia-subnet)
  - [3.7 Ưu điểm của IPv4](#37-ưu-điểm-của-ipv4)
  - [3.8 Nhược điểm của IPv4:](#38-nhược-điểm-của-ipv4)
- [4. Các kiểu định tuyến:](#4-các-kiểu-định-tuyến)
- [5. Quá trình truyền tin qua Internet:](#5-quá-trình-truyền-tin-qua-internet)


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
### 2.5 IP Private và IP Public
- Đễ dễ hiểu
  - IP Private dùng để giao tiếp giữa các máy trong 1 mạng nội bộ
  - IP Public sử dụng để giao tiếp trong môi trường Internet 
- Một IP Public có thể được sử dụng cho nhiều IP Private
- VD trong 1 công ty gồm rất nhiều máy tính cá nhân, mỗi máy tính này đều có cùng 1 dải IP Private: 192.168.68.0 và có IP Private của mỗi máy là khác nhau, miễn là trong cùng 1 dải mạng. Tất cả các máy này sẽ đều có chung 1 IP Public để truy cập ra Internet. IP Public này sẽ chính là IP của Router. Vậy việc giao tiếp giữa máy A ở công ty A và máy B ở công ty B trong môi trường Internet sẽ là sự giao tiếp giữa 2 Router A và Router B
- Để có IP Public, bạn sẽ phải đi thuê và nó sẽ được các công ty cung cấp dịch vụ Internet cấp cho bạn.
- Tôi đã mô tả đơn giản quá trình qua sơ đồ như sau:
- ![](/Anh/Screenshot_51.png)
## 3. Internet Protocol version 4(IPv4)
- Giao thức Internet phiên bản thứ 4, là phiên bản thứ 4 trong quá trình phát triển của IP. Đây là phiên bản đầu tiên của IP được sử dụng rộng rãi. Đến nay, IPv4 vẫn đang được sử dụng rất nhiều
### 3.1 Cấu trúc địa chỉ IP
Được chia thành 2 phần:
- ![](/Anh/Screenshot_52.png)
- Phần Network: là địa chỉ mạng, dùng để xác định mạng mà thiết bị kết nối vào. Dùng để phần biệt mạng này với mạng khác
- Phần Host: dùng để định danh các thiết bị trong từng vùng mạng. Hiểu đơn giản, trong 1 mạng LAN có rất nhiều thiết bị kết nối vào cùng 1 mạng thì phần Host này sẽ được dùng để phân biệt các thiết bị đó với nhau
- Gồm có 32 bit nhị phân và được chia làm 4 cụm bằng nhau, mỗi cụm được gọi là 1 octet, mỗi octet có 8 bit. Và có tổng cộng 2^32 ~~ 4,29 tỷ địa chỉ IP
- Để cho dễ nhớ thì cứ 8 bit nhị phân sẽ được chuyển thành 1 số thập phân và từ đó IPv4 ra đời 
VD: `192.168.68.78` là: `11000000.10101000.01000100.01001110`
- Một số quy tắc khi đặt địa chỉ IP:
  -  Các bit phần mạng không được đặt đồng thời bằng 0
     -  VD: Địa chỉ `0.0.0.1` với phần mạng là `0.0.0` và phần HOST là 1 sẽ không hợp lệ
  - Các bit phần HOST đồng thời bằng 0 thì đấy sẽ là địa chỉ mạng
    - VD: `192.168.68.0` là 1 địa chỉ mạng và không thể gán cho HOST
    - Địa chỉ mạng là địa chỉ đại diện cho 1 dải mạng
  - Nếu các bit phần HOST đồng thời bằng 1 thì ta được 1 địa chỉ broadcast
    - VD: Ta có IP: `192.168.68.255` hay chính là `1100000.10101000.01000100.11111111` là một địa chỉ Broadcast
## 3.2 Các lớp địa chỉ IP
- Địa chỉ IP được chia thành 5 lớp: A, B, C, D, E. Nhưng đa số chúng ta chỉ tiếp xúc với 3 lớp đầu tiên. Lớp D dùng cho mục đích Multicast, Lớp E sinh ra để dự phòng và hầu như không được dùng đến.
- Người ta phân ra 3 lớp địa chỉ A, B, C nhằm phục vụ cho mục đích để người dùng chọn địa chỉ IP theo quy mô hệ thống mạng mà họ sử dụng. Mạng nhỏ thì dùng lớp C, dần dần to lên thì sẽ dùng đến B và đến A. Trong lớp mạng A có nhiều địa chỉ IP nhất
- Ta cùng đi phân tích các lớp địa chỉ IP
- Trước tiên, ta cần nhớ để phân biệt giữa 3 lớp A, B, C người ta dựa vào Octet đầu tiên
### 3.2.1 Lớp A
- ![](/Anh/Screenshot_54.png)
- Theo quy ước, lớp A có 8 bits đầu tiên là Network ID 
- Bit đầu tiên của lớp A luôn bằng 0: `0xxxxxxx.X.X.X`
- Để dễ nhớ hơn, người ta quy ước, octet đầu của các địa chỉ IP lớp A sẽ chạy trong khoảng từ 1-127(chính là từ 00000001-01111111)
- Các địa chỉ mạng của lớp A: 1.0.0.0, 2.0.0.0,....,127.0.0.0
  - Tuy nhiên, mạng 127.0.0.0 được sử dụng làm mạng *loopback* nên địa chỉ mạng ở lớp A chỉ gồm: 1.0.0.0,....,126.0.0.0 (tổng cộng 126 mạng)
  - Địa chỉ 127.0.0.1 là 1 địa chỉ *loopback*
  - Loopback là một địa chỉ IP đặc biệt được sử dụng để kiểm tra những lỗi đường truyền trong hệ thống mạng.
  - VD: Để kiểm tra chồng giao thức TCP/IP có được cài đặt đúng hay không, ta ping 127.0.0.1, nếu kết quả ping thành công thì chồng giao thức TCP/IP đã được cài đặt đúng
  - Còn 24 bits còn lại là địa chỉ Host ID vậy nên lớp A có tổng cộng 2^24-2 địa chỉ IP = 16777214 địa chỉ
- VD: 10.0.0.1, 1.1.1.1, 2.3.4.5, .... là các địa chỉ lớp A
- 
### 3.2.2 Lớp B
- ![](/Anh/Screenshot_56.png)
- Theo quy ước, lớp B có 16 bits đầu tiên là NetWork ID 
- Hai bit đầu của lớp B luôn bằng 10: `10xxxxxx.X.X.X`
- Octet đầu của các địa chỉ IP lớp B sẽ chạy trong khoảng từ 128-191(chính là từ 10000000-10111111)
- Các địa chỉ mạng lớp B bao gồm: 128.0.0.0 - 191.255.0.0, có tất cả 2^14 mạng trong lớp B
- Còn 16 bits còn lại là Host ID, vậy nên lớp B có tổng cộng 2^16-2 địa chỉ IP = 65534 địa chỉ
- VD: 191.1.2.3, 191.168.12.56, 128.28.28.28 là các địa chỉ lớp B

### 3.2.3 Lớp C
- ![](/Anh/Screenshot_57.png)
-  Theo quy ước, lớp C có 24 bits đầu tiên là NetWork ID 
-  Ba bit đầu của lớp C luôn luôn bằng 110: `110x.X.X.X`
-  Octet đầu của các địa chỉ IP lớp C sẽ chạy trong khoảng từ 192-223(chính là từ 1100000-11011111)
-  Các địa chỉ mạng lớp C bao gồm: 192.0.0.0 - 223.255.255.0, có tất cả 2^21 = 2097152 mạng trong lớp C
-  Còn 8 bits còn lại là Host ID, vậy nên lớp C có tổng cộng 2^8-2 địa chỉ IP = 254 địa chỉ
-  VD: 192.168.68.78, 220.220.220.2, 223.9.0.5,.. là các địa chỉ IP lớp C

### 3.2.4 Lớp D
- 4 bit đầu tiên của D luôn bằng 1110
- Gồm các địa chỉ thuộc dải: 224.0.0.0 --> 239.255.255.255
- Được dùng làm các địa chỉ Multicast. 
- VD: 224.0.0.5 dùng cho OSPF, 224.0.0.9 dùng cho RIPv2,...
### 3.2.5 Lớp E
- Từ 240.0.0.0 trở đi
- Được dùng cho mục đích dự phòng

## 3.3 Địa chỉ Broadcast
- Gồm có 2 loại Broadcast:
  - VD: IP của bạn 192.168.78.78
  - Direct: 192.168.68.255, Chỉ các thiết bị trong dải mạng 192.168.68.0 nhận được
  - Local: 255.255.255.255, Chỉ các thiết bị trong dải mạng của bạn nhận được tức(192.168.78.0)

## 3.4 SubnetMask
- Là 1 dải 32 bits nhị phân đi kèm với 1 địa chỉ IP, được các Host sử dụng để xác định địa chỉ mạng của địa chỉ IP này. Để làm được điều đó, Host sẽ đem địa chỉ IP thực hiện phép tính AND từng bit một với subnetmask của nó
- Phép toán AND: 0 AND 0 = 0; 1 AND 1 = 1; 0 AND 1 = 0; 1 AND 0 = 0
- VD: Xét địa chỉ IP: 192.168.68.78

|  |Dạng thập phân|Dạng nhị phân|
|--|--------------|-------------|
|Địa chỉ IP|192.168.68.78 |11000000.10101000.01000100.01001110|
|Subnet Mask|255.255.255.0|11111111.11111111.11111111.00000000|
|Địa chỉ mạng|192.168.68.0|11000000.10101000.01000100.00000000|

- Phần mạng chạy đến đâu, bit 1 của subnet mask chạy đến đó
- Ứng với các bit phần host, các bit của subnet mask được thiết lập giá trị 0
- Một số SubnetMask chuẩn:
    - Lớp A: 255.0.0.0
    - Lớp B: 255.255.0.0
    - Lớp C: 255.255.255.0
- Subnet Mask là 1 phần quan trọng trong hệ thống mạng
- Nếu không có SubnetMask mạng sẽ gặp phải nhiều vấn đề:
    - Giảm khả năng kiểm soát lưu lượng mạng
    - Việc kết nối từ xa trở nên khó khăn hơn
    - Việc mở rộng mạng sẽ trở nên phức tạp và khó khăn hơn
## 3.5 Prefix
- Để mô tả một địa chỉ IP, người ta dùng 1 đại lượng gọi là số Prefix 
- Hiểu đơn giản thì số Prefix miêu tả số bit mạng trong một địa chỉ IP, được viết ngay sau địa chỉ IP, và được ngăn cách bởi dấu "/"
- VD: 192.168.68.78/24 : 24 bits đầu là NetworkID, 8 bits còn lại là Host ID
- Có tác dụng quan trọng trong việc phân chia mạng, giúp xác định kích thước của mạng, giúp các router xác định đường đi cho các gói tin
- Nếu không có số prefix, hệ thống mạng sẽ không thể hoạt động một cách hiệu quả
    - Các router sẽ không thể xác định đường đi cho các gói tin
    - Việc phân chia, quản lý mạng cũng sẽ trở nên khó khăn
## 3.6 Nguyên lý cơ bản của chia Subnet:
Vấn đề thực tế: Một công ty có 2 chi nhánh. Để 2 máy chủ ở 2 chi nhánh này có thể giao tiếp với nhau, chúng ta cần thiết lập đường truyền kết nối thông qua nhà cung cấp dịch vụ mạng và phải đặt IP cho 2 chi nhánh này. Tuy nhiên, công ty chỉ có 1 IP Public duy nhất là một NetID được thuê từ nhà cung cấp

Lúc này, ta cần chia NetID này thành nhiều NetID con hay còn gọi là SubnetID cho 2 chi nhánh của công ty

Vậy, để có thể chia từ một mạng lớn thành nhiều mạng con bằng nhau, người ta mượn thêm một số bit bên phần Host để làm phần Network. Các bit mượn này gọi là các *bit Subnet*. Tùy thuộc vào số *bit Subnet* mà ta có số lượng mạng con khác nhau với các kích cỡ khác nhau:
- Bảng chia Subnet:
- ![](/Anh/Screenshot_68.png)
  - Từ lớp mạng /24 , ta có thể chia thành 2 lớp mạng con /25, 4 lớp mạng con /26, 8 lớp mạng con /27, 16 lớp mạng con /28,....
  - Mỗi lớp mạng con có kích cỡ khác nhau:/24 có 256IP, /25 có 128IP, /26 có 64IP. Đơn giản thì số IP của mỗi lớp mạng con được tính bằng 2^(số bit còn lại của phần Host)
- Phân chia mạng lớn `192.168.68.0/24` thành 4 mạng con `/26`
  - Để dễ hình dung, ta thực hiện đưa Octet cuối về dạng nhị phân, vậy `/26` tức là mượn 2 bit ở octet cuối ==> 2 số đầu của octet cuối sẽ có sự thay đổi 00,01,10,11
  - ![](/Anh/Screenshot_71.png)
  - ==> Có 2^2 mạng con và mỗi mạng con có 2^6 địa chỉ IP
  - 4 địa chỉ mạng tương ứng:  
  - ![](/Anh/Screenshot_69.png)
  - Có 2 cách để viết các địa chỉ mạng này
    - Phân chia octet mượn bit thành dạng nhị phân, ta biết địa chỉ mạng là khi tất cả các bit phần Host đều bằng 0, thực hiện đổi ngược lại từ nhị phân sang thập phân
    - ![](/Anh/Screenshot_72.png)
    - Sử dụng phương pháp bước nhảy chính là số IP/ 1 Subnet
    - vd 0 --> 64 --> 128 --> 192
- Bảng quy hoạch IP cho hệ thống mạng:
- ![](/Anh/Screenshot_73.png)
- Thực hành quy hoạch IP cho hệ thống mạng của công ty:
- ![](/Anh/Screenshot_74.png)
  - Ta có IP nguồn: `192.168.68.0/24`
  - Ta tiến hành phân chia IP như sau :
- ![](/Anh/Screenshot_76.png)
  - Tầng 1 có nhu cầu sử dụng mạng nhiều nhất, ta chia `192.168.68.0/24` thành 2 lớp mạng con là `192.168.68.0/25` và `192.168.68.128/25` với mỗi lớp mạng có 128 địa chỉ IP và có 126 địa chỉ IP dùng được(đủ đáp ứng yêu cầu tầng 1 là 120 máy). Ta sử dụng lớp mạng `192.168.68.128/25` cho tầng 1
  - Tầng 2 có nhu cầu sử dụng mạng trung bình, ta thực hiện chia lớp mạng `192.168.68.0/25` thành 2 lớp mạng con `192.168.68.0/26` và `192.168.68.64/26` với mỗi lớp mạng có 64 địa chỉ IP và 62 địa chỉ IP có thể sử dụng(đủ đáp ứng nhu cầu ở tầng 2 là 60 máy). Ta sử dụng lớp mạng `192.168.68.64/26` cho tầng 2
  - Ở tầng 3 và 4, có nhu cầu sử dụng mạng khá ít, ta chia lớp mạng `192.168.68.0/26` còn lại thành 2 lớp mạng con `192.168.68.0/27` và `192.168.68.32/27` với mỗi lớp mạng có 32 địa chỉ IP và 30 địa chỉ IP có thể dùng được(vừa đủ với nhu cầu tầng 3 và thừa so với tầng 4). Ta gán lớp `192.168.68.0/27` cho tầng 3 và `192.168.68.32/27` cho tầng 4
  - Qúa trình phân chia mạng cho công ty hoàn tất. Phân chia mạng thành các mạng con giúp tối ưu hóa địa chỉ IP, giảm thiểu khả năng lãng phí và khiến việc quản lý mạng trở nên dễ dàng hơn
## 3.7 Ưu điểm của IPv4
- IPv4 là một giao thức không hướng nối
- Định tuyến IPv4 có thể được xử lý dễ dàng bởi tất cả các hệ thống.
- Dễ dàng ghi nhớ
- Trên một mạng lớn, IPv4 có thể kết nối nhiều thiết bị khác nhau và cùng với kết nối, việc xác minh cũng có thể được thực hiện. Điều này được thực hiện mà không cần sử dụng NAT
- Quyền riêng tư và bảo mật được duy trì trong IPv4 vì dữ liệu được mã hóa trong các gói.
## 3.8 Nhược điểm của IPv4:
- Với tốc độ phát triển Internet hiện nay, tài nguyên địa chỉ IPv4 đang dần cạn kiệt
- Vì IPv4 đã được thiết lập từ lâu, nên việc triển khai ngày nay có thể gặp các mối đe dọa mới
- Để khắc phục những điều này, IPv6 đã được cho ra đời
# 4. Các kiểu định tuyến:
- Broadcast: Một gói tin broadcast sẽ được chuyển tới tất cả các thiết bị bên trong 1 dải mạng, không quy định rõ ràng máy nào nhận. Nhưng broadcast chỉ giới hạn trong 1 mạng cục bộ và bị chặn bởi Router
- Anycast: Là kiểu truyền từ nguồn tới một nút mạng gần với nó nhất. 
- Multicast: Là kiểu truyền từ nguồn tới nhiều điểm khác(một nhóm các thiết bị trong mạng)
- Unicast: Là kiểu truyền dữ liệu phổ biến nhất trong Internet. Lưu lượng dữ liệu đi từ một nguồn tới một đích duy nhất. Đây chính là kiểu truyền dữ liệu **one-to-one** giữa bên gửi và bên nhận
# 5. Quá trình truyền tin qua Internet:
Sau khi biết thêm về địa chỉ IP Public và Private, tôi đã mô tả lại quá trình truyền tin qua Internet như sau:

![](/Anh/Screenshot_50.png)
- Ở đây, mỗi PC thuộc Router 1 đều có các IP Private riêng thuộc dải mạng `192.168.68.0/24` và tất cả các máy này sẽ đều dùng chung 1 IP Public là `14.177.64.37`- đây chính là địa chỉ mà công ty 1 đã thuê từ Một bên cung cấp dịch vụ Internet. Tương tự công ty 2 có IP Public là `ipPu2` và mỗi máy trong công ty 2 có các IP Private là `ipPr2/24`. Các máy trong 1 công ty được kết nối với nhau thông qua Switch và mỗi công ty có 1 router là Router 1 và Router 2
  - Ta cùng đi phân tích:
    - Giả sử PC A muốn gửi 1 gói tin cho PC E
    - Quá trình này sẽ diễn ra như sau: 
      - Từ PC A, sẽ thực hiện thiết lập kết nối tới Router 1 mang IP:`192.168.68.1`, quá trình này bao gồm các giao thức như ARP, TCP, UDP,..., sau đó sẽ thực hiện gửi tói tin cần gửi tới Router 1.
      - Tại Router 1, cơ chế NAT sẽ được thực hiện ở đây. Router 1 sẽ biến đổi từ địa chỉ IP Private sang IP Public để có thể kết nối ra Internet.
      - Ở Router 1 quá trình gửi gói tin tới Router 2 qua internet cũng có các quy trình như thiết lập kết nối, sau đó mới thực hiện gửi gói tin tới Router 2 nhưng ở đây 2 địa chỉ IP là 2 địa chỉ Public. Và gói tin sẽ được gửi thông qua bên công ty dịch vụ cung cấp các dịch vụ mạng rồi mới được chuyển tới Router 2.
      - Router 2 nhận gói tin PC A từ Router 1 sẽ thực hiện thiết lập kết nối tới PC E, sau đó gửi gói tin mà PC A đã gửi tới PC E.
  - Thật ra trong thực tế, gói tin sẽ phải đi qua nhiều nút mạng, sau đó mới có thể tới đích.
  - VD: Khi ta truy cập google:
    - ![](/Anh/Screenshot_77.png)
    - Gói tin phải đi qua nhiều nơi, sau đó mới đến Server của Google.
    - Ở đây, tôi thực hiện dùng lệnh `tracert google.com` để xem quá trình gói tin đi từ máy cá nhân tới Server của **Google.com**
