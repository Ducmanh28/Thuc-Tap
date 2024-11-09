# Các bước thiết lập cơ bản
Trước khi có thể bắt đầu làm việc với plugin, chúng ta cần tạo ra một môi trường làm việc hoàn hảo
## Cài đặt NetBox
Việc phát triển Plugin sẽ yêu cầu một phiên bản Netbox Local. Nếu bạn chưa biết cài đặt NetBox như thế nào, có thể tham khảo tại 1 trong các đường dẫn sau:
- [Cài đặt thủ công](https://suncloud.vn/netbox-la-gi-huong-dan-cai-dat-netbox-tren-linux-chi-tiet-nhat)
- [Cài đặt tự động](https://github.com/Ducmanh28/Thuc-Tap/tree/main/Linux/03.%20Linuxvagiaothucmang/NetBox/Tools/Install)

**Lưu ý**: Phiên bản của NetBox cần phải đảm bảo > `v3.2` để Plugin có thể hoạt động được

## Clone Git Repo demo
Tiếp theo, chúng ta sẽ clone demo git repository từ GitHub
- Trước tiên chúng ta sẽ tìm 1 nơi chứa:
```
cd /opt
```
- Sau đó sẽ clone git repo về:
```
git clone --branch step00-empty https://github.com/netbox-community/netbox-plugin-demo
Cloning into 'opt'...
remote: Enumerating objects: 219, done.
remote: Counting objects: 100% (49/49), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 219 (delta 43), reused 46 (delta 43), pack-reused 170 (from 1)
Receiving objects: 100% (219/219), 27.53 KiB | 469.00 KiB/s, done.
Resolving deltas: 100% (81/81), done.
```
- Kiểm tra lại với câu lệnh `ll`:
```
root@MANHNetBoxLab:/opt# ll
total 24
drwxr-xr-x  6 root root 4096 Oct 24 22:31 ./
drwxr-xr-x 20 root root 4096 Aug 13 14:29 ../
lrwxrwxrwx  1 root root   18 Aug 20 14:05 netbox -> /opt/netbox-4.0.5//
drwxrwxr-x  8 root root 4096 Aug 20 14:42 netbox-4.0.5/
drwxr-xr-x  3 root root 4096 Oct 24 22:31 netbox-plugin-demo/
drwxr-xr-x 10 root root 4096 Oct 21 14:52 netbox-sync/
drwxr-xr-x  4 root root 4096 Oct 21 16:58 netbox-telegram/
root@MANHNetBoxLab:/opt#
```
## Cấu hình Plugin
### Tạo file `__init__.py`
Lớp chứa tất cả thông tin cần biết về plugin của chúng ta để cài đặt nó. Đầu tiên, chúng ta sẽ tạo một thư mục con để giữ mã Python của plugin của chúng ta, cũng như một tệp để giữ định nghĩa
```
$ mkdir netbox_access_lists
$ touch netbox_access_lists/__init__.py
```

Mở file init trong trình soạn thảo, thêm thư viện của NetBox vào
```
from netbox.plugins import PluginConfig
```
### Tạo lớp PluginConfig 
Chúng ta sẽ tạo một lớp mới được đặt tên bằng subclassing . Điều này sẽ xác định tất cả các tham số cần thiết kiểm soát cấu hình plugin của chúng tôi sau khi cài đặt. Có rất nhiều thuộc tính tùy chọn có thể được đặt ở đây, nhưng bây giờ chúng ta chỉ cần xác định một vài thuộc tính thôi
```
class NetBoxAccessListsConfig(PluginConfig):
    name = 'netbox_access_lists'
    verbose_name = ' NetBox Access Lists'
    description = 'Manage simple ACLs in NetBox'
    version = '0.1'
    base_url = 'access-lists'
```
Điều này sẽ đủ để cài đặt plugin của chúng tôi trong NetBox sau này. Cuối cùng, chúng ta cần phơi bày lớp này để đảm bảo rằng NetBox phát hiện ra nó. Thêm dòng này vào cuối tệp:`config`
```
config = NetBoxAccessListsConfig
```
### Tạo File readme
Quay lại thư mục gốc của dự án và tạo file README

Sử dụng định dạng file `.md` để biểu thị đang sử dụng markdown

Thêm nội dung sau vào file:
```
## netbox-access-lists

Manage simple access control lists in NetBox
```
### Cài đặt Plugin
#### Tạo `setup.py`
Để cho phép cài đặt plugin của chúng tôi vào môi trường ảo mà chúng tôi đã tạo ở trên, chúng tôi sẽ tạo một tập lệnh thiết lập Python đơn giản. Trong thư mục gốc của dự án, tạo một tệp có tên `setup.py` và nhập mã bên dưới 
```
from setuptools import find_packages, setup

setup(
    name='netbox-access-lists',
    version='0.1',
    description='An example NetBox plugin',
    install_requires=[],
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
)
```
#### Thiết lập môi trường ả
Sử dụng môi trường ảo của NetBox:
```
source /opt/netbox/venv/bin/activate
```
#### Chạy setup.py
```
pip install -e .
```
### Cấu hình NetBox
Chỉnh sửa nội dung file `/opt/netbox/netbox/netbox/configuration.py`

Thêm vào nội dung sau:
```
PLUGINS = ['netbox_access_lists',]
```
### Khởi động lại dịch vụ
Khởi động lại dịch vụ Netbox:
```
systemctl restart netbox
```
### Thực hiện kiểm tra:
Kiểm tra trong mục **Admin-->System-->System**

![](/Anh/Screenshot_970.png)