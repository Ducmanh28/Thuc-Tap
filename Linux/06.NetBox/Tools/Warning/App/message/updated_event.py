from utils import format_timestamp
from message.detail import detail_config

def updated_event(webhook_data):
    event = webhook_data.get("event", {})
    timestamp = webhook_data.get("timestamp", {})
    time = format_timestamp(timestamp)
    username = webhook_data.get("username", {})
    object = webhook_data.get("model", {})
    
    device_data = webhook_data.get("data", {})
    device_name = device_data.get("name", {})
    device_site = device_data.get("site", {}).get("name", {})
    device_rack = device_data.get("rack", {})
    if device_rack:
        device_rack_name = device_rack.get("name", {})
    else:
        device_rack_name = "Not in any Rack"
    device_positon = device_data.get("position")
    custom_fields = device_data.get("custom_fields",{})
    contact = custom_fields.get("contact",{})
    if contact:
        contact_name = contact.get("name",{})
    else:
        contact_name = "No contact yet!"
    snapshots = webhook_data.get("snapshots", {})
    prechange = snapshots.get("prechange", {})
    postchange = snapshots.get("postchange", {})
    detail = detail_config(prechange,postchange)
    
    msg = (
        f"*Event:* {event}\n"
        f"*Object Type:* {object}\n"
        f"*Object Name:* {device_name}\n"
        f"*Site:* {device_site}\n"
        f"*Rack:* {device_rack_name}\n"
        f"*Position:* {device_positon}\n"
        f"*Contact:* {contact_name} \n"
        f"*Edit By:* {username}\n"
        f"*Time:* {time}UTC\n"
        f" \n"
    )
    msg += detail
    return msg