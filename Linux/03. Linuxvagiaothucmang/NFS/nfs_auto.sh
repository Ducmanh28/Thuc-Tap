#!/bin/bash

# Tạo hàm kiểm tra hệ điều hành
check_os() {
    if [[ "$(lsb_release -is)" != "Ubuntu" ]]; then         # Câu lệnh `lsb_release -is` sẽ trả về giá trị tên của hệ điều hành
        echo "Only Ubuntu Server can use this script."
        exit 1
    fi
}

install_package() {
    PACKAGE_NAME=$1                           # Gán biến bằng giá trị sẽ chèn vào
    if ! dpkg -l | grep -q $PACKAGE_NAME; then     # Kiểm tra xem biến đã tồn tại trong list chưa
        echo "$PACKAGE_NAME isn't installed on this server. Installing..."
        sudo apt update
        sudo apt install -y $PACKAGE_NAME
    else
        echo "$PACKAGE_NAME is already installed."
    fi
}

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
    fi
}

check_nfs_port() {
    SERVER_IP=$1
    if nc -zv $SERVER_IP 2049 2>&1 | grep -q succeeded; then # `2>$1` sẽ trả về thông báo kết nối và chuyển thông báo ra sau cho grep kiểm tra
        echo "Port 2049 (NFS) on $SERVER_IP is open."
    else
        echo "Port 2049 (NFS) on $SERVER_IP is not open. Please check the server configuration."
        exit 1
    fi
}

check_directory_exists() {
    LOCAL_DIR=$1
    if [[ -d $LOCAL_DIR ]]; then
        echo "Directory $LOCAL_DIR exists."
    else
        echo "Directory $LOCAL_DIR does not exist. Creating it..."
        mkdir -p $LOCAL_DIR
        if [[ $? -eq 0 ]]; then
            echo "Successfully created directory $LOCAL_DIR."
        else
            echo "Failed to create directory $LOCAL_DIR."
            exit 1
        fi
    fi
}

check_os

read -p "Do you want to install NFS Server or Client? (1 for Server / 2 for Client): " choice

case $choice in
    1)
        install_package nfs-kernel-server
        echo"Open port NFS for Server..."
        sudo ufw allow nfs
        sudo restart ufw
        echo "Currently shared directories:"
        sudo exportfs -v
        ;;
    2)
        read -p "Do you just want to install or also auto-connect to the server? (a for just install / b for install and connect): " choice2
        install_package nfs-common
        
        if [[ $choice2 == "b" ]]; then
            read -p "Input your NFS Server IP: " SERVER_IP
            read -p "Input your mount directory on the client: " LOCAL_DIR
            
            check_ip $SERVER_IP
            check_directory_exists $LOCAL_DIR
            check_nfs_port $SERVER_IP
            
            REMOTE_DIR="/mnt/shared"
            echo "Mounting directory $REMOTE_DIR from NFS Server $SERVER_IP to $LOCAL_DIR..."
            sudo mount -t nfs ${SERVER_IP}:${REMOTE_DIR} ${LOCAL_DIR}
            
            if [[ $? -eq 0 ]]; then
                echo "Successfully mounted $REMOTE_DIR to $LOCAL_DIR."
            else
                echo "Failed to mount $REMOTE_DIR to $LOCAL_DIR."
                exit 1
            fi
            
            echo "Mounted directories:"
            df -h $LOCAL_DIR
        fi
        ;;
    *)
        echo "Invalid choice. Please select '1' for Server or '2' for Client."
        ;;
esac

