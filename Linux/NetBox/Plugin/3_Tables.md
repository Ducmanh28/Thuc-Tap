# Bước 3: Các bảng(Tables)
Bạn có thể quen thuộc với danh sách đối tượng trong NetBox. Đây là cách chúng tôi hiển thị tất cả các trường hợp của một loại đối tượng nhất định, chẳng hạn như trang web hoặc thiết bị, trong giao diện người dùng. Các danh sách này được tạo bởi các lớp bảng được xác định cho mỗi mô hình, sử dụng thư viện django-tables2.

Mặc dù việc tạo HTML thô cho `<table>` các phần tử trực tiếp trong mẫu là khả thi, nhưng điều này sẽ cồng kềnh và khó duy trì. Ngoài ra, các lớp bảng động này cung cấp chức năng thuận tiện như sắp xếp và phân trang.

## Tạo bảng
Chúng ta sẽ tạo hai bảng, một bảng cho mỗi mô hình của chúng ta. Bắt đầu bằng cách tạo `tables.py` trong thư mục `netbox_access_lists/`

Ở đầu tệp này, hãy nhập thư viện ***django-tables2***. Điều này sẽ cung cấp các lớp cột cho các trường mà chúng tôi muốn tùy chỉnh. Chúng ta cũng sẽ import lớp NetBoxTable của NetBox, lớp này sẽ đóng vai trò là lớp cơ sở cho các bảng của chúng ta và ChoiceFieldColumn. Cuối cùng, chúng tôi nhập các mô hình plugin của chúng tôi từ `models.py`.
```
import django_tables2 as tables

from netbox.tables import NetBoxTable, ChoiceFieldColumn
from .models import AccessList, AccessListRule
```
### AccessListTable
Tạo một lớp có tên **AccessListTable** làm lớp con của **NetBoxTable**. Trong lớp này, tạo một lớp **Meta** con kế thừa từ **NetBoxTable.Meta**; 

Điều này sẽ xác định mô hình, trường và cột mặc định của bảng.

```
class AccessListTable(NetBoxTable):

    class Meta(NetBoxTable.Meta):
        model = AccessList
        fields = ('pk', 'id', 'name', 'default_action', 'comments', 'actions')
        default_columns = ('name', 'default_action')
```
Thuộc tính model cho ***django-tables2*** biết mô hình nào sẽ sử dụng khi xây dựng bảng và thuộc tính fields cho biết trường mô hình nào được thêm vào bảng. 

`default_columns` kiểm soát cột nào có sẵn được hiển thị theo mặc định.

Các cột `pk` và `actions` hiển thị các bộ chọn hộp kiểm và menu thả xuống, tương ứng, cho mỗi hàng bảng; chúng được cung cấp bởi lớp **NetBoxTable**. Cột id sẽ hiển thị khóa chính bằng số của đối tượng, được bao gồm trên hầu hết mọi bảng trong NetBox nhưng thường bị tắt theo mặc định. Ba cột còn lại xuất phát từ các trường mà chúng tôi đã xác định trên mô hình **AccessList**.

Những gì chúng tôi có cho đến nay là đủ để hiển thị một bảng, nhưng chúng tôi có thể thực hiện một số cải tiến nhỏ. Đầu tiên, hãy làm cho cột `name` trở thành một liên kết đến từng đối tượng. Để làm điều này, chúng ta sẽ ghi đè lên cột mặc định bằng cách định nghĩa tên trên lớp và truyền `linkify=True`.

```
class AccessListTable(NetBoxTable):
    name = tables.Column(
        linkify=True
    )
```
Ngoài ra, hãy nhớ lại rằng trường `default_action` trên mô hình **AccessList** là trường lựa chọn, với màu được gán cho mỗi lựa chọn. Để hiển thị các giá trị này, chúng ta sẽ sử dụng lớp **ChoiceFieldColumn** của NetBox.

```
    default_action = ChoiceFieldColumn()
```
Nó cũng sẽ là tốt đẹp để bao gồm một số lượng hiển thị số lượng các quy tắc mà mỗi danh sách truy cập đã gán cho nó. Chúng ta có thể thêm một cột tùy chỉnh có tên `rule_count` để hiển thị điều này. (Dữ liệu cho cột này sẽ được chú thích bằng chế độ xem; thêm về điều này trong bước năm.) Chúng ta cũng sẽ cần thêm cột này vào các trường của mình và (tùy chọn) `default_columns` trong lớp con **Meta**. Bảng đã hoàn thành của chúng tôi sẽ trông như thế này:
```
class AccessListTable(NetBoxTable):
    name = tables.Column(
        linkify=True
    )
    default_action = ChoiceFieldColumn()
    rule_count = tables.Column()

    class Meta(NetBoxTable.Meta):
        model = AccessList
        fields = ('pk', 'id', 'name', 'rule_count', 'default_action', 'comments', 'actions')
        default_columns = ('name', 'rule_count', 'default_action')
```
### AccessListRule Table
Chúng ta cũng sẽ tạo một bảng cho mô hình **AccessListRule** của chúng ta bằng cách sử dụng cách tiếp cận tương tự như trên. Bắt đầu bằng cách liên kết các cột `access_list` và cột chỉ mục. Cái trước sẽ liên kết đến danh sách truy cập chính và cái sau sẽ liên kết với quy tắc riêng lẻ. Chúng tôi cũng muốn khai báo giao thức và hành động là các trường hợp **ChoiceFieldColumn**.
```
class AccessListRuleTable(NetBoxTable):
    access_list = tables.Column(
        linkify=True
    )
    index = tables.Column(
        linkify=True
    )
    protocol = ChoiceFieldColumn()
    action = ChoiceFieldColumn()

    class Meta(NetBoxTable.Meta):
        model = AccessListRule
        fields = (
            'pk', 'id', 'access_list', 'index', 'source_prefix', 'source_ports', 'destination_prefix',
            'destination_ports', 'protocol', 'action', 'description', 'actions',
        )
        default_columns = (
            'access_list', 'index', 'source_prefix', 'source_ports', 'destination_prefix',
            'destination_ports', 'protocol', 'action', 'actions',
        )
```
Đây sẽ là tất cả những gì chúng ta cần để liệt kê các đối tượng này trong giao diện người dùng. Tiếp theo, chúng ta sẽ định nghĩa một số biểu mẫu để cho phép tạo và sửa đổi các đối tượng.