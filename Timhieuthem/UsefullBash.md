# Mục này giải thích về một vài Shell Scripts đơn giản

## 1. Vẽ ra một mẫu đặc biệt
Đoạn code:
```
#!/bin/bash  
#Dòng này xác định loại shell mà script sẽ chạy, trong trường hợp này là bash.

MAX_NO=0    
#Khởi tạo biến MAX_NO với giá trị mặc định là 0.
echo -n "Enter a number between (5 to 9): "
read MAX_NO 
# Nhập một số từ 5 đến 9, sau đó đưa giá trị người dùng nhập vào rồi gán vào biến MAX_NO

if ! [ $MAX_NO -ge 5 -a $MAX_NO -le 9 ]; then
   echo "Please enter a number between 5 and 9. Try again."
   exit 1
fi
# Nếu biến MAX_NO <=5 hoặc >=9 thì chạy điều kiện sau then, nếu không thì chạy sau fi.
clear

for ((i=1; i<=MAX_NO; i++)); do
    for ((s=MAX_NO; s>=i; s--)); do
        echo -n " "
    done
    for ((j=1; j<=i; j++)); do
        echo -n " ."
    done
    echo ""
done
# Vòng lặp for đầu tiên: Dùng để vẽ ra nửa tam giác trên bằng cách sử dụng hai vòng lặp lồng nhau. Vòng lặp bên ngoài chạy từ 1 đến giá trị của MAX_NO, và vòng lặp bên trong chạy từ giá trị của MAX_NO đến 1.

###### Second stage ######################

for ((i=MAX_NO; i>=1; i--)); do
    for ((s=i; s<=MAX_NO; s++)); do
        echo -n " "
    done
    for ((j=1; j<=i; j++)); do
        echo -n " ."
    done
    echo ""
done
# Vòng lặp for thứ hai: Tương tự như vòng lặp for đầu tiên, nhưng lặp ngược lại từ MAX_NO đến 1.

echo -e "\n\n\t\t\t Whenever you need help, Tecmint.com is always there"
```

## 2. Tạo ra một Script đầy màu sắc
Đoạn code:

```
#!/bin/bash
clear 
echo -e "\e[1mHello World"      # In đậm
echo -e "\e[5mBlink"            # Nhấp nháy
echo -e "\e[0mHello World"      # Trở về trạng thaí mặc định
echo -e "\e[31mHello World"     # Red color
echo -e "\e[32mHello World"     # Green color
echo -e "\e[33mHello World"     # Yellow color
echo -e "\e[34mHello World"     # Blue color
echo -e "\e[35mHello World"     # Magenta color
echo -e "\e[36mHello World"     # Cyan color
echo -e "\e[0m"                 # back to normal
echo -e "\e[41mHello World"     # Red background
echo -e "\e[42mHello World"     # Green background
echo -e "\e[43mHello World"     # Yellow background
echo -e "\e[44mHello World"     # Blue background
echo -e "\e[45mHello World"     # Magenta background
echo -e "\e[46mHello World"     # Cyan background
echo -e "\e[0mHello World"      # back to normal
```

Trong đó `\e[(number)m]` là mã điều khiển

## 3. Mã hóa một tệp tin hoặc thư mục nào đó:
Đoạn code có sử dụng công cụ mã hóa **GnuPG**(GPG)
```
#!/bin/bash

echo "Welcome! I am ready to encrypt a file/folder for you."
echo "Currently, I have a limitation. Please place me in the same folder where the file to be encrypted is located."
echo "Enter the exact file name with the extension."
read file;  # Đọc file

gpg -c "$file"  # Sử dụng GPG để mã hóa tập tin được chỉ định bởi biến file. Tùy chọn -c yêu cầu GPG mã hóa tập tin và tạo ra một phiên bản mới có đuôi .gpg.

echo "I have successfully encrypted the file..."

# Ask for confirmation before removing the original file
read -p "Do you want to remove the original file? (y/n): " confirm  # Hỏi người dùng có muốn xóa tập tin gốc hay không.

if [ "$confirm" == "y" ]; then
    rm -rf "$file"  # 
    echo "Original file removed."
else
    echo "Original file was not removed. Exiting without deletion."
# Nếu người dùng đồng ý xóa tập tin gốc (confirm là "y"), thì sử dụng lệnh rm để xóa tập tin. Tùy chọn -rf được sử dụng để đảm bảo xóa tập tin mà không cần xác nhận và không hiển thị thông báo lỗi.
```

## 4. Trình bày sức khỏe hệ thống
Đoạn code:

```
#!/bin/bash
    date;
    echo "uptime:"
    uptime
    echo "Currently connected:"
    w
    echo "--------------------"
    echo "Last logins:"
    last -a |head -3
    echo "--------------------"
    echo "Disk and memory usage:"
    df -h | xargs | awk '{print "Free/total disk: " $11 " / " $9}'
    free -m | xargs | awk '{print "Free/total memory: " $17 " / " $8 " MB"}'
    echo "--------------------"
    start_log=`head -1 /var/log/messages |cut -c 1-12`
    oom=`grep -ci kill /var/log/messages`
    echo -n "OOM errors since $start_log :" $oom
    echo ""
    echo "--------------------"
    echo "Utilization and most expensive processes:"
    top -b |head -3
    echo
	top -b |head -10 |tail -4
    echo "--------------------"
    echo "Open TCP ports:"
    nmap -p- -T4 127.0.0.1
    echo "--------------------"
    echo "Current connections:"
    ss -s
    echo "--------------------"
    echo "processes:"
    ps auxf --width=200
    echo "--------------------"
    echo "vmstat:"
    vmstat 1 5
```
Giải thích từng dòng code:

- date;: In ra ngày và giờ hiện tại.
echo "uptime:": In ra thông tin về thời gian hoạt động của hệ thống.
- uptime: Hiển thị thời gian hoạt động của hệ thống, số người dùng đang kết nối và tải trung bình của hệ thống.
echo "Currently connected:": In ra thông tin về người dùng hiện đang kết nối.
- w: Hiển thị người dùng hiện đang đăng nhập và các hoạt động của họ.
- echo "--------------------": In ra một đường kẻ ngang để phân tách các phần thông tin.
- echo "Last logins:": In ra thông tin về các lần đăng nhập cuối cùng vào hệ thống.
- last -a |head -3: Hiển thị ba lần đăng nhập cuối cùng vào hệ thống.
echo "--------------------": In ra một đường kẻ ngang.
- echo "Disk and memory usage:": In ra thông tin về sử dụng đĩa và bộ nhớ.
- df -h | xargs | awk '{print "Free/total disk: " $11 " / " $9}': Hiển thị thông tin về sử dụng đĩa.
- free -m | xargs | awk '{print "Free/total memory: " $17 " / " $8 " MB"}': Hiển thị thông tin về sử dụng bộ nhớ.
- echo "--------------------": In ra một đường kẻ ngang
- start_log=head -1 /var/log/messages |cut -c 1-12``: Lấy thời gian bắt đầu ghi log từ file /var/log/messages.
- oom=grep -ci kill /var/log/messages``: Đếm số lần ghi log có chứa từ "kill" từ file /var/log/messages.
- echo -n "OOM errors since $start_log :" $oom: In ra số lượng lỗi "OOM" (Out of Memory) từ thời điểm start_log.
- echo "": In ra một dòng trống.
- echo "--------------------": In ra một đường kẻ ngang.
- echo "Utilization and most expensive processes:": In ra thông tin về tải CPU và các tiến trình tốn nhiều tài nguyên nhất.
- top -b |head -3: Hiển thị ba tiến trình đầu tiên đang tốn nhiều tài nguyên nhất.
- top -b |head -10 |tail -4: Hiển thị bốn tiến trình tiếp theo tốn nhiều tài nguyên nhất.
- echo "--------------------": In ra một đường kẻ ngang.
- echo "Open TCP ports:": In ra thông tin về các cổng TCP đang mở trên hệ thống.
- nmap -p- -T4 127.0.0.1: Quét tất cả các cổng TCP trên máy cục bộ.
- echo "--------------------": In ra một đường kẻ ngang.
- echo "Current connections:": In ra thông tin về các kết nối hiện tại.
- ss -s: Hiển thị tóm tắt về tình trạng kết nối.
- echo "--------------------": In ra một đường kẻ ngang.
- echo "processes:": In ra thông tin về các tiến trình đang chạy.
- ps auxf --width=200: Hiển thị thông tin về các tiến trình đang chạy.
- echo "--------------------": In ra một đường kẻ ngang.
- echo "vmstat:": In ra thông tin về tình trạng hệ thống và tài nguyên.
- vmstat 1 5: Hiển thị thống kê về bộ nhớ, CPU, I/O và tình trạng tiến trình mỗi giây trong 5 giây tiếp theo.

## 5. Giasm sát sử dụng ổ đĩa
Đoạn code:
```
#!/bin/bash

# Đặt một biến MAX để đại diện cho phần trăm sử dụng tối đa của không gian đĩa (90% trong trường hợp này)
MAX=90 

# Đặt biến EMAIL để chỉ định địa chỉ email mà cảnh báo sẽ được gửi đến.
EMAIL=user@example.com

# Đặt biến PARTITION để chỉ định phân vùng sẽ được giám sát. Đây có thể là một phân vùng đĩa cụ thể
PARTITION=/dev/sda1

# Sử dụng lệnh df -h để lấy thông tin về sử dụng không gian đĩa cho phân vùng được chỉ định. Dòng lệnh awk và tr được sử dụng để lọc và định dạng thông tin này thành một chuỗi duy nhất.
USAGE_INFO=$(df -h "$PARTITION" | awk 'NR==2 {print $5, $1, $2, $3, $4}' | tr '\n' ' ') 

# Trích xuất phần trăm sử dụng không gian đĩa từ chuỗi thông tin và lưu vào biến USAGE.
USAGE=$(echo "$USAGE_INFO" | awk '{print int($1)}')  
# Remove the percentage sign

# Bắt đầu một câu lệnh điều kiện, kiểm tra xem phần trăm sử dụng không gian đĩa có lớn hơn ngưỡng tối đa không.
if [ "$USAGE" -gt "$MAX" ]; then
  # Send an email alert with detailed disk usage information
  echo -e "Warning: Disk space usage on $PARTITION is $USAGE%.\n\nDisk Usage Information:\n$USAGE_INFO" | \
    mail -s "Disk Space Alert on $HOSTNAME" "$EMAIL"
fi
```