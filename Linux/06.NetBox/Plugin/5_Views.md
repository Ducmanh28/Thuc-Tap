# Các Views
# Bước 5: Views

Views chịu trách nhiệm cho logic nghiệp vụ của ứng dụng. Thông thường, điều này bao gồm xử lý các yêu cầu đến, thực hiện một số hành động và trả về phản hồi cho client. Mỗi view thường có một URL liên kết và có thể xử lý một hoặc nhiều loại yêu cầu HTTP (ví dụ: yêu cầu GET và/hoặc POST).

Django cung cấp một bộ lớp view chung để xử lý phần lớn mã lặp lại cần thiết để xử lý các yêu cầu. Tương tự, NetBox cung cấp một bộ lớp view để đơn giản hóa việc tạo các view cho việc tạo, chỉnh sửa, xóa và xem các đối tượng. Các view này cũng hỗ trợ các tính năng đặc thù của NetBox như custom fields và ghi nhật ký thay đổi.

Trong bước này, chúng ta sẽ tạo một bộ views cho mỗi model của plugin.

**:blue_square**: **Lưu ý:** Nếu bạn đã bỏ qua bước trước, chạy lệnh `git checkout step04-forms`

Tạo Views

Bắt đầu bằng cách tạo tệp `views.py` trong thư mục `netbox_access_lists/`

```
$ cd netbox_access_lists/
$ edit views.py
```
Chúng ta cần import các module models, tables, và forms của plugin: Đây là nơi mọi thứ chúng ta đã xây dựng trước đó kết hợp lại! Chúng ta cũng cần import module view chung của NetBox, vì nó cung cấp các lớp cơ sở cho các view của chúng ta.
```
from netbox.views import generic
from . import forms, models, tables
```
**:green_circle:** Mẹo: Bạn sẽ thấy chúng ta đang import toàn bộ module model, form, và tables. Nếu muốn, bạn có thể chỉ import từng class liên quan trực tiếp; chỉ cần nhớ thay đổi định nghĩa của các class bên dưới cho phù hợp.

Đối với mỗi model, chúng ta cần tạo bốn view:

- Detail view - Hiển thị một đối tượng duy nhất
- List view - Hiển thị một bảng chứa tất cả các instance hiện có của một model cụ thể
- Edit view - Xử lý thêm và chỉnh sửa đối tượng
- Delete view - Xử lý việc xóa đối tượng

Views cho AccessList
Mẫu chung ở đây là kế thừa từ một lớp view chung do NetBox cung cấp và định nghĩa các thuộc tính cần thiết. Chúng ta sẽ không cần viết mã phức tạp vì các view của NetBox đã xử lý logic yêu cầu cho chúng ta.

Bắt đầu với một detail view. Chúng ta kế thừa generic.ObjectView và định nghĩa queryset của các đối tượng mà chúng ta muốn hiển thị.

```
class AccessListView(generic.ObjectView):
    queryset = models.AccessList.objects.all()
```
**:green_circle**: Mẹo: Các view yêu cầu chúng ta định nghĩa queryset thay vì chỉ model, vì đôi khi cần phải sửa đổi queryset, ví dụ: để lấy trước các đối tượng liên quan hoặc giới hạn theo một thuộc tính cụ thể.

Tiếp theo, chúng ta sẽ thêm một list view. Đối với view này, chúng ta cần định nghĩa cả queryset và table.
```
class AccessListListView(generic.ObjectListView):
    queryset = models.AccessList.objects.all()
    table = tables.AccessListTable
```
**:green_circle**: Mẹo: Có thể bạn sẽ thấy tên model kết thúc bằng "List" hơi gây nhầm lẫn ở đây. Chỉ cần nhớ rằng AccessListView là view detail (một đối tượng), còn AccessListListView là view list (nhiều đối tượng).
reverse() cần 2 biến: Tên view, và danh sách các phần tử. View name bao gồm:
- The string 'plugins'
- The name of the plugin's app, e.g., 'netbox_access_lists'
- The specific view name, e.g., 'accesslist'

Đối với AccessListRule model, chúng ta làm như sau:
```
class AccessListRule(NetBoxModel):
    # ...
    def get_absolute_url(self):
        return reverse('plugins:netbox_access_lists:accesslistrule', args=[self.pk])
```
**:blue_square**: Lưu ý: Việc sử dụng `get_absolute_url()` không chỉ giúp duy trì tiêu chuẩn của Django mà còn cho phép các phương thức khác trong ứng dụng (như API hoặc mẫu) liên kết tới URL chính xác của đối tượng một cách nhất quán.

Kết luận

Vậy là chúng ta đã hoàn thành bước 5: Tạo các views và ánh xạ chúng tới URLs. Các view này xử lý logic ứng dụng của bạn và định nghĩa cách mà người dùng tương tác với các mô hình của plugin. Ở bước tiếp theo, chúng ta sẽ tập trung vào việc cấu hình template để cải thiện giao diện người dùng.

**:green_circle**: Gợi ý: Hãy chắc chắn rằng bạn đã commit toàn bộ thay đổi trước khi tiếp tục:
```
$ git add .
$ git commit -m "Completed step 5: Views"
```