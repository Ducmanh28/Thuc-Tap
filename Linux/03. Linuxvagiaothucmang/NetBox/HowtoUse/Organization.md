# Mục này tìm hiểu các mục nằm trong Organization của NetBox
MỤC LỤC:
- [Mục này tìm hiểu các mục nằm trong Organization của NetBox](#mục-này-tìm-hiểu-các-mục-nằm-trong-organization-của-netbox)
  - [Lý thuyết](#lý-thuyết)
    - [SITES:](#sites)
    - [RACKS:](#racks)
    - [TENANCY](#tenancy)
    - [CONTACTS:](#contacts)


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
- Gán A, người là "technical contact", cho một rack cụ thể trong trung tâm dữ liệu để cô ấy chịu trách nhiệm về các thiết bị trong rack đó.


 