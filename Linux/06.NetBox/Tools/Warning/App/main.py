import config
import asyncio
from telegrams import send_telegram_alert
from journal import create_journal
from message.created_event import created_event
from message.updated_event import updated_event
from message.deleted_event import deleted_event
from flask import Flask, request, jsonify

app = Flask(__name__)
@app.route('/webhooks', methods=['POST'])
def webhook():
    # Get data
    data = request.get_json()
    print(data)
    event = data.get("event", {})
    # Process data
    messenger = f"*Warning!!!* \n"
    if event == "updated":
        info = updated_event(data)
        messenger+=info
        create_journal(data)
    elif event == "created":
        info = created_event(data)
        messenger+=info
        create_journal(data)
    elif event == "deleted":
        info = deleted_event(data)
        messenger+=info
    else:
        messenger+="No Info! Error while get data from NetBox!"
    # Send messenger
    asyncio.run(send_telegram_alert(messenger))
    return jsonify({"status": "success"}), 200
# Main
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=config.WEBHOOKS_PORTS, debug=True)
