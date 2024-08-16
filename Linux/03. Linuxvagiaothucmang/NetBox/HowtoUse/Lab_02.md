# Một số lưu ý cho bài Lab add Device:
Để thêm được 1 thiết bị hoạt động đầy đủ trên NetBox, những điều cơ bản mà chúng ta cần có là gì?
- Trước tiên, là Tenancy. Đây chính là thông tin khách hàng, người sở hữu hoặc đang sử dụng thiết bị.
- Tiếp đó, là Region, Site, Location. Các mục này sẽ chỉ rõ cho chúng ta biết được vị trí của thiết bị nằm ở đâu. 
- Hơn thế nữa, chúng ta cũng có thể biết thiết bị đang nằm ở Rack nào vai trò của Rack là gì(**Rack Roles**) và xem mô hình thực tế Rack(**Rack Elevations**)
- Sau đó, chúng ta sẽ thực hiện thêm 1 số thông tin nhận dạng, phân loại thiết bị:
  - Manufacturer: Thương hiệu của thiết bị
  - Device Roles: Vai trò của thiết bị
  - Device Types: Loại thiết bị
  - Platforms: Hệ điều hành mà thiết bị đang sử dụng
  - Modules Bays, Device Bays: Các khe cắm của thiết bị
- Sau khi đã có các thông tin, đặc điểm nhận dạng của thiết bị, chúng ta tiến hành thêm Device.
- Thêm được Device chưa phải là hết, để thiết bị có thể hoạt động, chúng ta cần liệt kê các cổng(**Interfaces**) để kết nối các thiết bị với nhau, tạo thành 1 mô hình mạng(Đây cũng là phần khó nhằn nhất hiện tại, bạn sẽ dễ nhầm lẫn giữa các cổng, các kết nối, các quy định cho các kết nối)
- Sau khi có các kết nối, chúng ta phải định danh cho chúng bằng địa chỉ IP, mục này sẽ nằm ở IPAM
- Đối với các điều cơ bản để mô hình mạng hoạt động thì các điều trên sẽ được coi là tạm ổn. Bạn cũng có thể thêm các nguồn điện, các kết nối tới nguồn điện để tăng tính thực tế.
- Do các tài liệu bài Lab_02 là nội bộ, vui lòng kiểm tra bài [Lab_01](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/HowtoUse/Lab_01.md) để biết thêm về quá trình thực hành thêm Device.