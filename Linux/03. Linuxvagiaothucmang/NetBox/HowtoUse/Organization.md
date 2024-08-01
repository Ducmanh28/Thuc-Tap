# Mục này tìm hiểu các mục nằm trong Organization của NetBox
MỤC LỤC:
- [Mục này tìm hiểu các mục nằm trong Organization của NetBox](#mục-này-tìm-hiểu-các-mục-nằm-trong-organization-của-netbox)
  - [Lý thuyết](#lý-thuyết)
    - [SITES:](#sites)
    - [RACKS:](#racks)
    - [TENANCY](#tenancy)
    - [CONTACTS:](#contacts)
  - [Thực hành tạo](#thực-hành-tạo)
    - [Tạo Regions](#tạo-regions)
    - [Tạo SiteGroups(optional)](#tạo-sitegroupsoptional)
    - [Tạo TenantGroups](#tạo-tenantgroups)
    - [Tạo Tenants](#tạo-tenants)
    - [Tạo Sites:](#tạo-sites)
    - [Tạo Locations:](#tạo-locations)
    - [Tạo 1 Rack Role cơ bản:](#tạo-1-rack-role-cơ-bản)
    - [Tạo Rack:](#tạo-rack)
    - [Tạo đơn đặt chỗ Rack](#tạo-đơn-đặt-chỗ-rack)
    - [Tạo các Liên hệ:](#tạo-các-liên-hệ)
  - [Hoàn tất](#hoàn-tất)


![](/Anh/Screenshot_740.png)

## Lý thuyết
### SITES:
Sites: Biểu diễn một địa điểm vật lý mà bạn quản lý các thiết bị mạng và tài nguyên mạng khác. Ví dụ như các trung tâm dữ liệu, văn phòng chi nhánh, hoặc các cơ sở khác

Regions: Là một thuật ngữ được sử dụng để đề cập đến các khu vực địa lý hoặc phân đoạn trong cơ sở hạ tầng mạng của bạn

Site Groups: Các site có các điểm chung có thể được nhóm vào 1 sitegroups

Locations: Là một vị trí cụ thể, nơi đặt các thiết bị. Ví dụ như tầng 1, tầng 2 , phòng A, phòng B trong 1 tòa nhà

Ví dụ: 
- Regions: Việt Nam
- Site Groups: Các trung tâm dữ liệu tại miền Bắc
- Site: IDC Nam Thăng Long(Hà Nội)
- Locations: Tầng 2, tầng 3 trong tòa nhà

### RACKS:
Racks: Là tủ đựng các thiết bị mạng. Tương đương với tủ rack trong IDC

Rack Roles: Được sử dụng để miêu tả vai trò của tủ Rack. 

Rackreservations: Đặt trước các rack cho các mục đích cụ thể

Rack Elevations (bản vẽ rack) : Đưa cho ta hình vẽ trực quan các thiết bị đang đặt trên tủ Rack

Ví dụ: 
- Tủ đựng thiết bị trong IDC, chúng chứa các thiết bị như máy chủ, switch, router,...
- Có các tủ dành cho khách hàng, tủ dành cho công ty hay các dịch vụ nội bộ
- Cung cấp chức năng đặt chỗ tủ rack trước cho các mục đích cụ thể
- Bản vẽ sẽ giúp dễ dàng xác định thiết bị nào được đặt ở đâu và hỗ trợ trong việc quản lý và bảo trì thiết bị
### TENANCY
Tenants: Đề cập đến khách hàng. Có thể là 1 cá nhân, công ty hoặc 1 tổ chức

TenantsGroup: Nhóm các khách hàng có điểm chung thành 1 nhóm để dễ quản lý

Ví dụ:
- Một công ty thuê một phần của trung tâm dữ liệu để lưu trữ các máy chủ của họ. Trong trường hợp này, công ty đó là một tenant.
- Nhóm các công ty công nghệ vào một Tenant Group để quản lý các yêu cầu và dịch vụ của họ một cách hiệu quả. Các công ty như Google, Facebook, và Microsoft có thể được nhóm vào một Tenant Group.
### CONTACTS:
Contacts: Liên hệ cá nhân hoặc nhóm liên hệ.

Contact Groups: Nhóm các contact có thể được sử dụng để tổ chức và quản lý các contact theo nhóm.

Contact Roles: Các vai trò cho các contact như "primary contact", "technical contact", v.v.

Contact Assignments: Gán các contact cho các đối tượng như site, rack, v.v

Ví dụ:
- Một cá nhân chịu trách nhiệm quản lý mạng tại một công ty là một contact. Nhóm liên hệ có thể là bộ phận IT của công ty.
- Nhóm các nhân viên IT của một công ty vào một Contact Group để dễ dàng quản lý và liên lạc.
- A là "primary contact" cho một dự án, còn B là "technical contact" chịu trách nhiệm về các vấn đề kỹ thuật.
- Gán A, người là "technical contact", cho một rack cụ thể trong trung tâm dữ liệu để A chịu trách nhiệm về các thiết bị trong rack đó.

## Thực hành tạo
### Tạo Regions
Ví dụ tạo 1 khu vực đơn giản như sau:
- Name: Việt Nam
- Slug: vit-nam

### Tạo SiteGroups(optional) 
Có thể tạo 1 nhóm Sites là các Site ở khu vực miền Bắc, Trung, Nam.

- Ví dụ tạo SiteGroups miền Bắc:
  - Name: Miền Bắc
  - Slug: min-bc
  - Descripts(optional): Các cơ sở dữ liệu thuộc khu vực miền Bắc

Kết quả của quá trình tôi được 3 SiteGroups như sau:

![](/Anh/Screenshot_753.png)

### Tạo TenantGroups
Tương tự như việc tạo các SiteGroups, tôi cũng sẽ chia các khách hàng ra làm 3 khu vực: Bắc, Trung và Nam

- Ví dụ tạo TenantGroups miền Bắc:
  - Name: KH Miền Bắc
  - Slug: kh-min-bc
  - Descripts: Nhóm khách hàng khu vực miền Bắc

Kết quả của quá trình tôi được 3 TenantGroups như sau:

![](/Anh/Screenshot_755.png)

### Tạo Tenants
Tiến hành tạo 1 khách hàng cơ bản như sau:
- Name: Suncloud Group
- Slug: suncloud-group
- Group: KH Miền Bắc

### Tạo Sites:
Ví dụ tạo 1 Sites với các thông tin cơ bản như sau:
- Name: IDC Ha Noi
- Slug: idc-ha-noi
- Status: Active
- Region: Việt Nam
- Group: Miền Bắc
- Time zone: Asia/Ho Chi Minh

- Tenant group: KH Miền Bắc
- Tenant: Suncloud Group

Contact Info
- Physical address: Số 92/1 phố Đào Tấn, Phường Cống Vị, Quận Ba Đình, Thành phố Hà Nội, Việt Nam
- Shipping address: 101A, Liền kề C2, Vũ Ngọc Phan, Láng Hạ, Đống Đa, Hà Nội, Việt Nam
If different from the physical address

### Tạo Locations:
Mẫu tạo 1 Locations trông như sau:

![](/Anh/Screenshot_756.png)

Nghĩa là: Tại tầng 2 của tòa nhà sẽ là phòng DataCenter 1 của Suncloud Group

### Tạo 1 Rack Role cơ bản:
Tạo 1 Rack có vai trò là tủ đựng các thiết bị mạng

- Name: Device Rack
- Slug: device-rack
- Descripts: Tủ đựng các thiết bị mạng

### Tạo Rack:
Ví dụ khởi tạo 1 rack với các thông tin như sau:

![](/Anh/Screenshot_757.png)

![](/Anh/Screenshot_758.png)

### Tạo đơn đặt chỗ Rack
Mẫu tạo Reservation:
- Rack: Suncloud Rack Device
- Units: 12-17
Description: Mở rộng hệ thống
Tenant: KH Miền Bắc/ Suncloud Group

### Tạo các Liên hệ:
Tạo Contact Roles:

![](/Anh/Screenshot_759.png)

Tạo Contact Groups:

![](/Anh/Screenshot_760.png)

Tạo Contact:

![](/Anh/Screenshot_761.png)

Đối với mục Contact Assignment, bạn truy cập vào Site, SiteGroups hay Rack,.... để thực hiện khởi tạo.

Ví dụ mẫu:

![](/Anh/Screenshot_762.png)

## Hoàn tất
Sau khi hoàn tất, chúng ta thực hiện kiểm tra lại các mục xem đã liên kết với nhau chưa, kiểm tra lại các thông tin xem chính xác hay chưa
