import requests
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes

# Cấu hình thông tin NetBox
NETBOX_API_URL = "https://www.netboxlab.local/api/"
NETBOX_TOKEN = "aa8f29998abd6a63f476a2328ce2a629a506b579"

# Hàm lấy dữ liệu thiết bị từ NetBox
def get_device_data(device_name):
    headers = {
        "Authorization": f"Token {NETBOX_TOKEN}",
    }
    response = requests.get(f"{NETBOX_API_URL}dcim/devices/?name={device_name}", headers=headers)
    return response.json()

# Hàm tìm kiếm thiết bị theo tên
def search_devices(device_name):
    headers = {
        "Authorization": f"Token {NETBOX_TOKEN}",
    }
    response = requests.get(f"{NETBOX_API_URL}dcim/devices/?name__icontains={device_name}", headers=headers)
    return response.json()

# Hàm xử lý lệnh /device
async def device_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if len(context.args) == 0:
        await update.message.reply_text("Vui lòng cung cấp tên thiết bị.")
        return
    
    device_name = ' '.join(context.args)
    
    # Tìm kiếm thiết bị
    devices = search_devices(device_name)

    if len(devices['results']) == 0:
        await update.message.reply_text(f"Không tìm thấy thiết bị nào với tên '{device_name}'.")
        return

    if len(devices['results']) == 1:
        device = devices['results'][0]
        response_message = f"*Device Name:* [{device['name']}](copy:{device['name']})\n" \
                           f"*Device Type:* {device['device_type']['display_name']}\n" \
                           f"*Site:* {device['site']['name']}\n" \
                           f"*Status:* {device['status']['label']}"
        await update.message.reply_text(response_message, parse_mode='MarkdownV2')
    else:
        # Hiển thị danh sách thiết bị
        device_list = "\n".join([f"[{d['name']}](copy:{d['name']})" for d in devices['results']])
        await update.message.reply_text(f"Các thiết bị tìm thấy:\n{device_list}", parse_mode='MarkdownV2')

if __name__ == '__main__':
    application = ApplicationBuilder().token("7668680460:AAGEtAX8YBsQ8R6XrILwnoCRnfTFZmpFeNs").build()
    application.add_handler(CommandHandler("device", device_command))
    application.run_polling()
