# Tầng Mạng
MỤC LỤC

## 1. Tầng mạng là gì?
- Là tầng thứ 3 trong 7 tầng trong mô hình OSI
- Tầng này cung cấp đường truyền giữa 2 máy tính của tầng mạng. Cụ thể hơn là chuyển gói tin (segment) của tầng transport từ máy tính này đến máy tính khác
- Nhận yêu cầu từ tầng giao vận và đưa ra các yêu cầu cho tầng liên kết dữ liệu
- Chúng ta sẽ thẩy rằng tầng mạng gồm có nhiều máy tính và các router trung gian chứ không như tầng giao vận. Vì thế các giao thức của tầng mạng sẽ rất phức tạp
- Đơn vị dữ liệu: Packets
## 2. Các chức năng chính?
IP datagram packets từ mạng nguồn phải được gửi tới thiết bị nhận đặt tại mạng đích. Vì vậy, các chức năng tầng Network bao gồm:
+ Addressing: Xác định địa chỉ IP đích đến
+ Định tuyến(Routing) - Xác định đường đi: Xác định các tuyến đường dẫn tốt nhất để vận chuyển gói tin
+ Chuyển tiếp(Forwarding): Khi gói tin đến đầu vào router, router phải quyết định gửi gói tin tới đầu ra thích hợp nào. 
+ Encapsulation: Nhận dữ liệu từ giao thức tầng trên, thêm IP Header vào quá trình truyền từ nguồn tới đích
+ De-capsulation: Nhận và mở gói nhận được từ tầng data link
+ Đảm bảo chất lượng dịch vụ(QoS): Có cơ chế kiểm soát lưu lượng và đảm bảo hiệu suất truyền gói tin
+ Sử dụng dịch vụ chuyển mạch gói
## 3. Cách tầng mạng hoạt động:
- Tầng Mạng nhận gói dữ liệu (segment) từ tầng giao vận, và thêm vào các tiêu đề (header) của nó. Phần tiêu đề này chứa thông tin cần thiết cho việc định tuyến và chuyển tiếp
- Định tuyến: Xác định đường đi tốt nhất để truyền các gói dữ liệu từ nguồn đến đích.
- Chuyển tiếp: Sau khi xác định đường dẫn, tầng mạng chuyển tiếp các gói dữ liệu đến tầng datalink. 
- Xử lý lỗi và tắc nghẽn: Cũng chịu trách nhiệm trong việc xử lý các vấn đề như tắc nghẽn mạng và lỗi truyền dẫn. Nếu có lỗi, thử lại việc truyền dữ liệu

Các quá trình này sẽ lặp lại cho tới khi truyền hết dữ liệu 

## 4. Dịch vụ chuyển mạch gói (datagram) và chuyển mạch ảo (virtual circuit)
## 4.1 Tổng quan
- Để chuyển gói tin của tầng giao vận, tầng mạng thường đưa ra dịch vụ chuyển mạch ảo hoặc chuyển mạch gói nhưng không bao giờ cung cấp cả 2 dịch vụ này
- Hiểu đơn giản thì:
    + Chuyển mạch gói: các gói tin khác nhau có thể đi theo các tuyến đường khác nhau
    + Chuyển mạch ảo: 
- VD: Dịch vụ của mạng ATM là VC trong khi mạng Internet cung cấp dịch vụ chuyển mạch gói 
## 4.2 Dịch vụ chuyển mạch gói
Trong mạng chuyển mahc gói, khi muốn gửi 1 gói tin đi, thiết bị đầu cuối đặt vào gói tin địa chỉ của thiết bị nhận, sau đó chuyển gói tin vào mạng
![Alt text](/Anh/image17.png)
Nó không có giai đoạn thiết lập VC. Những thiết bị trung chuyển trong chuyển mạch gói (gọi là bộ định tuyến - router) không duy trì bất kì trạng thái nào về VC. Những thiết bị này sẽ xác định địa chỉ đích --> tìm kiếm trên bảng định tuyến --> chuyển tiếp gói tin theo hướng đến đích(ta có thể thấy nó giống việc chuyển thư bình thường trong bưu điện).

Vì bảng định tuyến có thể được cập nhật liên tục --> các gói tin được gửi từ các thiết bị đầu cuối này tới thiết bị khác có thể đi bằng nhiều đường khác nhau, không theo thứ tự

Mạng Internet ngày nay sử dụng dịch vụ chuyển mạch gói
## 4.3 Dịch vụ chuyển mạch ảo
- Về 1 khía cạnh nào đó, mạch ảo tương tự mạng điện thoại truyền thống (mặc dù mạng điện thoại sử dụng mạch thực). Có 3 giai đoạn:
    + Thiết lập mạch ảo: Phía gửi thông báo địa chỉ , yêu cầu thiết lập **VC**. Tầng mạng lúc này chấp nhận sẽ xác định đường đi, thiết bị sử dụng mà các gói dữ liệu sẽ đi qua 
    + Truyền dữ liệu: Sau khi việc thiết lập kết nối thành công, dữ liệu sẽ được truyền trong **VC**
    + Giải phóng mạch ảo: Bắt đầu khi phía gửi (hoặc nhận)  báo cho tầng mạng yêu cầu đóng **VC**. Tầng mạng sẽ thông báo cho các thiết bị đầu cuối cũng như các thiết bị chuyển mạch trên VC để cập nhật lại bảng định tuyến, giải phóng tài nguyên.
    
![Alt text](/Anh/image16.png)

- Thông điệp trao đổi giữa các thiết bị đầu cuối yêu cầu khởi tạo hay kết thúc mạch ảo, hay thông điệp trao đổi giữa các thiết bị chuyển mạch ảo được gọi là thông điệp báo hiệu (signaling message). Và giao thức được dùng ở đầy là giao thức báo hiệu (signaling protocol)

# 5. Định tuyến
## 5.1 Tổng quan:
Để truyền gói dữ liệu từ máy tính gửi đến máy tính nhận, tầng mạng phải quyết định đường đi, các router mà gói dữ liệu sẽ đi qua. 



