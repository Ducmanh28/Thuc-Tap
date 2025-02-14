import datetime
import logging

def format_timestamp(ts):
    """
    Chuyển đổi timestamp sang chuỗi định dạng 'dd-mm-yyyy hh:mm:ss'
    - Nếu ts là số (Unix epoch) thì chuyển đổi theo từtimestamp.
    - Nếu ts là chuỗi ISO 8601, chuyển đổi bằng fromisoformat.
    """
    try:
        # Cố gắng ép về float (trường hợp Unix epoch)
        try:
            ts_float = float(ts)
            dt = datetime.datetime.fromtimestamp(ts_float)
        except ValueError:
            # Nếu ép không được, giả sử ts là chuỗi ISO 8601
            dt = datetime.datetime.fromisoformat(ts)
        return dt.strftime("%d-%m-%Y %H:%M:%S")
    except Exception as e:
        logging.error(f"Error while formating timestamp: {e}")
        return ts

# Ví dụ sử dụng:
timestamp_str = "2025-02-14T09:09:44.184329+00:00"
formatted = format_timestamp(timestamp_str)
print(formatted)  # In ra: 14-02-2025 09:09:44
