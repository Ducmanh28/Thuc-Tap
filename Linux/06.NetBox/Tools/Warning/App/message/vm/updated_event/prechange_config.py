from config import nb

def prechange_config(prechange_data):
    site_id = prechange_data.get("site", {})
    if site_id:
        site = nb.dcim.sites.get(site_id)
        site_name = site.name
    else:
        site_name = "No site yet!"
    primary_ip4_id = prechange_data.get("primary_ip4")
    if not primary_ip4_id:
        primary_ip4_name = "No Ip yet!"
    else:
        primary_ip4 = nb.ipam.ip_addresses.get(primary_ip4_id)
        primary_ip4_name = primary_ip4.address
    vm_name = prechange_data.get("name",{})
    vm_cluster_id = prechange_data.get("cluster",{})
    if vm_cluster_id:
        vm_cluster = nb.virtualization.clusters.get(vm_cluster_id)
        vm_cluster_name = vm_cluster.name
    else:
        vm_cluster_name = "No cluster"
    vm_device_id = prechange_data.get("device",{})
    if vm_device_id:
        vm_device = nb.dcim.devices.get(vm_device_id)
        vm_device_name = vm_device.name
    else:
        vm_device_name = "No device"
    vm_platform_id = prechange_data.get("platform",{})
    if vm_platform_id:
        vm_platform = nb.dcim.platforms.get(vm_platform_id)
        vm_platform_name = vm_platform.name
    else:
        vm_platform_name = "No Platform"
    vm_cpu = prechange_data.get("vcpus",{})
    vm_memory = prechange_data.get("memory",{})
    vm_disk = prechange_data.get("disk",{})
    vm_des = prechange_data.get("description",{})
    vm_comments = prechange_data.get("comments",{})
    data = {
        "Site": site_name,
        "VM Name": vm_name,
        "VM Ip": primary_ip4_name,
        "Platform": vm_platform_name,
        "VM Device": vm_device_name,
        "VM Cluster": vm_cluster_name,
        "VM CPU": vm_cpu,
        "VM Memory": vm_memory,
        "VM Disk": vm_disk,
        "Comments": vm_comments,
        "Description": vm_des
    }
    return data