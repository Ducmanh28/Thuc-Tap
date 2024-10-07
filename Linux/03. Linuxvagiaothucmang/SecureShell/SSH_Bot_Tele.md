# Giám sát truy cập SSH thông qua Telegram
- Việc giám sát truy cập SSH là điều quan trọng mà Người quản lý máy chủ cần phải làm
- Ta có thể cài đặt để nhận thông báo khi có lượt truy cập SSH thông qua ứng dụng Telegram
- Việc cài đặt và quá trình sẽ diễn ra như sau:
  - Trước tiên, để nhận được thông báo, phải có người gửi thông báo cho mình. Trong trường hợp này, chúng ta sẽ sử dụng BOT của Telegram
  - Tiến hành tạo BOT Telegram:
    - Trên thanh **Search** của Telegram, tìm kiếm **BOTFATHER**
    - Thực hiện trò chuyện với **BOTFATHER** `/start`
    - Tạo Bot mới bằng cách nhập `/newbot`
    - Quá trình tạo sẽ diễn ra như sau:
    - ![](/Anh/Screenshot_308.png)
    - Tin nhắn **Done** hiện ra nghĩa là bạn đã hoàn thành việc tạo BOT. Hãy chú ý tới **Token** vì nó sẽ được dùng để điều khiển BOT của bạn
  - Tiến hành kiểm tra BOT:
    - Truy cập đường dẫn sau `https://api.telegram.org/bot<TOKEN>/getMe`
    - Lưu ý thay <Token> bằng Token bot của bạn
    - Ví dụ Bot của tôi sẽ có đường dẫn là [BOTDUCMANH](https://api.telegram.org/bot6740699828:AAGyqyeheYfcUpWSbLuW6T18w4xI-Jh0-Ac/getMe)
    - Thông tin của BOT sẽ hiện ra 
    - ![](/Anh/Screenshot_300.png)
  - Bây giờ, bạn cần biết ID Chat:
    - Truy cập Telegram
    - Tìm kiếm **@myidbot** 
    - `/start` và nhập lệnh `/getid` để tìm id của mình
    - ![](/Anh/Screenshot_301.png)
  - Tiếp đó, ta cần một trình biên dịch để đọc các file `.json`. Ở đây, ta sẽ dùng trình biên dịch `jq`
    - Có thể cài đặt bằng cách dùng lệnh `apt install jq -y`
  - Tiến hành cài Scripts gửi thông báo
    - Chúng ta cần xác định thư mục để tạo scripts
      - Thư mục ở đây sẽ có đường dẫn `/etc/profile.d`
      - Thư mục sẽ nằm trong list các thư mục hệ thống, nằm trong `profile.d` vì thư mục này được sử dụng để chứa các script mà hệ thống sẽ chạy khi mà một người dùng đăng nhập vào hệ thống
      - Các file có kết thúc là `.d` hay còn gọi là `directory` để chỉ ra rằng đây là thư mục chứa các file hoặc scripts của hệ thống
    - Sau khi xác nhận xong đường dẫn tạo thư mục, ta dùng trình soạn thảo văn bản để tạo ra 1 file mới và đặt tên cho file này là `ssh-telegram.sh`.
      - File `.sh` là các file **Shell Scripts**, là một file text chứa một chuỗi các lệnh cho hệ thống dựa trên UNIX/DEBIAN/LINUX/UBUNTU
      - Các file `.sh` là các file thực thi của OS Unix, tương đương với các file `.bat` trên Windows. Có thể tham khảo thêm các file [`.bat`](https://quantrimang.com/cong-nghe/file-bat-la-gi-196163)
    - Tiếp đó, ta thực hiện chỉnh sửa file `ssh-telegram.sh` như sau: 
    - ```
      USERID="<target_user_id>" #USERID của bạn
      TOKEN="<bot_private_TOKEN>" #TOKEN của bot đã lập
      TIMEOUT="10"
      URL="https://api.telegram.org/bot$TOKEN/sendMessage"
      DATE_EXEC="$(date "+%d %b %Y %H:%M")"
      TMPFILE='/tmp/ipinfo.txt'
      if [ -n "$SSH_CLIENT" ]; then
      IP=$(echo $SSH_CLIENT | awk '{print $1}')
      PORT=$(echo $SSH_CLIENT | awk '{print $3}')
      HOSTNAME=$(hostname -f)
      IPADDR=$(echo $SSH_CONNECTION | awk '{print $3}')
      curl http://ipinfo.io/$IP -s -o $TMPFILE
      CITY=$(cat $TMPFILE | jq '.city' | sed 's/\"//g')
      REGION=$(cat $TMPFILE | jq '.region' | sed 's/\"//g')
      COUNTRY=$(cat $TMPFILE | jq '.country' | sed 's/\"//g')
      ORG=$(cat $TMPFILE | jq '.org' | sed 's/\"//g')
      TEXT=$(echo -e "Thời gian: $DATE_EXEC\nUser: ${USER} logged in to $HOSTNAME ($IPADDR)\nFrom $IP - $ORG - $CITY, $REGION, $COUNTRY on port $PORT")
      curl -s -X POST --max-time $TIMEOUT $URL -d "chat_id=$USERID" -d text="$TEXT" > /dev/null
      rm $TMPFILE
      fi 
      ```
    - Giải mã Code:
      - Giải thích các biến được sử dụng:
        - **USERID**: Nhập vào ID Chat của bạn
        - **TOKEN**: Nhập vào Token bot bạn đã lập
        - **TIMEOUT**: Thời gian chờ tối đa
        - **URL**: Đường Link đến Bot Telegram của bạn
        - **DATE_EXEC**: Biến này chứa thời gian của hệ thống
        - **TMPFILE**: Khởi tạo File [Temp](https://fptshop.com.vn/tin-tuc/thu-thuat/file-tmp-la-gi-cach-mo-file-tmp-tren-windows-151813)
        - **$SSH_CLIENT**: Biến này chứa ip, port_number của SSH_CLIENT 
        - ![](/Anh/Screenshot_303.png)
        - **$SSH_CONNECTION**: Biến này chứa IP đích, nguồn, cổng port kết nối SSH
        - ![](/Anh/Screenshot_304.png)
        - **$HOSTNAME**: Biến này chứa tên máy chủ
        - **$TEXT**: Biến này chứa nội dung cảnh báo
      - Giải thích từng dòng code:
        - `USERID="<target_user_id>"`: Đây là ID của người dùng Telegram mà bạn muốn gửi thông báo đến. Bạn cần thay <target_user_id> = id chat của bạn
        - `TOKEN="<bot_private_TOKEN>"`: Đây là mã token riêng của bot Telegram mà bạn đã tạo. Bạn cần thay <bot_private_TOKEN> = TOKEN bot của bạn
        - `TIMEOUT="10"`: Đây là thời gian chờ tối đa (tính bằng giây) cho việc gửi thông báo qua bot.
        - `URL="https://api.telegram.org/bot$TOKEN/sendMessage"`: Đây là URL của API Telegram, được sử dụng để gửi tin nhắn từ bot.
        - `DATE_EXEC="$(date "+%d %b %Y %H:%M")"`: Đây là lệnh để lấy thời gian hiện tại của hệ thống.
        - `TMPFILE='/tmp/ipinfo.txt'`: Đây là đường dẫn tới file tạm thời, được sử dụng để lưu thông tin về địa chỉ IP.
        - `if [ -n "$SSH_CLIENT" ]; then`: Đây là câu lệnh kiểm tra xem biến môi trường SSH_CLIENT có giá trị hay không. Nếu có, đoạn mã bên trong khối if sẽ được thực thi.
          - `if`: Bắt đầu vào câu điều kiện trong bash scripts
          - `[-n "$SSH_CLIENT"]`: Là biểu thức điều kiện. Tùy chọn `-n` sẽ kiểm tra xem biến trong `" "` có độ dài khác 0 hay không.
            - Nếu khác 0 sẽ trả về True
            - Nếu = 0 sẽ trả về False
          - `then`: Nếu điều kiện True sẽ khởi chạy các câu lệnh sau `then - fi`. Nếu điều kiện là False sẽ khởi chạy các câu lệnh sau `fi` mà bỏ qua các câu lệnh từ `then - fi`
        - `IP=$(echo $SSH_CLIENT | awk '{print $1}')`: Đây là lệnh để lấy địa chỉ IP của người dùng đang kết nối qua SSH.
          - `echo` để in ra giá trị
          - Tùy chọn thêm `awk '{print $1}'`: Là lấy giá trị đầu tiên của biến
          - Tức là lệnh này sẽ in ra giá trị đầu tiên trong biến $SSH_CLIENT
        - `PORT=$(echo $SSH_CLIENT | awk '{print $3}')`: Đây là lệnh để lấy cổng mà người dùng đang kết nối qua SSH.
        - `HOSTNAME=$(hostname -f)`: Đây là lệnh để lấy tên máy chủ.
        - `IPADDR=$(echo $SSH_CONNECTION | awk '{print $3}')`: Đây là lệnh để lấy địa chỉ IP của máy chủ.
        - `curl http://ipinfo.io/$IP -s -o $TMPFILE`: Đây là lệnh để lấy thông tin về địa chỉ IP từ trang web ipinfo.io và lưu vào file tạm thời.
        - `CITY=$(cat $TMPFILE | jq '.city' | sed 's/\"//g')`: Đây là lệnh để lấy thông tin về thành phố từ file tạm thời
          - `cat $TMPFILE`: Đọc file $TMPFILE
          - `jq '.city'`: lấy giá trị của trường **city** từ file **JSON**
          - `sed 's/\"//g'`: Dùng để xóa dấu `"` trong chuỗi văn bản
          - `'s/\"//g'`: `s` là lệnh thay thế, `\"` là dấu `"` cần xóa, `//` là phần thay thế(trống), `g` là tùy chọn thay thế trên toàn bộ văn bản
        - `REGION=$(cat $TMPFILE | jq '.region' | sed 's/\"//g')`: Đây là lệnh để lấy thông tin về khu vực từ file tạm thời.
        - `COUNTRY=$(cat $TMPFILE | jq '.country' | sed 's/\"//g')`: Đây là lệnh để lấy thông tin về quốc gia từ file tạm thời.
        - `ORG=$(cat $TMPFILE | jq '.org' | sed 's/\"//g')`: Đây là lệnh để lấy thông tin về tổ chức từ file tạm thời.
        - `TEXT=$(echo -e "Thời gian: $DATE_EXEC\nUser: ${USER} logged in to $HOSTNAME ($IPADDR)\nFrom $IP - $ORG - $CITY, $REGION, - $COUNTRY on port $PORT")`: Đây là lệnh để tạo nội dung cảnh báo.
        - `curl -s -X POST --max-time $TIMEOUT $URL -d "chat_id=$USERID" -d text="$TEXT" > /dev/null`: Đây là lệnh để gửi cảnh báo qua bot Telegram.
          - `curl`: Đây là lệnh được sử dụng để gửi yêu cầu HTTP
          - `-s`: Là một tùy chọn của `curl`, khiến `curl` hoạt động ở chế độ im lặng, không in ra thông tin về quá trình kết nối và tiến trình
          - `-X POST`: Tùy chọn này sẽ chỉ định `curl` gửi một yêu cầu **HTTP POST**
          - `--max-time $TIMEOUT`: Tùy chọn này đặt thời gian chờ tối đa cho toàn bộ quá trình kết nối
          - `$URL`: Là URL mà `curl` sẽ gửi yêu cầu đến
          - `-d "chat_id=$USERID"` và `-d text="$TEXT"`: các tùy chọn `-d` để tùy chọn dữ liệu sẽ được gửi trong yêu cầu POST 
          - `> /dev/null `: Chuyển hướng đầu ra của `curl` đến `/dev/null`. Điều này có nghĩa bạn sẽ không thấy bất kì đầu ra của `curl` trên màn hình console
        - `rm $TMPFILE`: Đây là lệnh để xóa file tạm thời sau khi script thực hiện xong.
        - `fi`: Được dùng để kết thúc một khối lệnh `if`
        ``
- Kiểm tra quá trình:
  - Dùng lệnh `cat /etc/profile.d/ssh-telegram.sh`
  - ![](/Anh/Screenshot_309.png)
  - Test thử kết quả:
  - ![](/Anh/Screenshot_307.png)