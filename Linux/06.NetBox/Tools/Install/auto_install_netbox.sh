#!/bin/bash

# Hàm cài đặt PostgreSQL Server
function install_postgresql {
    if ! dpkg -l | grep -q "postgresql"; then
        echo "Installing PostgreSQL..."
        
        echo "Update system...."
        sudo apt update
        echo "Installing PostgreSQL Server...."
        sudo apt install -y postgresql postgresql-contrib
        
        if dpkg -l | grep -q "postgresql"; then
            echo "PostgreSQL has been successfully installed!"
        else
            echo "Error: Failed to install PostgreSQL."
            exit 1
        fi
    else
        echo "PostgreSQL is already installed!"
    fi
}

# Hàm khởi tạo User PostgreSQL Server
function user_PostgreSQL {
    echo "Starting create Database, user and grant permission"
    sudo -i -u postgres psql <<EOF
        CREATE DATABASE $POSTGRESQL_DATABASE;
        CREATE USER $POSTGRESQL_USERNAME WITH PASSWORD '$POSTGRESQL_PASSWORD';
        ALTER DATABASE $POSTGRESQL_DATABASE OWNER TO $POSTGRESQL_USERNAME;
        GRANT ALL PRIVILEGES ON DATABASE $POSTGRESQL_DATABASE TO $POSTGRESQL_USERNAME;
EOF
    if [ $? -eq 0 ]; then
        echo "Database, user, and permission have been successfully created and granted."
    else 
        echo "Error: Failed to create database or user."
        exit 1
    fi
}

# Hàm cài đặt Redis
function install_Redis {
    if ! dpkg -l | grep -q "redis"; then
        echo "Redis is not installed. Installing Redis..."
        sudo apt install -y redis

        if dpkg -l | grep -q "redis";then
            echo "Redis has been successfully installed."
        else
            echo "Error: Failed to install Redis."
            exit 1
        fi
    else 
        echo "Redis is already installed"
    fi
}

# Hàm cài đặt Python
function install_python {
    echo "Installing Python and Dependencies...."
    sudo apt install -y python3 python3-pip python3-venv python3-dev build-essential libxml2-dev libxslt1-dev libffi-dev libpq-dev libssl-dev zlib1g-dev
    echo "Python dependencies have been successfully installed."
}

# Hàm cài đặt NetBox
function download_netbox {
    if ! command -v wget &> /dev/null; then
        sudo apt install -y wget
    fi

    local netbox_dir="/opt/netbox"
    local netbox_tar="/tmp/v$netbox_version.tar.gz"

    if [ -d "$netbox_dir" ]; then
        echo "Netbox is already downloaded."
    else
        echo "Downloading Netbox version $netbox_version..."
        sudo wget "https://github.com/netbox-community/netbox/archive/refs/tags/v$netbox_version.tar.gz" -P /tmp
        if [ $? -ne 0 ]; then
            echo "Error: Failed to download Netbox version $netbox_version."
            exit 1
        fi

        echo "Extracting Netbox..."
        sudo tar -xzf "$netbox_tar" -C /opt
        if [ $? -ne 0 ]; then
            echo "Error: Failed to extract Netbox version $netbox_version."
            exit 1
        fi

        echo "Creating Symbolic link..."
        sudo ln -s "/opt/netbox-$netbox_version/" "$netbox_dir"
        
        echo "Add user and create group"
        sudo adduser --system --group $GROUP_NAME
        
        echo "Change Owner of netbox to $GROUP_NAME"
        sudo chown --recursive $GROUP_NAME "$netbox_dir"/netbox/media/
        sudo chown --recursive $GROUP_NAME "$netbox_dir"/netbox/reports/
        sudo chown --recursive $GROUP_NAME "$netbox_dir"/netbox/scripts/

        echo "Netbox version $netbox_version has been successfully installed."
    fi
}

INSTALL_STATUS_FILE="/opt/netbox/.netbox_installed"

# Hàm cấu hình NetBox để cài đặt
function configure_netbox_to_install {
    echo "Making Secret key..."
    # LƯU Ý: NetBox 4.1+ không còn file generate_secret_key.py. Sử dụng thư viện secrets của Python.
    Secret_key=$(python3 -c "import secrets; print(secrets.token_urlsafe(50))")
    
    if [ -z "$Secret_key" ]; then
        echo "Error: Failed to generate secret key."
        exit 1
    fi
    
    echo "Generating secret key complete. Moving to NetBox config..."
    
    local config_file="/opt/netbox/netbox/netbox/configuration.py"
    
    if [ ! -f "$config_file" ]; then
        echo "Copying file configuration.py"
        cp /opt/netbox/netbox/netbox/configuration_example.py "$config_file" || { echo "Error: Failed to copy configuration file."; exit 1; }
    fi

    echo "Updating configuration file..."
    sed -i "s/^ALLOWED_HOSTS = \[\]$/ALLOWED_HOSTS = ['$DNS','$IP']/g" "$config_file"
    sed -i "s/'USER': ''/'USER': '$POSTGRES_USERNAME'/g" "$config_file"
    sed -i "0,/'PASSWORD': ''/s/'PASSWORD': ''/'PASSWORD': '$POSTGRES_PASSWORD'/g" "$config_file"
    sed -i "s/SECRET_KEY = ''/SECRET_KEY = '$Secret_key'/g" "$config_file"
    echo "Configuration updated."
    
    if [ -f "$INSTALL_STATUS_FILE" ]; then
        echo "NetBox has already been upgraded. Skipping installation."
    else
        echo "Installing NetBox environment..."
        /opt/netbox/upgrade.sh || { echo "Error: Failed to run NetBox upgrade.sh."; exit 1; }
        echo "NetBox environment successfully deployed!"
        touch "$INSTALL_STATUS_FILE"
    fi
}

# Hàm cấu hình NetBox để sử dụng
function configure_netbox_to_use {
    echo "Access Virtual Environment..."
    source /opt/netbox/venv/bin/activate
    cd /opt/netbox/netbox
    
    echo "Create SuperUser"
    DJANGO_SUPERUSER_PASSWORD=$NETBOX_PASSWORD python3 /opt/netbox/netbox/manage.py createsuperuser --no-input --username $NETBOX_USERNAME --email $NETBOX_MAIL
    
    echo "Creating a symbolic link for cron job..."
    if [ ! -L /etc/cron.daily/netbox-housekeeping ]; then
        ln -s /opt/netbox/contrib/netbox-housekeeping.sh /etc/cron.daily/netbox-housekeeping
    fi
    
    echo "Copy setting of gunicorn..."
    cp /opt/netbox/contrib/gunicorn.py /opt/netbox/gunicorn.py
    
    echo "Making Netbox can use systemctl..."
    cp -v /opt/netbox/contrib/*.service /etc/systemd/system/
    
    echo "Reload daemon and startting NetBox services"
    systemctl daemon-reload
    systemctl enable --now netbox netbox-rq
    
    systemctl is-active --quiet netbox netbox-rq
    if [ $? -ne 0 ]; then
        echo "Error: Some NetBox services failed to start."
        exit 1
    else 
        echo "NetBox configuration and startup completed successfully!"
    fi
    deactivate
}

# Hàm cài đặt Nginx
function install_nginx {
    if ! dpkg -l | grep -q "nginx"; then
        echo "Installing Nginx..."
        sudo apt install -y nginx
        if dpkg -l | grep -q "nginx";then
            echo "Nginx has been successfully installed."
            systemctl start nginx
        else
            echo "Error: Failed to install Nginx."
            exit 1
        fi
    else 
        echo "Nginx is already installed"
    fi
}

# Hàm kiểm tra apache2
function check_apache2 {
    if systemctl is-active --quiet apache2; then
        echo "Found active Apache2 on your Server. Turning off to avoid port conflicts...."
        sudo systemctl stop apache2
        sudo systemctl disable apache2    
    fi
}

# Hàm cấu hình Nginx
function config_nginx {
    echo "Creat Virtual Host of Nginx and making it to Reverse Proxy"
    if [ -f /etc/nginx/sites-enabled/netbox.conf ]; then
        rm -rf /etc/nginx/sites-enabled/netbox.conf
        rm -rf /etc/nginx/sites-available/netbox.conf
    fi
    
    sudo tee /etc/nginx/sites-available/netbox.conf > /dev/null <<EOF
server {
    listen 80;
    server_name ${Nginx_HOSTS} ${Nginx_HOSTS_IP};
    access_log /var/log/nginx/netbox.access.log;
    error_log /var/log/nginx/netbox.error.log;

    client_max_body_size 25m;

    location /static/ {
        alias /opt/netbox/netbox/static/;
    }

    location / {
        proxy_pass http://127.0.0.1:8001;
        proxy_set_header X-Forwarded-Host \$http_host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF
    echo "Enable new config..."
    rm -f /etc/nginx/sites-enabled/default
    ln -s /etc/nginx/sites-available/netbox.conf /etc/nginx/sites-enabled/netbox.conf
    
    echo "Checking Nginx configuration..."
    if sudo nginx -t; then
        echo "Nginx configuration test successful. Reloading..."
        sudo systemctl reload nginx
        sudo systemctl enable nginx
    else
        echo "Error: Nginx configuration test failed. Check syntax."
        exit 1
    fi
}

# Hàm bật tường lửa
function Ufw_turnon {
    echo "Allowing ports in UFW.... "
    sudo ufw allow 8000/tcp
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    sudo ufw allow 8001/tcp
    echo "Complete allow Ports"
}

# Hàm tính tổng thời gian chạy ứng dụng
function Total_time {
    local total_seconds=$SECONDS
    local hours=$((total_seconds / 3600))
    local minutes=$(( (total_seconds % 3600) / 60 ))
    local seconds=$((total_seconds % 60))
    echo "Finished in: ${hours} hours, ${minutes} minutes and ${seconds} seconds"
}

# Hàm check quyền root
check_root_permissions() {
    if [[ $(id -u) -ne 0 ]]; then
        echo "You need root permissions to run this script. Exiting..."
        exit 1
    fi
}

# Hàm kiểm tra địa chỉ IP
check_ip() {
    IP=$1                                                     
    if [[ $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then   
        for octet in ${IP//./ }; do      
            if ((octet > 255)); then    
                echo "Invalid IP address: $IP. Each octet must be between 0 and 255."
                exit 1
            fi
        done
    else       
        echo "Invalid IP address format: $IP. Please check again."
        exit 1
    fi
}

# Hàm check hệ điều hành
check_os() {
    if [[ "$(lsb_release -is)" != "Ubuntu" ]]; then         
        echo "Only Ubuntu Server can use this script."
        exit 1
    fi
}

# Hàm cấu hình chứng chỉ SSL
function create_ssl {
    CA_KEY="/etc/ssl/private/CA.key"
    CA_PEM="/etc/ssl/certs/CA.pem"
    
    echo "Making your Server become CA..."
    openssl genrsa -out $CA_KEY 2048 || { echo "Error: Failed to make CA Key."; exit 1; }
    openssl req -x509 -sha256 -new -nodes -days 3650 -key $CA_KEY -out $CA_PEM -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$ORG_UNIT/CN=$DOMAIN/emailAddress=$EMAILSS" || { echo "Error: Failed to make CA Pem."; exit 1; }

    PRIVATE_KEY="/etc/ssl/private/private.key"
    CSR_FILE="/etc/ssl/certs/certificate.csr"
    EXT_FILE="/etc/ssl/certs/certificate.ext"
    CRT_FILE="/etc/ssl/certs/certificate.crt"

    echo "Making private key for your website..."
    openssl genrsa -out $PRIVATE_KEY 2048 || { echo "Error: Failed to make Private Key."; exit 1; }
    openssl req -new -key $PRIVATE_KEY -out $CSR_FILE -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$ORG_UNIT/CN=$DOMAIN/emailAddress=$EMAILSS" || { echo "Error: Failed to make CSR."; exit 1; }

    echo "Making Ext file..."
    sudo tee /etc/ssl/certs/certificate.ext > /dev/null <<EOF
authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = ${Nginx_HOSTS}
IP.1 = ${Nginx_HOSTS_IP}
EOF
    
    echo "Making SSL CRT_file..."
    openssl x509 -req -in $CSR_FILE -CA $CA_PEM -CAkey $CA_KEY -CAcreateserial -days 3650 -sha256 -extfile $EXT_FILE -out $CRT_FILE || { echo "Error: Failed to make CRT."; exit 1; }
    echo "SSL Certificate Generation Complete!"
}

# Hàm áp dụng ssl vào nginx
function apply_ssl_to_nginx {
    echo "Creat Virtual Host of Nginx with SSL Configuration"
    if [ -f /etc/nginx/sites-enabled/netbox.conf ]; then
        rm -rf /etc/nginx/sites-enabled/netbox.conf
        rm -rf /etc/nginx/sites-available/netbox.conf
    fi
    
    sudo tee /etc/nginx/sites-available/netbox.conf > /dev/null <<EOF
server {
    listen [::]:443 ssl;
    listen 443 ssl;
    server_name ${Nginx_HOSTS} ${Nginx_HOSTS_IP};
    
    ssl_certificate /etc/ssl/certs/certificate.crt;
    ssl_certificate_key /etc/ssl/private/private.key;
    
    client_max_body_size 25m;
    
    location /static/ {
        alias /opt/netbox/netbox/static/;
    }
    
    location / {
        proxy_pass http://127.0.0.1:8001;
        proxy_set_header X-Forwarded-Host \$http_host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}

server {
    listen [::]:80;
    listen 80;
    server_name ${Nginx_HOSTS} ${Nginx_HOSTS_IP};
    return 301 https://\$host\$request_uri;
}
EOF

    echo "Enable SSL config..."
    rm -f /etc/nginx/sites-enabled/default
    ln -s /etc/nginx/sites-available/netbox.conf /etc/nginx/sites-enabled/netbox.conf
    
    if sudo nginx -t; then
        echo "Nginx configuration test successful. Reloading..."
        sudo systemctl reload nginx
        sudo systemctl enable nginx
    else
        echo "Error: Nginx SSL configuration failed."
        exit 1
    fi
}

# Hàm main 
function main {
    check_os
    check_root_permissions
    SECONDS=0

    install_postgresql
    read -p "Enter the PostgreSQL database name [netbox_db]: " POSTGRESQL_DATABASE
    POSTGRESQL_DATABASE=${POSTGRESQL_DATABASE:-netbox_db}

    read -p "Enter the PostgreSQL username [netbox_user]: " POSTGRESQL_USERNAME
    POSTGRESQL_USERNAME=${POSTGRESQL_USERNAME:-netbox_user}

    read -p "Enter the PostgreSQL password [netbox_pass]: " POSTGRESQL_PASSWORD
    POSTGRESQL_PASSWORD=${POSTGRESQL_PASSWORD:-netbox_pass}

    user_PostgreSQL
    install_Redis
    install_python

    read -p "Enter the NetBox version [4.1.10]: " netbox_version
    netbox_version=${netbox_version:-4.1.10}

    read -p "Enter the group name for NetBox [netbox]: " GROUP_NAME
    GROUP_NAME=${GROUP_NAME:-netbox}

    download_netbox

    read -p "Enter the DNS for NetBox configuration [localhost]: " DNS
    DNS=${DNS:-localhost}

    read -p "Enter the IP for NetBox configuration [127.0.0.1]: " IP
    IP=${IP:-127.0.0.1}
    check_ip $IP

    read -p "Enter the PostgreSQL username for NetBox configuration [netbox_user]: " POSTGRES_USERNAME
    POSTGRES_USERNAME=${POSTGRES_USERNAME:-netbox_user}

    read -p "Enter the PostgreSQL password for NetBox configuration [netbox_pass]: " POSTGRES_PASSWORD
    POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-netbox_pass}
    
    configure_netbox_to_install
    
    echo "Install Completed. Setting up Superuser account..."
    read -p "Enter the NetBox superuser username [admin]: " NETBOX_USERNAME
    NETBOX_USERNAME=${NETBOX_USERNAME:-admin}
    
    read -p "Enter the NetBox superuser password [admin_pass]: " NETBOX_PASSWORD
    NETBOX_PASSWORD=${NETBOX_PASSWORD:-admin_pass}

    read -p "Enter the NetBox superuser email [admin@example.com]: " NETBOX_MAIL
    NETBOX_MAIL=${NETBOX_MAIL:-admin@example.com}

    configure_netbox_to_use
    check_apache2
    install_nginx

    read -p "Enter the Nginx hosts for NetBox configuration [localhost]: " Nginx_HOSTS
    Nginx_HOSTS=${Nginx_HOSTS:-localhost}
    read -p "Enter the Nginx IP for NetBox configuration [127.0.0.1]: " Nginx_HOSTS_IP
    Nginx_HOSTS_IP=${Nginx_HOSTS_IP:-127.0.0.1}
    check_ip $Nginx_HOSTS_IP

    read -p "Do you want to use SSL? [yes/no]: " CHOICE
    if [ "$CHOICE" = "yes" ]; then
        read -p "Common Name[localhost]: " DOMAIN
        DOMAIN=${DOMAIN:-localhost}
        read -p "Country Name[VN]: " COUNTRY
        COUNTRY=${COUNTRY:-VN}
        read -p "State or Province Name[HN]: " STATE
        STATE=${STATE:-HN}
        read -p "Locality Name: " LOCALITY
        LOCALITY=${LOCALITY:-HN}
        read -p "Organization Name: " ORGANIZATION
        read -p "Organizational Unit Name: " ORG_UNIT
        read -p "Email Address[netbox@example.com]: " EMAILSS
        EMAILSS=${EMAILSS:-netbox@example.com}

        create_ssl
        apply_ssl_to_nginx
    else
        config_nginx
    fi
    
    Ufw_turnon
    Total_time

    echo "================================================================"
    echo " NetBox installation and configuration complete! "
    if [ "$CHOICE" = "yes" ]; then
        echo " To access via HTTPS securely, import 'CA.pem' to your browser."
    fi
    echo " Check README at: https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/README.md "
    echo "================================================================"
}

echo "This script installs NetBox & prerequisites automatically!"
echo "Please execute with root permissions (e.g. sudo ./auto_install_netbox.sh)"
echo "Documentation: https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/README.md"
read -p "Confirm to proceed (yes/no): " choice
if [ "$choice" = "yes" ]; then
    main
else 
    exit 1
fi