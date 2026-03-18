# Docker là gì?
Là một nền tảng mở để phát triển, triển khai và khởi chạy các ứng dụng. Docker cho phép bạn tách các ứng dụng khỏi hạ tầng, giúp việc triển khai trở nên nhanh chóng. Với Docker, bạn có thể quản lý cơ sở hạ tầng như quản lý ứng dụng. Bằng cách sử dụng Docker, bạn có thể tối ưu đáng kể thời gian viết mã và triển khai ứng dụng thực tế.

# Docker Platform
Docker cung cấp khả năng đóng gói và chạy ứng dụng trong các vùng chứa(*container*). Sự cô lập và bảo mật này cho phép bạn chạy nhiều container đồng thời trên 1 máy chủ nhất định.

Container có trọng lượng nhẹ và chứa mọi thứ cần thiết để chạy ứng dụng, vì vậy bạn không cần dựa vào những gì đã được cài đặt trên máy chủ.

Bạn có thể chia sẻ container trong khi làm việc, và hãy đảm bảo rằng mọi người bạn chỉa sẻ đều nhận được cùng 1 container hoạt động theo cách tương tự

# Docker có thể làm được gì
## Phân phối ứng dụng nhanh chóng, nhất quán
Docker hợp lý hóa vòng đời phát triển bằng cách cho phép các nhà phát triển làm việc trong môi trường được tiêu chuẩn hóa bằng cách sử dụng các bộ chứa cục bộ cung cấp cho các ứng dụng của bạn và dịch vụ. Container rất tốt để tích hợp liên tục và liên tục quy trình phân phối (CI/CD).

Hãy xem xét tình huống ví dụ sau:

- Các nhà phát triển của bạn viết mã cục bộ và chia sẻ công việc của họ với đồng nghiệp của họ sử dụng container Docker.
- Họ sử dụng Docker để đẩy ứng dụng của mình vào môi trường thử nghiệm và chạy kiểm tra tự động và thủ công.
- Khi các nhà phát triển tìm thấy lỗi, họ có thể sửa chúng trong môi trường phát triển và triển khai lại chúng vào môi trường thử nghiệm để thử nghiệm và xác thực.
- Khi thử nghiệm hoàn tất, việc khắc phục cho khách hàng cũng đơn giản như đẩy hình ảnh cập nhật lên môi trường sản xuất.
## Triển khai và mở rộng quy mô đáp ứng
Nền tảng dựa trên bộ chứa của Docker cho phép khối lượng công việc có tính di động cao. Docker container có thể chạy trên máy tính xách tay cục bộ của nhà phát triển, trên vật lý hoặc ảo máy móc trong trung tâm dữ liệu, trên các nhà cung cấp dịch vụ đám mây hoặc trong hỗn hợp các môi trường.

Tính di động và tính chất nhẹ của Docker cũng giúp bạn dễ dàng động quản lý khối lượng công việc, mở rộng quy mô hoặc phá bỏ các ứng dụng và dịch vụ như Nhu cầu kinh doanh quyết định, gần như theo thời gian thực.

## Chạy nhiều khối lượng công việc hơn trên cùng một phần cứng
Docker nhẹ và nhanh. Nó cung cấp một giải pháp thay thế khả thi, tiết kiệm chi phí đến các máy ảo dựa trên hypervisor, để bạn có thể sử dụng nhiều máy chủ hơn năng lực để đạt được mục tiêu kinh doanh của bạn. Docker hoàn hảo cho mật độ cao môi trường và cho các triển khai vừa và nhỏ, nơi bạn cần làm nhiều việc hơn với ít tài nguyên hơn.

# Kiến trúc của Docker
Sử dụng kiến trúc Client-Server. Client sẽ giao tiếp với Docker-daemon, thực hiện các công việc nặng như xây dựng, chạy và phân phối các container của bạn.

Client có thể chạy trên cùng 1 hệ thống hoặc có thể kết nối client với Docker từ xa.

Quá trình giao tiếp sử dụng API REST, qua UNIX ổ cắm hoặc giao diện mạng. Một ứng dụng Docker khác là Docker Compose sẽ cho phép bạn làm việc với các ứng dụng bao gồm 1 tập hợp các container

# Docker Daemon
Là 1 trình chạy ngầm của Docker, là cách chính mà người dùng Docker tương tác với Docker. Khi bạn sử dụng các lệnh, client sẽ gửi các lệnh này đến server và thực hiện chúng. Lệnh sử dụng API Docker. Docker Client có thể giao tiếp với nhiều daemon.

# Đối tượng trong Docker
Khi bạn sử dụng Docker, bạn đang tạo và sử dụng images, container, network, disk, plugin và các đối tượng khác.
## Images
Là 1 mẫu chỉ đọc với hướng dẫn tạo Docker container. Thông thường, 1 images dựa trên 1 images khác, với 1 số lượng tùy chỉnh bổ sung. Ví dụ:
- Bạn có thể tạo 1 image dựa trên Ubuntu image nhưng vao gồm máy chủ web Apache và ứng dụng của bạn, cũng như chi tiết cấu hình cần thiết để làm cho ứng dụng của bạn chạy 
 
Bạn cũng có thể tạo image của riêng mình hoặc bạn có thể sử dụng những image do người khác tạo ra. Để tạo image của riêng bạn, bạn tạo 1 Dockerfile với 1 cú pháp đơn giản để xác định các bước cần thiết để tạo image và chạy nó.

Mỗi lệnh trong Dockerfile sẽ tạo ra 1 lớp trong hình ảnh. Khi bạn thay đổi tệp Docker và xây dựng lại image, chỉ những lớp có thay đổi được xây dựng lại. Đây là 1 phần của những gì làm cho image trở nên nhẹ, nhỏ và nhanh chóng khi so sánh với các công nghệ ảo hóa khác.

## Containers
container là một phiên bản có thể chạy được của hình ảnh. Bạn có thể tạo, bắt đầu, dừng, di chuyển hoặc xóa container bằng API Docker hoặc CLI. Bạn có thể kết nối một vào một hoặc nhiều mạng, đính kèm bộ nhớ vào mạng hoặc thậm chí tạo một hình ảnh dựa trên trạng thái hiện tại của nó.

Theo mặc định, một container được cách ly tương đối tốt với các container khác và máy chủ của nó. Bạn có thể kiểm soát mức độ cách ly mạng, bộ lưu trữ của bộ chứa, hoặc các hệ thống con cơ bản khác là từ các container khác hoặc từ máy chủ máy móc.

Một container được xác định bởi hình ảnh của nó cũng như bất kỳ tùy chọn cấu hình nào mà bạn cung cấp cho nó khi bạn tạo hoặc khởi động nó. Khi một container bị xóa, mọi thay đổi đối với trạng thái của nó không được lưu trữ trong bộ nhớ liên tục sẽ biến mất.