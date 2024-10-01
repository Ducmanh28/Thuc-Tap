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
        echo "Can't connect to NetBox, please check the url and token again!!!"
        exit 1
    else    
        echo "Connect to $NETBOX_URL successfully!"
        echo "Finished Checking!"
    fi

    
}


main_menu() {
    echo "Welcome to the main menu, where you can choose what to do with data of Device in NetBox!"
    echo "========== Main Menu =========="
    echo "1. Add Device"
    echo "2. Update Device"
    echo "3. Delete Device"
    echo "4. Exit"
    echo "==============================="
    read -p "Your choice: " main_choice

    case $main_choice in
        1) add_device ;;
        2) echo "Create data" ;;
        3) echo "Create data" ;;
        4) exit 0 ;;
        *) echo "Wrong choice. Please check again!" ;;
    esac
}
Required_menu() {
    echo "Welcome to the Required Data Menu - where you choose what do you want to do with the data that you can take from NetBox"
    echo "========== Required Data Menu =========="
    echo "1. Create new"
    echo "2. Take data from NetBox"
    echo "3. Comback"
    echo "4. Exit"
    echo "========================================"
    read -p "Your choice: " data_r_choice
    case $data_r_choice in
        1) create_menu ;;
        2) show_data_Menu ;;
        3) main_menu ;;
        4) exit 0;;
    esac
}
create_menu() {
    echo "Welcome to the Create Menu - where you choose which of data that you need to create"
    echo "========== Create Menu =========="
    echo "1. Create new Site"
    echo "2. Create new Location"
    echo "3. Create new Device Role"
    echo "4. Create new Device Type"
    echo "5. Continue"
    echo "================================="
    read -p "Your choice: " data_r_choice
    case $data_r_choice in
        1) create_site ;;
        2) create_location ;;
        3) create_device_role ;;
        4) create_device_type ;;
        5) Required_menu;;
    esac
}
show_data_Menu () {
    echo "Welcome to the Showing data menu, where we show you the data you need"
    echo "========== Showing Data Menu =========="
    echo "1. Showing data of Sites"
    echo "2. Showing data of Locations"
    echo "3. Showing data of Device Role"
    echo "4. Showing data of Device Type"
    echo "5. Continue"
    echo "======================================="
    read -p "Your choice: " data_r_choice
    case $data_r_choice in
        1) show_data_of_Sites ;;
        2) show_data_of_location ;;
        3) show_data_of_Device_Roles ;;
        4) show_data_of_Device_Types ;;
        5) Required_menu;;
    esac
}
show_data_of_Sites () {
    echo "Taking data....."

    response=$(curl -s -H "Authorization: Token $NETBOX_API" -H "Content-Type: application/json" https://$NETBOX_URL/api/dcim/sites/)

    if [[ -n "$response" ]]; then
        # Lấy tên và ID của các site
        local sites_data=($(echo "$response" | jq -r '.results[] | "\(.id): \(.name)"'))
        echo "List of Sites:"
        for site_info in "${sites_data[@]}"; do
            echo "- $site_info"
        done
    else
        echo "No data received from NetBox."
    fi

    show_data_Menu
}
show_data_of_Device_Types () {
    echo "Taking data....."

    response=$(curl -s -H "Authorization: Token $NETBOX_API" -H "Content-Type: application/json" https://$NETBOX_URL/api/dcim/device-types/)

    if [[ -n "$response" ]]; then
        # Lấy tên và ID của các loại thiết bị
        local device_types_data=($(echo "$response" | jq -r '.results[] | "\(.id): \(.model)"'))
        echo "List of Device Types:"
        for device_type_info in "${device_types_data[@]}"; do
            echo "- $device_type_info"
        done
    else
        echo "No data received from NetBox."
    fi

    show_data_Menu
}

show_data_of_Device_Roles () {
    echo "Taking data....."

    response=$(curl -s -H "Authorization: Token $NETBOX_API" -H "Content-Type: application/json" https://$NETBOX_URL/api/dcim/device-roles/)

    if [[ -n "$response" ]]; then
        # Lấy tên và ID của các vai trò thiết bị
        local device_roles_data=($(echo "$response" | jq -r '.results[] | "\(.id): \(.name)"'))
        echo "List of Device Roles:"
        for device_role_info in "${device_roles_data[@]}"; do
            echo "- $device_role_info"
        done
    else
        echo "No data received from NetBox."
    fi

    show_data_Menu
}
show_data_of_location () {
    echo "Taking data....."

    response=$(curl -s -H "Authorization: Token $NETBOX_API" -H "Content-Type: application/json" https://$NETBOX_URL/api/dcim/locations/)

    if [[ -n "$response" ]]; then
        # Lấy tên và ID của các vị trí
        local location_data=($(echo "$response" | jq -r '.results[] | "\(.id): \(.name)"'))
        echo "List of Locations:"
        for location_info in "${location_data[@]}"; do
            echo "- $location_info"
        done
    else
        echo "No data received from NetBox."
    fi

    show_data_Menu
}


SITES=()
create_site () {
    read -p "Enter Site Name: " site_name
    read -p "Enter Slug: " site_slug

    # Gửi yêu cầu POST để tạo site trên NetBox
    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Authorization: Token $NETBOX_API" -H "Content-Type: application/json" \
        -d "{\"name\": \"$site_name\", \"slug\": \"$site_slug\"}" https://$NETBOX_URL/api/dcim/sites/)

    # Kiểm tra phản hồi từ NetBox
    if [[ $response -lt 300 ]]; then
        # Lấy ID của site vừa tạo
        site_id=$(curl -s -H "Authorization: Token $NETBOX_API" https://$NETBOX_URL/api/dcim/sites/ | jq ".results[] | select(.name==\"$site_name\") | .id")

        echo "Site created successfully!"
        SITES+=("$site_id:$site_name")  # Thêm ID và tên vào mảng SITES
    else
        echo "Failed to create site. HTTP Status Code: $response"
    fi

    create_menu
}

LOCATIONS=()
create_location () {
    list_of_locations=()
    responselistloca=$(curl -s -X GET -H "Authorization: Token $NETBOX_API" "https://$NETBOX_URL/api/dcim/locations/")
    mapfile -t list_of_locations < <(echo "$responselistmanu" | jq -r '.results[] | "\(.id):\(.name)"')

    echo "Available locations:"
    for location_info in "${list_of_locations[@]}"; do
        echo "$location_info"
    done


    read -p "Enter Location Name: " location_name
    read -p "Enter Slug: " location_slug
    read -p "Enter Site ID: " site_id 

    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Authorization: Token $NETBOX_API" -H "Content-Type: application/json" \
        -d "{\"name\": \"$location_name\", \"slug\": \"$location_slug\", \"site\": $site_id}" https://$NETBOX_URL/api/dcim/locations/)

    if [[ $response -lt 300 ]]; then
        # Lấy ID của location vừa tạo
        location_id=$(curl -s -H "Authorization: Token $NETBOX_API" https://$NETBOX_URL/api/dcim/locations/ | jq ".results[] | select(.name==\"$location_name\") | .id")

        echo "Location created successfully!"
        LOCATIONS+=("$location_id:$location_name")  # Thêm ID và tên vào mảng LOCATIONS
    else
        echo "Failed to create location. HTTP Status Code: $response"
    fi

    create_menu
}
DEVICE_TYPES=()
create_device_type () {
    list_of_manufacturers=()
    responselistmanu=$(curl -s -X GET -H "Authorization: Token $NETBOX_API" "https://$NETBOX_URL/api/dcim/manufacturers/")
    mapfile -t list_of_manufacturers < <(echo "$responselistmanu" | jq -r '.results[] | "\(.id):\(.name)"')

    echo "Available manufacturers:"
    for manufacturer_info in "${list_of_manufacturers[@]}"; do
        echo "$manufacturer_info"
    done

    read -p "Enter Manufacturer: " manufacturer_id
    read -p "Enter Model: " model
    read -p "Enter Slug: " slug
    read -p "Enter U_Height: " u_height

    response=$(curl -s -w "%{http_code}" -o /dev/null -X POST -H "Authorization: Token $NETBOX_API" \
        -H "Content-Type: application/json" \
        -d "{\"manufacturer\": $manufacturer_id, \"model\": \"$model\", \"slug\": \"$slug\", \"u_height\": $u_height}" \
        "https://$NETBOX_URL/api/dcim/device-types/")

    if [[ $response -lt 300 ]]; then
        # Lấy ID của device type vừa tạo
        device_type_id=$(curl -s -H "Authorization: Token $NETBOX_API" "https://$NETBOX_URL/api/dcim/device-types/" | jq ".results[] | select(.model==\"$model\") | .id")

        echo "Device Type created successfully!"
        DEVICE_TYPES+=("$device_type_id:$model")  # Lưu ID và tên vào mảng
    else
        echo "Failed to create device types. HTTP Status Code: $response"
    fi

    create_menu
}

DEVICE_ROLES=()
create_device_role () {
    read -p "Enter Device Role Name: " role_name
    read -p "Enter Slug: " role_slug
    read -p "Enter Color(Hex): " role_color

    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Authorization: Token $NETBOX_API" -H "Content-Type: application/json" \
        -d "{\"name\": \"$role_name\", \"slug\": \"$role_slug\", \"color\": \"$role_color\"}" https://$NETBOX_URL/api/dcim/device-roles/)

    if [[ $response -lt 300 ]]; then
        # Lấy ID của device role vừa tạo
        role_id=$(curl -s -H "Authorization: Token $NETBOX_API" https://$NETBOX_URL/api/dcim/device-roles/ | jq ".results[] | select(.name==\"$role_name\") | .id")

        echo "Device Role created successfully!"
        DEVICE_ROLES+=("$role_id:$role_name")  # Lưu ID và tên vào mảng
    else
        echo "Failed to create device role. HTTP Status Code: $response"
    fi

    create_menu
}

add_device() {
    Required_menu
}

#update_device() {

#}

delete_device() {
    echo "Deleting a Device"
    read -p "Enter Device ID to delete: " device_id
    curl -X DELETE -H "Authorization: Token $NETBOX_API" https://$NETBOX_URL/api/dcim/devices/$device_id/
    echo "Device deleted successfully!"
}

# Gọi hàm Pre-Launch
pre_launch_check
main_menu

