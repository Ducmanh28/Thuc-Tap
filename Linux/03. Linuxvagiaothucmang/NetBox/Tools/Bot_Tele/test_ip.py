import re

def check_ip(ip):
    # Kiểm tra định dạng địa chỉ IP
    pattern = r'^([0-9]{1,3}\.){3}[0-9]{1,3}$'
    
    if re.match(pattern, ip):
        # Tách các octet
        octets = ip.split('.')
        
        # Kiểm tra từng octet
        for octet in octets:
            if int(octet) > 255:
                return False  # Nếu một octet lớn hơn 255
        return True  # Nếu tất cả các octet hợp lệ
    else:
        return False  # Nếu định dạng không đúng

# Sử dụng hàm
ip_address = input("Nhập địa chỉ IP để kiểm tra: ")
is_valid = check_ip(ip_address)

if is_valid:
    print(f"Địa chỉ IP {ip_address} hợp lệ.")
else:
    print(f"Địa chỉ IP {ip_address} không hợp lệ.")
