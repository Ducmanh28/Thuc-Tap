# Mục này tìm hiểu tổng quan về NetBox
## NetBox là gì?
NetBox là một ứng dụng mã nguồn mở, được phát triển bởi DigitalOcean, để quản lý và lập tài liệu cho cơ sở hạ tầng mạng. Được thiết kế để giúp các tổ chức quản lý tài sản mạng của mình một cách hiệu quả và chính xác

NetBox là một công cụ quản lý cơ sở hạ tầng mạng và trung tâm dữ liệu. Nó được sử dụng để lưu trữ thông tin chi tiết về mạng, bao gồm các thiết bị, kết nối, địa chỉ IP, các VLAN, và các thành phần khác

## Lịch sử hình thành và phát triển
### Lịch sử hình thành
#### Khởi đầu
2016, NetBox được công bố lần đầu tiên bởi DigitalOcean vào tháng 6 năm 2016. Ý tưởng ban đầu là tạo ra một công cụ nội bộ để quản lý cơ sở hạ tầng mạng cho DigitalOcean

#### Phát triển ban đầu
2017 - 2018: Nhanh chóng nhận được sự chú ý từ cộng đồng mã nguồn mở. Một số tính năng được cải thiện và mở rộng như:
- Quản lý thiết bị
- Quản lý IP(IPAM)
- Theo dõi kết nối

#### Mở rộng tính năng
2019 - 2020: Tiếp tục phát triển với một số cải tiến như:
- Quản lý các thiết bị ảo(virtualization)
- Quản lý các mạch viễn thông(circuits)
- Tích hợp các plugin để mở rộng chức năng
- Một số cải tiến về giao diện người dùng, hiệu suất

#### Ổn định
2021 - 2022: Đạt được độ ổ định cao hơn, được sử dụng rộng rãi hơn. Các phiên bản mới tập trung vào việc cải thiện hiệu suất, bảo mật và trải nghiệm người dùng

Hệ thống API RESTful của NetBox được cải tiến để hỗ trợ cho các tích hợp và tự động hóa

### Tổng kết phiên bản:
**Phiên bản 1.0**: Phiên bản khởi đầu, giới thiệu các tính năng cơ bản.

**Phiên bản 2.0**: Giới thiệu nhiều cải tiến về giao diện và tính năng, bao gồm hỗ trợ tốt hơn cho IPAM và quản lý thiết bị.

**Phiên bản 2.5**: Thêm hỗ trợ cho virtualization và circuits, cùng với nhiều cải tiến về API.

**Phiên bản 3.0**: Tập trung vào hiệu suất và bảo mật, cải tiến giao diện người dùng, và giới thiệu hệ thống plugin.

**Phiên bản 3.2**: Cải thiện tích hợp và tự động hóa, bổ sung thêm nhiều tính năng quản lý tài nguyên.

## NetBox dùng để làm gì?
NetBox được sử dụng cho nhiều mục đích khác nhau:
- **Quản lý thiết bị lưu trữ**:Lưu trữ và quản lý thông tin về các thiết bị mạng như router, switch, máy chủ, và các thiết bị khác.
- **Quản lý địa chỉ IP**: Quản lý các khối địa chỉ IP và các phân bổ địa chỉ IP.
- **Quản lý cáp và kết nối**: heo dõi các kết nối vật lý giữa các thiết bị, cổng kết nối, và các loại cáp.
- **Quản lý tài sản**: heo dõi thông tin về các tài sản mạng, bao gồm cả phần cứng và phần mềm.
- **Quản lý tài liệu**: Lưu trữ tài liệu liên quan đến cơ sở hạ tầng mạng, như sơ đồ mạng, bản vẽ kỹ thuật, và các tài liệu khác.

## Cấu tạo của NetBox:
NetBox là một ứng dụng web dựa trên Django, một framework Python phổ biến. Nó bao gồm các thành phần chính sau:
- HTTP: nginx hoặc Apache
- WSGI: gunicorn hoặc uWSGI
- App: Django hoặc Python
- Database: Sử dụng PostgreSQL để lưu trữ dữ liệu
- Web Interface: Giao diện web thân thiện để tương tác với người dùng
- API: Cung cấp một API RESTfull để tương tác NetBox với các ứng dụng khác
- Plugins: Hỗ trợ các Plugins để mở rộng chức năng của NetBox
- Hang đợi tác vụ: Redis/django-rq
## Cách hoạt động của NetBox
NetBox hoạt động như một ứng dụng web tiêu chuẩn. Người dùng có thể truy cập giao diện web của NetBox thông qua trình duyệt. Các bước hoạt động cơ bản bao gồm:

- Cài đặt: Cài đặt NetBox trên một máy chủ, cấu hình cơ sở dữ liệu và các thành phần khác.
- Cấu hình: Thêm và cấu hình các thiết bị, khối địa chỉ IP, các kết nối, và các thông tin khác vào NetBox.
- Quản lý: Sử dụng giao diện web hoặc API để quản lý và theo dõi cơ sở hạ tầng mạng.
- Báo cáo: Tạo các báo cáo và trích xuất thông tin từ NetBox để hỗ trợ việc quản lý và lập kế hoạch.


