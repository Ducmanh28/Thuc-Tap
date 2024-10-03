# Mục này thực hành viết tools thao tác với API của NetBox
Trước khi tiến tới việc viết tools, chúng ta cần thực hành add thủ công device của NetBox trước để nắm rõ các bước, các thông tin cần điền,...

## Tổng quan về dự án
Tools này được làm ra để có thể thao tác với dữ liệu của NetBox từ các máy client từ xa, không cần truy cập qua hệ thống giao diện đồ họa của NetBox, chỉ sử dụng các công cụ dòng lệnh, API để làm việc với dữ liệu trên NetBox. 

Tools sử dụng ngôn ngữ BashScripts, chạy trên các máy hệ điều hành UNix, Linux. Ngoài ra, có thể tích hợp thêm Python hoặc JavaScripts để hỗ trợ cho các tính năng của Tools.

Tools có khả năng thêm, sửa, xóa,... đối với dữ liệu trên NetBox. Ví dụ như thêm 1 thiết bị, chỉnh sửa thông tin khách hàng hoặc xóa 1 thiết bị nào đó,... trên NetBox. 

## Mô hình tổng quan quy trình hoạt động của ứng dụng
![](/Anh/Screenshot_935.png)

### Pre-Launch(Checking)
Mục này sẽ kiểm tra xem thiết bị có phù hợp để chạy tools không. Các điều kiện sẽ là:
- Kiểm tra hệ điều hành: Linux
- Kiểm tra quyền hiện tại của người dùng đối với thiết bị đang sử dụng: Khuyến khích quyền Roots
- Kiểm tra trạng thái kết nối tới NetBox Server: Thử get 1 data bất kỳ và kiểm tra phản hồi

Nếu đáp ứng đủ các yêu cầu ở trên, tools sẽ bắt đầu quá trình khởi chạy

### Launch
Bắt đầu khởi chạy chương trình

Ở Menu chính sẽ là nơi mà bạn chọn xem bạn muốn làm gì với dữ liệu.
#### Add
Khi chọn thêm dữ liệu. Điều đầu tiên bạn sẽ thực hiện là chọn thêm mới 1 thiết bị ngay lập tức, hay lựa chọn thêm mới các dữ liệu cần thiết cho 1 Device trước

Nếu như lựa chọn của bạn là thêm mới ngay lập tức, nghĩa là bạn đã có đầy đủ các dữ liệu cần thiết cho 1 Device rồi và sẵn sàng để thêm mới tức thì. 

Và nếu bạn lựa chọn làm việc với các dữ liệu cần thiết trước thì bạn sẽ có 2 lựa chọn là:
- Lấy dữ liệu có sẵn từ NetBox. Đối với việc này, tôi chỉ đơn giản show ra cho bạn những dữ liệu sẵn có từ NetBox để bạn tham khảo và tái sử dụng
- Tạo mới dữ liệu. Tạo mới hoàn toàn các dữ liệu này với các thông tin cơ bản bắt buộc phải có.

Sau khi đã hoàn tất, dữ liệu sẽ được tổng hợp lại và đưa ra thành 1 file json.

Cuối cùng, dữ liệu được bỏ vào phần body của lệnh curl để đưa lên NetBox
#### Update

#### Delete

## Chi tiết về dự án
Ở phần này chúng ta sẽ cùng phát triển dự án này
### Pre-Launch
Ở phần này sẽ là hiển thị các thông báo kiểm tra các yêu cầu hệ thống, phân quyền, kết nối trước khi khởi chạy Tools.

Vì các code kiểm tra này khá đơn giản, vậy nên mình sẽ tạo ra 1 hàm Pre-Lauch có tác đầy đủ các mục kiểm tra trước khi chạy mà mình đã nêu trên
#### Kiểm tra OS:
Kiểm tra hệ điều hành có phải Linux hay không. Nếu không phải thì in ra thông báo và thoát:
```
if [[ "$(uname -s)" != "Linux" ]]; then
        echo "You must using Linux OS to run this scripts!"
        exit 1
    else
        echo "Checking........"
        echo "OS Checking complete!"
    fi
```
Giải thích code: 
- Câu lệnh `uname -s` sẽ hiển thị hệ điều hành của thiết bị
- So sánh với Linux. Nếu không phải Linux thì hiện lỗi và thoát
#### Kiểm tra quyền của người dùng
Kiểm tra xem người dùng có đang chạy chương trình với quyền root hay không.
```
if [[ $EUID -ne 0 ]]; then
        echo "You should run this scripts with root's permission!"
        exit 1
    else
        echo "Checking......."
        echo "Permission Checking complete!"
    fi
```
Giải thích:
- Biến **$EUID** sẽ chứa 1 số lưu thông tin quyền của người dùng
- Nếu giá trị của biến là `0` thì sẽ là người dùng với quyền root
#### Kiểm tra trạng thái kết nối API tới NetBox
NetBox Server
```
response=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Token $NETBOX_TOKEN" https://$NETBOX_URL/api/)
    if [[ $response -ne 200 ]]; then
        echo "Can't connect to NetBox, please check the url and token again!!!"
        exit 1
        Total_time
    else    
        echo "Connect to $NETBOX_URL successfully!"
        echo "Finished Checking!"
    fi
```
- Để kiểm tra trạng thái kết nối, tôi sẽ gọi 1 câu lệnh GET tới Server. 
- Câu lệnh `curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Token $NETBOX_TOKEN" https://$NETBOX_URL/api/` sẽ trỏ tới trang web API của NetBox mà bạn đã nhập.
  - `-s` để ẩn tiến trình và lỗi
  - `-o /dev/null` để lưu response vào `/dev/null`
  - `-w "%{http_code}"` để lưu mã trạng thái
  - `-H "Authorization: Token $NETBOX_TOKEN"` để thêm vào Header trường Authorization
  - `https://$NETBOX_URL/api/` là đường dẫn tới web api
- Sau khi thực hiện câu lệnh, biến response sẽ chứa mã trạng thái khi Get Data. Nếu mã là 200 thì sẽ hiển thị kết nối ổn định và hoàn thành Check
### Các Menu trong Tools
Mục này mô tả về Code các Menu trong Tools này
#### Main Menu
Là nơi mà bạn chọn cách thao tác với dữ liệu trên NetBox
```
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
```
Giải thích:
- Sử dụng cấu trúc `case - in` để hiển thị các lựa chọn trong Menu
- Mỗi lựa chọn sẽ dẫn tới 1 Menu hoặc 1 hàm khác.
- Ví dụ, khi bạn chọn `Add Device` thì tools sẽ dẫn bạn đến Menu Add.
- Tương tự khi bạn chọn vào 1 mục bất kì trong Menu

#### Add Menu
Là Menu để bạn lựa chọn các thao tác khi Add data
```
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
```
Giải thích:
- Tương tự như các Menu khác, chúng ta cũng sử dụng cấu trúc `case - in` để tạo ra các lựa chọn
- Mỗi lựa chọn sẽ đưa chúng ta tới 1 nơi khác nhau để làm việc

#### Add Device Menu
Là Menu cho bạn chọn lựa khi muốn thêm 1 Device mới
```
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
        1) adding ;;                  # Hàm để add Device
        2) show_data_Menu ;;          # Menu Show data
        3) add_menu ;;                # Trở về Menu Add
        4) main_menu ;;               # Trở về Main Menu
        *) echo "Invalid choice. Please select 1, 2, 3, or 4." ;;
    esac
}
```
Giải thích:
- Vẫn tiếp tục sử dụng cấu trúc `case - in`
- Thêm 1 số lựa chọn cho phép quay trở lại các Menu trước đó

#### Add Data of Device Menu
Là Menu để bạn lựa chọn sẽ thêm dữ liệu gì trước khi thêm Device
```
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
```
Giải thích:
- Vẫn tiếp tục sử dụng cấu trúc `case - in` để làm các lựa chọn cho Menu
- Bạn sẽ có 2 lựa chọn: Tạo mới hoặc xem các dữ liệu có sẵn trên NetBox
#### Create Menu
Là menu để bạn chọn dữ liệu để thêm mới trước khi thêm 1 device
```
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
```
Giải thích:
- Vẫn tiếp tục sử dụng cấu trúc `case - in`
- Menu này sẽ đưa bạn tới với các Hàm Create để tạo mới data
- Hoặc khi việc tạo đã hoàn tất sẽ có lựa chọn để trở lại Menu Add Data

#### Show data Menu
Là menu cho bạn lựa chọn xem data nào ở NetBox
```
show_data_Menu () {
    echo "Welcome to the Showing data menu, where we show you the data you need"
    echo "========== Showing Data Menu =========="
    echo "1. Showing data of Sites"
    echo "2. Showing data of Locations"
    echo "3. Showing data of Device Role"
    echo "4. Showing data of Device Type"
    echo "5. Showing data of Devices"
    echo "6. Continue"
    echo "======================================="
    read -p "Your choice: " data_r_choice
    case $data_r_choice in
        1) show_data_of_Sites ;;
        2) show_data_of_location ;;
        3) show_data_of_Device_Roles ;;
        4) show_data_of_Device_Types ;;
        5) show_device ;;
        6) Add_data_menu;;
    esac
}
```
Giải thích:
- Vẫn tiếp tục sử dụng cấu trúc `case - in`
- Menu này sẽ đưa bạn đến với các Hàm Show data
- Hoặc cũng sẽ có lựa chọn để đưa bạn về Menu chính

### Các hàm Create
Là các hàm được tạo ra nhằm Post data lên NetBox
#### Create Site
Là hàm được tạo ra với mục đích tạo ra 1 Site mới với các thông tin cơ bản
```
create_site () {
    read -p "Enter Site Name: " site_name
    read -p "Enter Slug: " site_slug
    read -p "Enter Status(active): " site_status
    read -p "Enter Region ID: " region
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
    response=$(curl -s -w "%{http_code}" -o /dev/null -X POST "https://$NETBOX_URL/api/dcim/sites/" \
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
```
Giải thích:
- Trước tiên, sẽ yêu cầu người dùng nhập vào 1 số thông tin cần thiết để tạo ra 1 Sites.
  - Sử dụng câu lệnh `read -p` để nhận giá trị nhập vào và gán vào biến
  - Set up các giá trị mặc định nếu người dùng không nhập vào gì: `site_time_zone=${site_time_zone:-Asia/Ho_Chi_Minh}`
- Sau khi người dùng nhập hoàn tất các thông tin cần thiết, chúng ta sẽ tiến hành tổng hợp dữ liệu và tạo thành 1 đoạn code json
  - Cú pháp cat `<<EOF ... EOF` được gọi là ***heredoc***, dùng để nhập một khối văn bản nhiều dòng vào một biến hoặc truyền cho một lệnh. Ở đây là truyền đoạn văn bản vào biến `json_body`
  - Đoạn mã json sẽ chứa các dữ liệu sau khi đã tổng hợp ở trên.
- Cuối cùng chúng ta tiến hành gửi yêu cầu POST lên NetBox để tiến hành tạo 1 Site mới
  - `response=$(curl -s -w "%{http_code}" -o /dev/null -X POST "https://$NETBOX_URL/api/dcim/sites/" \
  -H "Authorization: Token $NETBOX_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$json_body")` phần này sẽ gán kết quả của lệnh curl vào biến `response`
  - Sau đó sẽ có 1 đoạn code dùng để kiểm tra mã trạng thái này xem liệu việc POST có thành công hay không.
- Sau khi hoàn tất sẽ gọi lại menu Create để người dùng có thể tiếp tục làm việc
#### Create Locations
Hàm sử dụng để tạo ra 1 Locations mới
```
create_location () {
    list_of_locations=()
    responselistloca=$(curl -s -X GET -H "Authorization: Token $NETBOX_TOKEN" "https://$NETBOX_URL/api/dcim/locations/")
    mapfile -t list_of_locations < <(echo "$responselistmanu" | jq -r '.results[] | "\(.id):\(.name)"')

    echo "Available locations:"
    for location_info in "${list_of_locations[@]}"; do
        echo "$location_info"
    done

    read -p "Enter Site ID: " site_id
    read -p "Enter Location Name: " location_name
    read -p "Enter Slug: " location_slug
    read -p "Enter Status: " location_status

    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" \
        -d "{\"site\": $site_id, \"name\": \"$location_name\", \"slug\": \"$location_slug\",  \"status\": \"$location_status\"}" https://$NETBOX_URL/api/dcim/locations/)

    if [[ "$response" -lt 300 ]]; then
        echo "Location created successfully!"
    else
        echo "Failed to create location. HTTP Status Code: $response"
    fi

    create_menu
}
```
Giải thích code:
- Trước tiên, tôi sẽ tạo ra 1 mảng trống để hiển thị 1 Danh sách các Locations có sẵn.
  - Biến `responselistloca` sẽ chứa dữ liệu JSON trả về từ NetBox, chứa thông tin về các địa điểm (locations).
  - Tiếp theo đó, tôi sử dụng `mapfile` để xử lý dữ liệu JSON
  - `mapfile -t list_of_locations`: Lệnh ***mapfile*** sẽ đọc dữ liệu từ đầu vào và lưu vào mảng **list_of_locations**. Tùy chọn `-t` sẽ loại bỏ ký tự dòng mới `(\n)` khi lưu vào mảng.
  - Tiếp đến sẽ sử dụng `jq` để xử lý các dữ liệu đầu ra. Tùy chọn `-r` sẽ trả về kết quả dạng chuỗi không có các dấu ngoặc. Sau đó sẽ tiến hành lặp qua các giá trị trong `results` và lấy ra các trường "id" và "name". Kết quả sẽ được lưu vào mảng `list_of_locations`
  - Cuối cùng là vòng lặp `for` để hiển thị từng phần tử trong mảng cho người dùng
- Tiếp theo sẽ là câu lệnh đưa dữ liệu lên NetBox, sử dụng lệnh `curl`
```
response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Authorization: Token $NETBOX_TOKEN" -H "Content-Type: application/json" \
        -d "{\"site\": $site_id, \"name\": \"$location_name\", \"slug\": \"$location_slug\",  \"status\": \"$location_status\"}" https://$NETBOX_URL/api/dcim/locations/)
```
- Dữ liệu sẽ được gán vào biến response.
- Lệnh curl sẽ sử dụng các tùy chọn như 
  - `-s`: Ẩn quá trình, lỗi
  - `-o /dev/null`: Lưu kết quả vào file tạm thời
  - `-w "%{http_code}"`: Lưu lại mã trạng thái
  - `-X POST`: Phương thức sử dụng là POST
  - `-H "Authorization: Token $NETBOX_TOKEN"`: Thêm trường Autho để nhập Token
  - `-d "{\"site\": $site_id, \"name\": \"$location_name\", \"slug\": \"$location_slug\",  \"status\": \"$location_status\"}"`: Sử dụng options `-d` để nhập vào phần body chứa dữ liệu muốn thêm vào NetBox
  - `https://$NETBOX_URL/api/dcim/locations/`: Cuối cùng là URL dẫn tới Web API
- Cuối cùng sẽ đưa người dùng trở về MENU CREATE

#### Create Device Types:
Hàm được tạo ra để tạo mới 1 Device Types.
```
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
```
Giải thích: 
- Về logic hoạt động, nó giống hêt với hàm Create Locations.
- Ban đầu, hàm cũng sẽ hiển thị 1 List các Manufactures có sẵn với ID và Tên để người dùng có thể dễ dàng chọn lựa
- Sau đó, người dùng nhập vào 1 số thông tin cần thiết để tạo nên 1 Device Types
- Sau đó sẽ tổng hợp dữ liệu và đưa vào lệnh `curl` rồi Post lên NetBox
- 