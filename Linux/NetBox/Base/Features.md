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
    - [Ví dụ thực tế:](#ví-dụ-thực-tế-2)
  - [Internet Protocol Address Management(IPAM)](#internet-protocol-address-managementipam)
    - [IP Hierarchy](#ip-hierarchy)
    - [Utilization Stats:](#utilization-stats)
    - [VRF Tracking:](#vrf-tracking)
    - [AS Numbers:](#as-numbers)
    - [Service Mapping:](#service-mapping)
    - [Ví dụ về IPAM](#ví-dụ-về-ipam)
  - [Circuits (Mạch Kết Nối)](#circuits-mạch-kết-nối)
    - [ASN (Số Hệ Thống Tự Quản Lý)](#asn-số-hệ-thống-tự-quản-lý)
    - [Nhà Cung Cấp (Provider)](#nhà-cung-cấp-provider)
    - [Mạng Của Nhà Cung Cấp (Provider Network)](#mạng-của-nhà-cung-cấp-provider-network)
    - [Mạch Kết Nối (Circuit)](#mạch-kết-nối-circuit)
    - [Mạch Vật Lý vs. Mạch Ảo](#mạch-vật-lý-vs-mạch-ảo)
    - [Kết Nối Mạch](#kết-nối-mạch)
  - [Virtualization (Ảo Hóa)](#virtualization-ảo-hóa)
    - [Clusters (Cụm)](#clusters-cụm)
    - [Virtual Machines (Máy Ảo)](#virtual-machines-máy-ảo)
    - [Platform (Nền Tảng)](#platform-nền-tảng)
    - [VMInterface (Giao Diện Máy Ảo)](#vminterface-giao-diện-máy-ảo)
    - [Tổng kết lại](#tổng-kết-lại)
  - [Tenancy (Sự Gán Quyền Sở Hữu)](#tenancy-sự-gán-quyền-sở-hữu)
    - [Nhóm Khách Hàng](#nhóm-khách-hàng)
    - [Khách Hàng (Tenant)](#khách-hàng-tenant)
    - [Đối Tượng Có Thể Gán Cho Khách Hàng](#đối-tượng-có-thể-gán-cho-khách-hàng)
    - [Gán Khách Hàng](#gán-khách-hàng)
    - [Tóm Lại](#tóm-lại)
  - [Contacts (Liên Hệ)](#contacts-liên-hệ)
    - [Gán liên hệ](#gán-liên-hệ)
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
**Tính năng**: 
- Lưu trữ thông tin về nhà sản xuất thiết bị và Module
- Liên kết các DeviceType, ModuleType với nhà sản xuất tương ứng

**Lợi ích**: Dễ dàng theo dõi và quản lý nguồn gốc của thiết bị, module

**Ví dụ**: Cisco, Juniper, HP là các nhà sản xuất thiết bị mạng phổ biến

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
**Tính năng**:
- Tấm phân phối điện là thiết bị chính trong việc quản lý và phân phối điện năng tư nguồn điện chính đến các thiết bị hoặc giá đỡ 
- Cho phép quản lý các mạch điện(circuits) và các thông số liên quan như dòng điện, điện áp, công suất,...

**Lợi ích**: 
- Giúp quản lý và giám sất việc phân phối điện trong trung tâm dữ liệu một cách chi tiết và hiệu quả
- Giảm thiểu rủi ro gây ra bởi sự cố điện nhờ việc theo dõi và kiểm soát các mạch điện
- Tối ưu hóa việc sử dụng điện năng và cải thiện hiệu suất hoạt động của hệ thống

### Power Feeds(Nguồn cấp điện)
**Tính năng**: 
- Nguồn cấp điện là các đường dây hoặc mạch cung cấp điện từ tấm phân phối điện đến các thiết bị hoặc giá đỡ
- Dùng để quản lý các thông tin về nguồn cấp điện, bao gồm nguồn gốc, đường đi, các thông số kỹ thuật và các thiết bị được cấp điện

**Lợi ích**:
- Giúp theo dõi và quản lý nguồn cấp điện từ đầu vào đến các thiết bị đầu cuối, đảm bảo cung cấp điện ổn định và liên tục
- Cung cấp khả năng dự phòng và chuyển đổi nguồn điện trong trường hợp có sự cố hoặc bảo trì
- Tăng cường tính linh hoạt trong việc quản lý và mở rộng hệ thống điện

### Ví dụ thực tế:
**Trung Tâm Dữ Liệu**
- Power Panels (Tấm phân phối điện):
  - Tấm phân phối điện chính: Được lắp đặt tại khu vực phân phối điện của trung tâm dữ liệu, tấm này nhận điện từ lưới điện quốc gia hoặc máy phát điện dự phòng.
  - Các tấm phân phối phụ: Được lắp đặt tại các khu vực khác nhau trong trung tâm dữ liệu để phân phối điện đến các giá đỡ.
- Power Feeds (Nguồn cấp điện):
  - Nguồn cấp từ tấm phân phối chính đến các tấm phân phối phụ: Các dây cáp điện chính được sử dụng để chuyển điện từ tấm phân phối chính đến các tấm phân phối phụ.
  - Nguồn cấp từ các tấm phân phối phụ đến các giá đỡ: Các dây cáp điện nhỏ hơn cung cấp điện từ tấm phân phối phụ đến từng giá đỡ, cung cấp điện cho các máy chủ, thiết bị lưu trữ và thiết bị mạng.

## Internet Protocol Address Management(IPAM)
IPAM là một trong những tính năng cốt lõi của NetBox. Nó hỗ trợ đầy đủ cho cả IPv4 và IPv6, gán VRF nâng cao, hình thành hệ thống phân cấp tự động và hơn thế nữa.

### IP Hierarchy
NetBox sử dụng một số loại đối tượng để đại diện cho một hệ thống phân cấp tài nguyên IP:
- **Aggregate**: Đại diện cho gốc của hệ thống phân cấp địa chỉ IP, thường là một phạm vi lớn của không gian địa chỉ công cộng hoặc riêng tư.
- **Prefix**: 
  - Một mạng con được xác định trong một Aggregate, mở rộng hệ thống phân cấp.
  - Ví dụ: Trung tâm dữ liệu A có một dải địa chỉ IP là 192.168.0.0/16. Trong dải địa chỉ này, họ chia thành các dải con như 192.168.1.0/24 cho máy chủ web, 192.168.2.0/24 cho các dịch vụ nội bộ, và 192.168.3.0/24 cho khách hàng.
- **IP Range**: Một dải địa chỉ IP riêng lẻ trong một Prefix, chia sẻ cùng một mặt nạ.
- **IPAddress**: 
  - Một địa chỉ IP riêng lẻ với mặt nạ mạng con của nó, được tự động sắp xếp trong cấu trúc phân cấp.
  - Ví dụ: Máy chủ web chính của công ty sử dụng địa chỉ IP 192.168.1.10, trong khi máy chủ cơ sở dữ liệu sử dụng địa chỉ IP 192.168.1.11.
**Ví dụ cho một IP Hierarchy**:

100.64.0.0/10 (aggregate)
- 100.64.0.0/20 (prefix)
- 100.64.16.0/20 (prefix)
  - 100.64.16.0/24 (prefix)
    - 100.64.16.1/24 (address)
    - 100.64.16.2/24 (address)
    - 100.64.16.3/24 (address)
  - 100.64.19.0/24 (prefix)
- 100.64.32.0/20 (prefix)
  - 100.64.32.1/24 (address)
  - 100.64.32.10-99/24 (range)

### Utilization Stats: 
Tỷ lệ sử dụng cho mỗi prefix được tính toán tự động dựa trên trạng thái của nó. Các prefix container là những prefix chứa các prefix con, tỷ lệ sử dụng của chúng được xác định dựa trên không gian IP khả dụng được tiêu thụ bởi các prefix con.

Tương tự như Aggregate, Utilization rate sử dụng cho các aggregates được xác định dựa trên không gian được tiêu thụ bởi các prefix con của chúng.

Ví dụ: Một công ty có dải mạng như sau: 192.168.1.0/24, tổng cộng có 256 địa chỉ IP, trong đó 200 địa chỉ đã sử dụng, tỷ lệ sử dụng 78%.
### VRF Tracking: 
NetBox hỗ trợ mô hình hóa các thể hiện định tuyến và chuyển tiếp ảo (VRF) để biểu diễn nhiều bảng định tuyến khác nhau, bao gồm cả các không gian địa chỉ chồng lấn. Mỗi loại đối tượng IP trong một Aggregate - Prefix, phạm vi IP và địa chỉ IP - có thể được gán cho một VRF cụ thể.

Mô hình VRF trong NetBox tuân thủ rất chặt chẽ những gì bạn tìm thấy trong các cấu hình mạng trong thế giới thực, với mỗi VRF được chỉ định một bộ phân biệt tuyến tuân thủ tiêu chuẩn. Bạn thậm chí có thể tạo các mục tiêu tuyến đường để quản lý việc nhập và xuất thông tin định tuyến giữa các VRF.

Mỗi VRF có thể được cấu hình độc lập để cho phép hoặc cấm các đối tượng IP trùng lặp. 

**Ví dụ**: VRF đã được cấu hình để thực thi không gian IP duy nhất sẽ không cho phép tạo hai tiền tố 192.0.2.0/24. Khả năng chuyển đổi hạn chế này trên mỗi VRF mang lại cho người dùng sự linh hoạt tối đa trong việc mô hình hóa không gian IP của họ.

Ví dụ: Công ty A thuê một phần của trung tâm dữ liệu và yêu cầu một VRF riêng để đảm bảo lưu lượng mạng của họ được định tuyến tách biệt khỏi các khách hàng khác. VRF này có thể được đặt tên là "VRF_CongTyA".

Tracking: VRF "VRF_CongTyA" được theo dõi để đảm bảo rằng tất cả các thiết bị và đường dẫn mạng liên quan đến công ty A đều sử dụng đúng VRF này. Các thay đổi hoặc lỗi trong VRF này sẽ được ghi lại và báo cáo.


### AS Numbers: 
NetBox cũng theo dõi các số AS và sự phân bổ của chúng đến các địa điểm. Cả 16-bit và 32-bit AS numbers đều được hỗ trợ.

Autonomous System Numbers (ASNs) là các số nhận dạng duy nhất được gán cho các Autonomous Systems (AS) trên Internet. Autonomous System (AS) là một tập hợp các mạng (prefixes) được quản lý và điều hành bởi một hoặc một nhóm các nhà quản trị mạng, và có một chính sách định tuyến chung.
### Service Mapping: 
NetBox mô hình các ứng dụng mạng như các đối tượng dịch vụ riêng biệt liên kết với thiết bị và/hoặc máy ảo, và tùy chọn với các địa chỉ IP cụ thể được gắn với các đối tượng cha đó.

Để mô hình hóa các dịch vụ trong NetBox, hãy bắt đầu bằng cách tạo một mẫu dịch vụ xác định tên, giao thức và (các) số cổng mà dịch vụ lắng nghe. Mẫu này sau đó có thể dễ dàng khởi tạo để "đính kèm" các dịch vụ mới vào thiết bị hoặc máy ảo. Cũng có thể tạo các dịch vụ mới bằng tay mà không cần mẫu, tuy nhiên cách tiếp cận này có thể nhàm chán.

### Ví dụ về IPAM
- Prefixes: 192.168.0.0/16, chia thành 192.168.1.0/24 và 192.168.2.0/24.
- IP Addresses: Trong dải .1.0, 192.168.1.10 cho máy chủ web.
- VLANs: VLAN 10 (quản lý), VLAN 20 (khách hàng).
- VRFs: VRF "Customer_A" cho khách hàng A.
- Services: 192.168.1.100 cho dịch vụ DNS.

## Circuits (Mạch Kết Nối)
NetBox rất phù hợp để quản lý các nhà cung cấp dịch vụ mạng và các mạch kết nối của mạng bạn. Nó cho phép bạn mô hình hóa các mạch vật lý trong trung tâm dữ liệu và môi trường doanh nghiệp, và kết nối chúng trực tiếp với các giao diện thiết bị thông qua cáp.

### ASN (Số Hệ Thống Tự Quản Lý)
ASN là số nhận dạng duy nhất cho mỗi hệ thống tự quản lý trên Internet, giúp định tuyến các gói dữ liệu hiệu quả.

### Nhà Cung Cấp (Provider)
Nhà cung cấp là các tổ chức cung cấp kết nối Internet hoặc kết nối riêng. Họ có thể là các nhà cung cấp lớn hoặc các dịch vụ nội bộ. Mỗi nhà cung cấp có thể có các thông tin tài khoản, liên hệ, và nhiều số AS.

### Mạng Của Nhà Cung Cấp (Provider Network)
Đây là các mạng mà bạn không thể quản lý toàn bộ, thường được biểu diễn bằng biểu tượng đám mây trong sơ đồ. NetBox hỗ trợ mô hình hóa các mạng này để các mạch của bạn có thể kết nối vào. Ví dụ: mạng MPLS của nhà cung cấp kết nối nhiều địa điểm.

### Mạch Kết Nối (Circuit)
Mạch kết nối là kết nối vật lý giữa hai điểm, do nhà cung cấp bên ngoài cài đặt và bảo trì. Ví dụ: kết nối Internet qua cáp quang là một mạch kết nối.
- ID mạch: Mỗi mạch có một ID duy nhất cho nhà cung cấp đó.
- Loại mạch: Do người dùng định nghĩa.
- Trạng thái hoạt động và đặc tính khác.
### Mạch Vật Lý vs. Mạch Ảo
Mạch Vật Lý: Là kết nối thực tế bạn có thể chỉ vào.

Mạch Ảo: Là các kết nối được xây dựng trên cơ sở hạ tầng vật lý, như subinterface gắn thẻ VLAN.

### Kết Nối Mạch
Mỗi mạch có thể có đến hai điểm kết nối (A và Z), có thể kết nối với một trang web cụ thể hoặc mạng của nhà cung cấp. Cáp có thể kết nối giữa điểm kết nối của mạch và thiết bị để lập bản đồ kết nối vật lý.

## Virtualization (Ảo Hóa)
NetBox hỗ trợ mô hình hóa các máy ảo và cụm máy ảo cùng với cơ sở hạ tầng vật lý. Địa chỉ IP và các tài nguyên khác được gán cho các đối tượng ảo giống như các đối tượng vật lý, tạo nên sự tích hợp liền mạch giữa mạng vật lý và mạng ảo.

Các Thành Phần Chính
- ClusterGroup (Nhóm Cụm)
- ClusterType (Loại Cụm)
- Cluster (Cụm)
- VirtualMachine (Máy Ảo)
- Platform (Nền Tảng)
- VMInterface (Giao Diện Máy Ảo)
### Clusters (Cụm)
Là một hoặc nhiều thiết bị chủ vật lý (host) chạy các máy ảo.
- Loại và Trạng Thái: Mỗi cụm phải có loại (do người dùng định nghĩa) và trạng thái hoạt động.
- Nhóm: Các cụm có thể được phân vào các nhóm (do người dùng định nghĩa).
- Thiết Bị Chủ: Mỗi cụm có thể gán một hoặc nhiều thiết bị làm chủ (tùy chọn).
### Virtual Machines (Máy Ảo)
Là một instance tính toán được ảo hóa, hoạt động tương tự như các thiết bị vật lý trong NetBox nhưng không có thuộc tính vật lý.
- Giao Diện: Máy ảo có thể có các giao diện được gán địa chỉ IP và VLAN, nhưng không thể kết nối qua cáp vì chúng là ảo.
- Tài Nguyên: Mỗi máy ảo có thể định nghĩa các tài nguyên tính toán, bộ nhớ và lưu trữ của nó.
### Platform (Nền Tảng)
Là hệ điều hành hoặc phần mềm mà máy ảo hoặc thiết bị chạy trên đó. Ví dụ: VMware, KVM, hoặc OpenStack.
### VMInterface (Giao Diện Máy Ảo)
Là các cổng mạng ảo của máy ảo, có thể được gán địa chỉ IP và VLAN nhưng không thể kết nối vật lý.
### Tổng kết lại
**Clusters** (Cụm)
- Gồm nhiều thiết bị chủ vật lý.
- Có loại và trạng thái hoạt động.
- Có thể thuộc nhóm và gán thiết bị chủ (tùy chọn).

**Virtual Machines** (Máy Ảo)
- Là instance tính toán ảo.
- Có các giao diện mạng ảo (không kết nối vật lý).
- Định nghĩa tài nguyên tính toán, bộ nhớ và lưu trữ.

**Platform** (Nền Tảng): Hệ điều hành hoặc phần mềm mà máy ảo chạy trên đó.

**VMInterface** (Giao Diện Máy Ảo):Cổng mạng ảo của máy ảo.

## Tenancy (Sự Gán Quyền Sở Hữu)
Trong mô hình dữ liệu của NetBox, hầu hết các đối tượng cốt lõi hỗ trợ khái niệm tenancy. Đây là việc liên kết một đối tượng với một khách hàng hay tổ chức cụ thể để biểu thị quyền sở hữu hoặc phụ thuộc. 

Ví dụ, một doanh nghiệp có thể biểu diễn các đơn vị kinh doanh nội bộ của mình dưới dạng các khách hàng (tenants), trong khi một nhà cung cấp dịch vụ quản lý có thể tạo một tenant trong NetBox để đại diện cho từng khách hàng của mình.

Các Thành Phần Chính
- TenantGroup (Nhóm Khách Hàng)
- Tenant (Khách Hàng)
- Site (Địa Điểm)
- Device (Thiết Bị)
- Prefix (Prefix)
- Circuit (Mạch Kết Nối)
- Và nhiều đối tượng khác...
### Nhóm Khách Hàng
Các khách hàng có thể được nhóm bởi bất kỳ logic nào mà yêu cầu sử dụng của bạn, và các nhóm có thể được nhúng đệ quy cho tính linh hoạt tối đa. Ví dụ, bạn có thể định nghĩa một nhóm cha "Khách Hàng" với các nhóm con "Hiện tại" và "Quá khứ" bên trong.
### Khách Hàng (Tenant)
Thường thì mô hình khách hàng được sử dụng để đại diện cho một khách hàng hoặc tổ chức nội bộ, tuy nhiên nó có thể được sử dụng cho bất kỳ mục đích nào phù hợp với nhu cầu của bạn.

### Đối Tượng Có Thể Gán Cho Khách Hàng
Các đối tượng sau đây có thể được gán cho các khách hàng:
- Sites (Địa điểm)
- Racks (Tủ rack)
- Rack reservations (Đặt chỗ rack)
- Devices (Thiết bị)
- VRFs (Virtual Routing and Forwarding)
- Prefixes (Các phần đầu địa chỉ IP)
- Địa chỉ IP
- VLANs
- Circuits (Mạch kết nối)
- Clusters (Cụm)
- Virtual machines (Máy ảo)
### Gán Khách Hàng
Phân công khách hàng được sử dụng để chỉ định sở hữu của một đối tượng trong NetBox. Do đó, mỗi đối tượng chỉ có thể thuộc về một khách hàng duy nhất. 

Ví dụ, nếu bạn có một tường lửa dành riêng cho một khách hàng cụ thể, bạn sẽ gán nó cho khách hàng đó. Tuy nhiên, nếu tường lửa phục vụ cho nhiều khách hàng, việc gán khách hàng sẽ không phù hợp.

### Tóm Lại
Tenancy trong NetBox là cách thức để quản lý và theo dõi sự sở hữu của các đối tượng, cho phép bạn liên kết các tài nguyên với từng khách hàng hay tổ chức cụ thể.
Phân công khách hàng giúp định rõ quyền sở hữu của mỗi đối tượng và làm cho việc quản lý mạng dễ dàng và có tổ chức hơn.


## Contacts (Liên Hệ)

Trong NetBox, việc gán liên hệ cho phép bạn theo dõi người chịu trách nhiệm cho các tài nguyên. Mỗi liên hệ đại diện cho một cá nhân có trách nhiệm cụ thể.

- Nhóm Liên Hệ (ContactGroup): Nhóm các liên hệ theo logic tổ chức.

- Liên Hệ (Contact): Đại diện cho cá nhân, bao gồm tên, tiêu đề, số điện thoại, email và chi tiết liên quan.
- Vai Trò Liên Hệ (ContactRole): Xác định mối quan hệ của liên hệ đối với đối tượng được gán.

Các liên hệ có thể được tái sử dụng và gán cho nhiều đối tượng NetBox khác nhau, giúp quản lý và theo dõi tài nguyên một cách hiệu quả.

### Gán liên hệ
Các mô hình sau hỗ trợ việc gán liên hệ:

- circuits.Circuit (Mạch Kết Nối)
- circuits.Provider (Nhà Cung Cấp)
- circuits.ProviderAccount (Tài Khoản Nhà Cung Cấp)
- dcim.Device (Thiết Bị)
- dcim.Location (Địa Điểm)
- dcim.Manufacturer (Nhà Sản Xuất)
- dcim.PowerPanel (Bảng Điện)
- dcim.Rack (Tủ Rack)
- dcim.Region (Khu Vực)
- dcim.Site (Địa Điểm)
- dcim.SiteGroup (Nhóm Địa Điểm)
- tenancy.Tenant (Khách Hàng)
- virtualization.Cluster (Cụm)
- virtualization.ClusterGroup (Nhóm Cụm)
- virtualization.VirtualMachine (Máy Ảo)