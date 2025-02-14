# Importing
import asyncio
import logging
import config
import datetime
from flask import Flask, request, jsonify
from telegram import Bot
# Log Config
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
app = Flask(__name__)
def format_timestamp(ts):
    try:
        ts = float(ts)
        dt = datetime.datetime.fromtimestamp(ts)
        return dt.strftime("%d-%m-%Y %H:%M:%S")
    except Exception as e:
        logging.error(f"Error while formating timestamp: {e}")
        return ts
# Data Config
def process_data(webhook_data):
    event = webhook_data.get("event")
    timestamp = webhook_data.get("timestamp")
    username = webhook_data.get("username")
    
    device_data = webhook_data.get("data", {})
    device_name = device_data.get("name")
    
    snapshots = webhook_data.get("snapshots", {})
    prechange = snapshots.get("prechange", {})
    postchange = snapshots.get("postchange", {})
    msg = "*Thông báo!* \n"
    info = (
        f"*Alert Info* \n"
        f"*Event:* {event}\n"
        f"*Timestamp:* {timestamp}\n"
        f"*By User:* {username}\n"
        f"*Object Info* \n"
        f"*Device Name:* {device_name}\n"
        f"*Detail* \n"
    )
    
    msg += info
    return msg
# Send messenger
async def send_telegram_alert(message):
    bot = Bot(token=config.TELEGRAM_BOT_TOKEN)
    try:
        message = message.replace("_", "-")
        await bot.send_message(chat_id=config.TELEGRAM_CHAT_ID, text=message, parse_mode="Markdown")
        logging.info("Send successed!")
    except Exception as e:
        logging.error(f"Error while trying to send messenger: {e}")
# Config webhooks
@app.route('/webhooks', methods=['POST'])
def webhook():
    # Get data
    data = request.get_json()
    
    # Process data
    messenger = process_data(data)
    
    # Send messenger
    asyncio.run(send_telegram_alert(messenger))
    
    return jsonify({"status": "success"}), 200
# Main
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=config.WEBHOOKS_PORTS, debug=True)