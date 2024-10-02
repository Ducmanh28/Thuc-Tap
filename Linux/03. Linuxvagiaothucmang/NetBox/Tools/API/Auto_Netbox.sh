#!/bin/bash

echo "This Script is used to manipulate data on NetBox automatically using a command-line tool without having to access NetBox's web interface."
echo "Before Launch, we will check your devices to make sure that this script can run successfully!"

# Pre-Launch function
pre_launch_check() {

    echo "Before running, we need some informations about your NetBox Server"
    read -p "Input the NetBox URL [www.netboxlab.local]: " NETBOX_URL
    NETBOX_URL=${NETBOX_URL:-www.netboxlab.local}
    #read -p "Input the NetBox Ip Address": NETBOX_IP
    read -p "Input the API Token of NetBox: " NETBOX_TOKEN
    NETBOX_TOKEN=${NETBOX_TOKEN:-aa8f29998abd6a63f476a2328ce2a629a506b579}

    # Kiểm tra hệ điều hành
    if [[ "$(uname -s)" != "Linux" ]]; then
        echo "You must using Linux OS to run this scripts!"
        exit 1
        Total_time
    else
        echo "Checking........"
        echo "OS Checking complete!"
    fi

    # Kiểm tra quyền Root
    if [[ $EUID -ne 0 ]]; then
        echo "You should run this scripts with root's permission!"
        exit 1
        Total_time
    else
        echo "Checking......."
        echo "Permission Checking complete!"
    fi

    # Kiểm tra trạng thái kết nối
    response=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Token $NETBOX_TOKEN" https://$NETBOX_URL/api/)
    if [[ $response -ne 200 ]]; then
        echo "Can't connect to NetBox, please check the url and token again!!!"
        exit 1
        Total_time
    else    
        echo "Connect to $NETBOX_URL successfully!"
        echo "Finished Checking!"
    fi
}
check_ip() {
    IP=$1                                                     
    if [[ $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then   # Chia IP thành 2 phần: 3 phần có "." và 1 phần không có
        for octet in ${IP//./ }; do     # Vòng lặp kiểm tra từng octet 
            if ((octet > 255)); then    # Nếu giá trị của octet lớn hơn 255
                echo "Invalid IP address: $IP. Each octet must be between 0 and 255."
                adding
            fi
        done
    else       # Nếu không đúng kiểu địa chỉ
        echo "Invalid IP address format: $IP. Please check again."
        adding
    fi
}
function Total_time {
    local total_seconds=$SECONDS
    local hours=$((total_seconds / 3600))
    local minutes=$(( (total_seconds % 3600) / 60 ))
    local seconds=$((total_seconds % 60))

    echo "Finished in: ${hours} hours, ${minutes} minutes and ${seconds} seconds"
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
        1) add_menu ;;
        2) echo "Create data" ;;
        3) delete_device ;;
        4) Total_time
           exit 0 ;;
        *) echo "Wrong choice. Please check again!" ;;
    esac
}
Add_data_menu() {
    echo "Welcome to the Add Data Menu - where you choose what do you want to do with the data that you can take from NetBox"
    echo "========== Add Data Menu =========="
    echo "1. Create new"
    echo "2. View data from NetBox"
    echo "3. Comback"
    echo "========================================"
    read -p "Your choice: " data_r_choice
    case $data_r_choice in
        1) create_menu ;;
        2) show_data_Menu ;;
        3) main_menu ;;
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
        5) Add_data_menu;;
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
        5) Add_data_menu;;
    esac
}
show_data_of_Sites () {
    echo "Taking data....."

    response=$(curl -s -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" https://$NETBOX_URL/api/dcim/sites/)

    if [[ -n "$response" ]]; then
        # Lấy id và name của các site
        local sites_data=$(echo "$response" | jq -r '.results[] | "\(.id) - \(.name)"')
        echo "List of Sites:"
        while IFS= read -r site_info; do
            echo "- $site_info"
        done <<< "$sites_data"
    else
        echo "No data received from NetBox."
    fi

    show_data_Menu
}
show_device() {
    echo "Taking data....."
    response=$(curl -s -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" https://$NETBOX_URL/api/dcim/devices/ )

    if [[ -n "$response" ]]; then
        local devices_data=$(echo "$response" | jq -r '.results[] | "\(.id) - \(.name) - \(.device_type.model) - \(.role.name) (Site: \(.site.name))"')
        echo "List of Devices:"
        while IFS= read -r devices_info; do
            echo "- $devices_info"
        done <<< "$devices_data"
    else    
        echo "No data received from NetBox."
    fi
}
show_data_of_Device_Types () {
    echo "Taking data....."

    response=$(curl -s -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" https://$NETBOX_URL/api/dcim/device-types/)

    if [[ -n "$response" ]]; then
        # Lấy id và model của các loại thiết bị
        local device_types_data=$(echo "$response" | jq -r '.results[] | "\(.id) - \(.model)"')
        echo "List of Device Types:"
        while IFS= read -r device_types_info; do
            echo "- $device_types_info"
        done <<< "$device_types_data" 
    else
        echo "No data received from NetBox."
    fi

    show_data_Menu
}
show_data_of_Device_Roles () {
    echo "Taking data....."

    response=$(curl -s -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" https://$NETBOX_URL/api/dcim/device-roles/)

    if [[ -n "$response" ]]; then
        # Lấy tên và ID của các vai trò thiết bị
        local device_roles_data=$(echo "$response" | jq -r '.results[] | "\(.id) - \(.name)"')
        echo "List of Device Roles:"
        while IFS= read -r device_roles_info; do
            echo "- $device_roles_info"
        done <<< "$device_roles_data"
    else
        echo "No data received from NetBox."
    fi

    show_data_Menu
}
show_data_of_location () {
    echo "Taking data....."

    response=$(curl -s -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" https://$NETBOX_URL/api/dcim/locations/)

    if [[ -n "$response" ]]; then
        # Lấy tên và ID của các vị trí
        local location_data=$(echo "$response" | jq -r '.results[] | "\(.id) - \(.name) (Site: \(.site.name))"')
        echo "List of Locations:"
        while IFS= read -r location_info; do
            echo "- $location_info"
        done <<< "$location_data"
    else
        echo "No data received from NetBox."
    fi

    show_data_Menu
}
create_site () {
    read -p "Enter Site Name: " site_name
    read -p "Enter Slug: " site_slug

    # Gửi yêu cầu POST để tạo site trên NetBox
    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" \
        -d "{\"name\": \"$site_name\", \"slug\": \"$site_slug\"}" https://$NETBOX_URL/api/dcim/sites/)

    # Kiểm tra phản hồi từ NetBox
    if [[ "$response" -lt 300 ]]; then
        # Lấy ID của site vừa tạo
        site_id=$(curl -s -H "Authorization: Token $NETBOX_TOKEN" https://$NETBOX_URL/api/dcim/sites/ | jq ".results[] | select(.name==\"$site_name\") | .id")

        echo "Site created successfully!"
    else
        echo "Failed to create site. HTTP Status Code: $response"
    fi

    create_menu
}
create_location () {
    list_of_locations=()
    responselistloca=$(curl -s -X GET -H "Authorization: Token $NETBOX_TOKEN" "https://$NETBOX_URL/api/dcim/locations/")
    mapfile -t list_of_locations < <(echo "$responselistmanu" | jq -r '.results[] | "\(.id):\(.name)"')

    echo "Available locations:"
    for location_info in "${list_of_locations[@]}"; do
        echo "$location_info"
    done


    read -p "Enter Location Name: " location_name
    read -p "Enter Slug: " location_slug
    read -p "Enter Site ID: " site_id 

    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" \
        -d "{\"name\": \"$location_name\", \"slug\": \"$location_slug\", \"site\": $site_id}" https://$NETBOX_URL/api/dcim/locations/)

    if [[ "$response" -lt 300 ]]; then
        # Lấy ID của location vừa tạo
        location_id=$(curl -s -H "Authorization: Token $NETBOX_TOKEN" https://$NETBOX_URL/api/dcim/locations/ | jq ".results[] | select(.name==\"$location_name\") | .id")

        echo "Location created successfully!"
    else
        echo "Failed to create location. HTTP Status Code: $response"
    fi

    create_menu
}
create_device_type () {
    list_of_manufacturers=()
    responselistmanu=$(curl -s -X GET -H "Authorization: Token $NETBOX_TOKEN" "https://$NETBOX_URL/api/dcim/manufacturers/")
    mapfile -t list_of_manufacturers < <(echo "$responselistmanu" | jq -r '.results[] | "\(.id):\(.name)"')

    echo "Available manufacturers:"
    for manufacturer_info in "${list_of_manufacturers[@]}"; do
        echo "$manufacturer_info"
    done

    read -p "Enter Manufacturer: " manufacturer_id
    read -p "Enter Model: " model
    read -p "Enter Slug: " slug
    read -p "Enter U_Height: " u_height

    response=$(curl -s -w "%{http_code}" -o /dev/null -X POST -H "Authorization: Token $NETBOX_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"manufacturer\": $manufacturer_id, \"model\": \"$model\", \"slug\": \"$slug\", \"u_height\": $u_height}" \
        "https://$NETBOX_URL/api/dcim/device-types/")

    if [[ "$response" -lt 300 ]]; then
        # Lấy ID của device type vừa tạo
        device_type_id=$(curl -s -H "Authorization: Token $NETBOX_TOKEN" "https://$NETBOX_URL/api/dcim/device-types/" | jq ".results[] | select(.model==\"$model\") | .id")

        echo "Device Type created successfully!"
    else
        echo "Failed to create device types. HTTP Status Code: $response"
    fi

    create_menu
}
create_device_role () {
    read -p "Enter Device Role Name: " role_name
    read -p "Enter Slug: " role_slug
    read -p "Enter Color(Hex): " role_color

    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" \
        -d "{\"name\": \"$role_name\", \"slug\": \"$role_slug\", \"color\": \"$role_color\"}" https://$NETBOX_URL/api/dcim/device-roles/)

    if [[ "$response" -lt 300 ]]; then
        # Lấy ID của device role vừa tạo
        role_id=$(curl -s -H "Authorization: Token $NETBOX_TOKEN" https://$NETBOX_URL/api/dcim/device-roles/ | jq ".results[] | select(.name==\"$role_name\") | .id")

        echo "Device Role created successfully!"
    else
        echo "Failed to create device role. HTTP Status Code: $response"
    fi

    create_menu
}
# Function to display the Add Menu
add_menu() {
    echo "Welcome to the Add Menu, where you can add devices or device data before adding a device."
    echo "========== Add Menu =========="
    echo "1. Add Device"
    echo "2. Add Data of Device"
    echo "=============================="
    read -p "Your choice: " add_menu_choice
    case $add_menu_choice in 
        1) add_device ;;               # Call the function to add a device
        2) Add_data_menu ;;            # Call the function to add data of a device
        *) echo "Invalid choice. Please select 1 or 2." ;;  # Handle invalid input
    esac
}
add_device() {
    echo "Before Adding Device, please make sure that all necessary data is created!"
    echo "Ensure you remember the 'id' of the data. If you don't remember it, you can choose to view it again!"
    echo "=============== Add Device ==============="
    echo "1. Add Device"
    echo "2. View Required Data List Again"
    echo "3. Back"
    echo "4. Main Menu"
    echo "=========================================="
    read -p "Your choice: " add_device_choice
    case $add_device_choice in
        1) adding ;;                  # Function to add device
        2) show_data_Menu ;;          # Function to show necessary data
        3) add_menu ;;                # Back to add menu
        4) main_menu ;;               # Back to main menu
        *) echo "Invalid choice. Please select 1, 2, 3, or 4." ;;
    esac
}
adding () {
    echo "=== Add a New Device to NetBox ==="
    
    read -p "Device Name: " device_name
    read -p "Device Type ID: " device_type
    read -p "Device Role ID: " device_role
    read -p "Platform ID (leave blank if none): " platform
    platform=${platform:-null}
    read -p "Serial Number: " serial
    read -p "Asset Tag: " asset_tag
    read -p "Site ID: " site
    read -p "Location ID (leave blank if none): " location
    location=${location:-null}
    read -p "Rack ID (leave blank if none): " rack
    rack=${rack:-null}
    read -p "Position in Rack (leave blank if none): " position
    position=${position:-null}
    read -p "Device Status (active, planned, staged, failed, offline): " status
    read -p "Primary IPv4 ID (leave blank if none): " primary_ip4
    # Gán null nếu primary_ip4 để trống
    if [[ -z "$primary_ip4" ]]; then
        primary_ip4=null
    else
        check_ip $primary_ip4
    fi
    # Tạo body json
    json_body=$(cat <<EOF
{
  "name": "$device_name",
  "device_type": $device_type,
  "role": $device_role,
  "platform": $platform,
  "serial": "$serial",
  "asset_tag": "$asset_tag",
  "site": $site,
  "location": $location,
  "rack": $rack,
  "position": $position,
  "status": "$status",
  "primary_ip4": $primary_ip4,
  "comments": "Device added via bash script"
}
EOF
)
    echo "Sending request to NetBox..."
    # Send POST request to NetBox API
    response=$(curl -s -w "%{http_code}" -o /dev/null -X POST "https://$NETBOX_URL/api/dcim/devices/" \
  -H "Authorization: Token $NETBOX_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$json_body")
    if [[ "$response" -lt 300 ]]; then
        echo "Adding Device Complete!"
        add_device
    else
        echo "Failed to adding device. HTTP Status Code: $response"
    fi
}
update_device() {
    show_device
    read -p "Enter Device ID to update: " device_id  # Add prompt for Device ID
    read -p "Device Name: " device_name
    read -p "Device Type ID: " device_type
    read -p "Device Role ID: " device_role
    read -p "Platform ID (leave blank if none): " platform
    platform=${platform:-null}
    read -p "Serial Number: " serial
    read -p "Asset Tag: " asset_tag
    read -p "Site ID: " site
    read -p "Location ID (leave blank if none): " location
    location=${location:-null}
    read -p "Rack ID (leave blank if none): " rack
    rack=${rack:-null}
    read -p "Position in Rack (leave blank if none): " position
    position=${position:-null}
    read -p "Device Face (1=Front, 2=Rear, leave blank if none): " face
    face=${face:-null}
    read -p "Device Status (active, planned, staged, failed, offline): " status
    read -p "Primary IPv4 ID (leave blank if none): " primary_ip4
    primary_ip4=${primary_ip4:-null}

    # Check IP format if primary_ip4 is provided
    if [[ -n "$primary_ip4" ]]; then
        check_ip "$primary_ip4"
    fi

    # Prepare JSON payload
    json_body=$(jq -n \
        --arg name "$device_name" \
        --arg type "$device_type" \
        --arg role "$device_role" \
        --arg serial "$serial" \
        --arg asset_tag "$asset_tag" \
        --arg site "$site" \
        --arg location "$location" \
        --arg rack "$rack" \
        --arg position "$position" \
        --arg face "$face" \
        --arg status "$status" \
        --arg primary_ip4 "$primary_ip4" \
        '{
            name: $name,
            device_type: ($type | if . == "" then null else . end),
            device_role: ($role | if . == "" then null else . end),
            serial: ($serial | if . == "" then null else . end),
            asset_tag: ($asset_tag | if . == "" then null else . end),
            site: ($site | if . == "" then null else . end),
            location: ($location | if . == "" then null else . end),
            rack: ($rack | if . == "" then null else . end),
            position: ($position | if . == "" then null else . end),
            face: ($face | if . == "" then null else . end),
            status: ($status | if . == "" then null else . end),
            primary_ip4: ($primary_ip4 | if . == "" then null else . end)
        }')

    # Send PATCH request to update device
    response=$(curl -s  -X PATCH "https://$NETBOX_URL/dcim/devices/$device_id/" \
        -H "Authorization: Token $NETBOX_TOKEN" \
        -H "Content-Type: application/json" \
        -d "$json_body")

    if [[ "$response" -lt 300 ]]; then
            echo "Update complete!"
        else
            echo "There is some problems while we trying to update device with ID: $device_id! Http status code: $response"
            main_menu
        fi
}
delete_device() {
    show_device
    read -p "Enter Device ID to delete: " device_id
    
    # Confirm deletion
    read -p "Are you sure you want to delete device with ID $device_id? (y/n): " confirm
    if [[ "$confirm" == "y" ]]; then
        response=$(curl -s -w "%{http_code}" -X DELETE "https://$NETBOX_URL/api/dcim/devices/$device_id/" \
        -H "Authorization: Token $NETBOX_TOKEN")
        if [[ "$response" -lt 300 ]]; then
            echo "Delete complete!"
            main_menu
        else
            echo "There is some problems while we trying to delete device with ID: $device_id!. Status code: $response"
            main_menu
        fi
    else    
        main_menu
    fi
}

# Gọi hàm Pre-Launch
pre_launch_check
main_menu

