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

## Dell R740
Dell R740 có tên đầy đủ là **Dell PowerEdge R740** - là một sản phẩm của dòng của dòng PowerEdge nổi tiếng của Dell Technologies, tập trung vào việc cung cấp các giải pháp máy chủ cho doanh nghiệp với hiệu suất, tính linh hoạt và khả năng mở rộng cao

Dell PowerEdge R740 đánh dấu một bước tiến lớn trong chiến lược của Dell để cung cấp các máy chủ mạnh mẽ, có khả năng đáp ứng nhu cầu ngày càng cao của các doanh nghiệp hiện đại.

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