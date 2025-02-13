# Hướng dẫn sử dụng Warning Tools
Cách cài đặt và sử dụng Warning Tools
## Yêu cầu cần có
- NetBox phiên bản `3.7` trở lên
  - Có cấu hình ***Event Rules***
  - Có cấu hình ***WebHooks***
- Server Linux (Ubuntu/CentOS)
  - Server có khả năng kết nối tới NetBox
  - Server này sẽ đóng vai trò làm nơi nhận data từ ***WebHooks***
  - Chương trình sẽ được chạy trên Server này

## Cài đặt
Tải xuống chương trình bằng câu lệnh sau:
- File `warning.py`
```
curl -O https://raw.githubusercontent.com/Ducmanh28/Thuc-Tap/refs/heads/main/Linux/06.NetBox/Tools/Warning/warning.py
```
- File `config.py`
```
https://raw.githubusercontent.com/Ducmanh28/Thuc-Tap/refs/heads/main/Linux/06.NetBox/Tools/Warning/config.py
```

## Cấu hình
### Cấu hình file `config`

Sẽ có 3 thông tin cần nhập vào:
- **Bot Token** - Mã Token bot Telegram của bạn
- **Chat ID** - Chat ID Telegram của bạn
- **Webhooks Port** - Cổng Port mà Webhooks của bạn đang lắng nghe

### Cấu hình WebHooks
Để cấu hình **WebHooks Local** trên NetBox, vui lòng tham khảo bài viết [này]() nếu bạn chưa biết!

Chỉnh sửa URL WebHooks trên NetBox của bạn thành như sau:
```
http://<ip>:<webhooks_ports>/webhooks
```
- Thay `<ip>`: Bằng địa chỉ IP của bạn
- Thay `<webhooks_ports>`: Bằng cổng webhooks của bạn
- Ví dụ: `http://172.16.66.82:5000/webhooks` là 1 URL đúng

### Cấu hình Event Rules
Chương trình hiện tại có thể làm việc với 2 loại Event
- **Create** - Tạo 1 device mới
- **Update** - Chỉnh sửa 1 device nào đó

### Cấu hình Server
Đảm bảo Server của bạn đáp ứng các yêu cầu sau
- Thiết lập môi trường ảo với python3:
```
python3 -m venv venv
source venv/bin/activate
```
- Cài đặt các mục cần thiết sử dụng `pip install`
```
pip install asyncio
pip install logging
pip install flask
pip install telegram
```
- Mở cổng webhooks(ví dụ cổng 5000)
```
# Nếu bạn dùng ufw
sudo ufw allow 5000/tcp

# Hoặc iptables
sudo iptables -A INPUT -p tcp --dport 5000 -j ACCEP

# Hay firewalld
sudo firewall-cmd --zone=public --add-port=5000/tcp --permanent
```
## Khởi chạy
Truy cập vào nơi lưu file code
```
python3 warning.py
```

