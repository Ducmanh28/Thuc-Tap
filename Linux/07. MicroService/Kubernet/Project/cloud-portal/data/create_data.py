import pynetbox

# --- CẤU HÌNH ---
NETBOX_URL = 'http://172.16.66.82:32080'
NETBOX_TOKEN = 'QhIDezWLjK6pVB5e1D9KHfpP87EGulGxS1qOX7nS'

nb = pynetbox.api(url=NETBOX_URL, token=NETBOX_TOKEN)

# Quy hoạch dải IP Data cho VM theo Site
VM_NETWORK_PLAN = {
    'ha-noi': '10.10.20',      # Lớp mạng HN-DATA
    'ho-chi-minh': '10.20.20', # Lớp mạng HCM-DATA
    'thanh-hoa': '10.30.20'    # Lớp mạng TH-DATA
}

def get_or_create_interface(vm_id, name):
    """Đảm bảo VM luôn có interface trước khi gán IP"""
    interface = nb.virtualization.interfaces.get(virtual_machine_id=vm_id, name=name)
    if not interface:
        interface = nb.virtualization.interfaces.create(
            virtual_machine=vm_id,
            name=name,
            enabled=True
        )
        print(f"    [+] Đã tạo Interface {name} cho VM ID: {vm_id}")
    return interface

try:
    print("🚀 Bắt đầu tiến trình gán IP cho Virtual Machines...")

    for site_slug, ip_prefix in VM_NETWORK_PLAN.items():
        site = nb.dcim.sites.get(slug=site_slug)
        if not site:
            continue

        print(f"\n📍 Xử lý VM tại Site: {site.name}")
        
        # Lấy danh sách VM thuộc Site này thông qua Cluster
        vms = nb.virtualization.virtual_machines.filter(site_id=site.id)
        
        if not vms:
            print(f"  ⚠️ Không tìm thấy VM nào tại site {site.name}")
            continue

        for idx, vm in enumerate(vms, start=101): # IP bắt đầu từ .101
            # 1. Đảm bảo có Interface eth0
            interface = get_or_create_interface(vm.id, 'eth0')
            
            # 2. Tạo IP Address
            ip_val = f"{ip_prefix}.{idx}/24"
            
            # Kiểm tra xem IP này đã tồn tại chưa để tránh lỗi Duplicate
            ip_obj = nb.ipam.ip_addresses.get(address=ip_val)
            if not ip_obj:
                ip_obj = nb.ipam.ip_addresses.create(
                    address=ip_val,
                    status='active',
                    assigned_object_type='virtualization.vminterface',
                    assigned_object_id=interface.id,
                    tenant=vm.tenant.id if vm.tenant else None
                )
            else:
                # Nếu IP đã tồn tại nhưng chưa gán vào interface này thì cập nhật
                if getattr(ip_obj, 'assigned_object_id', None) != interface.id:
                    ip_obj.update({
                        'assigned_object_type': 'virtualization.vminterface',
                        'assigned_object_id': interface.id
                    })

            # 3. Gán làm Primary IPv4 cho VM
            if not vm.primary_ip4 or vm.primary_ip4.id != ip_obj.id:
                vm.update({'primary_ip4': ip_obj.id})
                print(f"  ✅ VM {vm.name.ljust(20)} -> Primary IP: {ip_val}")
            else:
                print(f"  ℹ️ VM {vm.name.ljust(20)} đã có IP {ip_val}")

    print("\n✅ Hoàn tất gán IP cho toàn bộ Virtual Machines!")

except Exception as e:
    print(f"❌ Lỗi: {e}")