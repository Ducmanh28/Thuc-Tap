# Importing
import logging
import re
import pynetbox
import urllib3
from telegram import Update
from telegram.ext import ApplicationBuilder, ContextTypes, CommandHandler, Application, MessageHandler, filters

# Log config
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)

# Set up Variable
ADMIN_IDS = ['@ducmanh2873','@kquang','@totuongcong','@huyts9']
URLNETBOX = "https://172.16.66.82"                                  # Default Value
TOKENTELEGRAM = "7668680460:AAGEtAX8YBsQ8R6XrILwnoCRnfTFZmpFeNs"
TOKENNETBOX = "aa8f29998abd6a63f476a2328ce2a629a506b579"

input1 = input(f"Enter your Telegram username[@example]: ")         # Take information from user
if input1:                                                          # If it has value
    ADMIN_IDS += input1                                             # ==> Default value += Input value
    
input2 = input(f"Enter your Telegram-bot Token: ")
if input2:
    TOKENTELEGRAM = input2

input3 = input(f"Enter your URL NetBox[http://netbox.example.com]: ")
if input3:
    URLNETBOX = input3

input4 = input(f"Enter your NetBox Token: ")
if input4:
    TOKENNETBOX = input4
    
# Set up connection to NetBox
nb = pynetbox.api(URLNETBOX,token=TOKENNETBOX)                      # Connect to NetBox
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
                        f"IP Address:      `{ip_info.address}` \n"
                        f"IP Status:       `{ip_info.status}` \n"
                        f"IP Description:  `{ip_info.description}` \n"
                        f"Assigned:        `{ip_info.assigned_object.virtual_machine.name}` \n"
                        f"Assigned to an Virtual Machine"
                    )   
                    return msg
            
                elif ip_info.assigned_object_type == 'dcim.interface':                          # If IP was assigned to an Device
                    msg = (                                                                     # Make the message form
                        f"The Information of IP: \n"
                        # f"```\n"
                        f"IP Address:          `{ip_info.address}` \n"
                        f"IP Status:           `{ip_info.status}` \n"
                        f"IP Description:      `{ip_info.description}` \n"
                        f"Assigned:            `{ip_info.assigned_object.device.name}` \n"
                        f"Assigned to an Device"
                        # f"```\n"
                    )
                    return msg
                else: 
                    return "Can't find any information of this IP"
            else:
                msg = "Can't find this IP in NetBox! Please check again!"
                return msg    
        except Exception as e:  
            return f"Error: {str(e)}"
        
# Defind the message when user enter /ip
async def cmd_ip(update: Update, context: ContextTypes.DEFAULT_TYPE):       # Asynchronous def mean It can run asynchronously with other tasks without waiting for it to complete before continuing.
    ip_info = context.args                                                  # Set up value
    msg = ip_information(ip_info[0])                                        # Send message
    await update.message.reply_text(str(msg),parse_mode='Markdown')         # Form Markdown to message

# Function to collect information of Device
def device_information(device_name):
    try:
        device_info = nb.dcim.devices.filter(name__ic=device_name)
               
        if device_info:
            msg = 'The Information of Device: \n'
            for device in device_info:
                detail = (
                        f"*Device Name*:          `{device.name}`\n"
                        f"Device ID:            {device.id}\n"
                        f"Device model type:    {device.device_type.model}\n"
                        f"Device serial:        {device.serial}\n"
                        f"Device asset:         {device.asset_tag}\n"
                        f"Device site:          {device.site.name}\n"
                        f"Device rack:          `{device.rack.name if device.rack else 'None'} - U: {device.position if device.rack else 'None'}`\n"
                        f"Device IPv4:          `{device.primary_ip4}`\n"
                        f"Device description:   {device.description}\n"
                        f"Device comments:      {device.comments}\n"
                        f"Device contact:       {device.custom_fields.get('contact', 'None')}\n"
                        f"`=================================================`\n"
                    )
                msg += detail
        else:
            msg = "Can't find any information about this device."
        return msg
            
    except Exception as e:
        return f"Error: {str(e)}"

# Defind the message when user enter /device
async def cmd_device(update: Update, context: ContextTypes.DEFAULT_TYPE):
    device_name = ' '.join(context.args) if context.args else ""
    msg = device_information(device_name)
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
                    f"VM Name:          `{vm.name}` \n"
                    f"VM ID:             {vm.id} \n"
                    f"VM Status:         {vm.status} \n"
                    f"VM Cluster:       `{vm.cluster.name if vm.cluster else 'None'}` \n"
                    f"VM Device:       `{vm.device if vm.device else 'None'}` \n"
                    f"VM IPv4:         `{vm.primary_ip if vm.primary_ip else 'None'}` \n"
                    f"VM Description:   {vm.description if vm.description else 'None'} \n"
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
    
# Defind the message when user enter /start
async def start_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(text='Type `/help` for instructions')
    
# Defind the message when user enter /help
async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    commands = [
        "1. Find IP information: `/ip ip_addr`",
        "2. Find Device by its name: `/device device_name`",
        "3. Find Virtual Machine by its name: `/vm vm_name`"
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
    application = ApplicationBuilder().token(TOKENTELEGRAM).build()

    # Commands
    application.add_handler(CommandHandler('start', start_command,filters.User(username=ADMIN_IDS)))
    application.add_handler(CommandHandler('help', help_command,filters.User(username=ADMIN_IDS)))
    application.add_handler(CommandHandler('device', cmd_device,filters.User(username=ADMIN_IDS)))
    application.add_handler(CommandHandler('ip', cmd_ip,filters.User(username=ADMIN_IDS)))
    application.add_handler(CommandHandler('vm', cmd_vm,filters.User(username=ADMIN_IDS)))
    application.add_handler(MessageHandler(filters.TEXT, handle_message))

    application.run_polling()
    