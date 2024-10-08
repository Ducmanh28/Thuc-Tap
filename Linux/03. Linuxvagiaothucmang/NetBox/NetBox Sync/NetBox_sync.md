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