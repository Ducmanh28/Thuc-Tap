# Mục này tìm hiểu các thông số liên quan đến ổ cứng

## Một số khái niệm liên quan đến ổ cứng

**Latency** : Là thời gian cần thiết để ổ cứng phản hồi một yêu cầu Input hoặc Output. 
- Độ trễ tổng cộng được chia thành:
  - Seek Time: Thời gian để đầu đọc/ghi di chuyển đến vị trí cụ thể trên bề mặt đĩa
  - Rotational Latency: Thời gian cần để đĩa quay đến đúng vị trí mà dữ liệu cần đọc/ghi được đặt
  - Command Overhead: Thời gian xử lý lệnh: Thời gian cần để xử lý và chuẩn bị cho việc đọc hoặc ghi
  - Data Transfer Time: Thời gian để thực sự truyền dữ liệu giữa ổ cứng và hệ thống
- Đơn vị đo: Milliseconds(ms), microseconds đối với ổ SSD
- Ý nghĩa: Độ trễ càng thấp thì ổ cứng phản hồi càng nhanh, cải thiện hiệu suất tổng thể của hệ thống

**IOPS** (Input/Output Operations Per Second): Đo lường khẳ năng của ổ cứng trong việc xử lý các yêu cầu nhập xuất trong một giây. Nó bao gồm các hoạt động đọc và ghi.
- Đơn vị đo: actions/s
- Yếu tố ảnh hưởng: IOPS phụ thuộc vào nhiều yếu tố như kích thước khối dữ liệu, mẫu truy cập(ngẫu nhiên hay tuần tự), và loại thiết bị
- Ý nghĩa: IOPS cao nghĩa là ổ cứng có thể xử lý nhiều yêu cầu I/O hơn trong cùng một khoảng thời gian, điều này đặc biệt quan trọng đối với các hệ thống cần xử lý nhiều tác vụ động thời, chẳng hạn như là 1 máy chủ Database

**Bandwidth** (Băng thông): Là tốc độ tối đa mà dữ liệu có thể được truyền từ hoặc đến ổ cứng trong 1 khoảng thời gian xác định. 
- Đơn vị đo: Mb/s hoặc Gb/s
- Ý nghĩa: Băng thông càng cao thì tốc độ truyền dữ liệu càng nhanh. Điều này quan trọng đối với các ứng dụng cần xử lý hoặc truyền tải lượng dữ liệu lớn, chăng hạn như video chất lượng cao, sao lưu dữ liệu, ....

Một số khái niệm khác như:
- **Capacity**(Dung lượng): Khả năng lưu trữ tối đa mà ổ cứng có thể lưu trữ, thường sẽ đo bằng GB hoặc TB
- **Access Speed**(Tốc độ truy cập): Là thời gian mà ổ cứng cần để truy cập và đọc hoặc ghi dữ liệu. Thường được đo bằng đơn vị (ms) hoặc (ns)
- **Sequential Read/ Write Speed**(Tốc độ đọc/ghi tuần tự): Tốc độ tối đa mà ổ cứng có thể đọc và ghi dữ liệu liên tục. Thương được đo bằng (Mb/s) 
- **Random Read/ Write Speed**(Tốc độ đọc/ghi ngẫu nhiên): Đo bằng số lần đọc/ghi trên 1 giây(IOPS)
- **Cache**: Số lượng bộ nhớ cache trên ổ cứng, giúp cải thiên tốc độ truy cập dữ liệu tạm thời
- **Reliability/Lifespan**: Tuổi thọ dự kiến của ổ cứng, thường được đo bằng giờ hoạt động(MTBF)
- **Interface**: Loại cổng giao tiếp mà ổ cứng sử dụng để kết nối với máy tính. Có thể là: SATA, NVMe, USB,...
- **Drive Type**: Có thể là ổ HDD hoặc SSD
- **Form Factor**: Kích thước ổ cứng: 2.5 inch, 3.5 inch, M.2,...
- **Rotational Speed**(Tốc độ quay): Tốc độ quay của đĩa trong ổ cứng, đo bằng vòng quay mỗi phút (RPM). Ổ cứng có tốc độ quay cao hơn (như 7200 RPM so với 5400 RPM) thường có hiệu suất tốt hơn.
- **Seek Time**(Thời gian tìm kiếm): Thời gian trung bình cần thiết để đầu đọc/ghi di chuyển đến vị trí cần thiết trên đĩa, đo bằng milliseconds (ms).