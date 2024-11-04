# Các biểu mẫu (Forms)
Lớp biểu mẫu tạo các phần tử biểu mẫu HTML cho giao diện người dùng, xử lý và xác thực đầu vào của người dùng. Chúng được sử dụng trong NetBox chủ yếu để tạo, sửa đổi và xóa các đối tượng. Chúng ta sẽ tạo một lớp biểu mẫu cho mỗi mô hình plugin của chúng ta.

## Tạo Biểu Mẫu
Bắt đầu bằng cách tạo một tệp có tên `forms.py` trong thư mục `netbox_access_lists/`.

Ở đầu tệp, chúng ta sẽ import lớp **NetBoxModelForm** của NetBox, lớp này sẽ đóng vai trò là lớp cơ sở cho các biểu mẫu của chúng ta. Chúng tôi cũng sẽ nhập các mô hình plugin của chúng tôi.

### AccessListForm
Tạo một lớp có tên **AccessListForm**, phân lớp **NetBoxModelForm**. Trong lớp này, định nghĩa một lớp con **Meta** xác định mô hình và trường của biểu mẫu. Lưu ý rằng danh sách trường cũng bao gồm các thẻ: Việc gán thẻ được **NetBoxModel** xử lý tự động, vì vậy chúng tôi không cần thêm nó vào mô hình của mình trong bước hai.
```
class AccessListForm(NetBoxModelForm):

    class Meta:
        model = AccessList
        fields = ('name', 'default_action', 'comments', 'tags')
```
Chỉ riêng điều này là đủ cho mô hình đầu tiên của chúng tôi, nhưng chúng tôi có thể thực hiện một tinh chỉnh: Thay vì trường mặc định mà Django sẽ tạo cho trường mô hình nhận xét, chúng tôi có thể sử dụng lớp **CommentField** được xây dựng có mục đích của NetBox. (Điều này xử lý một số chi tiết phần lớn là thẩm mỹ như đặt `help_text` và điều chỉnh bố cục của trường.) Để làm điều này, chỉ cần nhập lớp **CommentField** và ghi đè lên trường biểu mẫu:
```
from utilities.forms.fields import CommentField
# ...
class AccessListForm(NetBoxModelForm):
    comments = CommentField()

    class Meta:
        model = AccessList
        fields = ('name', 'default_action', 'comments', 'tags')
```
