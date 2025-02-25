def created_event(webhook_data):
    event = webhook_data.get("event", {})
    timestamp = webhook_data.get("timestamp", {})
    time = format_timestamp(timestamp)
    username = webhook_data.get("username", {})
    model = webhook_data.get("model", {})
    
    device_data = webhook_data.get("data", {})
    device_id = device_data.get("id", {})
    device_name = device_data.get("name", {})
    device_site = device_data.get("site", {}).get("name", {})
    device_rack = device_data.get("rack", {})
    if device_rack:
        device_rack_name = device_rack.get("name",{})
    else:
        device_rack_name = "Not in any rack"
    device_positon = device_data.get("position")
    device_tenant = device_data.get("tenant",{})
    device_serial = device_data.get("serial",{})
    if device_tenant:
        device_tenant_name = device_tenant.get("name")
    else:
        device_tenant_name = "No Tenant yet!"
    device_location = device_data.get("location")
    if device_location:
        device_location_name = device_location.get("name")
    else:
        device_location_name = "No Location!"
    device_info = nb.dcim.devices.get(id=device_id)

    device_role = device_info.role.name
    device_type = device_info.device_type.model
    device_des = device_data.get("description",{})
    device_comments = device_data.get("comments")
    custom_fields = device_data.get("custom_fields")
    device_owner = custom_fields.get("device_owner",{})
    contact = custom_fields.get("contact")
    if contact:
        contact_name = contact.get("name")
    else:
        contact_name = "No contact!"
    msg = (
        f"*Event: *{event} \n"
        f"*Object Type:* {model}\n"
        f"*Created by:* {username}\n"
        f"*At: *{time}UTC\n"
        f" \n"
        f"*Detail*\n"
        f"*Device Name:* {device_name}\n"
        f"*Device Role*: {device_role}\n"
        f"*Device Type*: {device_type}\n"
        f"*Device Serial:* {device_serial}\n"
        f"*Device Owner:* {device_owner}\n"
        f"*Tenant:* {device_tenant_name}\n"
        f"*Site:* {device_site}\n"
        f"*Location:* {device_location_name}\n"
        f"*Rack:* {device_rack_name}\n"
        f"*Position:* {device_positon}\n"
        f"*Contact:* {contact_name}\n"
        f"*Description:* {device_des}\n"
        f"*Comment:* {device_comments}\n"
    )
    return msg