# Mục này tìm hiểu các mục nằm trong phần Device của NetBox.
## LÝ THUYẾT
### Devices:
Devices: Là thiết bị vật lý trong cơ sở hạ tầng mạng hoặc trung tâm dữ liệu của bạn. 

Modules: Các modules là các thành phần có thể gắn vào thiết bị chính, chẳng hạn như card mạng, module quang học, hoặc các module mở cổng,... nhằm mở rộng chức năng hoặc nâng cấp hiệu suất của thiết bị

Device Roles: Vai trò của thiết bị giúp phân loại và quản lý các thiết bị theo chức năng của chúng .

Platforms: Là hệ điều hành hoặc phần mềm hệ thống đang được khởi chạy trên thiết bị. 

Virtual Chassis: Là một nhóm các thiết bị vật lý được cấu hình để hoạt động như một đơn vị logic duy nhất. Điều này thường áp dụng cho các switch để đơn giản hóa việc quản lý và tăng cường khả năng chịu lỗi

Virtual Device Context(VDCs): Cho phép chia sẻ 1 thiết bị vật lý duy nhất thành nhiều thiết bị ảo, trong đó mỗi thiết bị ảo có thể được cấu hình và quản lý riêng biệt

Ví dụ:
- **Devices**: Switch 01 là switch chính trong trung tâm dữ liệu, chịu trách nhiệm chuyển mạch và định tuyến chính trong mạng
- **Modules**: 48-port 10GbE SFP + là 1 module 48 cổng 10GbE SFP+ được gắn vào Switch 01 để cung cấp kết nối tốc độ cao cho các máy chủ
- **Device Roles**: Core Switch đóng vai trò là thiết bị chuyển mạch chính trong mạng, chịu trách nhiệm kết nối và quản lý lưu lượng giữa các switch khác và các thiết bị mạng quan trọng
- **Platform**: Cisco IOS là hệ điều hành chạy trên các thiết bị switch và router của Cisco, cung cấp các tính năng quản lý và điều khiển mạng tiên tiến
- **Virtual Chassis**: 1 virtual chassis bao gồm Switch01 và Switch02 được cấu hình để quản lý như 1 thiết bị duy nhất
- **Virtual Device Contexts**: Switch01 được chia thành 2 VDC là Internal Network để quản lý mạng nội bộ và External Network dành cho mạng ngoại vi giúp phân tách và bảo mật mạng tốt hơn.