#!/bin/bash

echo "This Script is used to manipulate data on NetBox automatically using a command-line tool without having to access NetBox's web interface."
echo "Before Launch, we will check your devices to make sure that this script can run successfully!"

# Pre-Launch function
pre_launch_check() {

    echo "Before running, we need some informations about your NetBox Server"
    read -p "Input the NetBox URL [https://www.netboxlab.local]: " NETBOX_URL
    NETBOX_URL=${NETBOX_URL:-https://www.netboxlab.local}
    #read -p "Input the NetBox Ip Address": NETBOX_IP
    read -p "Input the API Token of NetBox: " NETBOX_TOKEN
    NETBOX_TOKEN=${NETBOX_TOKEN:-aa8f29998abd6a63f476a2328ce2a629a506b579}
    #read -p "Enter path to your certificate.pem" SSLpath
    #SSLpath=${SSLpath:-/etc/ssl/certs/CA.pem}

    # Kiểm tra hệ điều hành
    if [[ "$(uname -s)" != "Linux" ]]; then
        echo "You must using Linux OS to run this scripts!"
        return 1
        Total_time
    else
        echo "Checking........"
        echo "OS Checking complete!"
    fi

    # Kiểm tra cài đặt jq
    if [[ $EUID -ne 0 ]]; then
        echo "You should run this scripts with root's permission!"
        Total_time
        exit 1
    else
        if ! dpkg -l | grep -q "jq"; then
            echo "jq is not installed. Installing jq..."
            sudo apt install -y jq
            # Check process
            if dpkg -l | grep -q "jq";then
                echo "jq has been successfully installed."
            else
                echo "Error: Failed to install jq."
                exit 1
                Total_time
            fi
        else 
            echo "jq is already installed"
        fi
    fi

    # Kiểm tra trạng thái kết nối
    response=$(curl -k -s -o /dev/null -w "%{http_code}" -H "Authorization: Token $NETBOX_TOKEN" $NETBOX_URL/api/)
    if [[ $response -ne 200 ]]; then
        echo "Can't connect to NetBox, please check the url and token again!!!"
        Total_time
        exit 1
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
        2) update_device ;;
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
    echo "2. Show data Menu"
    echo "3. Comback"
    echo "========================================"
    read -p "Your choice: " data_r_choice
    case $data_r_choice in
        1) create_menu ;;
        2) show_data_Menu ;;
        3) main_menu ;;
    esac
}
show_data_Menu () {
    echo "Welcome to the Show Data Menu - where you choose what do you want to see "
    echo "========== Show Data Menu =========="
    echo "1. Show data of Sites"
    echo "2. Show data of Locations"
    echo "3. Show data of Tenant"
    echo "4. Show data of Device Types"
    echo "5. Show data of Device Roles"
    echo "6. Show data of Devices"
    echo "7. Show data of IPv4"
    echo "8. Comeback"
    echo "========================================"
    read -p "Your choice: " data_s_choice
    case $data_s_choice in
        1) show_data_of_Sites 
            show_data_Menu ;;
        2) show_data_of_location
            show_data_Menu ;;
        3) show_data_of_tenant 
            show_data_Menu ;;
        4) show_data_of_Device_Types 
            show_data_Menu ;;
        5) show_data_of_Device_Roles 
            show_data_Menu ;;
        6) show_device 
            show_data_Menu ;;
        7) show_ip_addr
            show_data_Menu ;;
        8) Add_data_menu ;;
    esac
}
create_menu() {
    echo "Welcome to the Create Menu - where you choose which of data that you need to create"
    echo "========== Create Menu =========="
    echo "1. Create new Site"
    echo "2. Create new Location"
    echo "3. Create new Device Role"
    echo "4. Create new Device Type"
    echo "5. Comeback"
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
show_data_of_Sites () {
    echo "Taking data....."

    response=$(curl -k -s -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" $NETBOX_URL/api/dcim/sites/)

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

    #show_data_Menu
}
show_device() {
    echo "Taking data....."
    response=$(curl -k -s -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" $NETBOX_URL/api/dcim/devices/ )

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

    response=$(curl -k -s -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" $NETBOX_URL/api/dcim/device-types/)

    if [[ -n "$response" ]]; then
        local device_types_data=$(echo "$response" | jq -r '.results[] | "\(.id) - \(.model)"')
        echo "List of Device Types:"
        while IFS= read -r device_types_info; do
            echo "- $device_types_info"
        done <<< "$device_types_data" 
    else
        echo "No data received from NetBox."
    fi

    #show_data_Menu
}
show_data_of_Device_Roles () {
    echo "Taking data....."

    response=$(curl -k -s -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" $NETBOX_URL/api/dcim/device-roles/)

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

    #show_data_Menu
}
show_data_of_location () {
    echo "Taking data....."

    response=$(curl -k -s -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" $NETBOX_URL/api/dcim/locations/)

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

    #show_data_Menu
}
show_data_of_tenant () {
    echo "Taking data....."

    response=$(curl -k -s -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" $NETBOX_URL/api/tenancy/tenants/)

    if [[ -n "$response" ]]; then
        local tenant_data=$(echo "$response" | jq -r '.results[] | "\(.id) - \(.name)"')
        echo "List of Tenants:"
        while IFS= read -r tenant_info; do
            echo "- $tenant_info"
        done <<< "$tenant_data"
    else
        echo "No data received from NetBox."
    fi

    #show_data_Menu
}
show_ip_addr() {
    echo "Taking data....."

    response=$(curl -k -s -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" $NETBOX_URL/api/ipam/ip-addresses/)

    if [[ -n "$response" ]]; then
        local ip_data=$(echo "$response" | jq -r '.results[] | "\(.id) - \(.address) - \(.status.label)"')
        echo "List of IP Address:"
        while IFS= read -r ip_info; do
            echo "- $ip_info"
        done <<< "$ip_data"
    else
        echo "No data received from NetBox."
    fi

    #show_data_Menu
    
}


create_site () {
    show_data_of_Sites
    read -p "Enter Site Name: " site_name
    read -p "Enter Slug: " site_slug
    echo "1. Active"
    echo "2. Planned"
    echo "3. Staged"
    echo "4. Failed"
    echo "5. Offline"
    read -p "Device Status: " site_status
    case $status in 
        1) site_status="active" ;;
        2) site_status="planned" ;;
        3) site_status="staged" ;;
        4) site_status="failed" ;;
        5) site_status="offline" ;;
        *) site_status="active" ;; 
    esac
    
    read -p "Enter Region ID: " region
    show_data_of_tenant
    read -p "Enter Tenant ID: " site_tenant_id
    read -p "Enter Time Zone(Asia/Ho_Chi_Minh): " site_time_zone
    site_time_zone=${site_time_zone:-Asia/Ho_Chi_Minh}
    read -p "Enter Description: " site_description
    read -p "Enter Physical Address: " physical_addr

    # Gửi yêu cầu POST để tạo site trên NetBox
    # Tạo body json
    json_body=$(cat <<EOF
{
  "name": "$site_name",
  "slug": "$site_slug",
  "status": "$site_status",
  "region": $region,
  "tenant": $site_tenant_id,
  "time_zone": "$site_time_zone",
  "description": "$site_description",
  "physical_address": "$physical_addr"
}
EOF
)
    echo "Sending request to NetBox..."
    # Send POST request to NetBox API
    response=$(curl -k -s -w "%{http_code}" -o /dev/null -X POST "$NETBOX_URL/api/dcim/sites/" \
  -H "Authorization: Token $NETBOX_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$json_body")
    # Kiểm tra phản hồi từ NetBox
    if [[ "$response" -lt 300 ]]; then
        echo "Site created successfully!"
    else
        echo "Failed to create site. HTTP Status Code: $response"
    fi
    create_menu
}
create_location () {
    show_data_of_location
    read -p "Enter Site ID: " site_id
    read -p "Enter Location Name: " location_name
    read -p "Enter Slug: " location_slug
    echo "1. Active"
    echo "2. Planned"
    echo "3. Staged"
    echo "4. Failed"
    echo "5. Offline"
    read -p "Device Status: " location_status
    case $status in 
        1) location_status="active" ;;
        2) location_status="planned" ;;
        3) location_status="staged" ;;
        4) location_status="failed" ;;
        5) location_status="offline" ;;
        *) location_status="active" ;; 
    esac

    response=$(curl -k -s -o /dev/null -w "%{http_code}" -X POST -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" \
        -d "{\"site\": $site_id, \"name\": \"$location_name\", \"slug\": \"$location_slug\",  \"status\": \"$location_status\"}" $NETBOX_URL/api/dcim/locations/)

    if [[ "$response" -lt 300 ]]; then
        echo "Location created successfully!"
    else
        echo "Failed to create location. HTTP Status Code: $response"
    fi

    create_menu
}
show_manufacturers () {
    list_of_manufacturers=()
    responselistmanu=$(curl -k -s -X GET -H "Authorization: Token $NETBOX_TOKEN" "$NETBOX_URL/api/dcim/manufacturers/")
    mapfile -t list_of_manufacturers < <(echo "$responselistmanu" | jq -r '.results[] | "\(.id):\(.name)"')

    echo "Available manufacturers:"
    for manufacturer_info in "${list_of_manufacturers[@]}"; do
        echo "$manufacturer_info"
    done
}
create_device_type () {
    show_manufacturers

    read -p "Enter Manufacturer: " manufacturer_id
    read -p "Enter Model: " model
    read -p "Enter Slug: " slug
    read -p "Enter U_Height: " u_height

    response=$(curl -s -w "%{http_code}" -o /dev/null -X POST -H "Authorization: Token $NETBOX_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"manufacturer\": $manufacturer_id, \"model\": \"$model\", \"slug\": \"$slug\", \"u_height\": $u_height}" \
        "$NETBOX_URL/api/dcim/device-types/")

    if [[ "$response" -lt 300 ]]; then
        echo "Device Type created successfully!"
    else
        echo "Failed to create device types. HTTP Status Code: $response"
    fi
    create_menu
}
create_device_role () {
    list_of_roles=()
    responselistroles=$(curl -k -s -X GET -H "Authorization: Token $NETBOX_TOKEN" "$NETBOX_URL/api/dcim/device-roles/")
    mapfile -t list_of_roles < <(echo "$responselistroles" | jq -r '.results[] | "\(.id) - \(.name)"')

    echo "Available Roles:"
    for role_info in "${list_of_roles[@]}"; do
        echo "$role_info"
    done

    read -p "Enter Device Role Name: " role_name
    read -p "Enter Slug: " role_slug
    read -p "Enter Color(Hex): " role_color

    response=$(curl -k -s -o /dev/null -w "%{http_code}" -X POST -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" \
        -d "{\"name\": \"$role_name\", \"slug\": \"$role_slug\", \"color\": \"$role_color\"}" $NETBOX_URL/api/dcim/device-roles/)

    if [[ "$response" -lt 300 ]]; then
        echo "Device Role created successfully!"
    else
        echo "Failed to create device role. HTTP Status Code: $response"
    fi

    create_menu
}
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
    echo "=============== Add Device ==============="
    echo "1. Add Device"
    echo "2. View List of Device"
    echo "3. Back"
    echo "4. Main Menu"
    echo "=========================================="
    read -p "Your choice: " add_device_choice
    case $add_device_choice in
        1) adding ;;                  # Function to add device
        2) show_device 
            add_device ;;             
        3) add_menu ;;                # Back to add menu
        4) main_menu ;;               # Back to main menu
        *) echo "Invalid choice. Please select 1, 2, 3, or 4." ;;
    esac
}
adding () {
    echo "=== Add a New Device to NetBox ==="
    read -p "Device Name: " device_name
    show_data_of_Device_Types
    read -p "Device Type ID: " device_type
    show_data_of_Device_Roles
    read -p "Device Role ID: " device_role
    show_data_of_tenant
    read -p "Tenant ID: " tenant
    tenant=${tenant:-null}
    read -p "Serial Number: " serial
    show_data_of_Sites
    read -p "Site ID: " site
    show_data_of_location
    read -p "Location ID (leave blank if none): " location
    location=${location:-null}
    read -p "Rack ID (leave blank if none): " rack
    rack=${rack:-null}
    read -p "Position in Rack (leave blank if none): " position
    position=${position:-null}
    echo "1. Active"
    echo "2. Planned"
    echo "3. Staged"
    echo "4. Failed"
    echo "5. Offline"
    read -p "Device Status: " status
    case $status in 
        1) status="active" ;;
        2) status="planned" ;;
        3) status="staged" ;;
        4) status="failed" ;;
        5) status="offline" ;;
        *) status="active" ;; 
    esac
    show_ip_addr
    read -p "Primary IPv4 ID (leave blank if none): " primary_ip4
    # Tạo body json
    json_body=$(cat <<EOF
{
  "name": "$device_name",
  "device_type": $device_type,
  "role": $device_role,
  "tenant": $tenant,
  "serial": "$serial",
  "site": $site,
  "location": $location,
  "rack": $rack,
  "position": $position,
  "status": "$status",
  "primary_ip4": $primary_ip4
}
EOF
)
    echo "Sending request to NetBox..."
    # Send POST request to NetBox API
    response=$(curl -k -s -w "%{http_code}" -o /dev/null -X POST "$NETBOX_URL/api/dcim/devices/" \
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
    
    # Danh sách các trường có thể cập nhật
    echo "Select the data you want to update:"
    echo "1. Device Name"
    echo "2. Device Type ID"
    echo "3. Device Role ID"
    echo "4. Platform ID"
    echo "5. Serial Number"
    echo "6. Site ID"
    echo "7. Location ID"
    echo "8. Rack ID"
    echo "9. Position in Rack"
    echo "10. Device Status"
    echo "11. Primary IPv4 ID"
    read -p "Enter the numbers of the fields you want to update (comma separated, e.g. 1,3,5): " fields_to_update

    # Chia nhỏ danh sách các trường được chọn
    IFS=',' read -r -a fields <<< "$fields_to_update"

    # Khởi tạo biến để tạo JSON
    json_body="{"

    # Yêu cầu nhập dữ liệu cho các trường đã chọn
    for field in "${fields[@]}"; do
        case $field in
            1) read -p "Device Name: " device_name
               json_body+="\"name\": \"$device_name\", "
               ;;
            2) read -p "Device Type ID: " device_type
               json_body+="\"device_type\": $device_type, "
               ;;
            3) read -p "Device Role ID: " device_role
               json_body+="\"role\": $device_role, "
               ;;
            4) read -p "Platform ID (leave blank if none): " platform
               platform=${platform:-null}
               json_body+="\"platform\": $platform, "
               ;;
            5) read -p "Serial Number: " serial
               json_body+="\"serial\": \"$serial\", "
               ;;
            6) read -p "Site ID: " site
               json_body+="\"site\": $site, "
               ;;
            7) read -p "Location ID (leave blank if none): " location
               location=${location:-null}
               json_body+="\"location\": $location, "
               ;;
            8) read -p "Rack ID (leave blank if none): " rack
               rack=${rack:-null}
               json_body+="\"rack\": $rack, "
               ;;
            9) read -p "Position in Rack (leave blank if none): " position
               position=${position:-null}
               json_body+="\"position\": $position, "
               ;;
            10) read -p "Device Status (active, planned, staged, failed, offline): " status
               json_body+="\"status\": \"$status\", "
               ;;
            11) read -p "Primary IPv4 ID (leave blank if none): " primary_ip4
                if [[ -z "$primary_ip4" ]]; then
                    primary_ip4=null
                else
                    check_ip $primary_ip4
                fi
                json_body+="\"primary_ip4\": $primary_ip4"
                ;;
            *) echo "Invalid selection: $field"
               ;;
        esac
    done

    # Loại bỏ dấu phẩy thừa ở cuối JSON
    json_body="${json_body%, }"
    json_body+="}"

    # Send PATCH request to update device
    response=$(curl -k -s -w "%{http_code}" -o /dev/null -X PATCH "$NETBOX_URL/dcim/devices/$device_id/" \
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
        response=$(curl -k -s -w "%{http_code}" -X DELETE "$NETBOX_URL/api/dcim/devices/$device_id/" \
        -H "Authorization: Token $NETBOX_TOKEN")
        if [[ "$response" -lt 300 ]]; then
            echo "Delete complete!"
            main_menu
        else
            echo "There is some problems while we trying to delete device with ID: $device_id!. Status code: $response"
            main_menu
        fi
    else    
        delete_device
    fi
}

# Gọi hàm Pre-Launch
pre_launch_check
main_menu

