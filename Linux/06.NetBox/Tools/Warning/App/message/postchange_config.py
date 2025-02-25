from config import nb

def postchange_config(postchange_data):
    description = postchange_data.get('description', {})
    comments = postchange_data.get('comments', {})
    site_id = postchange_data.get("site", {})
    site = nb.dcim.sites.get(site_id)
    site_name = site.name
    device_type_id = postchange_data.get('device_type', {})
    device_type = nb.dcim.device_types.get(device_type_id)
    device_type_name = device_type.model
    device_role_id = postchange_data.get('role', {})
    device_role = nb.dcim.device_roles.get(device_role_id)
    device_role_name = device_role
    device_name = postchange_data.get("name", {})
    rack_id = postchange_data.get("rack", {})
    if not rack_id:
        rack_name = "Unknow rack"
        position = "Unknow position"
    else:
        rack = nb.dcim.racks.get(rack_id)
        rack_name = rack.name
        position = postchange_data.get("position")
    primary_ip4_id = postchange_data.get("primary_ip4")
    if not primary_ip4_id:
        primary_ip4_name = "No Ip yet!"
    else:
        primary_ip4 = nb.ipam.ip_addresses.get(primary_ip4_id)
        primary_ip4_name = primary_ip4.address
    customfields = postchange_data.get("custom_fields")
    contact_id = customfields.get("contact")
    if contact_id:
        contact = nb.tenancy.contacts.get(contact_id)
        contact_name = contact.name
    else:
        contact_name = "No contact!"
    data = {
        "Description": description,
        "Comments": comments,
        "Site": site_name,
        "Device Type": device_type_name,
        "Device Role": device_role_name,
        "Device Name": device_name,
        "Rack": rack_name,
        "Position": position,
        "Ipv4": primary_ip4_name,
        "Contact": contact_name
    }
    
    return data