import pandas as pd

# Đọc toàn bộ dữ liệu từ sheet
file_path = 'D:/test.xlsx'
data = pd.read_excel(file_path, sheet_name='AI61')  # Thay 'AI61' bằng tên sheet thực tế của bạn nếu khác

# Định nghĩa các cột cho file CSV đầu ra
columns = ['role', 'manufacturer', 'device_type', 'status', 'site', 'name', 'tenant', 'platform', 'serial', 'rack', 'position', 'face']

# Chuẩn bị DataFrame đầu ra
output_data = pd.DataFrame(columns=columns)

# Xử lý từng dòng trong dữ liệu thiết bị
for index, row in data.iterrows():
    # Lấy tên thiết bị từ cột có chứa tên (thay thế 'Tên thiết bị' bằng tên thực của cột)
    device_name = row.get('Name')  # Đổi 'name_column' sang tên cột chứa tên thiết bị

    if pd.notna(device_name):  # Kiểm tra nếu có tên thiết bị
        # Tìm vị trí của thiết bị trong phần bản vẽ rack
        rack_row = data.loc[data['Rack 01'] == device_name]  # Đổi 'device_name_column' thành cột chứa tên trong bản vẽ rack

        # Nếu tìm thấy thiết bị trong bản vẽ rack
        if not rack_row.empty:
            position = rack_row.iloc[0]['Position']  # Đổi 'position_column' thành tên cột chứa vị trí trong bản vẽ rack
        else:
            position = ''

        # Ánh xạ các cột đầu vào sang cột đầu ra
        new_row = {
            'role': row.get('Device Roles', ''),          
            'manufacturer': row.get('Manufacturers', ''),  
            'device_type': row.get('Device Types', ''),   
            'status': row.get('Status', ''),        
            'site': row.get('Site', ''),          
            'name': device_name,
            'tenant': row.get('Tenant', ''),       
            'platform': row.get('Platform', ''),      
            'serial': row.get('Serial', ''),        
            'rack': 'Rack 01',                 
            'position': position,
            'face': row.get('Face', '')           
        }
        output_data = output_data.append(new_row, ignore_index=True)

# Lưu dữ liệu vào file CSV
output_file = 'D:/test.csv'
output_data.to_csv(output_file, index=False, encoding='utf-8-sig')

print(f"File CSV đã được tạo tại {output_file}")
