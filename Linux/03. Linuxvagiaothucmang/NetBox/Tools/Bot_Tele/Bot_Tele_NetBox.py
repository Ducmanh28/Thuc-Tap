# Importing
import logging
import re
import pynetbox
import urllib3
import config
from telegram import Update
from telegram.ext import ApplicationBuilder, ContextTypes, CommandHandler, MessageHandler, filters

# Log config
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)

# Set up connection to NetBox
nb = pynetbox.api(config.URLNETBOX,token=config.TOKENNETBOX)        # Connect to NetBox
nb.http_session.verify = False                                      # Turnoff SSL cert
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning) # Turnoff Warning SSL

# Function to check IP value
def check_ip(ip):
    # IP Address Format Test
    pattern = r'^([0-9]{1,3}\.){3}[0-9]{1,3}$'
    
    if re.match(pattern, ip):
        # Split Octet
        octets = ip.split('.')
        
        # Test octet
        for octet in octets:
            if int(octet) > 255:
                return False  # If value in octet > 255
        return True  # If all octet true
    else:
        return False  # If Format false

# Function to collect information of IP
def ip_information(ip_addr):
    is_valid = check_ip(ip_addr)
    if is_valid:
        try:
            ip_info = nb.ipam.ip_addresses.get(address=ip_addr)
            if ip_info:
                if ip_info.assigned_object_type == 'virtualization.vminterface':                # IF IP was assigned to an Virtual Machine
                    msg = (                                                                     # Make the message form        
                        f"The Information of IP: \n"
                        f"`-------------------------------------------`\n"
                        f"IP Address:      `{ip_info.address}` \n"
                        f"IP Status:       `{ip_info.status}` \n"
                        f"IP Description:  `{ip_info.description}` \n"
                        f"Assigned to *Interface*: `{ip_info.assigned_object.name}` of *Virtual Machine*: `{ip_info.assigned_object.virtual_machine.name}`\n"
                        f"`-------------------------------------------`\n"
                    )   
                    return msg
            
                elif ip_info.assigned_object_type == 'dcim.interface':                          # If IP was assigned to an Device
                    msg = (                                                                     # Make the message form
                        f"The Information of IP: \n"
                        f"`-------------------------------------------`\n"
                        f"IP Address:          `{ip_info.address}` \n"
                        f"IP Status:           `{ip_info.status}` \n"
                        f"IP Description:      `{ip_info.description}` \n"
                        f"Assigned to *Interface*: `{ip_info.assigned_object.name}` of *Device*: `{ip_info.assigned_object.device.name}` \n"
                        f"`-------------------------------------------`\n"
                    )
                    return msg
                else: 
                    return "Can't find any information of this IP"
            else:
                msg = "Can't find this IP in NetBox! Please check again!"
                return msg    
        except Exception as e:  
            return f"Error: {str(e)}"
    else:
        return "Wrong Ip, please check again!"
        
# Defind the message when user enter /ip
async def cmd_ip(update: Update, context: ContextTypes.DEFAULT_TYPE):       # Asynchronous def mean It can run asynchronously with other tasks without waiting for it to complete before continuing.
    ip_info = context.args                                                  # Set up value
    msg = ip_information(ip_info[0])                                        # Send message
    msg = msg.replace("_", "-")
    await update.message.reply_text(str(msg),parse_mode='Markdown')         # Form Markdown to message

# Function to collect information of Device
def device_information(device_name):
    try:
        device_info = nb.dcim.devices.filter(name__ic=device_name)
        if device_info:
            msg = 'The Information of Device: \n'
            for device in device_info:
                contact = device.custom_fields.get('contact')
                if contact:
                    contact_name = contact.get('name', 'No contact available')
                else:
                    contact_name = 'No contact available'
                detail = (
                        f"`----------------------------------------`\n"
                        f"*Device Name*:         `{device.name}`\n"
                        f"Device ID:            {device.id}\n"
                        f"Device model type:    {device.device_type.model}\n"
                        f"Device serial:        `{device.serial}`\n"
                        f"Tenant of Device:     `{device.tenant.name}`\n"
                        f"Device asset:         {device.asset_tag}\n"
                        f"Device site:          {device.site.name}\n"
                        f"Device rack:          `{device.rack.name if device.rack else 'None'} - U: {device.position if device.rack else 'None'}`\n"
                        f"Device IP:          `{device.primary_ip}`\n"
                        f"Device description:   {device.description}\n"
                        f"Device comments:      {device.comments}\n"
                        f"Device contact:       `{contact_name}`\n"
                        f"`=================================================`\n"
                    )
                msg += detail
                interfaces = nb.dcim.interfaces.filter(device_id=device.id)
                if interfaces:
                    msg += f"Interfaces of `{device_name}`\n"
                    index = 0
                    for interface in interfaces:
                        if index >= 10: 
                            msg+= "......"
                            break
                        index += 1
                        #if interface.connected_endpoints:
                            #for interface.connected_endpoint in interface.connected_endpoints:
                                #msg += f"Interface {index}: `{interface.name}` has connected to {interface.connected_endpoint.name} of {interface.connected_endpoint.device.name}\n"
                        #else:
                            #msg += f"Interface {index}: `{interface.name}` is currently not connected to any other interface\n"
                        msg += f"Interface {index}: *{interface.name}*\n"
                    msg += f"Too see detail of connected interfaces of {device_name} please enter `/interfaceof {device_name}`\n"
        else:
            msg = "Can't find any information about this device."
        return msg
            
    except Exception as e:
        return f"Error: {str(e)}"

# Defind the message when user enter /device
async def cmd_device(update: Update, context: ContextTypes.DEFAULT_TYPE):
    device_name = ' '.join(context.args) if context.args else ""
    msg = device_information(device_name)
    msg = msg.replace("_", "-")
    max_length = 4096  # Độ dài tối đa cho một tin nhắn
    if len(msg) > max_length:
        # Chia tin nhắn thành các phần nhỏ hơn
        for i in range(0, len(msg), max_length):
            await update.message.reply_text(msg[i:i + max_length], parse_mode='Markdown')
    else:
        await update.message.reply_text(msg, parse_mode='Markdown')

# Function to collect information of Device
def devicesn_information(device_serial_number):
    try:
        device_info = nb.dcim.devices.filter(serial=device_serial_number)
        if device_info:
            msg = 'The Information of Device: \n'
            for device in device_info:
                contact = device.custom_fields.get('contact')
                if contact:
                    contact_name = contact.get('name', 'No contact available')
                else:
                    contact_name = 'No contact available'
                detail = (
                        f"`----------------------------------------`\n"
                        f"*Device Name*:         `{device.name}`\n"
                        f"Device ID:            {device.id}\n"
                        f"Device model type:    {device.device_type.model}\n"
                        f"Device serial:        `{device.serial}`\n"
                        f"Tenant of Device:     `{device.tenant.name}`\n"
                        f"Device asset:         {device.asset_tag}\n"
                        f"Device site:          {device.site.name}\n"
                        f"Device rack:          `{device.rack.name if device.rack else 'None'} - U: {device.position if device.rack else 'None'}`\n"
                        f"Device IP:          `{device.primary_ip}`\n"
                        f"Device description:   {device.description}\n"
                        f"Device comments:      {device.comments}\n"
                        f"Device contact:       `{contact_name}`\n"
                        f"`=================================================`\n"
                    )
                msg += detail
                interfaces = nb.dcim.interfaces.filter(device_id=device.id)
                if interfaces:
                    msg += f"Interfaces of `{device.name}`\n"
                    index = 0
                    for interface in interfaces:
                        if index >= 10: 
                            msg+= "......"
                            break
                        index += 1
                        #if interface.connected_endpoints:
                            #for interface.connected_endpoint in interface.connected_endpoints:
                                #msg += f"Interface {index}: `{interface.name}` has connected to {interface.connected_endpoint.name} of {interface.connected_endpoint.device.name}\n"
                        #else:
                            #msg += f"Interface {index}: `{interface.name}` is currently not connected to any other interface\n"
                        msg += f"Interface {index}: *{interface.name}*\n"
                    msg += f"Too see detail of connected interfaces of {device.name} please enter `/interfaceof {device.name}`\n"
        else:
            msg = "Can't find any information about this device."
        return msg
            
    except Exception as e:
        return f"Error: {str(e)}"
    
# Defind the message when user enter /devicesn
async def cmd_dvsn(update: Update, context: ContextTypes.DEFAULT_TYPE):
    device_serial_number = context.args[0]
    msg = devicesn_information(device_serial_number)
    msg = msg.replace("_", "-")
    max_length = 4096  # Độ dài tối đa cho một tin nhắn
    if len(msg) > max_length:
        # Chia tin nhắn thành các phần nhỏ hơn
        for i in range(0, len(msg), max_length):
            await update.message.reply_text(msg[i:i + max_length], parse_mode='Markdown')
    else:
        await update.message.reply_text(msg, parse_mode='Markdown')
# Function to collect information of Virtual Machine
def VM_information(VM_name):
    try:
        vm_info = nb.virtualization.virtual_machines.filter(name__ic=VM_name)  
        
        if vm_info: 
            msg = ""
            for vm in vm_info:  
                detail = (
                    f"The Information of Virtual Machine: \n"
                    f"`------------------------------------------`\n"
                    f"VM Name:          `{vm.name}` \n"
                    f"VM ID:             {vm.id} \n"
                    f"VM Status:         {vm.status} \n"
                    f"VM Cluster:       `{vm.cluster.name if vm.cluster else 'None'}` \n"
                    f"VM Device:        `{vm.device if vm.device else 'None'}` \n"
                    f"VM IP:            `{vm.primary_ip if vm.primary_ip else 'None'}` \n"
                    f"VM Description:    {vm.description if vm.description else 'None'} \n"
                    f"VM OS:            {vm.platform.name if vm.platform else 'None'} \n"          
                    f"VM Size:          CPU - {vm.vcpus if vm.vcpus else 'None'}, RAM - {vm.memory if vm.memory else 'None'} MB, DISK {vm.disk if vm.disk else 'None'} GB \n"
                    f"VM Comments:      {vm.comments if vm.comments else 'None'} \n"
                    f"`=================================================`\n"
                )
                msg += detail  
        else:   
            msg = "Can't find any information about this virtual machine!"
        
        return msg            
    except Exception as e:  
        return f"Error: {str(e)}"
     
# Defind the message when user enter /vm
async def cmd_vm(update: Update, context: ContextTypes.DEFAULT_TYPE):
    vm_name = context.args
    msg = VM_information(vm_name[0])
    await update.message.reply_text(str(msg), parse_mode='Markdown')

# Function to collect information of Contact
def Contact_information(ct_name):
    try:
        ct_info = nb.tenancy.contacts.filter(name=ct_name)   
        if ct_info:
            msg = ""
            for contact in ct_info:
                detail = (
                    f"The Contact information:\n"
                    f"`----------------------------------------------`\n"
                    f"*Contact Name*:       {contact.display}\n"  
                    f"Contact Title:        {contact.title}\n"
                    f"Contact Phone Number: {contact.phone}\n"
                    f"Contact Email:        {contact.email}\n"
                    f"Contact Address:      {contact.address}\n"
                    f"`==============================================`\n"
                )
                msg += detail
            return msg      
        else:
            return "Can't find any information about this contact!" 
    except Exception as e:  
        return f"Error: {str(e)}"
        
# Defind the messsage when user enter /contact
async def cmd_contact(update:Update, context: ContextTypes.DEFAULT_TYPE ):
    ct_name = ' '.join(context.args) if context.args else ""
    msg = Contact_information(ct_name)
    msg = msg.replace("_", "-")
    await update.message.reply_text(str(msg), parse_mode='Markdown')

# Function to collect report
def report_information(rp_thing):
    try:
        if rp_thing == "device":
            total_devices = nb.dcim.devices.count()
            if total_devices:
                device_list = nb.dcim.devices.all()
                report = f"*Total Devices*: {total_devices}\n\n"
                report += "No. Device Name - ID \n"
                for index, device in enumerate(device_list, 1):
                    report += f"{index}. {device.name} - {device.id} \n"
                return report
            else:
                return "Can't take information of total device!"
        elif rp_thing == "vm":
            total_vms = nb.virtualization.virtual_machines.count()
            if total_vms:
                vm_list = nb.virtualization.virtual_machines.all()
                report = f"Total VM: {total_vms}\n\n"
                report += "No. VM Name -- ID \n"
                for index, vm in enumerate(vm_list, 1):
                    report += f"{index}. {vm.name} -- {vm.id} \n"
                return report
            else:
                return "Can't take information of total virtual machine!"
        elif rp_thing == "ip":
            total_ips = nb.ipam.ip_addresses.count()
            if total_ips:
                ip_list = nb.ipam.ip_addresses.all()
                report = f"*Total IPv4*: {total_ips}\n\n"
                report += "No. IP Address - ID \n"
                for index, ip in enumerate(ip_list, 1):
                    report += f"{index}. {ip.address} - {ip.id}\n"
                return report
            else:
                return "Can't take information of total IPv4!"
        else:
            return "Please Enter only `ip`, `device`, or `vm`"
    except Exception as e:
        return f"Error: {str(e)}"

# Defind the message when user enter /report
async def cmd_report(update:Update, context: ContextTypes.DEFAULT_TYPE ):
    rp_thing = context.args[0]  
    msg = report_information(rp_thing)
    msg = msg.replace("_", "-")
    await update.message.reply_text(msg)

# Function to show rack
def rack_information(r_name):
    try:
        rack_info = nb.dcim.racks.get(name=r_name)

        if rack_info and isinstance(rack_info, pynetbox.models.dcim.Racks):
            msg = f"*Rack*: `{rack_info.name}` \n"
            msg+="Device name - U Position \n"
            msg+="------------------------------------ \n"
            devices = nb.dcim.devices.filter(rack_id=rack_info.id)
                
            if devices:
                devices_sorted = sorted(devices, key=lambda d: d.position if d.position else 0, reverse=True)

                for device in devices_sorted:
                    u_positions = f"U{device.position}" if device.position else "Unknown"
                    msg += f"{device.name} - {u_positions} \n"
            else:
                msg += "No devices installed in this rack!"
                    
            return msg
        else:
            return "Can't find rack in NetBox!"
    
    except Exception as e:
        return f"Error: {str(e)}"

# Defind the message when user enter /rack
async def cmd_rack(update:Update, context: ContextTypes.DEFAULT_TYPE ):
    r_name = ' '.join(context.args) if context.args else ""
    msg = rack_information(r_name)
    msg = msg.replace("_", "-")
    await update.message.reply_text(str(msg), parse_mode='Markdown')

# Function to collect interface
def interface_device_information(device_name):
    try:
        devices = nb.dcim.devices.filter(name__ic=device_name)
        if devices:
            msg = f"*Interface that has been connected of Device*: `{device_name}`\n"
            msg += f"`---------------------------`\n"
            for device in devices:
                interfaces = nb.dcim.interfaces.filter(device_id=device.id)
                if interfaces:
                    for interface in interfaces:
                        if interface.connected_endpoints:
                            msg += f"Interface name: `{interface.name}`\n"
                            msg += f"Interface type: {interface.type.label}\n"
                            msg += f"Interface description: {interface.description}\n"
                            for interface_connected_endpont in interface.connected_endpoints:
                                msg += f"Connected to Interface: `{interface_connected_endpont.name}` of Device: `{interface_connected_endpont.device.name}`\n"
                            msg += f"`--------------------------------------------------`\n"
                    return msg
                else:
                    msg = f"Can't find interface of this Device: {device_name}"
            return msg
        else:
            return "Can't find that Device in NetBox!"
    except Exception as e:
        return f"Error: {str(e)}"
    
# Defind the message when user enter /interface
async def cmd_interfaceof(update:Update, context: ContextTypes.DEFAULT_TYPE):
    device_name = ' '.join(context.args) if context.args else ""
    msg = interface_device_information(device_name)
    msg = msg.replace("_", "-")
    max_length = 4096  
    if len(msg) > max_length:
        for i in range(0, len(msg), max_length):
            await update.message.reply_text(msg[i:i + max_length], parse_mode='Markdown')
    else:
        await update.message.reply_text(msg, parse_mode='Markdown')
# Defind the message when user enter /start
async def start_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(text='Type `/help` for instructions')

# Defind the message when user enter /help
async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    commands = [
        "1. Find IP information: `/ip ip_addr`",
        "2. Find Device by its name: `/device device_name`",
        "3. Find Device by its serial number: `/devicesn device_serial_number`",
        "4. Find Virtual Machine by its name: `/vm vm_name`",
        "5. Find Contact of Device by its name: `/contact contact_name`",
        "6. Show Rack list by its name: `/rack rack_name`",
        "7. Show interface connect of Device by device name: `/interface device_name`",
        "8. Report Total: `/report (vm/device/ip)`"
    ]
    await update.message.reply_text('Use the following commands:\n' + '\n'.join(commands), parse_mode='Markdown')

# Defind the message when user enter text
def handle_response(text: str) -> str:
    # Create your own response logic
    processed: str = text.lower()

    if 'hello' in processed:
        return 'Hey there!'

    if 'how are you' in processed:
        return 'I\'m good!'

    if 'i love python' in processed:
        return 'Remember to subscribe!'
    
    if 'defind ' in processed:
        return 'I\'m bot Telegram!'

    return 'Not having this command, type `/help` for help '

# Defind the form of response
async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    message_type: str = update.message.chat.type  
    text: str = update.message.text  
    
    print(f'User ({update.message.chat.id}) in {message_type}: "{text}"')
    
    response: str = handle_response(text)
    print('Bot:', response)
    await update.message.reply_text(response, parse_mode='Markdown')
    
# Main function to run Server
if __name__ == '__main__':
    application = ApplicationBuilder().token(config.TOKENTELEGRAM).build()

    # Commands
    application.add_handler(CommandHandler('start', start_command,filters.User(username=config.ADMIN_IDS)))
    application.add_handler(CommandHandler('help', help_command,filters.User(username=config.ADMIN_IDS)))
    application.add_handler(CommandHandler('device', cmd_device,filters.User(username=config.ADMIN_IDS)))
    application.add_handler(CommandHandler('devicesn', cmd_dvsn,filters.User(username=config.ADMIN_IDS)))
    application.add_handler(CommandHandler('ip', cmd_ip,filters.User(username=config.ADMIN_IDS)))
    application.add_handler(CommandHandler('vm', cmd_vm,filters.User(username=config.ADMIN_IDS)))
    application.add_handler(CommandHandler('contact', cmd_contact,filters.User(username=config.ADMIN_IDS)))
    application.add_handler(CommandHandler('rack',cmd_rack,filters.User(username=config.ADMIN_IDS)))
    application.add_handler(CommandHandler('interfaceof',cmd_interfaceof,filters.User(username=config.ADMIN_IDS)))
    application.add_handler(CommandHandler('report', cmd_report,filters.User(username=config.ADMIN_IDS)))
    application.add_handler(MessageHandler(filters.TEXT, handle_message))

    application.run_polling()
    