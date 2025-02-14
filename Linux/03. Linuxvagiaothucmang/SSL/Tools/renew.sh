#!/bin/bash

# Nhập thông tin từ người dùng
read -p "Nhập user Zimbra: " ZIMBRA_USER
read -p "Nhập thư mục Zimbra: " ZIMBRA_DIR
read -p "Nhập thư mục chứa SSL: " SSL_DIR
read -p "Nhập domain: " DOMAIN

BACKUP_DIR="$SSL_DIR/backup_$(date +%F_%T)"

# Kiểm tra thư mục Zimbra tồn tại không
if [ ! -d "$ZIMBRA_DIR" ]; then
    echo "Thư mục Zimbra không tồn tại!" >&2
    exit 1
fi

# Kiểm tra thư mục SSL tồn tại không
if [ ! -d "$SSL_DIR" ]; then
    echo "Thư mục SSL không tồn tại!" >&2
    exit 1
fi

# Tạo chứng chỉ SSL mới với Certbot
echo "Generating new SSL certificates with Certbot..."
certbot certonly --standalone -d $DOMAIN || { echo "Lỗi khi tạo chứng chỉ với Certbot!" >&2; exit 1; }

NEW_CERT_DIR="/etc/letsencrypt/live/$DOMAIN"

# Kiểm tra chứng chỉ mới có tồn tại không
if [ ! -f "$NEW_CERT_DIR/privkey.pem" ] || [ ! -f "$NEW_CERT_DIR/fullchain.pem" ]; then
    echo "Chứng chỉ mới không đầy đủ hoặc không tồn tại!" >&2
    exit 1
fi

# Tắt dịch vụ Zimbra
echo "Stopping Zimbra services..."
sudo -u $ZIMBRA_USER $ZIMBRA_DIR/bin/zmcontrol stop || { echo "Lỗi khi dừng Zimbra!" >&2; exit 1; }

# Tạo backup chứng chỉ cũ
mkdir -p $BACKUP_DIR
mv $SSL_DIR/zimbra/* $BACKUP_DIR/ || { echo "Lỗi khi sao lưu chứng chỉ cũ!" >&2; exit 1; }

# Copy chứng chỉ mới
echo "Copying new SSL files..."
cp $NEW_CERT_DIR/privkey.pem $SSL_DIR/zimbra/commercial.key
cp $NEW_CERT_DIR/fullchain.pem $SSL_DIR/zimbra/commercial.crt
cp $NEW_CERT_DIR/fullchain.pem $SSL_DIR/zimbra/commercial_ca.crt

# Kiểm tra việc copy có thành công không
if [ $? -ne 0 ]; then
    echo "Lỗi khi sao chép chứng chỉ mới!" >&2
    exit 1
fi

# Thay đổi quyền sở hữu file
echo "Setting file permissions..."
chown -R $ZIMBRA_USER:$ZIMBRA_USER $SSL_DIR/zimbra
chmod 640 $SSL_DIR/zimbra/*

# Update SSL
echo "Deploying new SSL certificates..."
sudo -u $ZIMBRA_USER $ZIMBRA_DIR/bin/zmcertmgr deploycrt comm \
    $SSL_DIR/zimbra/commercial.crt \
    $SSL_DIR/zimbra/commercial_ca.crt || { echo "Lỗi khi cập nhật SSL!" >&2; exit 1; }

# Khởi động lại dịch vụ Zimbra
echo "Starting Zimbra services..."
sudo -u $ZIMBRA_USER $ZIMBRA_DIR/bin/zmcontrol start || { echo "Lỗi khi khởi động Zimbra!" >&2; exit 1; }

echo "SSL Renewal Completed!"
