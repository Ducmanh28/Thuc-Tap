# Mục này tìm hiểu về Plugin trong NetBox
## Tổng quan:
Để có thể tạo ra được Plugin cho NetBox thì trước tiên chúng ta cần phải hiểu Plugin là gì.

### Plugin NetBox là gì?
Plugin chính là các thành phần mở rộng được tích hợp để thêm tính năng hoặc tùy chỉnh hoạt động của NetBox mà không cần sửa đổi mã nguồn gốc. 
- Chúng cho phép người dùng mở rộng khả năng của hệ thống, chẳng hạn như bổ sung các tính năng quản lý thiết bị mới, tích hợp với hệ thống khác hoặc thay đổi cách hiển thị và tương tác với dữ liệu. 
- NetBox hỗ trợ plugins thông qua **API** và **UI**, và chúng thường được cài đặt như các gói Python và cấu hình trong tệp `configuration.py` 

### Cách hoạt động của plugin NetBox:
**Tích hợp API**: Plugins có thể bổ sung hoặc mở rộng API của NetBox để cung cấp các endpoint tùy chỉnh cho các mục đích đặc biệt.

**Giao diện người dùng**: Plugins có thể thay đổi hoặc thêm vào giao diện NetBox, chẳng hạn như các trang mới, biểu mẫu hoặc trường dữ liệu.

**Xử lý sự kiện**: Plugins có thể xử lý các sự kiện, chẳng hạn như kích hoạt một số hành động khi có một thay đổi nhất định trong NetBox (ví dụ: thêm thiết bị mới).

**Chức năng bổ sung**: Chúng có thể tích hợp các công cụ khác vào NetBox, cung cấp các tính năng như quản lý cấu hình, tự động hóa, báo cáo hoặc tích hợp với các hệ thống giám sát và quản lý bên ngoài.

## Cách tạo ra Plugin
### Điều kiện cần có:
Trước khi cố gắng tạo một plugin, vui lòng đánh giá khả năng cá nhân của bạn. Bạn sẽ cần có khả năng ở:
- Lập trình Python
- Khung Django
- Kiến thức cơ bản về API REST (nếu có)
- Cài đặt, cấu hình và sử dụng NetBox

### Các bước:
Bước 1: Thiết lập 

Bước 2: Mô hình

Bước 3: Bảng

Bước 4: Biểu mẫu

Bước 5: Lượt xem

Bước 6: Mẫu

Bước 7: Điều hướng

Bước 8: Bộ lọc

Bước 9: REST API

Bước 10: API GraphQL

Bước 11: Tìm kiếm

### Tham Khảo
- [NetBox-Community](https://github.com/netbox-community/netbox-plugin-tutorial)

- [NetBoxDevelopment-Plugin](https://netbox.readthedocs.io/en/stable/plugins/development/)

- [Một vài Plugin được NetBox chứng nhận](https://github.com/netbox-community/netbox/wiki/Plugin-Certification-Program)