from utils import format_timestamp
def created_event_vm(webhook_data):
    event = webhook_data.get("event", {})
    timestamp = webhook_data.get("timestamp", {})
    time = format_timestamp(timestamp)
    username = webhook_data.get("username", {})
    model = webhook_data.get("model", {})
    
    vm_data = webhook_data.get("data", {})
    vm_name = vm_data.get("name",{})
    vm_site = vm_data.get("site", {})
    if vm_site:
        vm_site_name = vm_site.get("name",{})
    else:
        vm_site_name = "Not in any Site!"
    vm_cluster = vm_data.get("cluster",{})
    if vm_cluster:
        vm_cluster_name = vm_cluster.get("name",{})
    else:
        vm_cluster_name = "Not in any cluster!"
    vm_device = vm_data.get("device",{})
    if vm_device:
        vm_device_name = vm_device.get("name",{})
    else:
        vm_device_name = "Not assign on any Device!"
    vm_tenant = vm_data.get("tenant",{})
    if vm_tenant:
        vm_tenant_name = vm_tenant.get("name",{})
    else:
        vm_tenant_name = "Not belong to any Tenant!"
    vm_ip = vm_data.get("primary_ip4",{})
    if vm_ip:
        vm_ip_addr = vm_ip.get("address",{})
    else:
        vm_ip_addr = "Not have IP!!"
    vm_os = vm_data.get("platform",{})
    if vm_os:
        vm_os_name = vm_os.get("name",{})
    else:
        vm_os_name = "No OS yet!"
    vm_cpu = vm_data.get("vcpus",{})
    vm_ram = vm_data.get("memory",{})
    vm_disk = vm_data.get("disk",{})
    vm_des = vm_data.get("description",{})
    vm_com = vm_data.get("comments")
    msg = (
        f"*Event: *{event} \n"
        f"*Object Type:* {model}\n"
        f"*Created by:* {username}\n"
        f"*At: *{time}UTC\n"
        f" \n"
        f"*Detail*\n"
        f"*VM Name:* {vm_name}\n"
        f"*VM IP:* {vm_ip_addr}\n"
        f"*VM OS:* {vm_os_name}\n"
        f"*VM Size:* CPU-{vm_cpu}/RAM-{vm_ram}/DISK-{vm_disk} \n"
        f"*VM Description:* {vm_des}\n"
        f"*VM Comments:* {vm_com}\n"
        f"*VM Site:* {vm_site_name}\n"
        f"*VM Cluster:* {vm_cluster_name}\n"
        f"*VM Device:* {vm_device_name}\n"
        f"*VM Tenant:* {vm_tenant_name}\n"
    )
    return msg