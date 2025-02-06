#!/usr/bin/env python3
import json
import threading
import pynetbox
import requests
import asyncio

from flask import Flask, request, jsonify

# Thư viện telegram và telegram.ext để xây dựng bot với các lệnh
import telegram
from telegram import Update
from telegram.ext import (
    ApplicationBuilder,
    ContextTypes,
    CommandHandler,
    MessageHandler,
    filters,
)
import config

# ----------------- CẤU HÌNH ----------------- #
TELEGRAM_BOT_TOKEN = config.TELEGRAM_BOT_TOKEN
TELEGRAM_CHAT_ID = config.TELEGRAM_CHAT_ID

NETBOX_URL = config.NETBOX_URL
NETBOX_API_TOKEN = config.NETBOX_API_TOKEN
# ---------------------------------------------- #

# Khởi tạo kết nối tới NetBox qua pynetbox
nb = pynetbox.api(NETBOX_URL, token=NETBOX_API_TOKEN)

# Tạo một instance bot để gửi tin nhắn từ các thread khác
bot_instance = telegram.Bot(token=TELEGRAM_BOT_TOKEN)

# Flask app để nhận webhook từ NetBox
app = Flask(__name__)

def send_telegram_alert(message: str):
    """
    Gửi thông báo tới Telegram sử dụng bot_instance.
    """
    try:
        bot_instance.send_message(chat_id=TELEGRAM_CHAT_ID, text=message)
        print("Telegram alert sent.")
    except Exception as e:
        print("Error sending Telegram message:", e)

def create_journal_entry(device_id: int, comment: str):
    """
    Tạo Journal entry cho thiết bị trong NetBox thông qua pynetbox.
    Sử dụng API extras của NetBox:
      - assigned_object_type: "dcim.device"
      - assigned_object_id: ID của device
      - kind: loại entry (ví dụ: "warning")
      - comments: nội dung thay đổi
    """
    payload = {
        "assigned_object_type": "dcim.device",
        "assigned_object_id": device_id,
        "kind": "warning",  
        "comments": comment
    }
    try:
        entry = nb.extras.journal_entries.create(payload)
        print("Journal entry created:", entry)
    except Exception as e:
        print("Error creating journal entry:", e)

@app.route('/webhook', methods=['POST'])
def webhook_handler():
    """
    Xử lý webhook gửi từ NetBox khi có sự thay đổi của thiết bị (dcim.device).
    Payload JSON thường chứa các trường: event, model, username, timestamp, data và snapshots.
    """
    data = request.get_json()
    print("Received webhook:", json.dumps(data, indent=2))

    event = data.get("event")
    model = data.get("model")
    # Chỉ xử lý đối tượng thiết bị
    if model != "dcim.device":
        return jsonify({"message": "Not a device event"}), 200

    if event in ["created", "updated"]:
        device_data = data.get("data", {})
        device_id = device_data.get("id")
        device_name = device_data.get("name")
        username = data.get("username", "unknown")
        timestamp = data.get("timestamp")
        action = event

        # Nếu sự kiện cập nhật, kiểm tra sự thay đổi site để xác định di chuyển
        snapshots = data.get("snapshots", {})
        prechange = snapshots.get("prechange")
        postchange = snapshots.get("postchange")
        if event == "updated" and prechange and postchange:
            if prechange.get("site") != postchange.get("site"):
                action = "moved"

        # Tạo thông báo cho Telegram
        telegram_msg = (f"Thiết bị '{device_name}' (ID: {device_id}) đã được {action} "
                        f"bởi {username} vào {timestamp}.")
        send_telegram_alert(telegram_msg)

        # Ghi nội dung vào Journal của NetBox
        journal_comment = (f"Thiết bị '{device_name}' (ID: {device_id}) đã được {action} "
                           f"bởi {username} vào {timestamp}.\nChi tiết: {json.dumps(device_data, indent=2)}")
        create_journal_entry(device_id, journal_comment)

        return jsonify({"message": "Telegram alert sent and journal entry created"}), 200
    else:
        # Các sự kiện khác không được xử lý
        return jsonify({"message": "Event not processed"}), 200



async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """
    Xử lý lệnh /start cho bot Telegram.
    """
    await update.message.reply_text("Chào bạn! Đây là bot NetBox thông báo. Sử dụng /help để biết thêm chi tiết.")

async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """
    Xử lý lệnh /help cho bot Telegram.
    """
    help_text = (
        "Các lệnh hỗ trợ:\n"
        "/start - Bắt đầu tương tác với bot.\n"
        "/help - Hiển thị trợ giúp.\n"
        "Ngoài ra, bot sẽ gửi thông báo khi có thay đổi trên NetBox."
    )
    await update.message.reply_text(help_text)

async def echo(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """
    Phản hồi tin nhắn người dùng 
    """
    await update.message.reply_text(update.message.text)

def run_telegram_bot():
    """
    Khởi tạo và chạy bot Telegram sử dụng ApplicationBuilder với polling.
    """
    # Tạo ứng dụng bot
    application = ApplicationBuilder().token(TELEGRAM_BOT_TOKEN).build()

    # Thêm CommandHandler và MessageHandler
    application.add_handler(CommandHandler("start", start))
    application.add_handler(CommandHandler("help", help_command))
    application.add_handler(MessageHandler(filters.TEXT & (~filters.COMMAND), echo))

    # Chạy bot (blocking call, vì vậy chạy trong thread riêng)
    application.run_polling()

# ----------------- MAIN ----------------- #
if __name__ == "__main__":
    # Chạy bot Telegram trong một thread riêng
    telegram_thread = threading.Thread(target=run_telegram_bot, daemon=True)
    telegram_thread.start()
    print("Telegram bot started.")

    # Chạy Flask app để nhận webhook từ NetBox
    app.run(host="0.0.0.0", port=5000)
