# Thứ tự tạo các đối tượng trong NetBox
Khi bắt đầu với một cơ sở dữ liệu hoàn toàn trống, có thể không rõ ràng ngay lập tức bắt đầu từ đâu. Nhiều mô hình trong NetBox dựa vào việc tạo trước các loại khác. 

Ví dụ: bạn không thể tạo loại thiết bị cho đến sau khi bạn đã tạo nhà sản xuất.

Dưới đây là thứ tự (thô) được đề xuất trong đó các đối tượng NetBox nên được tạo hoặc nhập. Mặc dù không bắt buộc phải tuân theo thứ tự chính xác này, nhưng làm như vậy sẽ giúp đảm bảo quy trình làm việc suôn sẻ nhất.
- Tenant groups and tenants
- Regions, site groups, sites, and locations
- Rack roles and racks
- Manufacturers, device types, and module types
- Platforms and device roles
- Devices and modules
- Providers, provider accounts, and provider networks
- Circuit types and circuits
- Wireless LAN groups and wireless LANs
- Route targets and VRFs
- RIRs and aggregates
- IP/VLAN roles
- Prefixes, IP ranges, and IP addresses
- VLAN groups and VLANs
- Cluster types, cluster groups, and clusters
- Virtual machines and VM interfaces

## Tenancy
![](/Anh/Screenshot_741.png)

Đối với Tenancy, bạn có thể tạo tenantgroup trước hay tạo trực tiếp tenant trước đều được, tùy vào mục đích sử dụng. Sau khi đã có tenant, bạn có thể dễ dàng tạo các mục khác như Site, Device, Prefix,...

## Sites, Racks, and Device
![](/Anh/Screenshot_742.png)

Trước tiên, bạn cần tạo Region và SiteGroup(nếu có) trước tiên. Sau khi hoàn tất, bạn tiến hành tạo Site, gán các thông tin cho Site của bạn. Sau đó lần lượt tạo Location, Manufacturer, Platform, DeviceRole, DeviceType, Rack. Sau khi hoàn tất, các bạn tạo Device. Thêm ModuleType và tạo Module. Cuối cùng là tạo Interface.

## VRFs, Prefixes, IP Addresses, and VLANs
![](/Anh/Screenshot_743.png)

Đối với mục này, trước tiên, bạn cần tạo RIR và RouteTarget trước, sau đó tạo Role, Aggregate, VRE. Sau đó tạo Prefix, VLANGroup(nếu có), sau đó tạo VLAN, IPRange, IPAddress.



# Tài liệu tham khảo:
[Planning](https://netboxlabs.com/docs/netbox/en/stable/getting-started/planning/)