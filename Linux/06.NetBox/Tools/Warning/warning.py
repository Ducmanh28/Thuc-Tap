# Importing
import asyncio
import logging
import config
import datetime
import requests
import urllib3
from flask import Flask, request, jsonify
from telegram import Bot
# Log Config
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
app = Flask(__name__)
# Create journal
def create_journal(webhook_data):
    event = webhook_data.get("event")
    device_data = webhook_data.get("data", {})
    device_id = device_data.get("id")
    device_name = device_data.get("name", "Unknown Device")

    if not device_id:
        return False, "Error: device_id is missing!"

    headers = {
        "Authorization": f"Token {config.TOKEN_NETBOX}",
        "Content-Type": "application/json"
    }
    body = {
        "assigned_object_type": "dcim.device",
        "assigned_object_id": device_id,
        "kind": "info",
        "comments": f"{event}-{device_name}"
    }

    response = requests.post(f"{config.URL_NETBOX}/api/extras/journal-entries/", json=body, headers=headers,verify=False)

    if response.status_code == 201:
        return True, "Journal entry created successfully!"
    else:
        return False, f"Error {response.status_code}: {response.text}"
# Format Time
def format_timestamp(ts):
    try:
        try:
            ts_float = float(ts)
            dt = datetime.datetime.fromtimestamp(ts_float)
        except ValueError:
            dt = datetime.datetime.fromisoformat(ts)
        return dt.strftime("%d-%m-%Y %H:%M:%S")
    except Exception as e:
        logging.error(f"Error while formating timestamp: {e}")
        return ts
# Data Config
def process_data(webhook_data):
    event = webhook_data.get("event")
    timestamp = webhook_data.get("timestamp")
    time = format_timestamp(timestamp)
    username = webhook_data.get("username")
    object = webhook_data.get("model")
    
    device_data = webhook_data.get("data", {})
    device_name = device_data.get("name")
    
    snapshots = webhook_data.get("snapshots", {})
    prechange = snapshots.get("prechange", {})
    postchange = snapshots.get("postchange", {})
    exclude_fields = ["-name", "created", "last-updated", "latitude", "longitude"]
    prechange_data = {key: value for key, value in prechange.items() if key not in exclude_fields}
    postchange_data = {key: value for key, value in postchange.items() if key not in exclude_fields}
    
    msg = "*Warning!* \n"
    info = (
        f"*Alert Info* \n"
        f"*Event:* {event}\n"
        f"*Time:* {time}\n"
        f"*By User:* {username}\n"
        f"   \n"
        f"*Object Info*"
        f"*Object Type:* {object}\n"
        f"*Object Name:* {device_name}\n"
        f"   \n"
        f"*Detail* \n"
        f"*Before:* {prechange_data} \n"
        f"*After Change:* {postchange_data} \n"
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
    
    # Create journal
    create_journal(data)
    
    return jsonify({"status": "success"}), 200
# Main
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=config.WEBHOOKS_PORTS, debug=True)