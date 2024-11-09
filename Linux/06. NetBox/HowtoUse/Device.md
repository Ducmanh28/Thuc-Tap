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

### Device Types:
Device Types: là các kiểu, dạng thiết bị định trước, nó sẽ mô tả các thuộc tính của 1 loại thiết bị cụ thể. Điều này giúp chuẩn hóa việc quản lý thiết bị bằng cách cung cấp 1 cấu hình chung cho tất cả các thiết bị thuộc cùng 1 loại

Module Types: là các kiểu, mẫu module định trước, mô tả các thuộc tính chung của một loại module cụ thể. Module Types bao gồm thông tin về loại kết nối, số cổng, kích thước và các tính năng kỹ thuật khác

Manufactures: Là nhà sản xuất các thiết bị và module. 

Ví dụ: Quản lý thiết bị Switch
- **Manufacturer**: Cisco Systems - là 1 công ty công nghệ đa quốc gia của Mỹ, nổi tiếng với các sản phẩm và dịch vụ liên quan đến mạng và truyền thông
- **Device Type**: Cisco Catalyst 9300 - là thiết bị chuyển mạch với 48 cổng ethernet 1GbE và 4 cổng uplink 10GbE, kích thước 1U, được dùng phổ biến trong các mạng doanh nghiệp
- **Module Type**: Cisco 9300 48-port 10GbE SFP+ Module - là module dùng để mở rộng số cổng mạng tốc độ cao trên switch Cisco Catalyst 9300.

### Device Components(Các thành phần)
**Interfaces**: Là các kết nối mạng trên thiết bị, như cổng Ethernet, cổng quang học, và các loại kết nối khác. Interfaces sẽ cung cấp các thông tin về tốc độ, loại kết nối, và trạng thái của từng cổng.

**Front Ports**: Là các kết nối vật lý nằm ở mặt trước của thiết bị. 
Thường được sử dụng cho các kết nối nhanh chóng các thiết bị ngoại vi hoặc cáp mạng

**Rear Ports**: Là các cổng kết nối nằm ở phía sau. Thường được sử dụng cho các kết nối cố định hoặc các kết nối chính

**Console Ports**: Các cổng điều khiển là các kết nối đặc biệt dùng để quản lý và cấu hình thiết bị thông qua giao diện dòng lệnh (CLI). Thường được sử dụng cho các nhiệm vụ quản trị

**Console Server Ports**: Các cổng điều khiển server là các cổng kết nối đến một máy chủ điều khiển, cho phép quản trị từ xa các thiết bị thông qua mạng

**Power Ports**: Các cổng nguồn là các kết nối cung cấp điện cho thiết bị. Chúng bao gồm thông tin về loại cổng, điện áp, và công suất

**Power Outlets**: Các ổ cắm nguồn là các kết nối cung cấp điện từ thiết bị ra ngoài, thường dùng để cấp nguồn cho các thiết bị khác.

**Module Bays**: Các khay module là các khe cắm trên thiết bị chính dùng để lắp đặt các module mở rộng, giúp tăng cường tính năng và hiệu suất của thiết bị

**Device Bays**: Các khay thiết bị là các khe cắm để lắp đặt các thiết bị khác, như các ổ cứng, bộ xử lý, hoặc các thành phần phần cứng khác

**Inventory Items**: Các mục tồn kho là các phần tử cụ thể trong thiết bị, như bộ nhớ, CPU, ổ cứng, hoặc các linh kiện khác. Mỗi mục tồn kho được theo dõi riêng lẻ để quản lý hiệu quả.

**Inventory Item Roles**: Các vai trò của mục tồn kho là các chức năng hoặc nhiệm vụ mà mỗi mục tồn kho thực hiện trong thiết bị. Điều này giúp phân loại và quản lý các linh kiện dựa trên vai trò của chúng

Ví dụ:
Thiết bị Router Cisco ASR 9000 với các thành phần chi tiết như sau:
- Device Components: Các thành phần của router bao gồm giao diện mạng, cổng nguồn, cổng điều khiển, và các khay module
- Interfaces: Router Cisco ASR 9000 có 10 cổng Ethernet 10GbE và 2 cổng Ethernet 100GbE
- Front Ports: Các cổng phía trước của router bao gồm các cổng Ethernet và các cổng quang học cho kết nối mạng
- Rear Ports: Các cổng phía sau của router bao gồm các cổng nguồn và các cổng điều khiển
- Console Ports: Router có một cổng điều khiển RS-232 ở mặt trước để quản lý cấu hình
- Console Server Ports: Kết nối đến một máy chủ điều khiển qua cổng RJ-45 cho quản trị từ xa
- Power Ports: Router có hai cổng nguồn AC với điện áp 220V.
- Power Outlets: Router không có ổ cắm nguồn ra ngoài
- Module Bays: Router có 4 khay module để lắp các module mở rộng như các module chuyển mạch hoặc module cổng
- Device Bays: Router có 2 khay thiết bị để lắp thêm ổ cứng hoặc bộ xử lý bổ sung
- Inventory Items: Bộ nhớ 32GB, CPU Intel Xeon, 4 ổ SSD 1TB
- Inventory Item Roles: Bộ nhớ dùng cho lưu trữ tạm thời (RAM), CPU dùng cho xử lý dữ liệu, ổ SSD dùng cho lưu trữ dữ liệu dài hạn

## THỰC HÀNH 
Chúng ta sẽ thực hành tạo theo thứ tự của NetBox. Nếu chưa nắm rõ quy luật tạo, vui lòng tham khảo tại [đây](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/HowtoUse/OrderofOperators.md)

### Tạo Manufacturer
Tạo 1 nhà sản xuất cơ bản như sau:

![](/Anh/Screenshot_764.png)

### Tạo Device Type
Tạo Device Types với 1 số thông tin cơ bản như sau:

![](/Anh/Screenshot_765.png)

![](/Anh/Screenshot_766.png)

### Tạo Module Type
Có thể tạo mẫu module type như sau:

![](/Anh/Screenshot_767.png)

### Tạo Device Roles
Tạo device roles có vai trò access-switch

![](/Anh/Screenshot_768.png)

### Tạo Platforms
Hệ điều hành IOS-XE của Cisco

![](/Anh/Screenshot_769.png)

### Tạo Device:
Tạo mẫu 1 Switch như sau:

![](/Anh/Screenshot_771.png)

![](/Anh/Screenshot_772.png)

![](/Anh/Screenshot_773.png)
### Tạo Virtual Chassis
Tạo như sau:

![](/Anh/Screenshot_774.png)

### Tạo Virtual Device Context
Tạo VDC như sau:

![](/Anh/Screenshot_775.png)

### Tạo Module Bay
Tạo vị trí khe cắm đầu tiên:

![](/Anh/Screenshot_776.png)

### Tạo Module:
Module cắm vào khe số 1:

![](/Anh/Screenshot_777.png)

### Tạo Device Components
Tạo các thành phần của thiết bị
#### Interfaces

![](/Anh/Screenshot_778.png)
