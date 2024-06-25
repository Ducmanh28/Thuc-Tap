# Features of NetBox(Các tính năng của NetBox)
Mục Lục:
- [Features of NetBox(Các tính năng của NetBox)](#features-of-netboxcác-tính-năng-của-netbox)
  - [Facilities(Sự tiện nghi bao quát)](#facilitiessự-tiện-nghi-bao-quát)
    - [Region(Khu vực)](#regionkhu-vực)
    - [SiteGroup](#sitegroup)
    - [Site](#site)
    - [Location(Vị trí)](#locationvị-trí)
    - [Rack(Giá đỡ)](#rackgiá-đỡ)
    - [Rack Role (Vai trò của giá đỡ):](#rack-role-vai-trò-của-giá-đỡ)
    - [Device (Thiết bị):](#device-thiết-bị)
    - [Ví dụ thực tế:](#ví-dụ-thực-tế)
  - [Devices \& Cabling](#devices--cabling)
    - [Manufacturer](#manufacturer)
    - [DeviceRole](#devicerole)
    - [Platform](#platform)
    - [DeviceType](#devicetype)
    - [ModuleType](#moduletype)
    - [Module](#module)
    - [Interface (Giao diện)](#interface-giao-diện)
    - [ConsolePort (Cổng điều khiển)](#consoleport-cổng-điều-khiển)
    - [PowerPort (Cổng nguồn điện)](#powerport-cổng-nguồn-điện)
    - [Ví dụ thực tế:](#ví-dụ-thực-tế-1)
    - [Cable (Cáp)](#cable-cáp)
  - [Power Tracking](#power-tracking)
    - [Power Panels(Tấm phân phối điện)](#power-panelstấm-phân-phối-điện)
    - [Power Feeds(Nguồn cấp điện)](#power-feedsnguồn-cấp-điện)
## Facilities(Sự tiện nghi bao quát)
Từ các khu vực chứa đựng máy chủ lớn, đến tận nơi các giá đỡ thiết bị mạng riêng lẻ, NetBox đều cho phép bạn mô hình hóa toàn bộ sự hiện diện của mạng. Điều này được thực hiện thông qua việc sử dụng một số mô hình được xây dựng có mục đích. Biểu đồ dưới đây có thể minh họa một phần của chúng:

![](/Anh/Screenshot_736.png)

### Region(Khu vực)
**Tính năng**: Cho phép bạn phân chia và quản lý các Site theo khu vực địa lý mà mạng của bạn hoặc của khách hàng có mặt. Chúng thường được sử dụng để mô hình hóa các quốc gia, tiểu bang và thành phố. NetBox không quy định bất kỳ cách sử dụng chính xác nào nên nhu cầu để sử dụng của mỗi người có thể khác nhau.

**Lợi ích**: Giúp tổ chức các Site một cách logic và dễ quản lý, hỗ trợ việc báo cáo và quản lý theo khu vực

**Ví dụ**: Bạn có thể thiết kế ra một mô hình phân cấp như sau:
- Châu Âu
  - Pháp
  - Đức
  - Tây Ban Nha
- Bắc Mỹ
  - Canada
  - Hoa Kỳ
    - California
    - Texas

### SiteGroup
**Tổng quát**: Giống như với các Region, SiteGroup có thể được sắp xếp trong một cấu trúc phân cấp đệ quy. Tuy nhiên, trong khi các Region được dành cho tổ chức địa lý, các SiteGroup có thể được sử dụng để phân nhóm theo chức năng.

**Tính năng**: Cho phép nhóm các Site lại với nhau dựa trên một tiêu chí cụ thể như thuộc cùng một tổ chức con hoặc cùng 1 loại dịch vụ,...

**Lợi ích**: Giúp dễ dàng quản lý và phân loại các trang web, hỗ trợ việc tìm kiếm và báo cáo

**Ví dụ**: Bạn có thể phân loại các Site là Site của công ty, của chi nhánh hoặc khách hàng ngoài vị trí thực tế của chúng

### Site
**Tính năng**: Một Site thường đại diện cho các địa điểm vật lý cụ thể như trung tâm dữ liệu, văn phòng, hoặc bất kỳ địa điểm nào chứa các tài nguyên mạng. Mỗi Site đều được chỉ định một trạng thái hoạt động nào đó.

**Lợi ích**: Cung cấp các thông tin chi tiết về từng địa điểm, bao gồm địa chỉ, thông tin liên hệ, và các chi tiết liên quan khác.

**Ví dụ**: Một công ty quốc tế có các trung tâm dữ liệu tại Bắc Mỹ, Châu Âu, Châu Á. Trung tâm này chia làm 2 nhóm là dữ liệu chính và phụ. Trong nhóm trung tâm dữ liệu chính của khu vực Bắc Mỹ có các trung tâm dữ liệu tại NewYork và Chicago. Vậy thì các trung tâm dữ liệu tại NewYork và Chicago chính là các Site

### Location(Vị trí)
**Tính năng**: Mỗi Location sẽ đại diện cho các vị trí cụ thể ở trong một Site. Chẳng hạn như trong một tòa nhà chia làm nhiều phòng, mỗi phòng đảm nhận một nhiệm vụ khác nhau

**Lợi ích**: Điều này sẽ giúp tạo cấu trúc chi tiết hơn cho mỗi trang web, giúp chỉ định vị trí chính xác các tài nguyên vật lý

### Rack(Giá đỡ)
**Tính năng**: Quản lý các giá đỡ thiết bị, bao gồm thông tin về kích thước, vị trí, và trạng thái sử dụng

**Lợi ích**: Giúp theo dõi việc sử dụng không gian trong các giá đỡ, quản lý việc lắp đặt và bảo trì thiết bị

### Rack Role (Vai trò của giá đỡ):
**Tính năng**: Định nghĩa vai trò hoặc chức năng của các giá đỡ, ví dụ như giá đỡ máy chủ, giá đỡ lưu trữ, giá đỡ mạng

**Lợi ích**: Giúp tổ chức và phân loại các giá đỡ theo chức năng, hỗ trợ việc quản lý và bảo trì

### Device (Thiết bị):
**Tính năng**: Quản lý các thiết bị vật lý, bao gồm thông tin chi tiết về từng thiết bị như loại, nhà sản xuất, model, và vị trí lắp đặt.

**Lợi ích**: Cung cấp cái nhìn tổng thể về tất cả các thiết bị trong hệ thống, hỗ trợ việc theo dõi và quản lý vòng đời của thiết bị.

### Ví dụ thực tế:
**Ví dụ 1**: Quản lý Trung Tâm Dữ Liệu
- Region (Khu vực): Một công ty quốc tế có các trung tâm dữ liệu tại các khu vực Bắc Mỹ, Châu Âu và Châu Á.
- SiteGroup (Nhóm trang web): Trung tâm dữ liệu Bắc Mỹ được chia thành nhóm các trung tâm dữ liệu chính và nhóm các trung tâm dữ liệu phụ.
- Site (Trang web): Trong nhóm trung tâm dữ liệu chính của Bắc Mỹ, có các trung tâm dữ liệu tại New York và Chicago.
- Location (Vị trí): Trung tâm dữ liệu ở New York được chia thành ba tầng, mỗi tầng là một vị trí riêng biệt.
- Rack (Giá đỡ): Trên tầng một của trung tâm dữ liệu New York có 20 giá đỡ thiết bị.
- Device (Thiết bị): Một giá đỡ trên tầng một chứa 10 máy chủ, 2 switch mạng, và 1 firewall.

**Ví dụ 2**: Quản lý Văn Phòng Công Ty
- Region (Khu vực): Một công ty có các văn phòng tại các khu vực Đông Nam Á, Đông Á, và Nam Á.
- SiteGroup (Nhóm trang web): Các văn phòng tại Đông Nam Á được chia thành nhóm văn phòng chính và nhóm văn phòng phụ.
- Site (Trang web): Trong nhóm văn phòng chính của Đông Nam Á, có các văn phòng tại Singapore và Kuala Lumpur.
- Location (Vị trí): Văn phòng tại Singapore có các khu vực làm việc chung, phòng họp, và phòng máy chủ.
- Rack (Giá đỡ): Phòng máy chủ ở văn phòng Singapore có 5 giá đỡ chứa các máy chủ và thiết bị mạng.
- Device (Thiết bị): Một giá đỡ trong phòng máy chủ chứa 5 máy chủ và 2 switch.

## Devices & Cabling
Netbox là một công cụ để mô hình hóa cơ sở hạ tầng mạng của bạn và đối tượng Devices chính là mấu chốt cho chức năng đó. Có thể nhìn tổng quát theo mô hình sau:

![](/Anh/Screenshot_737.png)
### Manufacturer
Tính năng: 
- Lưu trữ thông tin về nhà sản xuất thiết bị và Module
- Liên kết các DeviceType, ModuleType với nhà sản xuất tương ứng

Lợi ích: Dễ dàng theo dõi và quản lý nguồn gốc của thiết bị, module

Ví dụ: Cisco, Juniper, HP là các nhà sản xuất thiết bị mạng phổ biến

### DeviceRole
**Tính năng**: Dùng để xác định vai trò của thiết bị trong mạng

**Lợi ích**: Phân loại và tổ chức thiết bị theo vai trò chức năng, giúp quản lý dễ dàng hơn. 

**Ví dụ**: Router, Switch, Firewall là các vai trò phổ biến trong mạng

### Platform
**Tính năng**: Xác định hệ điều hành hoặc môi trường phần mềm mà thiết bị sử dụng

**Lợi ích**: Quản lý và theo dõi các phiên bản phần mềm/ hệ điều hành của thiết bị

**Ví dụ**: Cisco IOS, Juniper Junos, Artisa EOS,...
### DeviceType
**Tính năng**: Xác định các thông số kỹ thuật và chức năng của thiết bị

**Lợi ích**: Giúp xác định và phân loại thiết bị dựa trên loại cụ thể

**Ví dụ**: Cisco 2901 Router, Juniper EX4300 Switch là các loại thiết bị cụ thể

### ModuleType
**Tính năng**: Xác định các thông số kỹ thuật và chức năng của module

**Lợi ích**: Quản lý và phân loại module dựa trên loại cụ thể

**Ví dụ**: Cisco NIM-2T Serial Module, Juniper MIC-3D-20GE-SFPP là các loại module cụ thể

### Module
**Tính năng**: Mở rộng chức năng hoặc khả năng của thiết bị bằng cách thêm các giao diện hoặc cổng kết nối

**Lợi ích**: Tăng cường khả năng linh hoạt và mở rộng của thiết bị

**Ví dụ**: Một module mạng NIM-2T được gắn vào router Cisco để cung cấp thêm cổng serial

### Interface (Giao diện)
**Tính năng**: Điểm kết nối mạng của thiết bị hoặc module, chẳng hạn như cổng Ethernet

**Lợi ích**: Quản lý và theo dõi các kết nối mạng của thiết bị

**Ví dụ**: Cổng Ethernet 1/0/1 trên một switch

### ConsolePort (Cổng điều khiển)
**Tính năng**: Cổng dùng để quản lý và cấu hình thiết bị

**Lợi ích**: Cho phép truy cập và cấu hình thiết bị thông qua giao diện dòng lệnh

**Ví dụ**: Cổng console RJ-45 trên một router Cisco

### PowerPort (Cổng nguồn điện)
**Tính năng**: Cổng cung cấp năng lượng cho thiết bị hoặc module

**Lợi ích**: Quản lý và theo dõi các nguồn cung cấp điện cho thiết bị

**Ví dụ**: Cổng nguồn AC trên một switch

### Ví dụ thực tế:
**Trung Tâm Dữ Liệu**
- Manufacturer: Cisco
- DeviceRole: Switch
- Platform: Cisco IOS
- DeviceType: Cisco 3750
- Device: Switch Cisco 3750 có vai trò chính là switch mạng, chạy nền tảng Cisco IOS.
- ModuleType: NIM-2T (Module Serial)
- Module: NIM-2T được gắn vào switch Cisco 3750 để mở rộng cổng serial.
- Interface: Cổng Ethernet 1/0/1 trên switch Cisco 3750.
- ConsolePort: Cổng console RJ-45 để cấu hình switch Cisco 3750.
- PowerPort: Cổng nguồn AC để cấp điện cho switch Cisco 3750.

**Mạng Văn Phòng**
- Manufacturer: Juniper
- DeviceRole: Router
- Platform: Juniper Junos
- DeviceType: Juniper MX480
- Device: Router Juniper MX480 dùng để định tuyến, chạy nền tảng Juniper Junos.
- ModuleType: MIC-3D-20GE-SFPP (Module 20GE)
- Module: MIC-3D-20GE-SFPP được gắn vào router Juniper MX480 để cung cấp thêm cổng 20GE.
- Interface: Cổng GE trên router Juniper MX480.
- ConsolePort: Cổng console trên router Juniper MX480.
- PowerPort: Cổng nguồn DC để cấp điện cho router Juniper MX480.

### Cable (Cáp)
**Tổng quan**: NetBox mô hình cáp dưới dạng kết nối giữa một số loại thành phần thiết bị và các đối tượng khác. Mỗi cáp có thể được gán một loại, màu sắc, chiều dài và nhãn. NetBox sẽ thực thi kiểm tra sự tỉnh táo cơ bản để ngăn chặn các kết nối không hợp lệ

**Tính năng**: Quản lý các kết nối cáp giữa các thiết bị, giá đỡ, và các điểm kết nối khác.

**Lợi ích**: Giúp theo dõi và quản lý hệ thống cáp, hỗ trợ việc bảo trì và giải quyết sự cố.

**Ví dụ thêm**: Một trong hai đầu của cáp có thể kết thúc với nhiều đối tượng cùng loại. Ví dụ, một giao diện mạng có thể được kết nối thông qua cáp quang đến hai cổng rời rạc trên một bảng vá (mỗi cổng gắn vào một sợi quang riêng lẻ trong cáp vá)

![](/Anh/Screenshot_738.png)

## Power Tracking
NetBox cung cấp khả năng quản lý cơ sở hạ tầng trung tâm dữ liệu(DCIM) và hỗ trợ mô hình hóa hệ thống cấp điện thông qua các tấm phân phối điện(power panels) và nguồn cấp điện (power feeds)

Các thành phần này thường được sử dụng để ghi lại và quản lý phân phối điện trong từng trung tâm dữ liệu, nhưng cũng có thể áp dụng cho các môi trường truyền thống khác. 

![](/Anh/Screenshot_739.png)

### Power Panels(Tấm phân phối điện)
Tính năng:
- Tấm phân phối điện là thiết bị chính trong việc quản lý và phân phối điện năng tư nguồn điện chính đến các thiết bị hoặc giá đỡ 
- Cho phép quản lý các mạch điện(circuits) và các thông số liên quan như dòng điện, điện áp, công suất,...

Lợi ích: 
- Giúp quản lý và giám sất việc phân phối điện trong trung tâm dữ liệu một cách chi tiết và hiệu quả
- Giảm thiểu rủi ro gây ra bởi sự cố điện nhờ việc theo dõi và kiểm soát các mạch điện
- Tối ưu hóa việc sử dụng điện năng và cải thiện hiệu suất hoạt động của hệ thống

### Power Feeds(Nguồn cấp điện)
Tính năng: 
- Nguồn cấp điện là các đường dây hoặc mạch cung cấp điện từ tấm phân phối điện đến các thiết bị hoặc giá đỡ
- Dùng để quản lý các thông tin về nguồn cấp điện, bao gồm nguồn gốc, đường đi, các thông số kỹ thuật và các thiết bị được cấp điện

Lợi ích:
- Giúp theo dõi và quản lý nguồn cấp điện từ đầu vào đến các thiết bị đầu cuối, đảm bảo cung cấp điện ổn định và liên tục
- Cung cấp khả năng dự phòng và chuyển đổi nguồn điện trong trường hợp có sự cố hoặc bảo trì
- Tăng cường tính linh hoạt trong việc quản lý và mở rộng hệ thống điện