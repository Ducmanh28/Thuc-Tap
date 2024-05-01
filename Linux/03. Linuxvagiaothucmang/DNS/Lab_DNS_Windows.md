# Mục này show ra quá trình lab DNS Local trên Windows
Chúng ta sẽ thực hiện tìm hiểu và thực hành DNS Local 
## Một vài thông tin về DNS Local
Là một hệ thống DNS được triển khai để hoạt động trên hệ thống mạng nội bộ, chủ yếu phục vụ các yêu cầu DNS của các thiết bị trong mạng nội bộ

## So sánh giữa DNS Local và DNS Public
**Phạm vi hoạt động:**
- DNS local: Hoạt động trong mạng nội bộ như gia đình, doanh nghiệp hoặc tổ chức. Nó phục vụ các yêu cầu DNS từ các thiết bị trong mạng cụ thể và được cấu hình và quản lý bởi người quản trị mạng trong mạng đó.
- DNS public: Là các máy chủ DNS được triển khai công cộng trên Internet và phục vụ cho mọi người trên toàn cầu. Các ví dụ của DNS public bao gồm các máy chủ DNS của các nhà cung cấp dịch vụ Internet (ISP) hoặc các dịch vụ DNS công cộng như của Google (8.8.8.8, 8.8.4.4).

**Hiệu suất và độ trễ**:
- DNS local: Thường có hiệu suất cao hơn vì nó nằm gần với người dùng và có thể lưu trữ thông tin trong bộ nhớ cache. Điều này giảm độ trễ và tăng tốc độ phản hồi cho các yêu cầu DNS.
- DNS public: Có thể có độ trễ cao hơn do phải xử lý các yêu cầu từ nhiều nguồn trên toàn cầu. Hiệu suất cũng có thể bị ảnh hưởng bởi các yếu tố như mạng Internet và tải lên máy chủ 
DNS công cộng.

**Bảo mật**:
- DNS local: Có thể được cấu hình để thực hiện các biện pháp bảo mật nhất định như kiểm soát truy cập, lọc nội dung hoặc chặn các trang web độc hại.
- DNS public: Cung cấp dịch vụ DNS mở và không cung cấp các tính năng bảo mật cao cấp như một máy chủ DNS local có thể thực hiện.

**Quản lý và kiểm soát**:
- DNS local: Được quản lý và kiểm soát hoàn toàn bởi người quản trị mạng trong mạng nội bộ. Người quản trị có thể cấu hình và tinh chỉnh máy chủ DNS theo nhu cầu cụ thể của họ.
- DNS public: Không được quản lý hoặc kiểm soát bởi người dùng cuối. Người dùng chỉ có thể chọn máy chủ DNS công cộng mà họ muốn sử dụng.

**Tính riêng tư**:
- DNS local: Có thể cung cấp mức độ riêng tư cao hơn do thông tin DNS của mạng nội bộ không được chia sẻ với công chúng.
- DNS public: Có thể liên kết các yêu cầu DNS với địa chỉ IP của người dùng, tạo ra các vấn đề liên quan đến quyền riêng tư.

## Mô hình hoạt động của DNS Local
Cài đặt máy chủ DNS local: Đầu tiên, bạn cần cài đặt một máy chủ DNS trên mạng nội bộ của bạn. Điều này có thể là một máy tính hoặc một thiết bị đặc biệt được cấu hình để chạy dịch vụ DNS.

Cấu hình máy chủ DNS: Bạn cần cấu hình máy chủ DNS để biết nơi nào để tra cứu các tên miền. Máy chủ DNS có thể được cấu hình để sử dụng một máy chủ DNS cấp cao hơn (như máy chủ DNS của ISP hoặc các máy chủ DNS công cộng như của Google) để tra cứu các tên miền mà nó không biết.

Phản hồi yêu cầu DNS: Khi một thiết bị trong mạng nội bộ gửi yêu cầu DNS đến máy chủ DNS local (ví dụ: yêu cầu giải quyết tên miền "www.example.com"), máy chủ DNS local sẽ kiểm tra xem nó có thông tin cho tên miền đó trong cơ sở dữ liệu của mình không.

Cache: Nếu máy chủ DNS local đã trước đó truy vấn thông tin cho tên miền đó và lưu trữ kết quả (được gọi là caching), nó sẽ trả lại địa chỉ IP từ bộ nhớ cache của mình. Điều này giúp cải thiện hiệu suất và giảm tải lên máy chủ DNS cấp cao hơn.

Tra cứu từ máy chủ cấp cao hơn (nếu cần): Nếu máy chủ DNS local không có thông tin trong bộ nhớ cache của mình, nó sẽ gửi yêu cầu DNS đến máy chủ DNS cấp cao hơn (hoặc máy chủ DNS công cộng nếu được cấu hình). Máy chủ này sẽ cố gắng giải quyết tên miền và trả lại địa chỉ IP tương ứng.

Trả về phản hồi: Máy chủ DNS local nhận phản hồi từ máy chủ cấp cao hơn và trả lại địa chỉ IP cho thiết bị yêu cầu.