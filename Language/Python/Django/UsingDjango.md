# Sử dụng Django để làm Web đơn giản
**Chuẩn bị**

- Tôi sẽ sử dụng Django trên máy chủ Linux của mình, chạy hệ điều hành Ubuntu 22

- Máy sẽ được cài sẵn Python3 và được thiết lập sẵn môi trường ảo Python

## Cài đặt Django
Trước tiên, truy cập tới thư mục của dự án và tạo ra 1 môi trường ảo:
```
root@MANH-API:/home/ducmanh/django# python3 -m venv venv
```
Khởi chạy môi trường ảo:
```
source /venv/bin/activate
```
Cài đặt Django:
```
pip install Django
```
## Tạo Project Dejango
Khởi tạo một dự án mới:
```
django-admin startproject mywebsite
```
- Bạn có thể thay `mywebsite` bằng tên project của bạn

Kiểm tra:
```
(venv) root@MANH-API:/home/ducmanh/django# cd mywebsite/
```
```
(venv) root@MANH-API:/home/ducmanh/django/mywebsite# ll
total 16
drwxr-xr-x 3 root root 4096 Oct 30 15:28 ./
drwxr-xr-x 4 root root 4096 Oct 30 15:28 ../
-rwxr-xr-x 1 root root  665 Oct 30 15:28 manage.py*
drwxr-xr-x 2 root root 4096 Oct 30 15:28 mywebsite/
```
```
(venv) root@MANH-API:/home/ducmanh/django/mywebsite# cd mywebsite/
(venv) root@MANH-API:/home/ducmanh/django/mywebsite/mywebsite# ll
total 24
drwxr-xr-x 2 root root 4096 Oct 30 15:28 ./
drwxr-xr-x 3 root root 4096 Oct 30 15:28 ../
-rw-r--r-- 1 root root  395 Oct 30 15:28 asgi.py
-rw-r--r-- 1 root root    0 Oct 30 15:28 __init__.py
-rw-r--r-- 1 root root 3230 Oct 30 15:28 settings.py
-rw-r--r-- 1 root root  765 Oct 30 15:28 urls.py
-rw-r--r-- 1 root root  395 Oct 30 15:28 wsgi.py
```
## Cấu trúc của 1 dự án Django
Trong Project Python sẽ có 1 file `manage.py` và 1 folder cùng tên với Project. 
- File `manage.py` sẽ  giúp ta tương tác với Project thông qua các command (như là tạo tài khoản admin, tạo database, chạy server ảo, ...), vì vậy không nên chỉnh sửa ở đây.
- Ở folder Project sẽ bao gồm:
  - `asgi.py`: File này giúp dự án chạy theo giao thức ASGI, cho phép chạy ứng dụng Django với tính năng bất đồng bộ, thích hợp cho việc triển khai thời gian thực.
  - `__init__.py`: đây là 1 file cơ bản trong Python dùng để biến folder chứa nó thành package, giúp tao có thể import
  - `setttings.py`: đây là file cấu hình project. (VD: cấu hình database, đặt múi giờ, cài thêm thư viện, ...)
  - `urls.py`: đây là file giúp chúng ta tạo các đường dẫn urls của trang web để liên kết các webpage lại với nhau
  - `wsgi.py`: đây là file giúp chúng ta deploy project lên server

## Thử khởi chạy web cơ bản ban đầu
Do tôi sử dụng Laptop Windows ssh vào máy chủ Ubuntu đang chứa dự án trang web, vậy nên để có thể truy cập tới trang web Django, chúng ta sẽ cần sửa đổi một chút:
- Truy cập vào file `settings.py` và chỉnh sửa như sau:
```
ALLOWED_HOSTS = ['<Ip máy chủ Ubuntu>', 'localhost']
```
- Sau đó ra thư mục dự án và chạy câu lệnh sau:
```
python3 manage.py runserver 0.0.0.0:8000
```
- Cấu hình `0.0.0.0` giúp Django lắng nghe các kết nối từ bên ngoài trên cổng 8000.
- Kiểm tra 

![](/Anh/Screenshot_974.png)

## Tạo ra 1 Web App cơ bản sử dụng Django
### Lý thuyết
**Web App** là nơi để tạo ra những trang web nằm trong toàn bộ hệ thống website, trong 1 dự án thì ta cần chia ra nhiều web app nhằm dễ quản lý và phân chia công việc.

Ví dụ: Bạn sẽ tạo ra 1 app để quản lý những tác vụ đăng vụ đăng nhập, đăng xuất riêng; 1 app quản lý về trang chủ,... Và sau khi hoàn thành các app, chúng ta sẽ có một website hoàn chỉnh.

### Khởi tạo
Sử dụng câu lệnh sau để khởi tạo 1 app:
```
python manage.py startapp mywebapp
```
Kiểm tra việc khởi tạo:
```
(venv) root@MANH-API:/home/ducmanh/django/mywebsite# ll
total 20
drwxr-xr-x 4 root root 4096 Oct 30 15:50 ./
drwxr-xr-x 4 root root 4096 Oct 30 15:28 ../
-rw-r--r-- 1 root root    0 Oct 30 15:35 db.sqlite3
-rwxr-xr-x 1 root root  665 Oct 30 15:28 manage.py*
drwxr-xr-x 3 root root 4096 Oct 30 15:50 mywebapp/
drwxr-xr-x 3 root root 4096 Oct 30 15:43 mywebsite/
```
```
(venv) root@MANH-API:/home/ducmanh/django/mywebsite# cd mywebapp/
(venv) root@MANH-API:/home/ducmanh/django/mywebsite/mywebapp# ll
total 32
drwxr-xr-x 3 root root 4096 Oct 30 15:50 ./
drwxr-xr-x 4 root root 4096 Oct 30 15:50 ../
-rw-r--r-- 1 root root   63 Oct 30 15:50 admin.py
-rw-r--r-- 1 root root  148 Oct 30 15:50 apps.py
-rw-r--r-- 1 root root    0 Oct 30 15:50 __init__.py
drwxr-xr-x 2 root root 4096 Oct 30 15:50 migrations/
-rw-r--r-- 1 root root   57 Oct 30 15:50 models.py
-rw-r--r-- 1 root root   60 Oct 30 15:50 tests.py
-rw-r--r-- 1 root root   63 Oct 30 15:50 views.py
```
Bây giờ ta sẽ khai báo cho project biết ta vừa tạo 1 App mới (mục đích chính là nếu sau này App có liên quan trong việc thiết kế các bảng trong database).

Ta vào mục mywebsite, mở file `settings.py`. Ở phần khai báo `INSTALLED_APPS`, tao ghi thêm tên App vào trong:
```
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'mywebapp',                # Ghi tại đây, lưu ý thêm dấu `,`
]
```
Sau đó, để cập nhật cho phần settings. Ta sẽ chạy lệnh sau:
```
# Quay trở lại thư mục dự án
cd /home/ducmanh/django/mywebsite 

# Chạy câu lệnh
python manage.py migrate
```
```
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying auth.0012_alter_user_first_name_max_length... OK
  Applying sessions.0001_initial... OK
```
Nếu ta chạy migrate project lần đầu. Thì project Django sẽ tạo một số bảng cho chức năng user, admin cho database hiện tại. Bản chất Django hỗ trợ cho chúng ta hệ thống user, admin để thuận tiện cho việc phát triển trang web nhanh hơn.

#### Cách thức hoạt động của web
Phía Client chính là máy tính của người dùng, khi người dùng gửi 1 request bằng giao thức HTTP cho phía Server. 

Sau khi Server nhận được request, server sẽ phân tích xem người dùng yêu cầu thứ gì rồi sẽ response về cho máy người dùng.

***Ví dụ***: khi bạn đi vào địa chỉ `www.google.com`, là trình duyệt của bạn đang request đến server là 'tôi muốn vào trang tìm kiếm google', khi web server của google nhận được, google sẽ trả cho bạn response có html của trang tìm kiếm google, trình duyệt sẽ chuyển html sang giao diện cho bạn thấy

#### Khởi tạo WebApp
Ở Django, chúng ta sẽ viết ra các hàm để xử lý những request của client gửi đến cho web server của mình. Bây giờ ta sẽ viết 1 hàm xử lý ở file `views.py` trong app mywebapp.
```
from django.shortcuts import render
from django.http import HttpResponse
# Create your views here.
def hello(request):
   response = HttpResponse()
   response.writelines('<h1>Xin chào</h1>')
   response.write('Đây là app home')
   return response
```
Đầu tiên mình sẽ `import HttpResponse` từ thư viện, sau đó sẽ viết 1 hàm `hello` có tham số request (chính là request người dùng gửi về). 

Tại hàm này, mình tạo một `instance HttpResponse`, sử dụng method `writelines` hay `write` để viết nội dung html nằm trong response này. Cuối cùng sẽ `return response` để trả về cho máy người dùng.

Tiếp theo ta sẽ phải xây dựng bộ urls để ứng với mỗi url trên trang web thì sẽ gọi hàm gì xử lý request đó. Ở mywebapp, ta tạo thêm 1 file `urls.py` có nội dung như sau:
```
from django.urls import path
from . import views

urlpatterns = [
    path('', views.hello, name='hello'),
]
```
Liên kết URL của mywebapp với dự án bằng cách thêm URL của app vào `mysite/urls.py`:
```
from django.contrib import admin
from django.urls import path

urlpatterns = [
    path('admin/', admin.site.urls),
    path('mywebapp/', include('mywebapp.urls')), # Thêm ở đây
]
```
Nếu sau khi cấu hình mà bạn gặp lỗi như sau khi truy cập

![](/Anh/Screenshot_975.png)

Nghĩa là: Hiện tại trong Project bạn chỉ cấu hình 2 đường dẫn là `admin` và `mywebapp` vì vậy mà đường dẫn mặc định sẽ không còn hoạt động

### Viết Test case đơn giản
Trong việc lập trình, việc kiểm thử phần mềm là điều luôn luôn có. Có khi chúng ta cũng có thể tự viết 1 vài test case đơn giản để kiểm tra trước khi đưa cho đội ngũ tester kiểm thử. 

Bạn vào file `tests.py` trong mywebapp để kiểm tra thử hàm hello, bạn viết như sau:
```
from django.test import TestCase
from django.urls import reverse

class HelloViewTests(TestCase):
    
    def test_hello_world_view(self):
        response = self.client.get(reverse('hello'))  
        self.assertEqual(response.status_code, 200)        
```

Sau khi chạy thử bạn sẽ được kết quả như sau:
```
(venv) root@MANH-API:/home/ducmanh/django/mywebsite# python manage.py test mywebapp
Found 1 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.
----------------------------------------------------------------------
Ran 1 test in 0.012s

OK
Destroying test database for alias 'default'...
```
