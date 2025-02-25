from utils import format_timestamp
from message.vm.updated_event.detail import detail_config

def updated_event_vm(webhook_data):
    event = webhook_data.get("event", {})
    timestamp = webhook_data.get("timestamp", {})
    time = format_timestamp(timestamp)
    username = webhook_data.get("username", {})
    object = webhook_data.get("model", {})
    
    vm_data = webhook_data.get("data", {})
    vm_name = vm_data.get("name", {})
    vm_site = vm_data.get("site", {})
    if vm_site:
        vm_site_name = vm_site.get("name")
    else:
        vm_site_name = "No site yet!"
    vm_ip = vm_data.get("primary_ip4",{})
    if vm_ip:
        vm_ip_addr = vm_ip.get("address",{})
    else:
        vm_ip_addr = "No IP yet!"
    snapshots = webhook_data.get("snapshots", {})
    prechange = snapshots.get("prechange", {})
    postchange = snapshots.get("postchange", {})
    detail = detail_config(prechange,postchange)
    
    msg = (
        f"*Event:* {event}\n"
        f"*Object Type:* {object}\n"
        f"*Object Name:* {vm_name}\n"
        f"*Object IP:* {vm_ip_addr}\n"
        f"*Site:* {vm_site_name}\n"
        f"*Edit By:* {username}\n"
        f"*Time:* {time}UTC\n"
        f" \n"
    )
    msg += detail
    return msg