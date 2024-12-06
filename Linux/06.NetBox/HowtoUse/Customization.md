# Mục này tìm hiểu về Customization của NetBox
## Lý thuyết
Phần ***Customization*** trong **NetBox** cho phép tùy chỉnh và mở rộng hệ thống để phù hợp với nhu cầu cụ thể của người dùng.

### Custom Fields(Trường tùy chỉnh)
Cho phép thêm các trường dữ liệu tùy chỉnh vào các đối tượng trong NetBox.

Có thể tạo các trường tùy chỉnh thông qua giao diện web hoặc qua API

Một số loại trường hỗ trợ như: text, integer, boolen, selection,...

Ví dụ: Trong NetBox không có tính năng cho biết Virtual Machine đang ở trong môi trường nào. Khi này, ta có thể tạo ra 1 trường có tên là **Enviroment**, gán nó cho trường dữ liệu VM. Lúc này, ta có thể thêm dữ liệu **Enviroment** vào mỗi VM

Một số khái niệm chưa biết:
- Related object type: Cho phép liên kết giữa trường này và trường khác.
- Search Weight: Xác định tầm quan trọng của trường trong tìm kiếm.
- Filter Logic: Xác định cách dữ liệu được khớp khi tìm kiếm (khớp lỏng lẻo hay chính xác).
- UI Visible: Quyết định trường có luôn hiển thị trên giao diện hay không.
- UI Editable: Cho phép trường có thể được chỉnh sửa trên giao diện người dùng.
- Display Weight: Quy định thứ tự hiển thị trường trong form, với giá trị cao hơn xuất hiện ở vị trí thấp hơn.
- Default: Giá trị mặc định khi không có giá trị nào được nhập.
- Choice Set: Các lựa chọn có sẵn cho trường dạng Selection.
- Minimum/Maximum Value: Giới hạn giá trị nhỏ nhất và lớn nhất cho trường số.
- Validation Regex: Quy định biểu thức chính quy để kiểm tra giá trị nhập vào cho các trường văn bản, đảm bảo dữ liệu tuân theo quy tắc bạn mong muốn.

### Custom Fields Choice
**CustomField Choice** trong NetBox là một tùy chọn thuộc loại trường tùy chỉnh (custom field) dạng "Lựa chọn". 

Khi bạn tạo ra một CustomField và chọn loại trường là *Selection*, bạn có thể định nghĩa 1 danh sách các giá trị cố định và người dùng sẽ đưa ra lựa chọn khi nhập dữ liệu

Ví dụ: Nếu bạn tạo một custom field cho thiết bị với tên là "Power Status" (Trạng thái nguồn) và chọn loại Selection, bạn có thể định nghĩa các giá trị lựa chọn như:
- "On"
- "Off"
- "Standby"

Người dùng khi nhập dữ liệu cho trường "Power Status" sẽ chỉ được chọn từ các giá trị này, giúp kiểm soát và chuẩn hóa dữ liệu trong NetBox.

### Custom Links (Liên kết tùy chỉnh)
Trường này sẽ cho phép bạn thêm các liên kết động trên giao diện chi tiết của 1 object trong NetBox.

Ví dụ: Bạn có thể thêm liên kết để mở trang quản lý thiết bị trực tiếp dựa trên IP của nó(IDRAC)

### Export Template
**Export Template** trong NetBox cho phép bạn tùy chỉnh cách xuất dữ liệu từ hệ thống sang các định dạng như CSV, JSON, YAML,... 

Nó thường được sử dụng khi bạn muốn xuất dữ liệu từ các bảng hoặc mô hình nào đó cụ thể trên NetBox với định dạng và cấu trúc do chúng ta xác định

Để thao tác với Template, chúng ta sẽ dùng ngôn ngữ Jinja2 để định dạng xuất dữ liệu 

### Saved Filters
Cho phép bạn lưu các bộ lọc tìm kiếm thường đùng để dễ dàng truy cập lại sau này. 

Đây là tính năng hữu ích khi bạn thường xuyên tìm kiếm hoặc sắp xếp dữ liệu dựa trên các tiêu chí cố định, giúp tiết kiệm thời gian

### Tags
Là một tính năng cho phép gắn nhãn các đối tượng để tiện cho việc phân biệt và quản lý

### Scripts
Như chúng ta đã biết Scripts chính là những công cụ, những chương trình được viết ra nhằm phục vụ cho 1 mục đích cá nhân nào đó của mỗi chúng ta.

Với NetBox cũng vậy. Scripts được viết ra nhằm tự động hóa 1 công việc nào đó, lọc dữ liệu hay bất kì công việc gì thay cho thủ công. 

Scripts trong NetBox được viết bằng ngôn ngữ Python và có thể được thao tác thông qua API nội bộ

## Thực hành
### Thêm 1 Custom Fields
Trước tiên, thêm 1 số thông tin cơ bản:

![](/Anh/Screenshot_955.png)

Để mặc định các giá trị Behavier

![](/Anh/Screenshot_956.png)

Kết quả ở phần Device, ta đã thấy mục Custom Fỉeld:

![](/Anh/Screenshot_957.png)