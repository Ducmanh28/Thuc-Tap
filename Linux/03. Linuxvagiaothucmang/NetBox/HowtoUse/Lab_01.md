# Mục này thực hiện bài Lab Campus Network của NetBox

Tuân theo mô hình sau:

![](/Anh/Screenshot_790.png)

Sơ đồ này mô tả chi tiết cách các thiết bị trong mạng được kết nối và tổ chức, bao gồm các máy tính, máy chủ, switch, tường lửa và router. Các thiết bị được chia thành các VLAN khác nhau để quản lý và bảo mật mạng tốt hơn

Chúng ta sẽ thực hiện các mục sau:
- Tạo Site
- Tạo Region
- Kết nối Site tới Region
- Tạo khách hàng và mô tả các thông tin liên quan
- Kết nối khách hàng với Site
- Thêm location
- Thêm tủ Rack
- Khai báo vai trò thiết bị
- Khai báo loại thiết bị
- Thêm thiết bị
- Thêm VLAN
- Cài đặt IP

# Lý thuyết cần nắm bắt:
Hiểu rõ các lý thuyết về NetBox

Nắm rõ quy luật tạo, tuân thủ theo bài Lab

Nắm rõ thông tin về từng thành phần thêm vào

# Thực hành
## Tạo 1 Site:
Vào mục Sites trong Organization và click Add thêm 1 Site. Sau đó điền các thông tin như sau:

![](/Anh/Screenshot_791.png)

## Tạo 1 Region
Tương tự trong phần Organization, click vào mục Region, click chọn Add, sau đó điền các thông tin như sau:

![](/Anh/Screenshot_792.png)

## Kết nối Site với Region
Quay trở về mục Sites, chọn Edit My_Campus

![](/Anh/Screenshot_793.png)

Thêm vào thông tin Region như sau:

![](/Anh/Screenshot_794.png)

## Tạo và điền thông tin Tenant
Nằm trong phần Organization --> Tenancy --> Tenants và click chọn Add, sau đó thêm vào thông tin như dưới:

![](/Anh/Screenshot_795.png)

## Kết nối Tenant với Site
Sau khi đã có thông tin về Tenant, chúng ta tiến hành kết nối Tenant với Site:

Quay trở về mục Sites, chọn Edit My_Campus

![](/Anh/Screenshot_793.png)

Thêm vào thông tin như sau:

![](/Anh/Screenshot_796.png)

Bây giờ Site của bạn nên trông như sau:

![](/Anh/Screenshot_797.png)

## Thêm vào 1 Location
Vẫn nằm trong Organization --> Sites. Trỏ vào mục Locations, sau đó chọn thêm mới và chỉnh thông tin như sau:

![](/Anh/Screenshot_798.png)

## Thêm mới 1 Rack
Khi đã có đầy đủ các thông tin về Region, Site, Location, chúng ta thực hiện thêm mới Rack như sau:

Tạo Rack 01:

![](/Anh/Screenshot_799.png)

![](/Anh/Screenshot_800.png)

Tạo Rack 02:

![](/Anh/Screenshot_801.png)

![](/Anh/Screenshot_802.png)

## Thêm Device Role
Trước khi thêm 1 thiết bị mới, chúng ta cần khai báo các thông tin liên quan tới thiết bị trước. Device Role sẽ nằm ở Devices --> Devices --> Device Roles Thực hiện thêm mới 1 số Device Role như sau:

Ví dụ thêm Access Switch:

![](/Anh/Screenshot_803.png)

Sau khi hoàn tất, kết quả nên trông như sau:

![](/Anh/Screenshot_804.png)

## Thêm Manufacturers
Các bạn có thể lấy 1 thông tin 1 số nhà sản xuất thiết bị nổi tiếng như: 
- Cisco
- Dell
- HP
.....

![](/Anh/Screenshot_805.png)

Khi hoàn tất, kết quả của bạn có thể trông như thế này:

![](/Anh/Screenshot_806.png)

## Khai báo Device Type
Chúng ta có thể lấy từ trang web của GitHub, hoặc tự thêm thông tin vào. 

Ví dụ lấy từ Github, mọi thông tin về mẫu DeviceTypes nằm ở [đây](https://github.com/netbox-community/devicetype-library/tree/master/device-types)

Thực hiện chọn Devices Types mà bạn cần:

![](/Anh/Screenshot_807.png)

Copy code, sau đó truy cập vào NetBox --> Devices --> Devices Types --> Devices Types --> Import, sau đó dán đoạn code vào. Mẫu trông như sau:

![](/Anh/Screenshot_808.png)


Hoặc bạn có thể điền thông tin trực tiếp bằng cách Add như sau:

![](/Anh/Screenshot_809.png)

![](/Anh/Screenshot_810.png)

Mỗi nhà sản xuất bạn nên add vài devices typeps. Mẫu kết quả có thể trông như sau:

![](/Anh/Screenshot_811.png)

### Khai báo Interfaces của Device Types
Trong Device types, chọn như sau:

![](/Anh/Screenshot_812.png)

Mẫu hiện thị nội dung tạo như sau:

![](/Anh/Screenshot_813.png)

### Thêm 1 Device type là Switch
Cisco 3725 Switch

![](/Anh/Screenshot_814.png)

#### Thêm cổng Console Port cho Cisco 3725
Trong mục +Add Components, click chọn Console Ports 

![](/Anh/Screenshot_815.png)

#### Thêm Network Interface
Tương tự như cách thêm ConsolePort, thêm Network Interfaces theo mẫu:

![](/Anh/Screenshot_816.png)

#### Thêm các Switch Ports
Thêm theo mẫu sau:

![](/Anh/Screenshot_817.png)

### Tương tự thêm 1 Access Switch Cisco 2960
![](/Anh/Screenshot_818.png)
#### Thêm Port
![](/Anh/Screenshot_819.png)
### Khai báo Patch Panel
Trước tiên, hãy tạo 1 nhà sản xuất mới có tên là Bell Den, bên này sẽ phụ trách cung cấp các thiết bị patch-panel. Sau đó thực hiện tạo Device Types như sau:

![](/Anh/Screenshot_820.png)

#### Thêm cổng sau và trước:
Cổng sau:

![](/Anh/Screenshot_821.png)

Cổng trước, sau khi thiết lập xong chúng ta được các kết nối như hình dưới:

![](/Anh/Screenshot_822.png)

### Khai báo User WorkStation
Thêm Device Types như sau:

![](/Anh/Screenshot_823.png)

#### Thêm Network Interface cho Workstation
Thêm giao diện mạng e0 như sau:

![](/Anh/Screenshot_824.png)

## Thêm Devices
Cuối cùng, sau khi đã hoàn tất các thông tin bên lề cho 1 Device, chúng ta tiến hành thêm Device như sau:

### Yêu cầu khởi tạo:
Đối với hệ thống mạng như mô hình ban đầu, chúng ta cần các thiết bị như sau:
- Ba máy chủ(Bao gồm cả tường lửa)
- 2 bảng cắm sợi
- 2 bảng cắm Cat 6
- 4 Router 3725
- 7 Access Switches 2960
- 10 Máy trạm

### Bắt đầu khởi tạo
#### Thêm mới 1 Server
Thêm 1 Device có thông tin như sau:

![](/Anh/Screenshot_825.png)

![](/Anh/Screenshot_826.png)

Tiếp tục tạo thêm 3 Device cần thiết là: Server_Cat_Patch_01, PfSense, LibreNms với các thông tin lần lượt như sau:
- Server_CAT_PATCH_01:
- ![](/Anh/Screenshot_827.png)

- PfSense:
- ![](/Anh/Screenshot_828.png)

- LibreNms:
- ![](/Anh/Screenshot_829.png)

Sau khi hoàn tất các khởi tạo, bạn sẽ được 1 mô hình Rack trông như thế này:

![](/Anh/Screenshot_830.png)

#### Thêm Router và các thiết bị khác vào trong Rack NW
Trước tiên, chúng ta thêm 1 router có thông tin như sau:

![](/Anh/Screenshot_831.png)

Thêm 1 cái nữa:

![](/Anh/Screenshot_832.png)

#### Tạo Faculty1 và thêm các device vào location này
##### Trước tiên chúng ta tạo 1 Tenant cơ bản như sau:

![](/Anh/Screenshot_833.png)

##### Thêm mới Location:

![](/Anh/Screenshot_834.png)

##### Tạo thêm 1 9U Rack:

- Tạo các thông tin cơ bản như sau:

![](/Anh/Screenshot_835.png)

![](/Anh/Screenshot_836.png)

##### Thêm 1 Router vào Rack
Thông tin nên có trông sẽ như sau:

![](/Anh/Screenshot_837.png)

##### Thêm Fibre Patch Panel và CAT 6 Patch Panel cho Rack này
Thêm Fibre Patch Panel:

![](/Anh/Screenshot_838.png)

Thêm CAT6 Patch Panel

![](/Anh/Screenshot_839.png)

#### Kết nối cáp các thiết bị với nhau

Mẫu ví dụ: Tạo mới kết nối giữa Campus Core(FE0/1) và Campus_FB_BACKBONE_PATCH_01(FP10)

![](/Anh/Screenshot_840.png)

![](/Anh/Screenshot_841.png)

Kiểm tra kết quả cuối cùng bằng Trace:

![](/Anh/Screenshot_842.png)

#### Thêm VLAN
Mẫu thêm 1 VLAN:

![](/Anh/Screenshot_843.png)

Tiến hành thêm để có kết quả như hình sau

![](/Anh/Screenshot_844.png)

#### Thêm và quản lý địa chỉ IP
Gồm 3 mục như sau:
- Tạo Aggregates
- Tạo Prefixes
- Thêm IP address

##### Tạo Aggregates:
Tạo RIR(Regional Internet Registry)

![](/Anh/Screenshot_845.png)

Tạo Aggregates, tạo dải `10.0.0.0/8`:

![](/Anh/Screenshot_846.png)

##### Tạo Prefixes
Chúng ta sẽ sử dụng dải `10.1.0.0/16` cho campus

![](/Anh/Screenshot_847.png)

Thêm Child Prefix:

![](/Anh/Screenshot_848.png)

- Tất cả các child prefix đều thuộc /24
- Khi hoàn thành tạo thì sẽ trông như thế này:

![](/Anh/Screenshot_849.png)

##### Thêm IP Address
Bây giờ chúng ta sẽ tiến hành thêm IP Address cho các thiết bị

Mẫu thêm Ip:

![](/Anh/Screenshot_850.png)

