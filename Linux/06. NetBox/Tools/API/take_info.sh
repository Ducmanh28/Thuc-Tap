#!/bin/bash

echo "Hello User, this tool is used to show you information of your device by finding it with one of its information"
echo "Before running, we need some informations about your NetBox Server"
read -p "Input the NetBox URL [https://www.netboxlab.local]: " NETBOX_URL
NETBOX_URL=${NETBOX_URL:-https://www.netboxlab.local}
#read -p "Input the NetBox Ip Address": NETBOX_IP
read -p "Input the API Token of NetBox: " NETBOX_TOKEN
NETBOX_TOKEN=${NETBOX_TOKEN:-aa8f29998abd6a63f476a2328ce2a629a506b579}

pre_launch_check() {
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
                main_menu
            fi
        done
    else       # Nếu không đúng kiểu địa chỉ
        echo "Invalid IP address format: $IP. Please check again."
        main_menu
    fi
}
main_menu () {
    echo "=============== Main Menu ==============="
    echo "1. Search by IP Address of Device"
    echo "2. Search by Name of Device"
    echo "3. Exit!"
    echo "========================================="    
    read -p "Your choice: " main_menu_choice
    case $main_menu_choice in 
        1) find_by_ip ;;
        2) find_by_name ;;
        3) exit 0 ;;
    esac
}

find_by_ip () {
    # The logic in here is: 
    # Find device_id
    # Show information of that device_id
    read -p "Enter the IP Address of Device: " device_ip_address
    check_ip $device_ip_address

    # Call API to find IP
    response=$(curl -s -H "Authorization: Token $NETBOX_TOKEN" $NETBOX_URL/api/ipam/ip-addresses/?q=$device_ip_address)
    
    # Check if exist IP
    ip_exist=$(echo "$response" | jq '.count')
    if [[ "$ip_exist" -eq 0 ]]; then
        echo "The Address IP $device_ip_address doesn't exist in NetBox."
        exit 1
    fi

    #Find device_id
    device_id=$(echo "$response" | jq -r '.results[0].assigned_object.device.id')
    
    # Check if device_id is null or no value
    if [[ "$device_id" == "null" ]]; then
        echo "The IP $device_ip doesn't assign with any device."
        exit 1
    fi

    # Call API to take information of device
    device_info=$(curl -s -H "Authorization: Token $NETBOX_TOKEN" $NETBOX_URL/api/dcim/devices/$device_id/)

    # Take information
    device_name=$(echo "$device_info" | jq -r '.name')
    site_name=$(echo "$device_info" | jq -r '.site.name')
    rack_name=$(echo "$device_info" | jq -r '.rack.name')
    position=$(echo "$device_info" | jq -r '.position')
    location_name=$(echo "$device_info" | jq -r '.location.name')
    device_type=$(echo "$device_info" | jq -r '.device_type.model')
    device_role=$(echo "$device_info" | jq -r '.role.name')
    device_status=$(echo "$device_info" | jq -r '.status.label')
    serial_number=$(echo "$device_info" | jq -r '.serial')
    asset_tag=$(echo "$device_info" | jq -r '.asset_tag')
    tenant=$(echo "$device_info" | jq -r '.tenant.name')

    # Print information
    echo "Information of Device with IP $device_ip_address:"
    echo "-----------------------------------------------"
    echo "Location of Device:"
    echo "- Site:         $site_name"
    echo "- Location:     $location_name"
    echo "- Rack:         $rack_name"
    echo "- Position:     $position"
    echo "Device Information:"
    echo "- Device Name:  $device_name"
    echo "- Device Type:  $device_type"
    echo "- Device Role:  $device_role"
    echo "- Status:       $device_status"
    echo "- Serial:       $serial_number"
    echo "- Asset Tag:    $asset_tag"
    echo "- Tenant:       $tenant"
    echo "-----------------------------------------------"

    #Comeback to main menu after working 
    main_menu
}

find_by_name () {
echo "Working...."
}


# Run tools
pre_launch_check

main_menu