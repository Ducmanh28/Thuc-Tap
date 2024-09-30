#!/bin/bash

echo "This Script is used to manipulate data on NetBox automatically using a command-line tool without having to access NetBox's web interface."
echo "Before Launch, we will check your devices to make sure that this script can run successfully!"
# Pre-Launch function
pre_launch_check() {

    echo "Before running, we need some informations about your NetBox Server"
    read -p "Input the NetBox URL": NETBOX_URL
    #read -p "Input the NetBox Ip Address": NETBOX_IP
    read -p "Input the API Token of NetBox:" NETBOX_API

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
    response=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Token $NETBOX_API" https://$NETBOX_URL/api/)
    if [[ $response -ne 200 ]]; then
        echo "Không thể kết nối đến API NetBox. Vui lòng kiểm tra URL và token."
        exit 1
    else    
        echo "Connect to $NETBOX_URL successfully!"
    fi

    echo "Finished Checking!"
}


main_menu() {
    echo "========== Main Menu =========="
    echo "1. Add Device"
    echo "2. Update Device"
    echo "3. Delete Device"
    echo "4. Exit"
    echo "==============================="
    read -p "Your choice: " main_choice

    case $main_choice in
        1) add_device ;;
        2) update_device ;;
        3) delete_device ;;
        4) exit 0 ;;
        *) echo "Wrong choice. Please check again!" ;;
    esac
}
add_menu() {
    echo "========== Add Menu =========="
    echo "1. Create new"
    echo "2. Take data from NetBox"
    echo "3. Comback"
    echo "4. Exit"
    echo "==============================="
    read -p "Your choice: " data_r_choice
    case $data_r_choice in
        1) create_menu ;;
        2) update_device ;;
        3) main_menu ;;
        4) exit 0;
}
create_menu() {
    echo "========== Create Menu =========="
    echo "1. Create new Site"
    echo "2. Create new Device Role"
    echo "3. Create new Device Type"
    echo "4. Continue"
    echo "==============================="
    read -p "Your choice: " data_r_choice
    case $data_r_choice in
        1) create_site ;;
        2) create_device_role ;;
        3) create_device_type ;;
        4) add_menu;
}
create_site () {
    ...
    create_menu
}

create_device_type () {
    ...
    create_menu
}

create_device_role () {
    ...
    create_menu
}

add_device() {
    add_menu
}

take_data_from_NetBox () {

}
update_device() {

}

delete_device() {

}

# Gọi hàm Pre-Launch
pre_launch_check
main_menu

