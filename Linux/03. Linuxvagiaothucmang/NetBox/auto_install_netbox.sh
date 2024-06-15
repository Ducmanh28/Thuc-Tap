#!/bin/bash


# Hàm cài đặt PostgreSQL Server
function  {
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
        fi
    else
        echo "PostgreSQL is already installed!"
    fi
}

# Hàm khởi tạo User PostgreSQL Server
function user_PostgreSQL {
    echo "Starting creat Database, user and grant permission"
    sudo -i -u postgres psql <<EOF
        CREATE DATABASE $POSTGRESQL_DATABASE;
        CREATE USER $POSTGRESQL_USERNAME WITH PASSWORD '$POSTGRESQL_PASSWORD';
        ALTER DATABASE $POSTGRESQL_DATABASE;
        GRANT ALL PRIVILEGES ON DATABASE $POSTGRESQL_DATABASE TO $POSTGRESQL_USERNAME;
EOF
    # Check process
    if [$? -eq 0]; then
        echo "Database, user, and permission have been successfully created and granted."
    else 
        echo "Error: Failed to create database, user"
    fi
}

# Hàm cài đặt Redis
function install_Redis {
    if ! dpkg -l | grep -q "redis-server"; then
        echo "Redis is not installed. Installing Redis..."
        sudo apt install -y redis-server

        # Check process
        if dpkg -l | grep -q "redis-server";then
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

    # Check if /opt/netbox directory exists
    echo "Checking directory /opt/netbox..."
    if [ ! -d "/opt/netbox" ]; then
    # Mặc định cho cài bản mới nhất
        # Download and install Netbox
        echo "Downloading netbox..."
        sudo wget "https://github.com/netbox-community/netbox/archive/refs/tags/$netbox_version.tar.gz" -P /tmp
        if [ $? -ne 0 ]; then
            echo "Error: Failed to download Netbox version $netbox_version."
            exit 1
        else
            echo "Extracting Netbox..."
            sudo tar -xzf "/tmp/$netbox_version.tar.gz" -C /opt
            if [ $? -ne 0 ]; then
                echo "Error: Failed to extract Netbox version $netbox_version."
                exit 1
            fi
            echo "Creating Symbolic link..."
            sudo ln -s "/opt/netbox-$netbox_version/" /opt/netbox
            echo "Add user and create group "
            sudo adduser --system --group $GROUP_NAME
            echo "Change Owner of netbox to $GROUP_NAME"
            sudo chown --recursive $GROUP_NAME /opt/netbox/netbox/media/
            sudo chown --recursive $GROUP_NAME /opt/netbox/netbox/reports/
            sudo chown --recursive $GROUP_NAME /opt/netbox/netbox/scripts/

            # Check if the installation was successful
            if [ $? -eq 0 ]; then
                echo "Netbox version $netbox_version has been successfully installed."
            else
                echo "Error: Failed to install Netbox version $netbox_version."
                exit 1
            fi
        fi
    else
        echo "Netbox is already downloaded."
    fi
}

# Hàm cấu hình NetBox để cài đặt
function configure_netbox_to_install {
    echo "Making Secret key..."
    Secret_key = $(python3 /opt/netbox/netbox/genarate_secret_key.py)
    echo "Genarating secret key compele. Move to netbox file"
    echo "Copying file configuration.py"
    cp configuration_example.py configuration.py
    echo "Editing file config..."
    sed -i "s/^ALLOWED_HOSTS = \[\]$/ALLOWED_HOSTS = ['$DNS','$IP']/g" configuration.py
    sed -i "s/'USER': ''/'USER': '$POSTGRES_USERNAME'/g" configuration.py
	sed -i "0,/'PASSWORD': ''/s/'PASSWORD': ''/'PASSWORD': '$POSTGRES_PASSWORD'/g" configuration.py
	sed -i "s/SECRET_KEY = ''/SECRET_KEY = '\/$Secret_key'/g" configuration.py
    echo "Complete config"
    echo "Installing NetBox..."
    /opt/netbox/upgrade.sh
    echo "NetBox has been successfully installed on your System!"
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
}

# Hàm cài đặt Nginx
function install_nginx {
    if ! dpkg -l | grep -q "nginx"; then
        echo "Nginx is not installed. Installing Nginx..."
        sudo apt install -y nginx

        # Check process
        if dpkg -l | grep -q "nginx";then
            echo "Nginx has been successfully installed."
        else
            echo "Error: Failed to install Nginx."
            exit 1
        fi
    else 
        echo "Nginx is already installed"
    fi
}


# Hàm cấu hình Nginx
function config_nginx {
    echo "Editing main config file of Nginx"
    sudo sed -i '/http {/a \ \ server_names_hash_bucket_size 64;' /etc/nginx/nginx.conf
    echo "Creat Virtual Host of Nginx and making it to Reverse Proxy"
    sudo tee /etc/nginx/sites-available/netbox.conf > /dev/null <<EOF
server {
    listen 80;
    server_name ${Nginx_HOSTS};
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
    sudo systemctl enable nginx
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
    else 
        echo "Root permissions check complete!"
    fi
}
# Hàm main 
function main {
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

    read -p "Enter the NetBox version [latest]: " netbox_version
    netbox_version=${netbox_version:-latest}

    read -p "Enter the group name for NetBox [netbox]: " GROUP_NAME
    GROUP_NAME=${GROUP_NAME:-netbox}

    download_netbox

    read -p "Enter the DNS for NetBox configuration [localhost]: " DNS
    DNS=${DNS:-localhost}

    read -p "Enter the IP for NetBox configuration [127.0.0.1]: " IP
    IP=${IP:-127.0.0.1}

    read -p "Enter the PostgreSQL username for NetBox configuration [netbox_user]: " POSTGRES_USERNAME
    POSTGRES_USERNAME=${POSTGRES_USERNAME:-netbox_user}

    read -p "Enter the PostgreSQL password for NetBox configuration [netbox_pass]: " POSTGRES_PASSWORD
    POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-netbox_pass}

    configure_netbox_to_install

    read -p "Enter the NetBox superuser password [admin_pass]: " NETBOX_PASSWORD
    NETBOX_PASSWORD=${NETBOX_PASSWORD:-admin_pass}

    read -p "Enter the NetBox superuser username [admin]: " NETBOX_USERNAME
    NETBOX_USERNAME=${NETBOX_USERNAME:-admin}

    read -p "Enter the NetBox superuser email [admin@example.com]: " NETBOX_MAIL
    NETBOX_MAIL=${NETBOX_MAIL:-admin@example.com}

    configure_netbox_to_use

    install_nginx

    read -p "Enter the Nginx hosts for NetBox configuration [localhost]: " Nginx_HOSTS
    Nginx_HOSTS=${Nginx_HOSTS:-localhost}

    config_nginx

    Ufw_turnon

    # Tính tổng thời gian chạy ứng dụng
    Total_time

    # Thông báo hoàn thành
    echo "NetBox installation and configuration complete!"
}


echo "This Scripts is used to install NetBox and all the things need to run NetBox! To run this Scripts, you will need root permission."
echo "You can access root permission by entering 'sudo su' and input your sudo password! "
echo "Before running this Scripts, please read README at: https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/README.md"
read -p "Choose 'yes/no' to run or out: " choice
if ["$choice" == "yes"]; then
    main;
else 
    exit 1
fi


