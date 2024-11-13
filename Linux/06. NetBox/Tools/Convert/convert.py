import pandas as pd

# Đọc toàn bộ dữ liệu từ sheet
file_path = 'D:/test.xlsx'
data = pd.read_excel(file_path, sheet_name='AI61')  # Thay 'Sheet1' bằng tên sheet nếu khác

# Định nghĩa các cột cho file CSV đầu ra
columns = ['role', 'manufacturer', 'device_type', 'status', 'site', 'name', 'tenant', 'platform', 'serial', 'rack', 'position', 'face']

# Chuẩn bị DataFrame đầu ra
output_data = pd.DataFrame(columns=columns)

# Xử lý từng dòng trong dữ liệu thiết bị (lọc theo cột có dữ liệu về tên thiết bị)
for index, row in data.iterrows():
    # Chỉ xử lý nếu có dữ liệu tên thiết bị
    device_name = row.get('K')  # Cột 'K' chứa tên thiết bị trong dữ liệu chính

    if pd.notna(device_name):  # Kiểm tra nếu có tên thiết bị (không phải NaN)
        # Tìm vị trí của thiết bị trong phần bản vẽ rack
        position = ''
        for r_index, r_row in data.iterrows():
            if r_row.get('C') == device_name:  # Cột 'C' chứa tên thiết bị trong bản vẽ rack
                position = r_row.get('B')  # Cột 'B' chứa vị trí của thiết bị trên rack

        # Ánh xạ các cột đầu vào sang cột đầu ra
        new_row = {
            'role': row.get('F', ''),          # Cột 'F' chứa vai trò của thiết bị
            'manufacturer': row.get('G', ''),  # Cột 'G' chứa nhà sản xuất
            'device_type': row.get('H', ''),   # Cột 'H' chứa loại thiết bị
            'status': row.get('I', ''),        # Cột 'I' chứa trạng thái
            'site': row.get('J', ''),          # Cột 'J' chứa site
            'name': device_name,
            'tenant': row.get('L', ''),        # Cột 'L' chứa tenant
            'platform': row.get('M', ''),      # Cột 'M' chứa platform
            'serial': row.get('N', ''),        # Cột 'N' chứa serial
            'rack': 'Rack 01',                 # Giả sử tất cả thiết bị nằm trong Rack 01
            'position': position,
            'face': row.get('O', '')           # Cột 'O' chứa thông tin mặt (front/back)
        }
        output_data = output_data.append(new_row, ignore_index=True)

# Lưu dữ liệu vào file CSV
output_file = 'D:/test.csv'
output_data.to_csv(output_file, index=False)

print(f"File CSV đã được tạo tại {output_file}")
