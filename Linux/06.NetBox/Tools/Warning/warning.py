# Importing
import asyncio
import logging
import config
import datetime
import requests
import urllib3
import pynetbox
from flask import Flask, request, jsonify
from telegram import Bot
# Log Config
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
nb = pynetbox.api(config.URL_NETBOX,token=config.TOKEN_NETBOX)        # Connect to NetBox
nb.http_session.verify = False   
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
    device_rack = device_data.get("rack", "Unknow Rack").get("name", "Unknow name")
    device_positon = device_data.get("position")
    
    device_info = nb.dcim.devices.get(id=device_id)

    device_role = device_info.role.name
    device_type = device_info.device_type.model
    msg = (
        f"*Event: *{event} \n"
        f"*Object Type:* {model}\n"
        f"*Created by:* {username}\n"
        f"*At: *{time}\n"
        f" \n"
        f"*Detail*\n"
        f"*Device Name:* {device_name}\n"
        f"*Device Role*: {device_role}\n"
        f"*Device Type*: {device_type}\n"
        f"*Site:* {device_site}\n"
        f"*Rack:* {device_rack}\n"
        f"*Position:* {device_positon}\n"
    )
    return msg

def updated_event(webhook_data):
    event = webhook_data.get("event", {})
    timestamp = webhook_data.get("timestamp", {})
    time = format_timestamp(timestamp)
    username = webhook_data.get("username", {})
    object = webhook_data.get("model", {})
    
    device_data = webhook_data.get("data", {})
    device_name = device_data.get("name", {})
    device_site = device_data.get("site", {}).get("name", {})
    device_rack = device_data.get("rack", {}).get("name", {})
    device_positon = device_data.get("position")
    
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

    msg = (
        f"*Event:* {event}\n"
        f"*Object Type:* {object}\n"
        f"*Object Name:* {device_name}\n"
        f"*Site:* {device_site}\n"
        f"*Rack:* {device_rack}\n"
        f"*Position:* {device_positon}\n"
        f"*Edit By:* {username}\n"
        f"*Time:* {time}\n"
        f" \n"
        f"*Detail* \n"
    )
    for key, diff in differences.items():
        msg += f"- {key}: Change from *{diff['prechange']}* to *{diff['postchange']}* \n"
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
    event = data.get("event", {})
    # Process data
    messenger = f"*Warning!!!* \n"
    if event == "updated":
        info = updated_event(data)
        messenger+=info
    elif event == "created":
        info = created_event(data)
        messenger+=info
    
    # Send messenger
    asyncio.run(send_telegram_alert(messenger))
    
    # Create journal
    create_journal(data)
    
    return jsonify({"status": "success"}), 200
# Main
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=config.WEBHOOKS_PORTS, debug=True)