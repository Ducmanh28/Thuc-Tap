#!/bin/bash

# Hàm check quyền sudo của user
check_sudo_privileges() {
    echo "Checking sudo privileges of $1"
    if sudo -lU $1 | grep -q '(ALL : ALL)'; then
        echo "$1 already has sudo privileges."
    else
        echo "$1 does not have sudo privileges."
        echo "Adding sudo privileges for $1..."
        sudo adduser $1 sudo
        echo "Successfully added sudo privileges for $1."
    fi
}

# Hàm check quyền root của user thực hiện scripts
check_root_permissions() {
    echo "Checking root permissions of current user!"
    if [[ $(id -u) -ne 0 ]]; then
        echo "You need root permissions to run this script. Exiting..."
        exit 1
    else 
        echo "Checking root permissions complete!"
    fi
}

# Hàm kiểm tra file backup
check_backup_file() {
    backup_file="/etc/ssh/sshd_config.bak"
    echo "Checking Backup file!"
    if [ ! -f "$backup_file" ]; then
        echo "Not have backupfile!"
        echo "Creating backup file..."
        sudo cp /etc/ssh/sshd_config "$backup_file"
    else
        echo "Backup file check completed."
    fi
}

# Hàm cấp quyền ssh
grant_ssh_access() {
    echo "Checking SSH permissions for $1"
    if grep -q "^AllowUsers.*$1" /etc/ssh/sshd_config || grep -qr "^AllowUsers.*$1" /etc/ssh/sshd_config.d/; then
        echo "$1 already has SSH access."
    else
        echo "$1 does not have SSH access."
        echo "Adding SSH access for $1..."
        echo "Editing SSH configuration to grant SSH access for user $1..."
        sudo sed -i "/^AllowUsers/ s/$/ $1/" /etc/ssh/sshd_config
        echo "Restarting SSH service..."
        sudo systemctl restart ssh
    fi
}

# Hàm cho phép đăng nhập từ xa bằng root
enable_root_login() {
    echo "Checking Root Login Permissions"
    if grep -q "^PermitRootLogin.*yes" /etc/ssh/sshd_config; then
        echo "Root login permitted."
    else
        echo "Enabling root login..."
        sudo sed -i "s/^PermitRootLogin.*/PermitRootLogin yes/" /etc/ssh/sshd_config
        echo "Complete allow Root Login Permissions. Restarting SSH..."
        sudo systemctl restart ssh
    fi
}
disenable_root_login() {
    echo "Checking Root Login Permissions"
    if grep -q "^PermitRootLogin.*no" /etc/ssh/sshd_config; then
        echo "Disable Root login complete."
    else
        echo "Disenableing root login..."
        sudo sed -i "s/^PermitRootLogin.*/PermitRootLogin no/" /etc/ssh/sshd_config
        echo "Complete disallow Root Login Permissions. Restarting SSH..."
        sudo systemctl restart ssh
    fi
}

# Hiển thị thông báo trước khi chạy Script
echo "This script is used to add SSH login permits for users and allow root SSH login for your server."
echo "To run this script, you will need root permissions. This script also creates a backup file for your sshd_config."

# Hỏi người dùng xem có xác nhận sử dụng không?
read -p "Confirm to proceed (yes/no): " choice
if [ "$choice" = "yes" ]; then
    # Kiểm tra quyền root
    check_root_permissions

    # Kiểm tra file backup
    check_backup_file

    # Nhập vào tên user
    read -p "Username: " username

    # Kiểm tra quyền sudo của user
    check_sudo_privileges $username

    # Cấp quyền SSH
    grant_ssh_access $username

    read -p "Do you want to allow Root Login: " choose
    if [ "$choose" = "yes" ]; then
        # Cấp quyền đăng nhập root từ xa
        enable_root_login
    elif [ "$choose" = "no" ];then
        disenable_root_login
    fi
    echo "Successfully granted SSH access for $username."
    exit 0
elif [ "$choice" = "no" ]; then
    echo "Goodbye!"
    exit 0
else
    echo "Please choose either yes or no."
    exit 1
fi
