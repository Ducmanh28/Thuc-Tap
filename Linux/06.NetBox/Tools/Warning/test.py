from flask import Flask, request, jsonify

app = Flask(__name__)
# Config webhooks
@app.route('/webhooks', methods=['POST'])
def webhook():
    data = request.get_json()
    print(data)
    
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)