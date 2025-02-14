#!/bin/bash

# Nhập thông tin từ người dùng
read -p "Enter user Zimbra: " ZIMBRA_USER
read -p "Enter Zimbra dic: " ZIMBRA_DIR
read -p "Enter SSL dic: " SSL_DIR
read -p "Enter new SSL dic: " NEW_CERT_DIR

BACKUP_DIR="$SSL_DIR/backup_$(date +%F_%T)"

# Kiểm tra thư mục Zimbra tồn tại không
if [ ! -d "$ZIMBRA_DIR" ]; then
    echo "Zimbra un exists!" >&2
    exit 1
fi

# Kiểm tra thư mục SSL tồn tại không
if [ ! -d "$SSL_DIR" ]; then
    echo "SSL un exists!" >&2
    exit 1
fi

# Kiểm tra chứng chỉ mới có tồn tại không
if [ ! -f "$NEW_CERT_DIR/privkey.pem" ] || [ ! -f "$NEW_CERT_DIR/fullchain.pem" ] || [ ! -f "$NEW_CERT_DIR/ca.pem" ]; then
    echo "New CA wrong!" >&2
    exit 1
fi

# Tắt dịch vụ Zimbra
echo "Stopping Zimbra services..."
sudo -u $ZIMBRA_USER $ZIMBRA_DIR/bin/zmcontrol stop || { echo "Error stop Zimbra!" >&2; exit 1; }

# Tạo backup chứng chỉ cũ
mkdir -p $BACKUP_DIR
mv $SSL_DIR/zimbra/* $BACKUP_DIR/ || { echo "Error copy!" >&2; exit 1; }

# Copy chứng chỉ mới
echo "Copying new SSL files..."
mv $NEW_CERT_DIR/privkey.pem $SSL_DIR/zimbra/commercial.key
mv $NEW_CERT_DIR/fullchain.pem $SSL_DIR/zimbra/commercial.crt
mv $NEW_CERT_DIR/ca.pem $SSL_DIR/zimbra/commercial_ca.crt

# Kiểm tra việc copy có thành công không
if [ $? -ne 0 ]; then
    echo "Error while copy new CA!" >&2
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
    $SSL_DIR/zimbra/commercial_ca.crt || { echo "Error while updating!" >&2; exit 1; }

# Khởi động lại dịch vụ Zimbra
echo "Starting Zimbra services..."
sudo -u $ZIMBRA_USER $ZIMBRA_DIR/bin/zmcontrol start || { echo "Error while starting Zimbra!" >&2; exit 1; }

echo "SSL Renewal Completed!"
