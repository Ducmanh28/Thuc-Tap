import google.generativeai as genai
import os

API_KEY = "AIz..."  # Thay thế bằng API key của bạn

genai.configure(api_key=API_KEY)

def check_available_gemini_models():
    print("Đang kiểm tra các mô hình Gemini khả dụng...\n")
    try:
        available_models = genai.list_models()
        
        count = 0
        for model in available_models:
            if 'generateContent' in model.supported_generation_methods:
                print(f"Tên mô hình: {model.name}")
                print(f"Mô tả: {model.description}")
                print("-" * 40)
                count += 1
                
        print(f"Tổng cộng có {count} mô hình hỗ trợ tạo nội dung.")
        
    except Exception as e:
        print(f"Đã xảy ra lỗi khi kiểm tra API key: {e}")

if __name__ == "__main__":
    check_available_gemini_models()