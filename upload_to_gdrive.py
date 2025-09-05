import os
import json
import requests
from datetime import datetime
import yaml

def get_flutter_version(pubspec_path='pubspec.yaml'):
    with open(pubspec_path, 'r') as f:
        pubspec = yaml.safe_load(f)
        return pubspec.get('version', 'unknown')

def send_telegram_message(message, telegram_token, chat_id):
    url = f"https://api.telegram.org/bot{telegram_token}/sendMessage"
    payload = {'chat_id': chat_id, 'text': message}
    response = requests.post(url, json=payload)
    if response.status_code != 200:
        raise Exception(f"Failed to send message: {response.text}")
    print("Message sent successfully to Telegram.")
    return response.json()['result']['message_id']

def send_telegram_file(file_path, telegram_token, chat_id, custom_file_name):
    url = f"https://api.telegram.org/bot{telegram_token}/sendDocument"
    with open(file_path, 'rb') as file:
        response = requests.post(url, data={'chat_id': chat_id}, files={'document': (custom_file_name, file)})
    if response.status_code != 200:
        raise Exception(f"Failed to send file: {response.text}")
    print("File sent successfully to Telegram.")
    return response.json()['result']['message_id']

def forward_telegram_message(telegram_token, from_chat_id, message_id, to_chat_id):
    url = f"https://api.telegram.org/bot{telegram_token}/forwardMessage"
    payload = {
        'chat_id': to_chat_id,
        'from_chat_id': from_chat_id,
        'message_id': message_id
    }
    response = requests.post(url, json=payload)
    if response.status_code != 200:
        raise Exception(f"Failed to forward message: {response.text}")
    print("Message forwarded successfully to another group.")

def sanitize_filename(filename):
    return filename.replace(':', '_').replace('/', '_')

if __name__ == '__main__':
    telegram_token = os.environ.get('TELEGRAM_BOT_TOKEN')
    chat_id = os.environ.get('TELEGRAM_CHAT_ID')
    current_date = datetime.now().strftime("%-d-%-m-%Y")
    flutter_version = get_flutter_version()
    
    # Paths and custom names
    apk_path = 'build/app/outputs/flutter-apk/app-release.apk'
    apk_name = sanitize_filename(f"Ghina shop_APK_{flutter_version}_{current_date}.apk")

    aab_path = 'build/app/outputs/bundle/release/app-release.aab'
    aab_name = sanitize_filename("Ghina shop-AAB_1.0.4+5_7-3-2025.aab")

    # Send APK to Telegram only
    send_telegram_message(f"✅ Ghina shop APK ready for download!", telegram_token, chat_id)
    send_telegram_file(apk_path, telegram_token, chat_id, apk_name)

    # Send AAB to Telegram (uncomment if needed)
    # send_telegram_message(f"✅ Ghina shop AAB ready for download!", telegram_token, chat_id)
    # send_telegram_file(aab_path, telegram_token, chat_id, aab_name)
