# Mục này sẽ thực hành đóng gói và triển khai 1 trang web sử dụng Docker
Mô tả công việc: 

- 1 trang web có:
  - Backend(Python)
  - Frontend(Jvs,Css kèm các file hình ảnh)
  - Cơ sở dữ liệu(Mysql)
  - WebServer(Nginx)
  - Trang web có 2 Link:
    - 1 Link Backend 
    - 1 Link Frontend 
- Triển khai trên 1 máy chủ chưa có gì, dữ liệu sẽ được lấy từ GitHub 
- Yêu cầu:
  - Cấu hình 2 Link trang web lấy chứng chỉ ssl local, cấu hình tên miền `booking.local` và `api.booking.local`
  - Đóng gói và triển khai bằng Docker
  - Trang web phải có đầy đủ nội dung 

# Thực hành
## Chuẩn bị môi trường
Do việc triển khai trên 1 máy chủ hoàn toàn mới, chưa có data gì, vậy nên trước tiên chúng ta cần chuẩn bị môi trường để đóng gói ứng dụng
```
# Cập nhật hệ thống
sudo apt update && sudo apt upgrade -y

# Cài đặt các mục thủ công 
sudo apt install -y git docker.io docker-compose python3 python3-pip mysql-server 

# Kéo dữ liệu từ Git về
git clone https://github.com/Ducmanh28/A41488.git
mv A41488/CNPM/Hotel_Booking_App /home
cd --
rm -rf A41488
```
Sau các bước trên, chúng ta đã có đầy đủ những mục cần cài đặt thủ công trên máy chủ
## Cấu hình MySQL
Để tối ưu cho việc cập nhật dữ liệu và phát triển mở rộng trong tương lai, tôi đã tách riêng MySQL ra khỏi Docker, vậy nên bây giờ chúng ta sẽ thực hiện cấu hình dữ liệu
```
#Truy cập vào mysql
mysql

# Khởi tạo User
CREATE USER 'admin'@'%' IDENTIFIED BY '28072003';

# Cấp quyền
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;

# Áp dụng thay đổi
FLUSH PRIVILEGES;

# Khởi tạo Database
CREATE DATABASE hotel_booking;
```
Sau khi khởi tạo user và database, chúng ta thực hiện đổ dữ liệu vào database
```
sudo mysql -u admin -p hotel_booking < Database/hba_backup.sql
```
Vậy là chúng ta đã cấu hình xong dữ liệu
## Khởi tạo file `.env`
Mặc định trên git đã có 1 file `.env(sample)`, bạn cần chỉnh lại file này sao cho phù hợp với thiết bị của bạn
```
DB_HOST=host.docker.internal
DB_USER=(your mysql user)
DB_PASSWORD=(your mysql password)
DB_NAME=(your name of database)
JWT_SECRET_KEY=(your jwt_secret_key)
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=465
SENDER_EMAIL=(your sender email)
APP_PASSWORD=(your app password)
URL=(your server url)
API_KEY=(your api_key)
IP=(your ip server)
API_URL=(your api url)
```
Trên đây là mẫu để các bạn có thể khởi tạo file `.env` của riêng bạn

Lưu ý rằng phần **DB_HOST** bắt buộc phải để như trên để docker có thể kết nối tới MySQL
## Chỉnh sửa 1 số nội dung trong đoạn code
Chỉnh sửa trong file `main.py`
```
vim /home/Hotel_Booking_App/main.py 
```
Sửa lại thành như sau:
```
app.run(host="your IP Server", port=5000, debug=True)
```
## Tạo chứng chỉ SSL cho trang web
Để tạo được chứng chỉ SSL cho trang web, vui lòng tham khảo tại đây!
Sau khi làm xong, giả sử chúng ta đã có 2 file như sau:
- `/etc/ssl/private/bookinglocal.key`
- `/etc/ssl/certs/bookinglocal.crt`

## Triển khai với Docker
Chúng ta sẽ cần có các file như sau:
- `Dockerfile.frontend`: File này chứa cấu hình cho frontend
- `Dockerfile.backend`: File này chứa cấu hình cho backend
- `frontend.conf`: File này chỉnh sửa 1 số nội dung liên quan đến nginx cho frontend
- `nginx-gateway/nginx.conf`: File này chứa cấu hình nginx của web
- `docker-compose`: File này là cấu hình chung, kịch bản khởi chạy

### Dockerfile.frontend
Nội dung file sẽ trông như sau:
```
FROM nginx:alpine   #Sử dụng nginx
RUN rm /etc/nginx/conf.d/default.conf   #Xóa file cấu hình mặc định nginx
COPY frontend.conf /etc/nginx/conf.d/default.conf    #COPY cấu hình từ file frontend.conf sang default.conf
COPY font /usr/share/nginx/html    #COPY nội dung từ font sang html
EXPOSE 80     
```
### Dockerfile.backend
Nội dung file sẽ trông như sau:
```
FROM python:3.11-slim   #Sử dụng phiên bản Python 3.11
WORKDIR /app            # Chỉ định thư mục làm việc
RUN apt-get update && apt-get install -y default-libmysqlclient-dev build-essential
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt #Tải các mục trong file
COPY . .
CMD ["python", "main.py"] # Chạy main.py
```
### frontend.conf
Nội dung cấu hình như sau:
```
server{
  listen 80;      # Lắng nghe trên cổng 80
  location / {
    root /usr/share/nginx/html;   # Thư mục chứa các file
    index home.html               # File mặc định là home.html
    try_files $uri $uri/ /home.html;
  }
}
```
### nginx-gateway/nginx.conf
Nội dung cấu hình như sau:
```
events {}
http {
    include /etc/nginx/mime.types;
    server {
        listen 443 ssl;
        server_name booking.local;
        ssl_certificate /etc/ssl/certs/bookinglocal.crt;
        ssl_certificate_key /etc/ssl/private/bookinglocal.key;
        location / {
            proxy_pass http://frontend:80;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
    }
    server {
        listen 443 ssl;
        server_name api.booking.local;
        ssl_certificate /etc/ssl/certs/bookinglocal.crt;
        ssl_certificate_key /etc/ssl/private/bookinglocal.key;
        location / {
            proxy_pass http://backend:5000;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
    }
}
```
### docker-compose.yml
Nội dung sẽ trông như sau:
```
version: '3.8'
services:
  backend:
    build:
      context: .
      dockerfile: Dockerfile.backend
    container_name: hotel_backend
    extra_hosts: 
      - "host.docker.internal:host-gateway"
    enviroment:
      - DB_HOST: host.docker.internal
      - DB_USER: your_db_user
      - DB_PASSWORD: your_db_password
      - DB_NAME: your_db_name
    networks:
      - hotel_net
  frontend:
    build:
      context: .
      dockerfile: Dockerfile.frontend
    container_name: hotel_frontend
    networks: 
      - hotel_net
  nginx:
    image: nginx:alpine
    container_name: hotel_gateway
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx-gateway/nginx.conf:/etc/nginx/nginx.conf
      - /etc/ssl/certs/bookinglocal.crt:/etc/ssl/certs/booking.crt:ro
      - /etc/ssl/private/bookinglocal.key:/etc/ssl/private/bookinglocal.key:ro
    depends_on:
      - backend
      - frontend
    networks:
      - hotel_net
networks:
  hotel_net:
    driver: bridge
```
### Triển khai
Sau khi đã hoàn thành các file trên, triển khai với câu lệnh sau:
```
docker-compose up -d --build
```
Sau đó có thể kiểm tra với câu lệnh
```
docker ps -a
```
Nếu tất cả hiện `STATE` là **UP** thì đã hoàn thành
## Kết quả
Cuối cùng khi đã hoàn thành bạn sẽ được kết quả như hình dưới
![](/Anh/Screenshot_108.png)