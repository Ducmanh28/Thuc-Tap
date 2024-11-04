# Bước 2: Mô Hình (Models)
Trong bước này, chúng ta sẽ định nghĩa một số mô hình Django để lưu trữ dữ liệu của plugin. Một mô hình (model) là một lớp Python đại diện cho một bảng trong cơ sở dữ liệu PostgreSQL; mỗi instance của mô hình tương đương với một dòng trong bảng. Chúng ta sử dụng mô hình thay vì SQL thô vì tương tác với các đối tượng Python tiện lợi và linh hoạt hơn.

**Lưu ý**: Nếu bạn bỏ qua bước trước, hãy chạy lệnh `git checkout step01-initial-setup`

## Tạo Mô Hình (Models)
Đầu tiên, vào thư mục netbox_access_lists và tạo file có tên là models.py. Đây là nơi các lớp mô hình của chúng ta sẽ được định nghĩa.
```
$ cd netbox_access_lists
$ edit models.py
```
Ở đầu file, import thư viện models của Django và lớp NetBoxModel của NetBox. Lớp này sẽ là lớp cơ sở cho các mô hình trong plugin của chúng ta. Chúng ta cũng sẽ import ArrayField của PostgreSQL, sẽ được giải thích chi tiết hơn:
```
from django.contrib.postgres.fields import ArrayField
from django.db import models
from netbox.models import NetBoxModel
```
Chúng ta sẽ tạo hai mô hình:

- **AccessList**: Đại diện cho danh sách truy cập (access list), với một tên và một hoặc nhiều quy tắc được gán cho nó.
- **AccessListRule**: Là một quy tắc cụ thể với địa chỉ IP nguồn/đích, số cổng, v.v., được gán vào một danh sách truy cập.
### AccessList
Chúng ta cần định nghĩa một số trường cho mô hình này. Mỗi mô hình sẽ tự động có trường khóa chính là số (id), vì vậy chúng ta không cần quan tâm đến nó, nhưng cần phải định nghĩa các trường cho tên ACL, hành động mặc định và chú thích (tùy chọn).

```
class AccessList(NetBoxModel):
    name = models.CharField(
        max_length=100
    )
    default_action = models.CharField(
        max_length=30
    )
    comments = models.TextField(
        blank=True
    )
```
Theo mặc định, các instance của mô hình được sắp xếp theo khóa chính của chúng, nhưng sẽ hợp lý hơn nếu sắp xếp các danh sách truy cập theo tên. Chúng ta có thể làm điều đó bằng cách tạo một lớp con Meta và định nghĩa biến ordering. (Hãy chắc chắn tạo lớp Meta bên trong lớp AccessList, không phải sau nó.)
```
    class Meta:
        ordering = ('name',)
```
Cuối cùng, chúng ta sẽ thêm một phương thức __str__() để kiểm soát cách ép kiểu instance thành chuỗi. Phương thức này sẽ trả về giá trị của trường name của instance. (Lưu ý rằng phương thức này phải nằm bên trong lớp AccessList.)
```
    def __str__(self):
        return self.name
```
### AccessListRule
Mô hình thứ hai của chúng ta sẽ chứa các quy tắc riêng lẻ được gán cho mỗi danh sách truy cập. Mô hình này sẽ phức tạp hơn một chút. Chúng ta cần định nghĩa các trường cho những mục sau:

- Danh sách truy cập cha (khóa ngoại tham chiếu tới một instance của AccessList)
- Số thứ tự (vị trí của quy tắc trong danh sách)
- Giao thức
- Mạng nguồn
- Cổng nguồn
- Mạng đích
- Cổng đích
- Hành động (cho phép, chặn hoặc từ chối)
- Mô tả (tùy chọn)

Bắt đầu bằng việc định nghĩa một trường ForeignKey tham chiếu tới mô hình AccessList.
```
class AccessListRule(NetBoxModel):
    access_list = models.ForeignKey(
        to=AccessList,
        on_delete=models.CASCADE,
        related_name='rules'
    )
```
Ba tham số được truyền cho trường:

- `to` tham chiếu tới lớp mô hình liên quan
- `on_delete` chỉ định hành động cần thực hiện nếu đối tượng liên quan bị xóa. CASCADE sẽ tự động xóa bất kỳ quy tắc nào được gán cho danh sách truy cập bị xóa.
- `related_name` định nghĩa tên của mối quan hệ ngược được thêm vào lớp liên quan. Các quy tắc được gán cho một instance AccessList có thể được tham chiếu như `accesslist.rules.all()`.

Tiếp theo, chúng ta sẽ thêm một trường index để lưu thứ tự của quy tắc trong danh sách truy cập. Chúng ta sẽ sử dụng PositiveIntegerField vì chỉ hỗ trợ các số dương.
```
    index = models.PositiveIntegerField()
```
Tiếp đến là trường giao thức. Trường này sẽ lưu tên của một giao thức như TCP hoặc UDP. Chúng ta đặt blank=True vì không bắt buộc phải chỉ định giao thức khi tạo quy tắc.
```
    protocol = models.CharField(
        max_length=30,
        blank=True
    )
```
Tiếp theo, chúng ta cần định nghĩa một mạng nguồn. Chúng ta sẽ sử dụng khóa ngoại để tham chiếu tới một instance của mô hình Prefix trong app ipam của NetBox. Thay vì import lớp mô hình, chúng ta có thể tham chiếu bằng tên. Để làm cho trường này trở thành tùy chọn, chúng ta thêm blank=True và null=True.
```
    source_prefix = models.ForeignKey(
        to='ipam.Prefix',
        on_delete=models.PROTECT,
        related_name='+',
        blank=True,
        null=True
    )
```
Mẹo: Trong khi CASCADE tự động xóa các đối tượng con, PROTECT ngăn chặn việc xóa đối tượng cha nếu tồn tại bất kỳ đối tượng con nào.

Chúng ta cũng cần thêm một trường cho số cổng nguồn. Thay vì dùng một trường số nguyên (integer), chúng ta sẽ sử dụng ArrayField để lưu danh sách các giá trị PositiveIntegerField. Trường này cũng là tùy chọn nên chúng ta thêm blank=True và null=True.
```
    source_ports = ArrayField(
        base_field=models.PositiveIntegerField(),
        blank=True,
        null=True
    )
```
Bây giờ chúng ta sẽ thêm các trường mạng đích và cổng đích, tương tự như các trường nguồn.
```
    destination_prefix = models.ForeignKey(
        to='ipam.Prefix',
        on_delete=models.PROTECT,
        related_name='+',
        blank=True,
        null=True
    )
    destination_ports = ArrayField(
        base_field=models.PositiveIntegerField(),
        blank=True,
        null=True
    )
```
Cuối cùng, chúng ta sẽ thêm các trường cho hành động và mô tả của quy tắc. Hành động là bắt buộc nhưng mô tả thì không.
```
    action = models.CharField(
        max_length=30
    )
    description = models.CharField(
        max_length=500,
        blank=True
    )
```
Với các trường đã được định nghĩa xong, mô hình này cũng cần một lớp Meta để định nghĩa thứ tự sắp xếp trong cơ sở dữ liệu và đảm bảo mỗi quy tắc có số thứ tự duy nhất trong danh sách truy cập cha của nó.
```
    class Meta:
        ordering = ('access_list', 'index')
        unique_together = ('access_list', 'index')
```
Cuối cùng, chúng ta sẽ thêm một phương thức __str__() để hiển thị danh sách truy cập cha và số thứ tự khi hiển thị một instance AccessListRule dưới dạng chuỗi:
```
    def __str__(self):
        return f'{self.access_list}: Rule {self.index}'
```

## Định Nghĩa Các Lựa Chọn Cho Trường
Nhìn lại các mô hình của chúng ta, ta có thể thấy một số trường sẽ hữu ích khi có các lựa chọn xác định sẵn mà người dùng có thể chọn khi tạo hoặc chỉnh sửa một instance. Cụ thể, trường action của quy tắc có thể có một trong ba giá trị sau:
- Permit
- Deny
- Reject

Chúng ta có thể định nghĩa một ChoiceSet để lưu các giá trị này, để tránh việc nhập tên của hành động mong muốn mỗi lần tạo quy tắc. Ở đầu `models.py`, import lớp `ChoiceSet` của NetBox:
```
from utilities.choices import ChoiceSet
```
Sau đó, dưới phần import nhưng trên phần định nghĩa các mô hình, tạo một lớp con ActionChoices:
```
class ActionChoices(ChoiceSet):
    key = 'AccessListRule.action'

    CHOICES = [
        ('permit', 'Permit', 'green'),
        ('deny', 'Deny', 'red'),
        ('reject', 'Reject (Reset)', 'orange'),
    ]
```
Thuộc tính CHOICES phải là một `iterable` của các tuple hai hoặc ba giá trị, mỗi tuple định nghĩa:
- Giá trị thô để lưu vào cơ sở dữ liệu
- Chuỗi thân thiện để hiển thị
- Màu sắc để hiển thị trong giao diện người dùng

Thêm vào đó, chúng tôi đã thêm một thuộc tính quan trọng: Điều này sẽ cho phép quản trị viên NetBox thay thế hoặc mở rộng các lựa chọn mặc định của plugin thông qua tham số cấu hình FIELD_CHOICES của NetBox.

Giờ đây, chúng ta có thể tham chiếu đến tập hợp các lựa chọn hợp lệ trên các trường default_action và action của mô hình bằng cách truyền nó dưới dạng đối số từ khóa choices.

```
# AccessList
default_action = models.CharField(
    max_length=30,
    choices=ActionChoices
)

# AccessListRule
action = models.CharField(
    max_length=30,
    choices=ActionChoices
)
```
Hãy tạo một tập hợp các lựa chọn cho trường `protocol` của một quy tắc. Thêm mã này dưới lớp ActionChoices:

```
class ProtocolChoices(ChoiceSet):
    CHOICES = [
        ('tcp', 'TCP', 'blue'),
        ('udp', 'UDP', 'orange'),
        ('icmp', 'ICMP', 'purple'),
    ]
```
Sau đó, thêm đối số từ khóa choices vào trường `protocol`:

```
# AccessListRule
protocol = models.CharField(
    max_length=30,
    choices=ProtocolChoices,
    blank=True
)
```
Thêm Phương Thức Màu Sắc cho Lựa Chọn

Giờ đây, khi đã định nghĩa các lựa chọn cho một số trường trong mô hình, chúng ta cần cung cấp một phương thức để trả về màu sắc tương ứng cho lựa chọn đã chọn. Điều này hoạt động tương tự như phương thức get_FOO_display() của Django, nhưng sẽ trả về màu sắc (được định nghĩa trên ChoiceSet của trường) thay vì nhãn. Phương thức này sẽ được gọi khi hiển thị trường trong một bảng, chẳng hạn.

Hãy thêm phương thức `get_default_action_color()` trên AccessList:
```
class AccessList(NetBoxModel):
    # ...
    def get_default_action_color(self):
        return ActionChoices.colors.get(self.default_action)
```
Chúng ta cũng cần thêm các phương thức cho protocol và action trên AccessListRule:
```
class AccessListRule(NetBoxModel):
    # ...
    def get_protocol_color(self):
        return ProtocolChoices.colors.get(self.protocol)

    def get_action_color(self):
        return ActionChoices.colors.get(self.action)
```
## Tạo Schema Migrations

Giờ đây, khi đã định nghĩa mô hình, chúng ta cần tạo schema cho cơ sở dữ liệu PostgreSQL. Mặc dù có thể tự tay tạo các bảng và ràng buộc, nhưng việc sử dụng tính năng migrations của Django sẽ dễ dàng hơn nhiều. Quá trình này bao gồm hai bước: Đầu tiên, tạo file migration bằng lệnh makemigrations, sau đó chạy migrate để áp dụng nó lên cơ sở dữ liệu thực tế.

**Lưu ý**: Trước khi tiếp tục, hãy đảm bảo bạn đã đặt DEVELOPER=True trong file configuration.py của NetBox. Điều này cần thiết để vô hiệu hóa một biện pháp bảo vệ nhằm ngăn người dùng vô tình tạo mới migrations.

### Tạo File Migration

Chuyển vào thư mục gốc của cài đặt NetBox để chạy manage.py. Đầu tiên, chúng ta sẽ chạy makemigrations với đối số --dry-run để kiểm tra. Lệnh này sẽ báo cáo những thay đổi đã được phát hiện mà không thực sự tạo các file migration.
```
$ python netbox/manage.py makemigrations netbox_access_lists --dry-run
```
Kết quả:
```
Migrations for 'netbox_access_lists':
  ~/netbox-plugin-demo/netbox_access_lists/migrations/0001_initial.py
    - Create model AccessList
    - Create model AccessListRule
```
Chúng ta sẽ thấy kế hoạch tạo file migration đầu tiên của plugin, 0001_initial.py, với hai mô hình đã định nghĩa trong models.py. (Nếu gặp lỗi hoặc không thấy kết quả trên, hãy dừng lại và kiểm tra lại.) Nếu mọi thứ đều ổn, tiến hành tạo file migration (bỏ qua đối số --dry-run):
```
$ python netbox/manage.py makemigrations netbox_access_lists
```
Kết quả:
```
Migrations for 'netbox_access_lists':
  ~/netbox-plugin-demo/netbox_access_lists/migrations/0001_initial.py
    - Create model AccessList
    - Create model AccessListRule
```
Trong thư mục làm việc của plugin, bạn sẽ thấy thư mục migrations với hai file: __init__.py và 0001_initial.py.
```
$ tree
.
├── __init__.py
├── migrations
│   ├── 0001_initial.py
│   ├── __init__.py
...
```
### Áp dụng Migrations

Cuối cùng, chúng ta có thể áp dụng file migration bằng lệnh migrate:
```
$ python netbox/manage.py migrate
```
Kết quả:
```
Operations to perform:
  Apply all migrations: admin, auth, circuits, contenttypes, dcim, django_rq, extras, ipam, netbox_access_lists, sessions, social_django, taggit, tenancy, users, virtualization, wireless
Running migrations:
  Applying netbox_access_lists.0001_initial... OK
```
Nếu muốn, bạn có thể kiểm tra các bảng vừa được tạo trong cơ sở dữ liệu bằng lệnh dbshell để vào shell của PostgreSQL:
```
$ python netbox/manage.py dbshell
```
Kết quả:
```
psql (10.19 (Ubuntu 10.19-0ubuntu0.18.04.1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.
```
```
netbox=> \d netbox_access_lists_accesslist
```
Kết quả sẽ hiển thị bảng `netbox_access_lists_accesslist` cùng các cột và chỉ mục của nó.

## Tạo Một Số Đối Tượng

Giờ đây khi đã cài đặt các mô hình, hãy thử tạo một số đối tượng. Đầu tiên, vào shell của NetBox - đây là một giao diện dòng lệnh Python tương tác cho phép chúng ta tương tác trực tiếp với các đối tượng và tài nguyên khác của NetBox.
```
$ python netbox/manage.py nbshell
```
Kết quả:
```
### NetBox interactive shell (MANHNetBoxLab)
### Python 3.10.12 | Django 5.0.6 | NetBox 4.0.5
### lsmodels() will show available models. Use help(<model>) for more info.
>>> 
```
Hãy tạo và lưu một danh sách truy cập:
```
>>> from netbox_access_lists.models import *
>>> acl = AccessList(name='MyACL1', default_action='deny')
>>> acl
<AccessList: MyACL1>
>>> acl.save()
```
Sau đó tạo một số prefix để tham chiếu trong các quy tắc:
```
>>> prefix1 = Prefix(prefix='192.168.1.0/24')
>>> prefix1.save()
>>> prefix2 = Prefix(prefix='192.168.2.0/24')
>>> prefix2.save()
```
Và cuối cùng tạo một số quy tắc cho danh sách truy cập:
```
>>> AccessListRule(
...     access_list=acl,
...     index=10,
...     protocol='tcp',
...     destination_prefix=prefix1,
...     destination_ports=[80, 443],
...     action='permit',
...     description='Web traffic'
... ).save()
>>> AccessListRule(
...     access_list=acl,
...     index=20,
...     protocol='udp',
...     destination_prefix=prefix2,
...     destination_ports=[53],
...     action='permit',
...     description='DNS'
... ).save()
>>> acl.rules.all()
<RestrictedQuerySet [<AccessListRule: MyACL1: Rule 10>, <AccessListRule: MyACL1: Rule 20>]>
```




