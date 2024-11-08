# Hướng dẫn sử dụng Tools API_DEVICE
## Tổng quan về Tools
Tools được lập ra trong quá trình tôi học cách sử dụng API kết hợp với NETBOX ở trên Linux.

Tools có khả năng Add, Update, Delete, Show dữ liệu của Device trên NetBox

Tools được viết bằng ngôn ngữ BashScripts và chỉ chạy được trên các hệ thống sử dụng hệ điều hành Linux

## Hướng dẫn sử dụng
### Chuẩn bị
#### Yêu cầu 
Để tools chạy mượt mà và ổn định nhất, bạn nên có:
- 1 thiết bị chạy Unix cơ bản
  - 2GB RAM
  - CPU ~ 2.0GHZ
- 1 Server NetBox để kết nối tới và lấy dữ liệu
- Internet(Hoặc đảm bảo các kết nối Local)
- Tools (Có thể tải xuống tại [đây](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/Tools/API/Auto_Netbox.sh)) hoặc xem ở mục Tải xuống và cài đặt bên dưới

#### Tải xuống
Nếu đang ở trên các thiết bị Linux như Centos hoặc Ubuntu, các bạn có thể tải xuống với lệnh sau:
```
# Sử dụng curl:
curl -O https://raw.githubusercontent.com/Ducmanh28/Thuc-Tap/refs/heads/main/Linux/03.%20Linuxvagiaothucmang/NetBox/Tools/API/Auto_Netbox.sh

# Hoặc sử dụng wget:
https://raw.githubusercontent.com/Ducmanh28/Thuc-Tap/refs/heads/main/Linux/03.%20Linuxvagiaothucmang/NetBox/Tools/API/Auto_Netbox.sh
```
### Khởi chạy
#### Màn hình ban đầu. 

![](/Anh/Screenshot_936.png)

Tại đây, bạn sẽ nhập vào 2 thứ:
- URL dẫn đến Web NetBox của bạn. Ví dụ bạn có url là: `https://www.netboxlab.local` thì tại mục này, bạn chỉ cần điền: `www.netboxlab.local`
- API Token: Tại mục này, bạn sẽ nhập vào API Token của NetBox.

#### Checking
Tiếp đến sẽ là phần Checking sẽ kiểm tra phần cứng và kết nối tới Web API NetBox

![](/Anh/Screenshot_937.png)

Sẽ có 3 mục check như trong ảnh, và nếu thiết bị của bạn vượt qua cả 3 mục thì Tools sẽ bắt đầu chạy

#### MENU chính
Phần Menu chính sẽ là nơi mà bạn chọn xem muốn làm gì với dữ liệu

![](/Anh/Screenshot_938.png)

MENU chính sẽ cho bạn 4 lựa chọn:
- Nếu chọn `1` sẽ đưa bạn tới Menu Add
- Nếu chọn `2` sẽ đưa bạn tới mục Update
- Nếu chọn `3` sẽ đưa bạn tới mục Delete
- Nếu chọn `4` sẽ thoát khỏi Tools

#### ADD
Là phần Menu chọn cách mà bạn muốn Add dữ liệu của 1 Device

![](/Anh/Screenshot_939.png)
 
Có 2 lựa chọn ở đây:
- Nếu bạn chọn `1` sẽ đưa bạn đến Menu để add Device
- Nếu bạn chọn `2` sẽ đưa bạn đến menu thêm mới các Data cần thiết cho 1 Device

#### ADD Device Menu
Trước khi sử dụng, sẽ có thông báo để bạn có thể chắc chắn rằng bản thân có thể nhớ rõ các thông tin như Device Roles ID, Device Types ID,... Nếu không nhớ, sẽ có lựa chọn để bạn xem laị

![](/Anh/Screenshot_940.png)

Có 4 lựa chọn ở đây:
- Nếu chọn `1` sẽ đưa bạn đến với phần thêm mới thiết bị
- Nếu chọn `2` sẽ đưa bạn đến Menu xem lại thông tin thiết bị
- Nếu chọn `3` sẽ quay trở lại ADD
- Nếu chọn `4` sẽ đưa bạn về Menu Chính

#### ADD Device
Tại đây, bạn sẽ thực hiện thêm mới dữ liệu cho 1 Device

![](/Anh/Screenshot_941.png)

- Trước tiên, bạn sẽ cần nhập 1 số thông tin cho thiết bị của mình.
- Trong đó các thông tin mà bạn bắt buộc phải nhập là:
  - Device Type ID: <Dữ liệu dạng số>
  - Device Role ID: <Dữ liệu dạng số>
  - Site ID: <Dữ liệu dạng số>
  - Device Status: <Dữ liệu dạng chữ>
- Sau khi hoàn thành công cuộc nhập dữ liệu, hãy chờ 1 lúc để dữ liệu được POST lên NetBox. Nếu thành công, sẽ hiển thị thông báo `Adding Device Complete!` và Menu Add Device sẽ lại xuất hiện

Vậy nếu trong trường hợp bạn không nhớ các thông tin liên quan tới thiết bị thì sao: Rất đơn giản, Khi Menu Add Device xuất hiện, bạn sẽ chọn Options `2` để hiển thị Menu Xem dữ liệu

![](/Anh/Screenshot_942.png)

Tại Menu này, có các lựa chọn như:
- Chọn `1` để xem dữ liệu của các Sites
- Chọn `2` để xem dữ liệu của các Locations
- Chọn `3` để xem dữ liệu của các Device Role
- Chọn `4` để xem dữ liệu của các Devices

Ví dụ, tôi không nhớ ID của các Device Roles là gì. Tôi chọn 3 thì kết quả hiển thị sẽ như sau:

![](/Anh/Screenshot_943.png)

Như các bạn có thể thấy, 1 danh sách các ID và tên của Device Role hiện ra. Sau khi hoàn tất hiển thị Tools cũng sẽ đưa bạn về lại với Menu Show.

#### Add Data Menu
Vậy trong trường hợp bạn chưa có sẵn các dữ liệu như Sites, Device Roles hay Device Types hoặc muốn tạo mới 1 dữ liệu cơ bản thì sao?

Lúc này, Tại Add Menu, các bạn chọn `2` để truy cập vào Menu Add Data. 

Tại Menu Add Data, các bạn chọn `1` để tiến tới menu Create.

![](/Anh/Screenshot_944.png)

Tại Menu Create, bạn sẽ có thể:
- Chọn `1` để khởi tạo 1 Site mới
- Chọn `2` để khởi tạo 1 Location mới
- Chọn `3` để khởi tạo 1 Device Role mới
- Chọn `4` để khởi tạo 1 Device Type mới
- Chọn `5` để quay trở lại Menu Add Data    
