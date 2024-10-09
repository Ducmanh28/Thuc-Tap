import logging
import pynetbox
import urllib3
from telegram import Update
from telegram.ext import ApplicationBuilder, ContextTypes, CommandHandler, Application, MessageHandler, filters, ContextTypes

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)

ADMIN_IDS = ['@ducmanh2873' ]
TOKENTELEGRAM = '7668680460:AAGEtAX8YBsQ8R6XrILwnoCRnfTFZmpFeNs'
TOKENNETBOX = 'aa8f29998abd6a63f476a2328ce2a629a506b579'

nb = pynetbox.api ("https://172.16.66.82/", token=TOKENNETBOX)
nb.http_session.verify = False

# Ham lay thong tin cua dia chi IP
def thong_tin_ip(dia_chi_ip):
    ip_info = nb.ipam.ip_addresses.get(address=dia_chi_ip)
    if ip_info:
        if ip_info.assigned_object_type == 'virtualization.vminterface':
            msg = (
                f"IP INFO 👇 : \n"
                # f"```\n"
                f"Address:      `{ip_info.address}` \n"
                f"Status:       `{ip_info.status}` \n"
                f"Description:   `{ip_info.description}` \n"
                f"Assigned:      `{ip_info.assigned_object.virtual_machine.name}` \n"
                f"`Gan cho: Virtual Machine`"
                # f"```\n"
            )
            return msg
        
        elif ip_info.assigned_object_type == 'dcim.interface': 
            msg = (
                f"IP INFO 👇: \n"
                # f"```\n"
                f"Address:          `{ip_info.address}` \n"
                f"Status:           `{ip_info.status}` \n"
                f"Description:     `{ip_info.description}` \n"
                f"Assigned (Device):  `{ip_info.assigned_object.device.name}` \n"
                f"`Gan cho: Device`"
                # f"```\n"
            )
            return msg
        else: 
            return "rong"
    else:
        msg = "KHONG TIM THAY THONG TIN IP NAY "
        return msg

# Dinh nghia ban tin tra ve khi go cau lenh /ip
async def cmd_ip(update: Update, context: ContextTypes.DEFAULT_TYPE):
    ip_info = context.args
    msg = thong_tin_ip(ip_info[0])
    await update.message.reply_text(str(msg),parse_mode='Markdown')


# Ham lay thong tin cua device
def thong_tin_thiet_bi(devices_name):
    device_info = nb.dcim.devices.filter(name__ic=devices_name)
    if device_info:
        msg = ''
        for device in device_info:
            detail = (
                f"*Device name:* `{device.name}`\n"
                f"Device id: {device.id} \n"
                f"Device model type: {device.device_type.model} \n"
                f"Device serial: {device.serial} \n"
                f"Device asset: {device.asset_tag} \n"
                f"Device site: {device.site.name} \n"
                f"Device rack: `{device.rack.name if device.rack is not None else 'The device has not been added to the Rack'} - U: {device.position if device.rack is not None else 'None'}` \n"
                f"Device ip4: `{device.primary_ip4}` \n"
                f"Device description: {device.description} \n"
                f"Device comments: {device.comments} \n"
                f"Device contact: {device.custom_fields['contact']} \n" if 'contact' in device.custom_fields else "Device contact: None \n"
                f"`=================================================`\n"
            )
            msg += detail
    else:
        msg = "KHONG CO THONG TIN THIET BI NAY"     
    return msg


# Dinh nghia ban tin tra ve khi go cau lenh /device
async def cmd_device(update: Update, context: ContextTypes.DEFAULT_TYPE):
    device_name = context.args
    msg = thong_tin_thiet_bi(device_name[0])
    await update.message.reply_text(str(msg),parse_mode='Markdown')


# Ham lay thong tin may ao
def thong_tin_vm(vm_name):
    vm_info = nb.virtualization.virtual_machines.get(name=vm_name)
    if vm_info:
        msg = (
            f"VM INFO 👇: \n"
            # f"```\n"
            f"VM Name:          `{vm_info.name}` \n"
            f"VM ID:            {vm_info.id} \n"
            f"VM Status:        {vm_info.status} \n"
            f"VM Cluster:       `{vm_info.cluster.name}` \n"
            f"VM Device :       `{vm_info.device}` \n"
            f"VM IPv4 :         `{vm_info.primary_ip}` \n"
            f"VM Description :  {vm_info.name} \n"
            f"VM OS :           {vm_info.platform.name if vm_info.platform is not None else 'None' } \n"          
            f"VM Size :         CPU - {vm_info.vcpus}, RAM - {vm_info.memory} MB, DISK {vm_info.disk} GB \n"
            f"VM Comments :     {vm_info.comments} \n"
            # f"```\n"
        )        
        return msg
    else: 
        msg = "KHONG TIM THAY THONG TIN VM NAY"
        return msg

# Dinh nghia ban tin tra ve khi go cau lenh /vms
async def cmd_vm(update: Update, context: ContextTypes.DEFAULT_TYPE):
    vm_name = context.args
    msg = thong_tin_vm(vm_name[0])
    await update.message.reply_text(str(msg), parse_mode='Markdown')

# Dinh nghia ban tin tra ve khi go cau lenh /start
async def start_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(text='Go lenh /help de duoc huong dan')

# Dinh nghia ban tin tra ve khi go cau lenh /help
async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text('Su dung cac lenh sau day \n 1. Tim kiem theo IP: `/ip dia_chi_ip` \n 2. Tim kiem theo ten thiet bi `/device ten_thiet_bi` \n 3. Tim kiem theo ten VM  `/vm ten_vm`', parse_mode='Markdown')

# # Dinh nghia ban tin tra ve khi go cau lenh /custom
# async def custom_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
#     await update.message.reply_text('This is a custom command, you can add whatever text you want here.')
def handle_response(text: str) -> str:
    # Create your own response logic
    processed: str = text.lower()

    if 'hello' in processed:
        return 'Hey there!'

    if 'how are you' in processed:
        return 'I\'m good!'

    if 'i love python' in processed:
        return 'Remember to subscribe!'

    return 'KHONG CO LENH NAY,  GO LENH `/help` DE TRA CUU '

async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    # Get basic info of the incoming message
    message_type: str = update.message.chat.type
    text: str = update.message.text

    # Print a log for debugging
    print(f'User ({update.message.chat.id}) in {message_type}: "{text}"')

    # React to group messages only if users mention the bot directly
    # if message_type == 'group':
    #     # Replace with your bot username
    #     if BOT_USERNAME in text:
    #         new_text: str = text.replace(BOT_USERNAME, '').strip()
    #         response: str = handle_response(new_text)
    #     else:
    #         return  # We don't want the bot respond if it's not mentioned in the group
    # else:
    #     response: str = handle_response(text)

    response: str = handle_response(text)

    # Reply normal if the message is in private
    print('Bot:', response)
    await update.message.reply_text(response, parse_mode='Markdown')


if __name__ == '__main__':
    application = ApplicationBuilder().token(TOKENTELEGRAM).build()

    # Commands
    application.add_handler(CommandHandler('start', start_command,filters.User(username=ADMIN_IDS)))
    application.add_handler(CommandHandler('help', help_command,filters.User(username=ADMIN_IDS)))
    # application.add_handler(CommandHandler('custom', custom_command))

    application.add_handler(CommandHandler('device', cmd_device,filters.User(username=ADMIN_IDS)))
    application.add_handler(CommandHandler('ip', cmd_ip,filters.User(username=ADMIN_IDS)))
    application.add_handler(CommandHandler('vm', cmd_vm))
    application.add_handler(MessageHandler(filters.TEXT, handle_message))

    application.run_polling()f