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

### RACKS:
Racks: Là tủ đựng các thiết bị mạng. Tương đương với tủ rack trong IDC

Rack Roles: Được sử dụng để miêu tả vai trò của tủ Rack. Ví dụ như tủ cho khách hàng, tủ cho công ty, tủ cho các dịch vụ nội bộ,...

Rackreservations: Đặt trước các rack cho các mục đích cụ thể

Rack Elevations (bản vẽ rack) : Đưa cho ta hình vẽ trực quan các thiết bị đang đặt trên tủ Rack

### TENANCY
Tenants: Đề cập đến khách hàng. Có thể là 1 cá nhân, công ty hoặc 1 tổ chức

TenantsGroup: Nhóm các khách hàng có điểm chung thành 1 nhóm để dễ quản lý

### CONTACTS:
Contacts: Liên hệ cá nhân hoặc nhóm liên hệ.

Contact Groups: Nhóm các contact có thể được sử dụng để tổ chức và quản lý các contact theo nhóm.

Contact Roles: Các vai trò cho các contact như "primary contact", "technical contact", v.v.

Contact Assignments: Gán các contact cho các đối tượng như site, rack, v.v


 