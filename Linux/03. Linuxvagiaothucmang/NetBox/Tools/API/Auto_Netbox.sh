#!/bin/bash
NETBOX_URL="www.netboxlab.local"
NETBOX_TOKEN="aa8f29998abd6a63f476a2328ce2a629a506b579" 

adding () {
    # Tạo body json
    json_body=$(cat <<EOF
{
  "name": "tlu04",
  "device_type": 7,
  "role": 4,
  "platform": null,
  "serial": "Tlu0001",
  "site": 1,
  "location": 1,
  "rack": null,
  "position": null,
  "status": "active",
  "primary_ip4": null
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
        #add_device
    else
        echo "Failed to adding device. HTTP Status Code: $response"
        #Total_time
        exit 1;
    fi
}
adding