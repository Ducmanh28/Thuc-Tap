# Importing
import asyncio
import logging
import config
from flask import Flask, request, jsonify
from telegram import Bot

# Log config
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
# Bot config
TELEGRAM_BOT_TOKEN = config.TELEGRAM_BOT_TOKEN
TELEGRAM_CHAT_ID = config.TELEGRAM_CHAT_ID
app = Flask(__name__)
# Data Config
def process_data(webhook_data):
    event = webhook_data.get("event")
    timestamp = webhook_data.get("timestamp")
    username = webhook_data.get("username")
    request_id = webhook_data.get("request_id")
    
    device_data = webhook_data.get("data", {})
    device_id = device_data.get("id")
    device_name = device_data.get("name")
    
    snapshots = webhook_data.get("snapshots", {})
    prechange = snapshots.get("prechange", {})
    postchange = snapshots.get("postchange", {})
    
    differences = {}
    all_keys = set(prechange.keys()).union(postchange.keys())
    
    for key in all_keys:
        pre_value = prechange.get(key)
        post_value = postchange.get(key)
        if pre_value != post_value:
            differences[key] = {"prechange": pre_value, "postchange": post_value}
    msg = "*Thông báo!* \n"
    info = (
        f"`------------------------------------------------------`\n"
        f"*Alert Info* \n"
        f"*Event:* {event}\n"
        f"*Timestamp:* {timestamp}\n"
        f"*By User:* {username}\n"
        f"*Request ID:* {request_id}\n"
        f"`------------------------------------------------------`\n"
        f"*Object Info* \n"
        f"*Device ID:* {device_id}\n"
        f"*Device Name:* {device_name}\n"
        f"`------------------------------------------------------`\n"
        f"*Event Info* \n"
    )
    for key, diff in differences.items():
        info += f"- {key}: Before = {diff['prechange']}, After = {diff['postchange']} \n"
    msg += info
    return msg
# Send messenger
async def send_telegram_alert(message):
    bot = Bot(token=TELEGRAM_BOT_TOKEN)
    try:
        message = message.replace("_", "-")
        await bot.send_message(chat_id=TELEGRAM_CHAT_ID, text=message, parse_mode="Markdown")
        logging.info("Tin nhắn đã gửi thành công!")
    except Exception as e:
        logging.error(f"Lỗi khi gửi tin nhắn Telegram: {e}")

@app.route('/webhooks', methods=['POST'])
def webhook():
    # Lấy data
    data = request.get_json()
    
    # Xử lý data
    messenger = process_data(data)
    
    # Gửi tin nhắn
    asyncio.run(send_telegram_alert(messenger))
    
    return jsonify({"status": "success"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)