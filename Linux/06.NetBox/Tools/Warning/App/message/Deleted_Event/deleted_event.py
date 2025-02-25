from utils import format_timestamp
def deleted_event(webhook_data):
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
        device_rack_new = device_rack.get("name",{})
    else:
        device_rack_new = "Not in any rack"
    device_positon = device_data.get("position")
    
    msg = (
        f"*Event:* {event}\n"
        f"*Object Type:* {object}\n"
        f"*Object Name:* {device_name}\n"
        f"*Site:* {device_site}\n"
        f"*Rack:* {device_rack_new}\n"
        f"*Position:* {device_positon}\n"
        f"*Removed By:* {username}\n"
        f"*Time:* {time}\n"
    )
    return msg