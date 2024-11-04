# Mục này tìm hiểu về Plugin trong NetBox
## Tổng quan:
Để có thể tạo ra được Plugin cho NetBox thì trước tiên chúng ta cần phải hiểu Plugin là gì.

### Plugin NetBox là gì?
Plugin chính là các thành phần mở rộng được tích hợp để thêm tính năng hoặc tùy chỉnh hoạt động của NetBox mà không cần sửa đổi mã nguồn gốc. 
- Chúng cho phép người dùng mở rộng khả năng của hệ thống, chẳng hạn như bổ sung các tính năng quản lý thiết bị mới, tích hợp với hệ thống khác hoặc thay đổi cách hiển thị và tương tác với dữ liệu. 
- NetBox hỗ trợ plugins thông qua **API** và **UI**, và chúng thường được cài đặt như các gói Python và cấu hình trong tệp `configuration.py` 

### Cách hoạt động của plugin NetBox:
**Tích hợp API**: Plugins có thể bổ sung hoặc mở rộng API của NetBox để cung cấp các endpoint tùy chỉnh cho các mục đích đặc biệt.

**Giao diện người dùng**: Plugins có thể thay đổi hoặc thêm vào giao diện NetBox, chẳng hạn như các trang mới, biểu mẫu hoặc trường dữ liệu.

**Xử lý sự kiện**: Plugins có thể xử lý các sự kiện, chẳng hạn như kích hoạt một số hành động khi có một thay đổi nhất định trong NetBox (ví dụ: thêm thiết bị mới).

**Chức năng bổ sung**: Chúng có thể tích hợp các công cụ khác vào NetBox, cung cấp các tính năng như quản lý cấu hình, tự động hóa, báo cáo hoặc tích hợp với các hệ thống giám sát và quản lý bên ngoài.

## Cách tạo ra Plugin
### Điều kiện cần có:
Trước khi cố gắng tạo một plugin, vui lòng đánh giá khả năng cá nhân của bạn. Bạn sẽ cần có khả năng ở:
- Lập trình Python
- Khung Django
- Kiến thức cơ bản về API REST (nếu có)
- Cài đặt, cấu hình và sử dụng NetBox

#### 1. Python 
Python là một ngôn ngữ lập trình bậc cao, linh hoạt, nổi tiếng với cú pháp dễ hiểu và khả năng ứng dụng rộng rãi từ phát triển web, phân tích dữ liệu, đến trí tuệ nhân tạo. 

Python hỗ trợ lập trình hướng đối tượng, cho phép tạo các lớp và đối tượng giúp quản lý và tổ chức mã dễ dàng hơn. Ngoài ra, Python có hệ sinh thái thư viện phong phú, giúp lập trình viên triển khai nhanh chóng các chức năng mà không cần viết lại từ đầu.

#### 2. Django
Django là một framework web mạnh mẽ của Python, được xây dựng nhằm đơn giản hóa và tăng tốc quá trình phát triển các ứng dụng web phức tạp. 

Django tuân theo mô hình MVT (Model-View-Template) và tích hợp nhiều tính năng sẵn có như quản lý cơ sở dữ liệu, hệ thống định tuyến, và xác thực người dùng. Khả năng bảo mật và mở rộng của Django rất cao, thích hợp cho các dự án lớn, giúp đảm bảo an toàn dữ liệu và dễ dàng quản lý mã nguồn.

#### 3. API REST: 
API REST (Representational State Transfer) là một chuẩn thiết kế cho phép giao tiếp giữa các ứng dụng qua HTTP, được ứng dụng phổ biến trong các hệ thống phân tán. 

REST API chia nhỏ các chức năng của hệ thống thành các "endpoint" khác nhau và sử dụng các phương thức như GET, POST, PUT, DELETE để thao tác dữ liệu. API REST linh hoạt và dễ mở rộng, giúp các ứng dụng và hệ thống khác nhau có thể tích hợp và trao đổi dữ liệu một cách hiệu quả.

#### 4. NetBox
NetBox là một công cụ mã nguồn mở để quản lý cơ sở hạ tầng mạng, từ thông tin thiết bị, IP, đến mối quan hệ giữa các thành phần. Cài đặt NetBox thường yêu cầu một môi trường máy chủ có PostgreSQL và Redis, sau đó cấu hình bằng Python và Django. 

Sau khi cài đặt, người dùng có thể truy cập giao diện quản trị để thêm mới, chỉnh sửa, và giám sát dữ liệu hạ tầng mạng, hỗ trợ quản lý tài nguyên mạng hiệu quả trong các tổ chức lớn.

### Các file cần có
Để tạo một plugin trong NetBox, bạn cần có các file chính sau đây:

`__init__.py`: Đặt trong thư mục plugin chính và các thư mục con như migrations để Python nhận diện chúng là các module. File này thường có thể để trống hoặc chứa cấu hình cơ bản của plugin.

`models.py`: Định nghĩa các mô hình dữ liệu (models) của plugin. Các models này sẽ được NetBox sử dụng để tạo các bảng trong cơ sở dữ liệu và quản lý dữ liệu của plugin.

`admin.py`: Cấu hình cách plugin của bạn hiển thị trong Django Admin (trang quản lý Django).

`views.py`: Định nghĩa các view trong plugin để xử lý giao diện người dùng và logic tương tác cho các yêu cầu HTTP.

`urls.py`: Đặt các đường dẫn URL để liên kết các view trong plugin của bạn. File này sẽ được kết hợp vào hệ thống URL chung của NetBox.

`choices.py`: Định nghĩa các ChoiceSet cho các trường lựa chọn trong models của plugin. Đây là nơi bạn đặt các tùy chọn như các protocol, hành động, hoặc bất kỳ trường lựa chọn nào trong models.

`migrations`: Thư mục này chứa các file migration để cập nhật lược đồ (schema) của cơ sở dữ liệu khi models được thay đổi. Bạn sẽ chạy lệnh makemigrations và migrate để tạo và áp dụng các file migration này.

`forms.py`: Xây dựng các biểu mẫu (forms) để sử dụng cho các view của plugin, giúp quản lý dữ liệu đầu vào và cách dữ liệu hiển thị trên giao diện.

`tables.py`: Định nghĩa các bảng (tables) để hiển thị dữ liệu từ các models của plugin theo cấu trúc bảng, giúp quản lý dữ liệu trực quan.

`filters.py`: Đặt các bộ lọc (filters) cho các dữ liệu, giúp người dùng dễ dàng tìm kiếm và phân loại thông tin trong plugin.

`api/serializers.py` và `api/views.py`: Nếu plugin hỗ trợ API, các file này sẽ giúp định nghĩa các serializer và viewset để xử lý dữ liệu API.

`tests.py`: Viết các bài kiểm thử tự động để đảm bảo plugin hoạt động đúng như mong đợi.

`tasks.py`: Đặt các tác vụ chạy nền (background tasks), nếu plugin yêu cầu các tác vụ tự động hoặc định kỳ.

`README.md` và `setup.py`: File `README` cung cấp tài liệu hướng dẫn cài đặt và sử dụng plugin, còn `setup.py` là file cấu hình giúp cài đặt plugin như một package Python.
### Các bước:
[Bước 1: Thiết lập](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/Plugin/1_Initial_Setup.md)

[Bước 2: Mô hình](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/Plugin/2_Models.md)

[Bước 3: Bảng](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/Plugin/3_Tables.md)

[Bước 4: Biểu mẫu](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/Plugin/4_Forms.md)

Bước 5: Lượt xem

Bước 6: Mẫu

Bước 7: Điều hướng

Bước 8: Bộ lọc

Bước 9: REST API

Bước 10: API GraphQL

Bước 11: Tìm kiếm

### Tham Khảo
- [NetBox-Community](https://github.com/netbox-community/netbox-plugin-tutorial)

- [NetBoxDevelopment-Plugin](https://netbox.readthedocs.io/en/stable/plugins/development/)

- [Một vài Plugin được NetBox chứng nhận](https://github.com/netbox-community/netbox/wiki/Plugin-Certification-Program)