# Ứng dụng WireShark

## 1. WireShark là gì?
![Alt text](/Anh/image28.png)

- Là 1 ứng dụng phân tích mạng
- Có thể bắt, phân tích, xác định các vấn đề có liên quan đến internet:
    + kết nối chậm
    + rớt gói tin
    + truy cập bất thường

==> Thông qua WireShark, quản trị viên có thể 
- hiểu hơn về Network Packets đang chạy trên hệ thống
- xác định lỗi và nguyên nhân gây ra lỗi một cách dễ dàng hơn

## 2. WireShark dùng để làm gì
- Để khắc phục sự cố mạng
- Kiểm tra các vấn đề liên quan đến bảo mật
- Xác minh các ứng dụng mạng
- Gỡ lỗi khi triển khai giao thức
- ...
## 3. Một vài tính năng nổi bật
- Có sẵn cho các hệ diều hành
- Có thể chụp dữ liệu gói trực tiếp từ giao diện mạng
- Thực hiện mở các tệp chứa gói dữ liệu bằng tcpdump, Windump
- Nhập các gói từ các tệp văn bản có chứa các hex dump của packetdata
- Hiển thị các gói thông tin 1 cách vô cùng chi tiết
- Tiến hành lưu trữ tất cả các dữ liệu gói đã bị bắt
- Xuất 1 số hoặc tất cả các gói thông qua định dạng capture file
- Dựa vào các tiêu chí khác nhau để chọn lọc gói tin
- Dựa trên nhiều tiêu chí để tìm kiếm các gói
- Colorize là gói hiển thị dựa trên bộ lọc
- Tạo các số liệu thống kê khác nhau

## 4. Cách mà WireShark hoạt động
Sử dụng pcap để nắm bắt các gói tin từ một mạng hoặc 1 tệp. Sau đó, nó thực hiện phân tích cú pháp và giải mã. Nó sẽ hiển thị cấu trúc và ý nghĩa của các giao thức mạng khác nhau. 

## 5. Cách tải WireShark
- Truy cập vào trang web của [WireShark](https://www.wireshark.org/)
- Thực hiện chọn phiên bản phù hợp với máy tính của bạn.Wireshark cung cấp ba phiên bản khác nhau:
    + Phiên bản dành cho máy tính để bàn được sử dụng cho các sự cố mạng thực tế
    + Phiên bản di động được sử dụng để phân tích pháp y
    + Phiên bản trực tuyến được sử dụng để phân tích pháp y và cung cấp đầy đủ chức năng của giao thức phân tích mạng


