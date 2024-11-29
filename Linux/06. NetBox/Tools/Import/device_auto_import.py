# Thêm các thư viện
import os
import pandas as pd
import pynetbox
import requests
import re
import urllib3
import config

# Gán các giá trị cơ bản
## Kết nối tới file của bạn
filepath = config.filepath
sheetname = config.sheetname

## Kết nối tới NetBox
NetBox_URL = config.NetBox_URL
NetBox_Token = config.NetBox_Token

# Kiểm tra sự tồn tại của file, nếu có thì đọc file
if os.path.exists(filepath):
    df = pd.read_excel(filepath, sheet_name=sheetname)
else:
    print(f"File '{filepath}' doesn't exist!")
    
# Kiểm tra kết nối tới NetBox
try:
    response = requests.get(
        NetBox_URL,
        headers={"Authorization": f"Token {NetBox_Token}"},
        timeout=20
    )
    if response.status_code == 200:
        nb = pynetbox.api(NetBox_URL, token=NetBox_Token)
        nb.http_session.verify = False                                      
        urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
    else:
        print(f"Connection Error: {response.status_code} - {response.reason}")
except requests.exceptions.RequestException as e:
    print(f"Error: Can't connect NetBox. More: {e}")
    

# Kiểm tra device-types đã có đầy đủ trên NetBox hay chưa?
## Lấy ra danh sách các device types từ file xlsx
device_types_in_file = df['Device Type'].dropna().drop_duplicates().tolist() 
## Khởi tạo mảng chứa
device_types_not_in_netbox = []
device_types_ids = []
for device_type in device_types_in_file:
    search_result = nb.dcim.device_types.filter(model=device_type)
    if not search_result:
        device_types_not_in_netbox.append(device_type)
    else:
        for data in search_result:
            device_types_ids.append(data.id)
        
## In ra danh sách
if device_types_not_in_netbox:
    print("Device Types not in NetBox:")
    print(device_types_not_in_netbox)

    ## Chọn cách mà bạn muốn làm với các device types chưa có trong NetBox
    print("\nWhat do you want to do with the device_types not in NetBox")
    print("1. Add manual and relaunch later!")
    print("2. Automatic add with sample value")

    choice = input("Enter your choice? (1 or 2): ")

    if choice == '1':
        print("\n Please Add Device Types manually!")
        exit()   
    elif choice == "2":
        print("You choose to Add Device Automatic with sample information")
        print("Trying to Add Automatic...")

        for device_type in device_types_not_in_netbox:
            try:
                # Lấy thông tin từ file xlsx
                matching_rows = df[df['Device Type'] == device_type]
                if matching_rows.empty:
                    print(f"Device type {device_type} not found in Excel. Skipping...")
                    continue
                row = matching_rows.iloc[0]
                manufacturer_name = row['Manufacturer'].strip()
                # Kiểm tra manufacturer tồn tại hoặc tạo mới
                # Kiểm tra xem manufacturer đã tồn tại trên NetBox chưa
                manufacturer_records = nb.dcim.manufacturers.filter(name=manufacturer_name)

                # Duyệt qua tất cả manufacturers trả về
                manufacturer = None
                for record in manufacturer_records:
                    manufacturer = record
                    break  # Lấy manufacturer đầu tiên tìm thấy

                if manufacturer:
                    print(f"Using existing manufacturer: {manufacturer.name} (ID: {manufacturer.id})")
                else:
                    # Tạo slug hợp lệ từ manufacturer_name
                    manufacturer_slug = re.sub(r'[^a-z0-9-]', '-', manufacturer_name.lower()).strip('-')

                    # Nếu không có manufacturer, tạo mới
                    manufacturer = nb.dcim.manufacturers.create(
                        name=manufacturer_name,
                        slug=manufacturer_slug  
                    )
                    print(f"Created new manufacturer: {manufacturer.name} (ID: {manufacturer.id})")

                # Tạo slug hợp lệ cho device type
                device_type_slug = re.sub(r'[^a-z0-9-]', '-', device_type.lower()).strip('-')

                # Thêm device type mới
                new_device_type = nb.dcim.device_types.create({
                    'model': device_type,
                    'slug': device_type_slug,
                    'manufacturer': manufacturer.id,
                    'u_height': 1,
                    'is_full_depth': 'yes',
                })
                
                print(f"Automatically added: {device_type}")
                device_types_ids.append(new_device_type.id)
            except Exception as e:
                print(f"Error while adding {device_type}: {e}, Data: {row.to_dict()}")
                exit()
else: 
    print("Device Types check complete!")
    
