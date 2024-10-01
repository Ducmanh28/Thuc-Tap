# Mục này thực hành viết tools thao tác với API của NetBox
Trước khi tiến tới việc viết tools, chúng ta cần thực hành add thủ công device của NetBox trước để nắm rõ các bước, các thông tin cần điền,...

## Tổng quan về dự án
Tools này được làm ra để có thể thao tác với dữ liệu của NetBox từ các máy client từ xa, không cần truy cập qua hệ thống giao diện đồ họa của NetBox, chỉ sử dụng các công cụ dòng lệnh, API để làm việc với dữ liệu trên NetBox. 

Tools sử dụng ngôn ngữ BashScripts, chạy trên các máy hệ điều hành UNix, Linux. Ngoài ra, có thể tích hợp thêm Python hoặc JavaScripts để hỗ trợ cho các tính năng của Tools.

Tools có khả năng thêm, sửa, xóa,... đối với dữ liệu trên NetBox. Ví dụ như thêm 1 thiết bị, chỉnh sửa thông tin khách hàng hoặc xóa 1 thiết bị nào đó,... trên NetBox. 

## Mô hình tổng quan quy trình hoạt động của ứng dụng
![](/Anh/Screenshot_934.png)

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
Khi chọn thêm dữ liệu. Điều đầu tiên sẽ thực hiện chọn xem bạn muốn thêm những dữ liệu gì của 1 device. 1 bảng thông tin sẽ hiện ra để bạn chọn những dữ liệu mà mình muốn thêm.

Sau khi chọn dữ liệu, chúng ta sẽ xử lý đến các trường dữ liệu có sẵn trên NetBox để lấy xuống. Ví dụ như Device Types, Device Roles, Sites, Locations,.... Đối với các trường dữ liệu như thế này, chúng ta sẽ có 2 lựa chọn. 
- Lấy dữ liệu có sẵn từ NetBox. Đối với việc này, sau khi get dữ liệu xuống, chúng ta sẽ lưu dữ liệu vào 1 mảng để người dùng có thể lựa chọn thêm dữ liệu nào
- Tạo mới dữ liệu

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
#### Kiểm tra trạng thái kết nối API tới NetBox
Kiểm tra xem Ping tới NetBox Server có thông hay không trước khi tiến hành chạy. Ở đây sẽ yêu cầu người dùng nhập vào domain của NetBox Server
```
read -p "Input the NetBox URL: " DOMAIN

    if ping -c 4 "$DOMAIN" > /dev/null 2>&1; then
        echo "Connect to $DOMAIN success!"
    else
        echo "Can't connect to $DOMAIN. Please check again! "
        exit 1
    fi
```
### Launch
Sau khi quá trình kiểm tra đã hoàn tất và thiết bị của bạn hoàn toàn đủ điều kiện để khởi chạy Tools thì script sẽ bắt đầu chạy.

#### Menu chính
Là nơi mà bạn sẽ chọn thao tác mà bạn muốn sử dụng đối với dữ liệu.

```
# Hàm in ra Menu chính
main_menu() {
    echo "========== Main Menu =========="
    echo "1. Add"
    echo "2. Update"
    echo "3. Delete"
    echo "4. Exit"
    echo "=============================="
    read -p "Your choice: " main_choice

    case $main_choice in
        1) add_menu ;;
        2) echo "Update" ;;
        3) echo "Delete" ;;
        4) exit 0 ;;
        *) echo "Wrong choice. Please check again!" ;;
    esac
}
```

#### 