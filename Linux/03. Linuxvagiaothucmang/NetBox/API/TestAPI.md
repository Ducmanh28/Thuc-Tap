# Mục này sẽ kiểm thử API trên Ubuntu
Ở mục này, tôi sẽ tạo một môi trường ảo Python, tạo 1 endpoint ảo để thao tác với các dữ liệu. API Token sẽ chưa được sử dụng ở mục này. Cùng tiến vào quá trình nhé

## Cài đặt môi trường
Nếu chưa có Python và Pip, cài đặt chúng:
```
sudo apt update

sudo apt install -y python3 python3-pip
```
### Cài đặt virtual Enviroment
Tạo 1 môi trường ảo để quản lý các gói python
```
sudo apt install -y python3-venv
```

Tạo môi trường ảo:
```
python3 -m venv myenv   

# Khởi động
source myenv/bin/activate
```
### Tạo API Local
Cài đặt Flask  
```
pip install Flask
```
Tạo dự án API:
```
mkdir api

cd api

touch app.py
```
Thêm nội dung sau:
```
#app.py

from flask import Flask, jsonify, request

app = Flask(_name_)

# Tạo 1 dánh sách chứa các dữ liệu ban đầu
items = []

# Lấy dữ liệu:
@app.route('/api/items', methods = ['GET'])
def get_items():
    return jsonify(items), 200

# Lấy thông tin 1 mục cụ thể:
@app.route('/api/items/<int:item_id>', methods = ['GET'])
def get_item(item_id):
    item = next((item for item in items if item['id'] == item_id), None)
    if item is None:
        return jsonify({'message': 'Item not found'}), 404  
    return jsonify(item), 200

# Tạo 1 mục mới:
@app.route('/api/items', methods=['POST'])
def create_item():
    new_item = request.get_json()
    if not new_item or 'id' not in new_item or 'name' not in new_item:
        return jsonify({'message:' 'Bad request'}), 404
    items.append(new_item), 201

# Chỉnh sửa, cập nhật 1 mục hiện có:
@app.route('/api/items/<int:item_id>', methods=['PUT'])
def update_item(item_id):
    item = next((item for item in items if item['id'] == item_id), None)
    if item is None:
        return jsonify({'message': 'Item not found'}), 404
    updated_item = request.get_json()
    item.update(updated_item)
    return jsonify(item), 200

# Xóa một mục
@app.route('/api/items/<int:item_id>', methods=['DELETE'])
def delete_item(item_id):
    global items
    items = [item for item in items if item['id'] != item_id]
    return jsonify({'message': 'Item deleted'}), 200

# Main
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
```
### Kiểm thử:
POST dữ liệu:
- Phía Client:
```
# Nội dung gửi đi:
curl -X POST http://localhost:5000/api/items      -H "Content-Type: application/json"      -d '{"id": 2, "name": "Item 2"}'

# Nội dung nhận được:
{
  "id": 1,
  "name": "Item 1"
}
```
- Phía Server:
```
127.0.0.1 - - [05/Sep/2024 16:34:38] "POST /api/items HTTP/1.1" 201 -
```

GET dữ liệu:
- Phía Client:
```
# Nội dung gửi đi
curl -X GET http://localhost:5000/api/items

# Nội dung nhận được
{
  "id": 1,
  "name": "Item 1"
}
```
- Phía Server:
```
127.0.0.1 - - [05/Sep/2024 16:34:24] "GET /api/items HTTP/1.1" 200 -
```

Cập nhật dữ liệu:
- Phía Client:
```
# Nội dung gửi đi
curl -X PUT http://localhost:5000/api/items/1 -H "Content-Type: application/json" -d '{"name": "Updated Item 1"}'

# Nội dung nhận được
{
  "id": 1,
  "name": "Updated Item 1"
}
```
- Phía Server:
```
127.0.0.1 - - [05/Sep/2024 16:44:18] "PUT /api/items/1 HTTP/1.1" 200 -
```

Xóa dữ liệu:
- Phía Client:
```
# Nội dung gửi đi:
curl -X DELETE http://localhost:5000/api/items/1

# Nội dung nhận được:
{
  "message": "Item deleted"
}
```
- Phía Server:
```
127.0.0.1 - - [05/Sep/2024 16:47:06] "DELETE /api/items/1 HTTP/1.1" 200 -
```

Khi tìm kiếm 1 mục không tồn tại:
- Phía Client:
```
# Nội dung gửi đi
curl -X GET http://localhost:5000/api/items/1

# Nội dung nhận về:
{
  "message": "Item not found"
}
```
- Phía Server:
```
127.0.0.1 - - [05/Sep/2024 16:48:51] "GET /api/items/1 HTTP/1.1" 404 -
```
