#!/bin/bash

echo "This Script is used to manipulate data on NetBox automatically using a command-line tool without having to access NetBox's web interface."
echo "Before Launch, we will check your devices to make sure that this script can run successfully!"
# Pre-Launch function
pre_launch_check() {

    # Kiểm tra hệ điều hành
    if [[ "$(uname -s)" != "Linux" ]]; then
        echo "You must using Linux OS to run this scripts!"
        exit 1
    else
        echo "Checking........"
        echo "OS Checking complete!"
    fi

    # Kiểm tra quyền Root
    if [[ $EUID -ne 0 ]]; then
        echo "You should run this scripts with root's permission!"
        exit 1
    else
        echo "Checking......."
        echo "Permission Checking complete!"
    fi

    # Kiểm tra trạng thái kết nối
    read -p "Input the NetBox URL: " DOMAIN

    if ping -c 4 "$DOMAIN" > /dev/null 2>&1; then
        echo "Connect to $DOMAIN success!"
    else
        echo "Can't connect to $DOMAIN. Please check again! "
        exit 1
    fi

    echo "Finished Checking!"
}

main_menu() {
    echo "========== Main Menu =========="
    echo "1. Add"
    echo "2. Update"
    echo "3. Delete"
    echo "4. Exit"
    echo "=============================="
    read -p "Your choice: " main_choice

    case $main_choice in
        1) echo "Add" ;;
        2) echo "Update" ;;
        3) echo "Delete" ;;
        4) exit 0 ;;
        *) echo "Wrong choice. Please check again!" ;;
    esac
}


# Gọi hàm Pre-Launch
pre_launch_check
