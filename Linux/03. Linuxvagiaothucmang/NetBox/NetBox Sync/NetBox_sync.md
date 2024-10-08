# Mục này tìm hiểu về NetBox Sync
## NetBox Sync là gì?
Dịch ra theo tiếng Việt có nghĩa là Đồng bộ NetBox. Đúng như cái tên của nó, NetBox Sync là một tool được sử dụng để đồng bộ dữ liệu giữa NetBox và các nguồn dữ liệu khác.

Các loại nguồn có thể sử dụng:
- Máy chủ VMware vCenter
- Các Inventory file của Red_fish


## Nguyên tắc 
NetBox documents đã chỉ ra rõ rằng công cụ này hoạt động như một "Source of Truth". Vì vậy mà việc thêm tự động dữ liệu thông qua Internet là điều không được khuyến khích. 

Mặc dù đây là logic hợp lý, tuy nhiên Raymond Beaudoin và đội ngũ phát triển của anh ấy vẫn nhắm đến việc cung cấp 1 nền tảng trung gian, làm giải pháp cho những người mong muốn chức năng nhập tự động

Tất cả những đối tượng được lấy từ vCenter đều có "vòng đời". Khi nhập dữ liệu, đối với các kiểu đối tượng được hỗ trợ thì họ sẽ gắn thẻ để lưu ý nguồn gốc và phân biệt với các đối tượng khác

## Cài đặt trên Ubuntu 
### Yêu cầu
Phần mềm:
- python >= 3.6
- packaging
- urllib3==1.26.9
- wheel
- requests==2.27.1
- pyvmomi==7.0.3
- aiodns==2.0.0
- setuptools>=62.00.0
- pyyaml==6.0

Môi trường:
- NetBox >= 2.9

Nguồn VMWare(nếu sử dụng):
- VMWare vCenter >= 6.0

Nguồn check_redfish(nếu sử dụng):
- check_redfish >= 1.2.0

### Cài đặt 
Trước tiên, hãy cập nhật hệ thống của bạn lên giao diện mới nhất. Để đảm bảo tool hoạt đon=ọng chính xác nhất
```
sudo apt upgrade

sudo apt update
```
Cài đặt Python
```
# Cài đặt ngôn ngữ
apt install python3-dev

# Cài đặt môi trường
apt install python3-venv
```
Clone repo về và cài đặt các yêu cầu cần thiết. Hãy làm việc này ở `/opt`
```
# Di chuyển vào /opt
cd /opt

# Clone repo về
git clone https://github.com/bb-Ricardo/netbox-sync.git

# Di chuyển vào thư mục netbox-sync
cd netbox-sync

# Thiết lập môi trường ảo
python3 -m venv .venv
. .venv/bin/activate

# Cài đặt các yêu cầu
pip3 install --upgrade pip || pip install --upgrade pip
pip3 install wheel || pip install wheel
pip3 install -r requirements.txt || pip install -r requirements.txt
```
Chúng ta sẽ cần thêm ***vsphere-automation-sdk*** để có thể thao tác với VMWare với câu lệnh chuẩn
```
pip install --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git
```
Cài đặt các gói mà môi trường Python cần để chạy NetBox-Sync
```
pip install packaging urllib3==1.26.9 wheel requests==2.27.1 pyvmomi==7.0.3 aiodns==2.0.0 setuptools>=62.00.0 pyyaml==6.0

pip install check_redfish>=1.2.0

pip3 install packaging
```
Tiếp đến, chúng ta lấy API Token của NetBox(Lưu ý rằng token của user này cần có mọi quyền như Admin)

Khởi chạy
```
usage: netbox-sync.py [-h] [-c settings.ini [settings.ini ...]] [-g]
                      [-l {DEBUG3,DEBUG2,DEBUG,INFO,WARNING,ERROR}] [-n] [-p]

Sync objects from various sources to NetBox

Version: 1.6.1 (2024-05-14)
Project URL: https://github.com/bb-ricardo/netbox-sync

options:
  -h, --help            show this help message and exit
  -c settings.ini [settings.ini ...], --config settings.ini [settings.ini ...]
                        points to the config file to read config data from
                        which is not installed under the default path
                        './settings.ini'
  -g, --generate_config
                        generates default config file.
  -l {DEBUG3,DEBUG2,DEBUG,INFO,WARNING,ERROR}, --log_level {DEBUG3,DEBUG2,DEBUG,INFO,WARNING,ERROR}
                        set log level (overrides config)
  -n, --dry_run         Operate as usual but don't change anything in NetBox.
                        Great if you want to test and see what would be
                        changed.
  -p, --purge           Remove (almost) all synced objects which were create
                        by this script. This is helpful if you want to start
                        fresh or stop using this script.
```
Ở trên chính là hướng dẫn để khởi chạy netbox-sync. Để chạy được chương trình, chúng ta cần tạo 1 file cấu hình cho nó.
```
# Truy cập tới thư mục chứa netbox-sync, tạo file cấu hình
vim /opt/netbox-sync/vcenter-addc-local.ini

# Thêm vào nội dung sau:
[common]
log_level = DEBUG2
[netbox]
api_token = **********
host_fqdn = 172.16.66.83        
port = 443
disable_tls = False
validate_tls_certs = False
prune_enabled = True
prune_delay_in_days = 0
[source/vcenter-name]
type = vmware
host_fqdn = 123.456.789.101
username = username
password = password
permitted_subnets = 172.16.66.0/24
[source/my-redfish-example]
type = check_redfish
inventory_file_path = /opt/netbox-sync/check_redfish
permitted_subnets = 172.16.66.0/24
```
Giải thích:
- api_token = là api token của netbox
- host_fqdn = IP của Netbox Server
- port = Ta có thể thay đổi port ứng với port mà Netbox sử dụng
- disable_tls : Do netbox của mình dùng https nên ko cần tsl
- validate_tls_certs: Nó tương tự option -k trong lệnh curl vậy
- prune_enabled: Cho phép xóa máy ảo không tồn tại
- prune_delay_in_days: Thời gian delay là 0 ngày, có thể thay đổi
- type = vmware : phân biệt vmware
- host_fqdn : tên miền hoặc IP kết nối đến vcenter
- username = Khai báo username đăng nhập vcenter
- password = Khai báo password đăng nhập vcenter
- permitted_subnets = 172.16.66.0/24: Ta khai báo dòng này để khi sync các máy ảo sẽ hiển thị được các địa chỉ IP trùng với dải mạng này
- Phần check_redfish cũng tương tự

Sau khi tạo file cấu hình xong ta sẽ tiến hành chạy
```
cd /opt/netbox-sync
./netbox-sync.py -c vcenter-addc-local.ini
```
Bây giờ chúng ta chờ NetBox đồng bộ

![](/Anh/Screenshot_950.png)

Kiểm tra kết quả:

![](/Anh/Screenshot_951.png)

### Thêm
Như vậy là chúng ta đã hoàn tất đồng bộ dữ liệu vCenter vào NetBox bằng NetBox-sync

Tuy nhiên để quá trình này có thể diễn ra tự động thì ta có thể lập lịch chạy chương trình bằng `crontab`
```
crontab -e

1 * * * * /bin/bash -c 'source /opt/netbox-sync/.venv/bin/activate && /opt/netbox-sync/.venv/bin/python3 /opt/netbox-sync/netbox-sync.py -c /opt/netbox-sync/vcenter-addc-local.ini'
```

## Tài liệu tham khảo:
[Anh Quang](https://github.com/thanhquang99/Netbox/blob/main/Netbox-sync/02.install-nb-sync.md#23-c%E1%BA%A5u-tr%C3%BAc-ch%E1%BA%A1y-script-trong-netbox-sync)

[NetBox Sync](https://github.com/bb-Ricardo/netbox-sync/blob/main/README.md)