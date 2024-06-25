# Hướng dẫn cài đặt NetBox thủ công
## Giới thiệu
Có 5 mục chính và 1 mục tùy chọn mà bạn cần thực hiện cài đặt và cấu hình để có thể sử dụng NetBox
- 5 Mục chính
  - PostgreSQL
  - Redis
  - NetBox
  - gunicorn và uWSGI
  - Máy chủ HTTP
- 1 mục tùy chọn:
  - LDAP

## Thực hành cài đặt NetbOX
Thiết bị: Máy Ubuntu Client, hệ điều hành Ubuntu22.04

### Cài đặt và cấu hình PostgreSQL 
PostgreSQL là database lưu trữ dữ liệu của NetBox

Cài đặt PostgreSQL:
```
# Cập nhật
sudo apt update

# Cài đặt
sudo apt install -y postgresql

# Kiểm tra phiên bản
psql -V
```

Tiến hành tạo database và user
```
sudo -u postgres psql
```
Hướng dẫn và đầu ra mặc định trông như sau:
```
postgres=# CREATE DATABASE netbox;
CREATE DATABASE
postgres=# CREATE USER netbox WITH PASSWORD 'SunCloud2024';
CREATE ROLE
postgres=# ALTER DATABASE netbox OWNER TO netbox;
ALTER DATABASE
postgres=# \connect netbox;
You are now connected to database "netbox" as user "postgres".
netbox=# GRANT CREATE ON SCHEMA public TO netbox;
GRANT
netbox=# \q
```
Kiểm tra lại với câu lệnh kết nối như sau:
```
psql --username ... --password --host .... netbox
```
Kết quả kiểm tra:
```
root@MANH-U22-client:~# psql --username netbox --password --host localhost netbox
Password:
psql (14.12 (Ubuntu 14.12-0ubuntu0.22.04.1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

netbox=> \conninfo
You are connected to database "netbox" as user "netbox" on host "localhost" (address "127.0.0.1") at port "5432".
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
netbox=> \q
```
### Cài đặt và cấu hình Redis
NetBox sử dụng Redis cho dịch vụ caching, vì vậy mà hệ thống của bạn cần phải có Redis

Cài đặt Redis với câu lệnh sau:
```
sudo apt install -y redis
```
Kiểm tra kết quả cài đặt
```
root@MANH-U22-client:~# redis-server -v
Redis server v=6.0.16 sha=00000000:0 malloc=jemalloc-5.2.1 bits=64 build=a3fdef44459b3ad6
```
Cấu hình Redis:
```
# Truy cập vào file cấu hình
vim /etc/redis/redis.conf

# Thêm vào nội dung sau
requirepass password

# Khởi động lại
systemctl restart redis-server

# Kiểm tra trạng thái:
systemctl status redis-server
```
### Cài đặt Python
Cài đặt python3 và các môi trường hỗ trợ bằng câu lệnh sau:
```
sudo apt install -y python3 python3-pip python3-venv python3-dev build-essential libxml2-dev libxslt1-dev libffi-dev libpq-dev libssl-dev zlib1g-dev
```
Kiểm tra phiên bản ít nhất là 3.10
```
root@MANH-U22-client:~# python3 -V
Python 3.10.12
```
### Cài đặt và cấu hình NetBox
Sau khi đã có Python và các môi trường cần thiết, chúng ta tiến hành cài NetBox

Tạo thư mục chứa NetBox và di chuyển tới thư mục đó:
```
mkdir -p /opt/netbox/

cd /opt/netbox
```
Tải xuống NetBox:
```
# Tải xuống
wget https://github.com/netbox-community/netbox/archive/refs/tags/v3.7.8.tar.gz

# Giải nén NetBox
root@MANH-U22-client:/opt/netbox# sudo tar -xzf v3.7.8.tar.gz
```
Tiến hành tạo User, Groups cho NetBox
```
root@MANH-U22-client:/opt/netbox# adduser --system --group netbox
Adding system user `netbox' (UID 119) ...
Adding new group `netbox' (GID 123) ...
Adding new user `netbox' (UID 119) with group `netbox' ...
Creating home directory `/home/netbox' ...

# Phân quyền
chown --recursive netbox /opt/netbox
chown --recursive netbox /opt/netbox/netbox/media/
sudo chown --recursive netbox /opt/netbox/netbox/reports/
sudo chown --recursive netbox /opt/netbox/netbox/scripts/
```
Tạo file config:
```
cd /opt/netbox/netbox/netbox/netbox/
cp configuration.example.py configuration.py
```
Tạo khóa:   
```
python3 ../generate_secret_key.py

Ju(-)OV2%xBghQ=&%adtqi#gpW*c5uqwN-#dEg4k(k60zl2RJ*
```
Sửa file cấu hình:
```
# Khai báo địa chỉ IP hoặc domain mà bạn có thể dùng để truy cập vào netbox
ALLOWED_HOST = ['172.16.66.82']

# Khai báo thông tin database
DATABASE = {
    'ENGINE': 'django.db.backends.postgresql',  # Database engine
    'NAME': 'netbox',         # Database name
    'USER': 'netbox',               # PostgreSQL username
    'PASSWORD': 'Suncloud@2024!',           # PostgreSQL password
    'HOST': 'localhost',      # Database server
    'PORT': '',               # Database port (leave blank for default)
    'CONN_MAX_AGE': 300,      # Max database connection age
}

# Phần Redis bạn có thể giữ nguyên như mặc định
REDIS = {
    'tasks': {
        'HOST': 'localhost',
        'PORT': 6379,
        'USERNAME': '',
        'PASSWORD': '',
        'DATABASE': 0,
        'SSL': False,
    },
    'caching': {
        'HOST': 'localhost',
        'PORT': 6379,
        'USERNAME': '',
        'PASSWORD': '',
        'DATABASE': 1,
        'SSL': False,
    }
}

SECRET_KEY = 'Nhập vào Secret key mà bạn vừa tạo ở trên' 
```
Sau khi cấu hình hoàn tất, save file và thực hiện cài đặt NetBox với câu lệnh sau:
```
/opt/netbox/upgrade.sh
```
Tiếp theo, khởi động môi trường ảo NetBox
```
source /opt/netbox/venv/bin/active
```
Sau đó, tạo một siêu người dùng:
```
cd /opt/netbox/netbox

python3 manage.py createsuperuser
```
Tạo theo mẫu như sau:
```
Username (leave blank to use 'root'): nadmin
Email address: admin@example.com
Password: Suncloud@2024!
Password (again): 
Superuser created successfully.
```
Cuối cùng tạo một đường liên kết
```
ln -s /opt/netbox/contrib/netbox-housekeeping.sh /etc/cron.daily/netbox-housekeeping
```

Tiến hành chạy thử NetBox Server
```
python3 manage.py runserver 0.0.0.0:8000 --insecure
```
Kết quả đầu ra
```
(venv) root@MANH-U22-client:/opt/netbox/netbox# python3 manage.py runserver 0.0.0.0:8000 --insecure
Performing system checks...

System check identified no issues (0 silenced).
June 13, 2024 - 09:36:27
Django version 4.2.11, using settings 'netbox.settings'
Starting development server at http://0.0.0.0:8000/
Quit the server with CONTROL-C.
```
Kết quả truy cập trang web(Lưu ý bật mở port):

![](/Anh/Screenshot_718.png)

Để NetBox có thể sử dụng systemctl như các service khác:
```
cp /opt/netbox/contrib/gunicorn.py /opt/netbox/gunicorn.py
cp -v /opt/netbox/contrib/*.service /etc/systemd/system/
systemctl daemon-reload
systemctl start netbox netbox-rq
systemctl enable netbox netbox-rq
```
Kiểm tra lại với câu lệnh sau:
```
systemctl status netbox.service
```

### Cài đặt Nginx cấu hình làm Reverse Proxy
Cài đặt nginx
```
sudo apt install -y nginx
```
Chỉnh sửa file cấu hình chính của nginx
```
# Truy cập vào file cấu hình
vim /etc/nginx/nginx.conf

# Thêm vào sau dòng http{:
server_name_hash_bucket_size 64;
```

Sau đó tạo 1 virtual host với nginx
```
# Truy cập tạo file cấu hình
vim /etc/nginx/conf.d/netbox.conf

# Thêm vào nội dung sau:
server {

  listen         80;
  server_name    netbox.test.com;
  access_log                /var/log/nginx/netbox.access.log;
  error_log                 /var/log/nginx/netbox.error.log;

  client_max_body_size 25m;

  # Proxy everything over to the netbox server
  location /static/ {
    alias /opt/netbox/netbox/static/;
  }

  location / {
    proxy_set_header        X-Real-IP $remote_addr;
    proxy_set_header        X-Forwarded-Proto $scheme;
    proxy_set_header	    X-Forwarded-Host $http_host;
    proxy_pass              http://127.0.0.1:8001;
  }
}
```



