# Mục này tìm hiểu các Device cho bài Lab VM_Cloud
- [Mục này tìm hiểu các Device cho bài Lab VM\_Cloud](#mục-này-tìm-hiểu-các-device-cho-bài-lab-vm_cloud)
  - [Dell R740](#dell-r740)
    - [Thông số kỹ thuật](#thông-số-kỹ-thuật)
    - [Bộ nhớ RAM](#bộ-nhớ-ram)
    - [Lưu trữ (Storage)](#lưu-trữ-storage)
    - [Port](#port)
    - [Nguồn:](#nguồn)
    - [Quản lý hệ thống:](#quản-lý-hệ-thống)
    - [Các tính năng nổi bật khác:](#các-tính-năng-nổi-bật-khác)
    - [Ứng dụng phổ biến:](#ứng-dụng-phổ-biến)
    - [Ưu điểm:](#ưu-điểm)
  - [IBM Storwire V7000](#ibm-storwire-v7000)
    - [Tổng quan về hệ thống](#tổng-quan-về-hệ-thống)
    - [Cấu hình phần cứng](#cấu-hình-phần-cứng)
    - [Cổng kết nối](#cổng-kết-nối)
      - [Cổng Fibre Chanel](#cổng-fibre-chanel)
      - [Cổng iSCSI/FCoE](#cổng-iscsifcoe)
      - [Cổng SAS (Serial Attached SCSI)](#cổng-sas-serial-attached-scsi)
      - [Cổng quản lý (Management Port)](#cổng-quản-lý-management-port)
      - [Cổng USB](#cổng-usb)
      - [Cổng nội bộ (Inter-Node)](#cổng-nội-bộ-inter-node)
      - [Cổng nguồn (Power Ports)](#cổng-nguồn-power-ports)
    - [Các tính năng phần mềm](#các-tính-năng-phần-mềm)

## Dell R740
Dell R740 có tên đầy đủ là **Dell PowerEdge R740** - là một sản phẩm của dòng của dòng PowerEdge nổi tiếng của Dell Technologies, tập trung vào việc cung cấp các giải pháp máy chủ cho doanh nghiệp với hiệu suất, tính linh hoạt và khả năng mở rộng cao

Dell PowerEdge R740 đánh dấu một bước tiến lớn trong chiến lược của Dell để cung cấp các máy chủ mạnh mẽ, có khả năng đáp ứng nhu cầu ngày càng cao của các doanh nghiệp hiện đại.

![](/Anh/Screenshot_874.png)

![](/Anh/Screenshot_875.png)
### Thông số kỹ thuật 
**Nhà sản xuất**: Dell Technologies

**Hệ số dạng**: Rack 2U

**Bộ xử lý**: Hỗ trợ tối đa 2 Intel Xeon Scalable thế hệ thứ 2 hoặc 3(lên đến 28 lõi mỗi CPU) - còn được gọi là "Ice Lake-SP," được ra mắt vào năm 2021. Đây là dòng bộ vi xử lý dành cho máy chủ và trung tâm dữ liệu, được tối ưu hóa cho các workload yêu cầu hiệu suất cao, bao gồm ảo hóa, trí tuệ nhân tạo (AI), điện toán đám mây, và phân tích dữ liệu.

**Chipset**: Intel C620 series - là một phần của nền tảng Whitley, đi kèm với bộ vi xử lý Intel Xeon Scalable thế hệ thứ 3. Dòng chipset này được thiết kế đặc biệt để cung cấp các tính năng quản lý, bảo mật và kết nối cao cấp cho các máy chủ và trung tâm dữ liệu.

### Bộ nhớ RAM
**Max RAM**: 3TB khi sử dụng RDIMM hoặc LRDIMM

**Loại RAM sử dụng**: DDR4 RDIMM hoặc LRDIMM
- RDIMM (Registered DIMM) sử dụng thanh ghi để giảm tải cho bộ điều khiển bộ nhớ, cải thiện độ tin cậy và hỗ trợ nhiều module hơn, nhưng có độ trễ thấp hơn LRDIMM. RDIMM phù hợp với hệ thống có yêu cầu bộ nhớ vừa phải.
- LRDIMM (Load-Reduced DIMM) sử dụng bộ đệm để giảm tải điện, cho phép hỗ trợ dung lượng lớn hơn với nhiều module hơn, nhưng có độ trễ cao hơn RDIMM. Thích hợp cho các hệ thống yêu cầu bộ nhớ lớn

Số khe RAM: 24 DIMM slots. Tức là 12 khe mỗi CPU

### Lưu trữ (Storage)
**Khả năng lưu trữ**: Hỗ trợ tối đa 16 ổ đĩa 2.5 inch hoặc là 8 ổ đĩa 3.5 inch.

**Loại giao thức lưu trữ**: SAS, SATA, hoặc NVMe
- SAS là giao thức tốc độ cao, chủ yếu được dùng trong môi trường doanh nghiệp và trung tâm dữ liệu, hỗ trợ khả năng mở rộng lớn và tính năng tin cậy cao. Tốc độ truyền tải của SAS lên đến 12 Gbps.
- SATA là giao thức phổ biến trong các máy tính cá nhân và hệ thống lưu trữ chi phí thấp. Nó có tốc độ truyền tối đa 6 Gbps, thấp hơn SAS, và thường được sử dụng cho ổ cứng HDD và SSD giá rẻ.
- NVMe là giao thức mới nhất, được thiết kế riêng cho SSD, sử dụng kết nối PCIe để đạt tốc độ cực cao, lên đến 64 Gbps. NVMe tối ưu hóa hiệu suất và độ trễ thấp, thích hợp cho các ứng dụng yêu cầu xử lý dữ liệu nhanh chóng.

**Bộ điều khiển RAID**: Hỗ trợ các bộ điều khiển RAID PERC từ Dell như H330, H730P, H740P, HBA330

### Port
Cổng mạng tích hợp: 4 cổng 1GbE(RJ-45) nằm ở mặt sau của máy chủ

Cổng quản lý: 
- 1x iDRAC9 Network Port(RJ-45) nằm ở mặt sau của máy chủ
- 1x iDRAC9 Direct Usb Port(UBS Type) nằm ở mặt trước của máy chủ

Cổng USB:
- 2x USB 3.0 phía trước(USB 3.0 Type-A) 
- 2x USB 3.0 phía sau(USB 3.0 Type-A)
- 1x USB 2.0 phía trước(USB 2.0 Type-A)

Cổng video
- 1x VGA nằm ở mặt sau

Cổng Serial:
- Thường dùng để truyền dữ liệu theo kiểu tuần tự, sử dụng kết nối các thiết bị ngoại vi với máy chủ
- Tên khác là **RS-232**. Loại chuẩn thường là DB9 - có 9 chân. Cổng này thường nằm ở mặt sau.

Cổng PCIe(Peripheral Component Interconnect Express) - là 1 tiêu chuẩn giao tiếp cho các thiết bị mở rộng trong máy tính. PCIe có tốc độ truyền dữ liệu 1 GB/s mỗi làn. PCIe 3.0 x16 có băng thông tối đa khoảng 16 GB/s
- DELL PE R740 có 8 khe PCIe 3.0 để thoải mái cho việc nâng cấp

### Nguồn:
- Tối đa: Có thể sử dụng tối đa 2 nguồn
- Loại: Tùy chọn PSU Hot-plug 495W, 750W, hoặc 1100W

### Quản lý hệ thống:
iDRAC9 with Lifecycle Controller: Cho phép quản lý từ xa mạnh mẽ, hỗ trợ cài đặt, giám sát, và cập nhật firmware từ xa.

Hỗ trợ các công cụ quản lý: OpenManage Enterprise, OpenManage Mobile, và các công cụ khác của Dell.

### Các tính năng nổi bật khác:
Khả năng ảo hóa: Được thiết kế tối ưu cho các ứng dụng ảo hóa như VMware, Microsoft Hyper-V, và Citrix XenServer.

Bảo mật: Hỗ trợ TPM 1.2/2.0, Silicon Root of Trust, và các tính năng bảo mật khác.

Hỗ trợ hệ điều hành: Rất nhiều hệ điều hành bao gồm Microsoft Windows Server, Ubuntu, Red Hat, VMware, và nhiều hệ điều hành doanh nghiệp khác.
### Ứng dụng phổ biến:
Ảo hóa và Hạ tầng siêu hội tụ (HCI): Tối ưu hóa cho việc chạy các ứng dụng ảo hóa, xây dựng cơ sở hạ tầng hội tụ.
Ứng dụng cơ sở dữ liệu: Hỗ trợ các cơ sở dữ liệu lớn và phân tích dữ liệu.

Lưu trữ và quản lý dữ liệu: Dùng cho lưu trữ đám mây, lưu trữ đối tượng và dữ liệu phi cấu trúc.
### Ưu điểm:
Tính linh hoạt cao: Hỗ trợ nhiều loại workload khác nhau từ ảo hóa đến HCI.

Khả năng mở rộng: Dễ dàng nâng cấp và mở rộng theo nhu cầu kinh doanh.

Hiệu suất mạnh mẽ: Nhờ vào việc hỗ trợ các CPU Xeon Scalable mới nhất và RAM tốc độ cao.

## IBM Storwire V7000
Là một hệ thống lưu trữ tầm trung mạnh mẽ của IBM, được thiết kế để cung cấp giải pháp lưu trữ linh hoạt, hiệu quả và có thể mở rộng cho các doanh nghiệp. 

### Tổng quan về hệ thống
Loại thiết bị: Hệ thống lưu trữ tầm trung(MSS)

Kiến trúc: Modular, có thể mở rộng, với khả năng kết hợp nhiều module

Kích thước: 2U

### Cấu hình phần cứng
Controller Nodes: Hệ thống hỗ trợ tối đa 4 controller nodes(mỗi node gồm 2 controllers hoạt động song song), cung cấp hiệu suất cao và khả năng chịu lỗi. Mỗi controller có nhiệm vụ quản lý việc đọc/ghi dữ liệu trên các ổ đĩa, xử lý các yêu cầu từ máy chủ, và thực hiện các chức năng như nén, sao chép, và phân cấp dữ liệu

Ổ đĩa hỗ trợ: Các loại ổ đĩa phổ biến như: SSD, HDD, SAS 2.5" và 3.5". Dung lượng mỗi ổ đĩa có thể dao động từ 300GB - 15.36TB

Mỗi thiết bị mặc định hỗ trợ tối đa 24 ổ đĩa 2.5" hoặc 12 ổ đĩa 3.5". Tuy nhiên, có thể mở rộng lên tới 504 ổ đĩa thông qua các expansion enclosure.

### Cổng kết nối
Có nhiều cổng kết nối để đảm bảo tính linh hoạt và khả năng tích hợp với các hệ thống mạng lưu trữ khác nhau
#### Cổng Fibre Chanel
- Loại cổng: SFP+ (Small Form-factor Pluggable)
- Chức năng: Kết nối với mạng lưu trữ SAN qua giao thức Fibre Channel
- Sử dụng kết nối Fibre Channel với tùy chọn tốc độ 8 Gbps, 16 Gbps, hoặc 32 Gbps
- Nằm ở phía trên các controller nodes, phía sau của control enclosure
- Số lượng: Mỗi controller node có 4 cổng FC, có thể lên tới 8 nếu có 2 controller nodes

#### Cổng iSCSI/FCoE
- Loại cổng: SFP+.
- Chức năng: Dùng để kết nối với mạng IP sử dụng giao thức iSCSI hoặc Fibre Channel over Ethernet (FCoE).
- Sử dụng kết nối: iSCSI hoặc FCoE với tốc độ 10 Gbps.
- Vị trí: Trên các controller nodes, phía sau của control enclosure.
- Số lượng: Mỗi controller node có 4 cổng có thể cấu hình cho iSCSI hoặc FCoE, tổng cộng có thể lên đến 8 cổng.
#### Cổng SAS (Serial Attached SCSI)
- Loại cổng: Mini-SAS HD.
- Chức năng: Kết nối với các expansion enclosures để mở rộng dung lượng lưu trữ.
- Sử dụng kết nối: SAS 12 Gbps.
- Vị trí: Trên các controller nodes, phía sau của control enclosure.
- Số lượng: Mỗi controller node có 2 cổng SAS, tổng cộng có thể lên đến 4 cổng khi có 2 controller nodes.
#### Cổng quản lý (Management Port)
- Loại cổng: RJ-45.
- Chức năng: Dùng để quản lý hệ thống thông qua giao diện web hoặc CLI.
- Sử dụng kết nối: Ethernet 1 Gbps.
- Vị trí: Trên các controller nodes, phía sau của control enclosure.
- Số lượng: Mỗi controller node có 2 cổng quản lý, tổng cộng có thể lên đến 4 cổng.
#### Cổng USB
- Loại cổng: USB Type-A.
- Chức năng: Sao lưu cấu hình hệ thống, cập nhật firmware.
- Sử dụng kết nối: USB 2.0.
- Vị trí: Trên các controller nodes, phía trước hoặc phía sau của control enclosure.
- Số lượng: Mỗi controller node có 1 cổng USB, tổng cộng có thể lên đến 2 cổng.
#### Cổng nội bộ (Inter-Node)
- Loại cổng: Mini-SAS.
- Chức năng: Kết nối giữa các controller nodes trong cùng một control enclosure.
- Sử dụng kết nối: SAS tốc độ cao để đồng bộ dữ liệu và chia sẻ tải giữa các nodes.
- Vị trí: Nằm bên trong hệ thống, không hiển thị ra ngoài.
- Số lượng: 2 cổng trên mỗi controller node, tổng cộng có 4 cổng kết nối nội bộ.
#### Cổng nguồn (Power Ports)
- Loại cổng: IEC C14.
- Chức năng: Cấp nguồn điện cho hệ thống.
- Sử dụng kết nối: AC 100-240V.
- Vị trí: Phía sau của control enclosure.
- Số lượng: 2 cổng nguồn cho mỗi controller node, tổng cộng 4 cổng cho hệ thống dự phòng.
### Các tính năng phần mềm
Storage Virtualization: Ảo hóa các hệ thống lưu trữ bên ngoài, giúp quản lý tập trung và tối ưu hóa tài nguyên.

Real-time Compression: Tính năng nén thời gian thực giúp tăng hiệu quả lưu trữ lên gấp 5 lần mà không ảnh hưởng đến hiệu suất.

Easy Tier: Tự động phân cấp dữ liệu giữa các lớp lưu trữ dựa trên mức độ sử dụng.

Data Replication: Hỗ trợ sao chép đồng bộ và không đồng bộ giữa các hệ thống Storwize hoặc các hệ thống khác thông qua chức năng Global Mirror và Metro Mirror.

Thin Provisioning: Tối ưu hóa việc cấp phát không gian lưu trữ, chỉ sử dụng dung lượng thực sự cần thiết.

Encryption: Mã hóa dữ liệu theo chuẩn AES-256 để bảo vệ dữ liệu.