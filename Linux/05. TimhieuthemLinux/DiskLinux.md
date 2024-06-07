# Mục này tìm hiểu các thông số liên quan đến ổ cứng

## Một số khái niệm liên quan đến ổ cứng

Latency: Là thời gian cần thiết để ổ cứng phản hồi một yêu cầu Input hoặc Output. 
- Độ trễ tổng cộng được chia thành:
  - Seek Time: Thời gian để đầu đọc/ghi di chuyển đến vị trí cụ thể trên bề mặt đĩa
  - Rotational Latency: Thời gian cần để đĩa quay đến đúng vị trí mà dữ liệu cần đọc/ghi được đặt
  - Command Overhead: Thời gian xử lý lệnh: Thời gian cần để xử lý và chuẩn bị cho việc đọc hoặc ghi
  - Data Transfer Time: Thời gian để thực sự truyền dữ liệu giữa ổ cứng và hệ thống
- Đơn vị đo: Milliseconds(ms), microseconds đối với ổ SSD
- Ý nghĩa: Độ trễ càng thấp thì ổ cứng phản hồi càng nhanh, cải thiện hiệu suất tổng thể của hệ thống

IOPS (Input/Output Operations Per Second): Đo lường khẳ năng của ổ cứng trong việc xử lý các yêu cầu nhập xuất trong một giây. Nó bao gồm các hoạt động đọc và ghi.
- Đơn vị đo: actions/s
- Yếu tố ảnh hưởng: IOPS phụ thuộc vào nhiều yếu tố như kích thước khối dữ liệu, mẫu truy cập(ngẫu nhiên hay tuần tự), và loại thiết bị