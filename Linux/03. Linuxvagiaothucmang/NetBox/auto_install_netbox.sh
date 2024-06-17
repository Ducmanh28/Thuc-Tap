#!/bin/bash

# Hàm cài đặt PostgreSQL Server
function install_postgresql {
    if ! dpkg -l | grep -q "postgresql"; then
        echo "Installing PostgreSQL..."
        
        # Install PostgreSQL
        echo "Update system...."
        sudo apt update
        echo "Installing PostgreSQL Server...."
        sudo apt install -y postgresql postgresql-contrib
        
        # Check installation status
        if dpkg -l | grep -q "postgresql"; then
            echo "PostgreSQL has been successfully installed!"
        else
            echo "Error: Failed to install PostgreSQL."
            exit 1
            Total_time
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
    # Check process
    if [ $? -eq 0 ]; then
        echo "Database, user, and permission have been successfully created and granted."
    else 
        echo "Error: Failed to create database or user."
        exit 1
        Total_time
    fi
}

# Hàm cài đặt Redis
function install_Redis {
    if ! dpkg -l | grep -q "redis"; then
        echo "Redis is not installed. Installing Redis..."
        sudo apt install -y redis

        # Check process
        if dpkg -l | grep -q "redis";then
            echo "Redis has been successfully installed."
        else
            echo "Error: Failed to install Redis."
            exit 1
            Total_time
        fi
    else 
        echo "Redis is already installed"
    fi
}

# Hàm cài đặt Python
function install_python {
    echo "Installing Python...."
    sudo apt install -y python3 python3-pip python3-venv python3-dev build-essential libxml2-dev libxslt1-dev libffi-dev libpq-dev libssl-dev zlib1g-dev
    echo "Python3 has been successfully installed."
}

# Hàm cài đặt NetBox
function download_netbox {
    # Cài đặt wget nếu cần thiết
    if ! command -v wget &> /dev/null; then
        sudo apt install -y wget
    fi

    local netbox_dir="/opt/netbox"
    local netbox_tar="/tmp/v$netbox_version.tar.gz"

    # Kiểm tra nếu thư mục /opt/netbox tồn tại
    if [ -d "$netbox_dir" ]; then
        echo "Netbox is already downloaded."
    else
        echo "Downloading Netbox..."
        sudo wget "https://github.com/netbox-community/netbox/archive/refs/tags/v$netbox_version.tar.gz" -P /tmp
        if [ $? -ne 0 ]; then
            echo "Error: Failed to download Netbox version $netbox_version."
            exit 1
            Total_time
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
#!/bin/bash

#!/bin/bash

# Đường dẫn tới tệp lưu trạng thái
INSTALL_STATUS_FILE="/opt/netbox/.netbox_installed"

#!/bin/bash

# Đường dẫn tới tệp lưu trạng thái
INSTALL_STATUS_FILE="/opt/netbox/.netbox_installed"

# Hàm cấu hình NetBox để cài đặt
function configure_netbox_to_install {
    echo "Making Secret key..."
    Secret_key=$(python3 /opt/netbox/netbox/generate_secret_key.py)
    if [ $? -ne 0 ]; then
        echo "Error: Failed to generate secret key."
        exit 1
    fi
    
    echo "Generating secret key complete. Moving to NetBox file..."
    
    # Kiểm tra nếu tệp configuration.py đã tồn tại và đã được cấu hình
    if [ -f /opt/netbox/netbox/netbox/configuration.py ]; then
        echo "Configuration file 'configuration.py' already exists."
        if grep -q "SECRET_KEY = '$Secret_key'" /opt/netbox/netbox/netbox/configuration.py && \
           grep -q "ALLOWED_HOSTS = ['$DNS','$IP']" /opt/netbox/netbox/netbox/configuration.py && \
           grep -q "'USER': '$POSTGRES_USERNAME'" /opt/netbox/netbox/netbox/configuration.py && \
           grep -q "'PASSWORD': '$POSTGRES_PASSWORD'" /opt/netbox/netbox/netbox/configuration.py; then
            echo "NetBox configuration is already up to date. Skipping configuration."
        else
            echo "Updating configuration file..."
            # Thay đổi các giá trị trong configuration.py nếu cần thiết
            sed -i "s/^ALLOWED_HOSTS = \[\]$/ALLOWED_HOSTS = ['$DNS','$IP']/g" /opt/netbox/netbox/netbox/configuration.py || { echo "Error: Failed to edit ALLOWED_HOSTS."; exit 1; }
            sed -i "s/'USER': ''/'USER': '$POSTGRES_USERNAME'/g" /opt/netbox/netbox/netbox/configuration.py || { echo "Error: Failed to edit DATABASES USER."; exit 1; }
            sed -i "0,/'PASSWORD': ''/s/'PASSWORD': ''/'PASSWORD': '$POSTGRES_PASSWORD'/g" /opt/netbox/netbox/netbox/configuration.py || { echo "Error: Failed to edit DATABASES PASSWORD."; exit 1; }
            sed -i "s/SECRET_KEY = ''/SECRET_KEY = '$Secret_key'/g" /opt/netbox/netbox/netbox/configuration.py || { echo "Error: Failed to edit SECRET_KEY."; exit 1; }
            echo "Configuration updated."
        fi
    else
        echo "Copying file configuration.py"
        cp /opt/netbox/netbox/netbox/configuration_example.py /opt/netbox/netbox/netbox/configuration.py || { echo "Error: Failed to copy configuration file."; exit 1; }
        echo "Editing configuration file..."
        # Thay đổi các giá trị trong configuration.py
        sed -i "s/^ALLOWED_HOSTS = \[\]$/ALLOWED_HOSTS = ['$DNS','$IP']/g" /opt/netbox/netbox/netbox/configuration.py || { echo "Error: Failed to edit ALLOWED_HOSTS."; exit 1; }
        sed -i "s/'USER': ''/'USER': '$POSTGRES_USERNAME'/g" /opt/netbox/netbox/netbox/configuration.py || { echo "Error: Failed to edit DATABASES USER."; exit 1; }
        sed -i "0,/'PASSWORD': ''/s/'PASSWORD': ''/'PASSWORD': '$POSTGRES_PASSWORD'/g" /opt/netbox/netbox/netbox/configuration.py || { echo "Error: Failed to edit DATABASES PASSWORD."; exit 1; }
        sed -i "s/SECRET_KEY = ''/SECRET_KEY = '$Secret_key'/g" /opt/netbox/netbox/netbox/configuration.py || { echo "Error: Failed to edit SECRET_KEY."; exit 1; }
        echo "Configuration complete."
    fi
    
    # Kiểm tra nếu NetBox đã được cài đặt trước đó
    if [ -f "$INSTALL_STATUS_FILE" ]; then
        echo "NetBox has already been installed. Skipping installation."
    else
        echo "Installing NetBox..."
        /opt/netbox/upgrade.sh || { echo "Error: Failed to install NetBox."; exit 1; }
        echo "NetBox has been successfully installed on your system!"
        # Tạo tệp để đánh dấu đã cài đặt thành công
        touch "$INSTALL_STATUS_FILE" || { echo "Error: Failed to create install status file."; exit 1; }
    fi
}


# Hàm cấu hình NetBox để sử dụng
function configure_netbox_to_use {
    echo "Access Virtual Enviroment..."
    source /opt/netbox/venv/bin/activate
    cd /opt/netbox/netbox
    # Create Superuser
    echo "Create SuperUser"
	DJANGO_SUPERUSER_PASSWORD=$NETBOX_PASSWORD python3 /opt/netbox/netbox/manage.py createsuperuser --no-input --username $NETBOX_USERNAME --email $NETBOX_MAIL
    # Create a symbolic link for cron job
    echo "Creating a symbolic link..."
    ln -s /opt/netbox/contrib/netbox-housekeeping.sh /etc/cron.daily
	# Start Netbox Server
	#python3 manage.py runserver 0.0.0.0:8000 --insecure
	#deactivate
    # Create daemon for Netbox
    echo "Copy setting of gunicorn..."
    cp /opt/netbox/contrib/gunicorn.py /opt/netbox/gunicorn.py
    echo "Making Netbox can use systemctl..."
    cp -v /opt/netbox/contrib/*.service /etc/systemd/system/
    echo "Reload deamon and startting NetBox"
    systemctl daemon-reload
    systemctl start netbox netbox-rq
    systemctl enable netbox netbox-rq
    systemctl restart netbox.service
     # Kiểm tra xem tất cả các dịch vụ đã khởi động thành công hay không
    systemctl is-active --quiet netbox netbox-rq
    if [ $? -ne 0 ]; then
        echo "Error: Some NetBox services failed to start."
        exit 1
        Total_time
    else 
        systemctl restart netbox.service
        echo "NetBox configuration and startup completed successfully!."
    fi    
}

# Hàm cài đặt Nginx
function install_nginx {
    if ! dpkg -l | grep -q "nginx"; then
        echo "Nginx is not installed. Installing Nginx..."
        sudo apt install -y nginx
        # Check process
        if dpkg -l | grep -q "nginx";then
            echo "Nginx has been successfully installed."
            systemctl start nginx
        else
            echo "Error: Failed to install Nginx."
            exit 1
            Total_time
        fi
    else 
        echo "Nginx is already installed"
    fi
}
# Hàm kiểm tra apache2
function check_apache2 {
    if dpkg -l | grep -q "apache2"; then
        echo "Found Apache2 on your Server. Turning off...."
        sudo systemctl stop apache2
        sudo systemctl disable apache2    
    fi
}



# Hàm cấu hình Nginx
function config_nginx {
    echo "Editing main config file of Nginx"
    sudo sed -i '/http {/a \ \ server_names_hash_bucket_size 64;' /etc/nginx/nginx.conf
    echo "Creat Virtual Host of Nginx and making it to Reverse Proxy"
    if dpkg -l | grep -q "netbox.conf";then
        rm -rf /etc/nginx/sites-enabled/netbox.conf
        rm -rf /etc/nginx/site-available/netbox.conf
    fi
    sudo tee /etc/nginx/sites-available/netbox.conf > /dev/null <<EOF
server {
    listen 80;
    server_name ${Nginx_HOSTS}, ${Nginx_HOSTS_IP};
    access_log /var/log/nginx/netbox.access.log;
    error_log /var/log/nginx/netbox.error.log;

    client_max_body_size 25m;

    location /static/ {
        alias /opt/netbox/netbox/static/;
    }

    location / {
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$http_host;
        proxy_pass http://127.0.0.1:8001;
    }
}
EOF
    echo "Enable new config..."
    rm /etc/nginx/sites-enabled/default
    ln -s /etc/nginx/sites-available/netbox.conf /etc/nginx/sites-enabled/netbox.conf
    echo "Restarting Nginx"
    sudo systemctl start nginx
    sudo systemctl restart nginx
    # Kiểm tra lại cấu hình Nginx
    echo "Checking Nginx configuration..."
    sudo nginx -t
    if [ $? -eq 0 ]; then
        echo "Nginx configuration test successful. Reloading Nginx..."
        sudo systemctl reload nginx
        sudo systemctl enable nginx
        sudo systemctl start nginx
    else
        echo "Error: Nginx configuration test failed. Rolling back changes..."
        # Đảm bảo rằng Nginx không bị tắt bởi cấu hình sai
        sudo systemctl reload nginx
        exit 1
        Total_time
    fi
	cd ~
}

# Hàm bật tường lửa
function Ufw_turnon {
    echo "Allowing port in UFW.... "
    sudo ufw allow 8000/tcp
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    sudo ufw allow 8001
    echo "Complete allow Port"
}

# Hàm tính tổng thời gian chạy ứng dụng
function Total_time {
    local total_seconds=$SECONDS
    local hours=$((total_seconds / 3600))
    local minutes=$(( (total_seconds % 3600) / 60 ))
    local seconds=$((total_seconds % 60))

    echo "Finished in: ${hours} hours, ${minutes} minutes and ${seconds} seconds"
}

# Hàm check quyền root của user thực hiện scripts
check_root_permissions() {
    echo "Checking root permissions of current user!"
    if [[ $(id -u) -ne 0 ]]; then
        echo "You need root permissions to run this script. Exiting..."
        exit 1
        Total_time
    else 
        echo "Root permissions check complete!"
    fi
}
# Hàm kiểm tra địa chỉ IP
check_ip() {
    IP=$1                                                     
    if [[ $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then   # Chia IP thành 2 phần: 3 phần có "." và 1 phần không có
        for octet in ${IP//./ }; do     # Vòng lặp kiểm tra từng octet 
            if ((octet > 255)); then    # Nếu giá trị của octet lớn hơn 255
                echo "Invalid IP address: $IP. Each octet must be between 0 and 255."
                exit 1
            fi
        done
    else       # Nếu không đúng kiểu địa chỉ
        echo "Invalid IP address format: $IP. Please check again."
        exit 1
        Total_time
    fi
}
# Hàm check hệ điều hành
check_os() {
    if [[ "$(lsb_release -is)" != "Ubuntu" ]]; then         # Câu lệnh `lsb_release -is` sẽ trả về giá trị tên của hệ điều hành
        echo "Only Ubuntu Server can use this script."
        exit 1
        Total_time
    fi
}

# Hàm cấu hình chứng chỉ SSL
function create_ssl {
    # Số ngày hiệu lực của chứng chỉ
    DAYS_VALID=365
    # Tên file private key
    PRIVATE_KEY_FILE="/etc/ssl/private/private.key"
    # Tên file CSR
    CSR_FILE="/etc/ssl/certs/certificate.csr"
    # Tên file chứng chỉ
    CERTIFICATE_FILE="/etc/ssl/certs/certificate.crt"
    PASSFILE="/etc/nginx/passphrase.txt"
    echo $PASSPHRASE > $PASSFILE
    chmod 600 $PASSFILE
    # Bắt đầu tạo chứng chỉ SSL
    echo "Create private key..."
    openssl genpkey -algorithm RSA -out $PRIVATE_KEY_FILE -aes256 -pass pass:$PASSPHRASE
    if [ $? -ne 0 ]; then
        echo "Error: Can't create private key"
        exit 1
        Total_time
    fi
    echo "Create Certificate Signing Request (CSR)..."
    openssl req -new -key $PRIVATE_KEY_FILE -passin pass:$PASSPHRASE -out $CSR_FILE -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$ORG_UNIT/CN=$DOMAIN/emailAddress=$EMAILSS"
    if [ $? -ne 0 ]; then
        echo "Error: Can't create Certificate Signing Request."
        exit 1
        Total_time
    fi
    echo "Create Certificate..."
    openssl x509 -req -days $DAYS_VALID -in $CSR_FILE -signkey $PRIVATE_KEY_FILE -passin pass:$PASSPHRASE -out $CERTIFICATE_FILE
    if [ $? -ne 0 ]; then
        echo "Error: Can't create Certificate."
        exit 1
        Total_time
    fi
    echo "Completed!SSL has been created!"
}
# Hàm áp dụng ssl vào nginx
function apply_ssl_to_nginx {
    echo "Editing main config file of Nginx"
    sudo sed -i '/http {/a \ \ server_names_hash_bucket_size 64;' /etc/nginx/nginx.conf
    echo "Creat Virtual Host of Nginx and making it to Reverse Proxy"
    if dpkg -l | grep -q "netbox.conf";then
        rm -rf /etc/nginx/sites-enabled/netbox.conf
        rm -rf /etc/nginx/site-available/netbox.conf
    fi
    PASSFILE="/etc/nginx/passphrase.txt"
    sudo tee /etc/nginx/sites-available/netbox.conf > /dev/null <<EOF
server {
    listen [::]:443 ssl ipv6only=off;
    # CHANGE THIS TO YOUR SERVER'S NAME
    server_name ${Nginx_HOSTS}, ${Nginx_HOSTS_IP};
    ssl_certificate /etc/ssl/certs/certificate.crt;
    ssl_certificate_key /etc/ssl/private/private.key;
    ssl_password_file $PASSFILE;
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
    # Redirect HTTP traffic to HTTPS
    listen [::]:80 ipv6only=off;
    server_name ${Nginx_HOSTS}, ${Nginx_HOSTS_IP};
    return 301 https://\$host\$request_uri;
}
EOF
    echo "Enable new config..."
    rm /etc/nginx/sites-enabled/default
    ln -s /etc/nginx/sites-available/netbox.conf /etc/nginx/sites-enabled/netbox.conf
    echo "Restarting Nginx"
    sudo systemctl start nginx
    sudo systemctl restart nginx
    sudo nginx -t
    if [ $? -eq 0 ]; then
        echo "Nginx configuration test successful. Reloading Nginx..."
        sudo systemctl reload nginx
        sudo systemctl enable nginx
        sudo systemctl start nginx
    else
        echo "Error: Nginx configuration test failed. Rolling back changes..."
        # Đảm bảo rằng Nginx không bị tắt bởi cấu hình sai
        sudo systemctl reload nginx
        exit 1
        Total_time
    fi
	cd ~
}
# Hàm main 
function main {
    check_os
    check_root_permissions

    # Ghi nhận thời gian bắt đầu
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

    read -p "Enter the NetBox version [4.0.5]: " netbox_version
    netbox_version=${netbox_version:-4.0.5}

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
    echo "Install Completed. Now you need to create superuser"

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
    Nginx_HOSTS=${Nginx_HOSTS_IP:-127.0.0.1}
    check_ip $Nginx_HOSTS_IP

    read -p "Do you want to use SSL?[yes/no]: " CHOICE
    if [ "$CHOICE" = "yes" ]; then
        read -p "Common Name[localhost]: " DOMAIN
        DOMAIN=${DOMAIN:-localhost}
        read -p "Country Name[VN]: " COUNTRY
        COUNTRY=${COUNTRY:-VN}
        read -p "State or Province Name: " STATE
        read -p "Locality Name: " LOCALITY
        read -p "Organization Name: " ORGANIZATION
        read -p "Organizational Unit Name: " ORG_UNIT
        read -p "Email Address[netbox@example.com]: " EMAILSS
        EMAILSS=${EMAILSS:-netbox@example.com}

        read -p "Enter passphrase for private key: " PASSPHRASE
        create_ssl
        apply_ssl_to_nginx
        Ufw_turnon
        # Tính tổng thời gian chạy ứng dụng
        Total_time

        # Thông báo hoàn thành
        echo "NetBox installation and configuration complete!"
    else
        config_nginx

        Ufw_turnon

        # Tính tổng thời gian chạy ứng dụng
        Total_time

        # Thông báo hoàn thành
        echo "NetBox installation and configuration complete!"
    fi
}


echo "This Scripts is used to install NetBox and all the things need to run NetBox! To run this Scripts, you will need root permission."
echo "You can access root permission by entering 'sudo su' and input your sudo password! "
echo "Before running this Scripts, please read README at: https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/README.md"
read -p "Confirm to proceed (yes/no): " choice
if [ "$choice" = "yes" ]; then
    main;
else 
    exit 1
fi


