# Mục này nghiên cứu cách tạo ra Bot_Tele_Info

## Tổng quan
Tool được sử dụng để hiển thị ra thông tin chi tiết của 1 device khi mà người dùng nhập vào 1 thông tin gì đó của Device như IP, Name,...

Tool sẽ thông qua Bot Telegram để hoạt động. Các thao tác sẽ được thực hiện thông qua Telegram. Ví dụ khi người dùng nhập IP vào ô chat, thông tin về Device gắn với IP đó sẽ hiện ra.

Sử dụng ngôn ngữ Python thay vì BashScripts. Có thể chạy trên đa nền tảng để có thể đảm bảo Tool luôn chạy trên cả Windows hay Mac hoặc Linux.

## Tổng quan về cách mà tool hoạt động.
Để có thể nắm bắt được cách phát triên, cách mà tool thực sự hoạt động thì trước tiên chúng ta phải nắm rõ quy trình hoạt động của API. Để hiểu biết rõ hơn về API, các bạn có thể tham khảo tại [đây](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/NetBox/API/API.md)

Mô hình hoạt động của API

![](/Anh/Screenshot_895.png)

API giúp giao tiếp giữa các thiết bị với nhau một cách dễ dàng. Nói dễ hiểu, API là cầu nối giao tiếp giữa các thiết bị điện tử. 

Từ đó, chúng ta có thể suy ra được cách mà Tool này hoạt động như sau

![](/Anh/Screenshot_952.png)

- Đầu tiên, client sẽ gửi 1 tin nhắn yêu cầu tới Bot-Telegram, yêu cầu này sẽ đi qua Telegram Server. Và chắc chắn cần có Internet để bạn thực hiện được điều này.
- Telegrame Server sẽ xử lý tin nhắn và gửi nó cho Bot-Telegram có Token tương ứng. 
- Bot-Telegram hiện tại đang nằm trên Laptop hoặc thiết bị nào đó có kết nối Internet và đang chạy Tool để Bot hoạt động và nhận được tin nhắn mà Telegram Server gửi tới.
- Sau khi đã nhận được tin nhắn, Bot Telegram sẽ xử lý yêu cầu mà tin nhắn gửi tới mong muốn nhận được phản hồi. Ví dụ bạn nhập `/ip 172.99.66.99` thì lúc này Bot sẽ gọi API lên NetBox Server để tìm kiếm, lấy thông tin.
- Sau khi tìm kiếm và lấy thông tin, Bot sẽ thực hiện xử lý thông tin thành tin nhắn dạng MarkDown và trả về cho Telegram Server.
- Cuối cùng, Telegram Server trả về tin nhắn cho Client.

Trong quá trình trên, Client sẽ giao tiếp với Bot thông qua Internet và Telegram Server. Còn quá trình giao tiếp giữa Bot và NetBox Server là Local.
## Phát triển
Hướng phát triển: Dựa theo mẫu sẵn và có phát triển thêm các tính năng và tiện ích, tối ưu cho người dùng.
### Tạo Bot Tele
Chúng ta có thể tạo 1 Bot Tele tại **BotFather** - BotFather là một con Bot được sử dụng để quản lý các bot còn lại. Chúng ta có thể sử dụng BotFather để tạo mới 1 con bot

Trước tiên, chúng ta tìm kiếm và nhập lệnh để bắt đầu cuộc trò chuyện:
```
/start
```
Sau khi nhập xong lệnh trên vào ô chat, chúng ta sẽ nhận được 1 tin nhắn bao gồm các lệnh như sau:
```
I can help you create and manage Telegram bots. If you're new to the Bot API, please see the manual (https://core.telegram.org/bots).

You can control me by sending these commands:

/newbot - create a new bot
/mybots - edit your bots

Edit Bots
/setname - change a bot's name
/setdescription - change bot description
/setabouttext - change bot about info
/setuserpic - change bot profile photo
/setcommands - change the list of commands
/deletebot - delete a bot

Bot Settings
/token - generate authorization token
/revoke - revoke bot access token
/setinline - toggle inline mode (https://core.telegram.org/bots/inline)
/setinlinegeo - toggle inline location requests (https://core.telegram.org/bots/inline#location-based-results)
/setinlinefeedback - change inline feedback (https://core.telegram.org/bots/inline#collecting-feedback) settings
/setjoingroups - can your bot be added to groups?
/setprivacy - toggle privacy mode (https://core.telegram.org/bots/features#privacy-mode) in groups

Web Apps
/myapps - edit your web apps (https://core.telegram.org/bots/webapps)
/newapp - create a new web app (https://core.telegram.org/bots/webapps)
/listapps - get a list of your web apps
/editapp - edit a web app
/deleteapp - delete an existing web app

Games
/mygames - edit your games (https://core.telegram.org/bots/games)
/newgame - create a new game (https://core.telegram.org/bots/games)
/listgames - get a list of your games
/editgame - edit a game
/deletegame - delete an existing game
```
Như đã thấy, chúng ta có thể"
- Create Bot
- Edit Bot
- Setting Bot
- Check Web Apps
- Play Games

Vấn đề quan trọng ở đây mà chúng ta cần để ý tới là:
```
# Câu lệnh để tạo 1 con bot mới
/newbot
```
Sau khi nhập lệnh trên, chúng ta sẽ nhận được 1 tin nhắn yêu cầu nhập vào tên của Bot. Hãy trả lời lại bằng tên của con Bot mà bạn muốn tạo
```
/newbot

Alright, a new bot. How are we going to call it? Please choose a name for your bot.

Bot_NetBox
```
Sau khi có tên, chúng ta sẽ lựa chọn username cho Bot. Hãy đọc kĩ lưu ý rằng phần kết thúc của username phải có từ ***bot***
```
Good. Now let's choose a username for your bot. It must end in `bot`. Like this, for example: TetrisBot or tetris_bot.

***_bot
```
Việc tạo bot bây giờ đã thành công, bạn có thể thấy được ô chat với bot và Bot Token ở phần tin nhắn trả lời này
```
Done! Congratulations on your new bot. You will find it at `t.me/***_bot`. You can now add a description, about section and profile picture for your bot, see /help for a list of commands. By the way, when you've finished creating your cool bot, ping our Bot Support if you want a better username for it. Just make sure the bot is fully operational before you do this.

Use this token to access the HTTP API:
******************************************
Keep your token secure and store it safely, it can be used by anyone to control your bot.

For a description of the Bot API, see this page: https://core.telegram.org/bots/api
```

### Giải thích Code và 1 số hàm sử dụng
#### Một số thư viện và lớp được sử dụng:
Thư viện `logging` của Python: Cung cấp các chức năng để ghi lại thông tin log trong ứng dụng. Sử dụng để theo dõi hoạt động của bot, ghi nhận lỗi và kiểm tra các phản hồi

Thư viện `re`: Sử dụng để xử lý các biểu thức(regular expressions). Sử dụng để tìm kiếm, thay thế, và xử lý các chuỗi văn bản

Thư viện `pynetbox`: Là một thư viện Python được thiết kế để tương tác API với NetBox

Thư viện `urllib3`: là một thư viện Python cho phép bạn thực hiện các yêu cầu HTTP một cách dễ dàng hơn. Nó cung cấp các tính năng như quản lý kết nối, kiểm soát timeout, và xử lý phản hồi.

Lớp `Update` từ thư viện `telegram`, dùng để xử lý các bản cập nhật (các tin nhắn, lệnh, hoặc sự kiện khác) từ Telegram. Lớp này chứa thông tin về tin nhắn hoặc sự kiện mà bot nhận được.

Một số lớp của thư viện `telegram.ext` như:
- `ApplicationBuilder`: Được sử dụng để xây dựng một ứng dụng bot Telegram, cấu hình các handler và middleware cho bot.
- `ContextTypes`: Cung cấp các loại ngữ cảnh (context) cho các handler, chứa thông tin cần thiết để xử lý tin nhắn.
- `CommandHandler`: Một handler cho phép bot xử lý các lệnh được gửi từ người dùng. Nó cho phép bạn định nghĩa các hành động mà bot sẽ thực hiện khi nhận được một lệnh cụ thể.
- `Application`: Lớp chính để chạy ứng dụng bot, quản lý tất cả các handler và ngữ cảnh.
- `MessageHandler`: Một handler cho phép bot xử lý các tin nhắn thông thường (không phải lệnh). Nó cho phép bạn định nghĩa các hành động mà bot sẽ thực hiện khi nhận được một tin nhắn.
- `filters`: Cung cấp các bộ lọc để xác định loại tin nhắn mà bot sẽ xử lý, chẳng hạn như chỉ xử lý tin nhắn văn bản, hình ảnh, hoặc các loại tin nhắn khác.

#### Log config
```
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
```
Hàm chứa các cài đặt của log.
- Biến `format` sẽ chứa thông tin về định dạng của bản tin log:
  - Thời gian
  - Tên chương trình
  - Cấp độ log
  - Tin nhắn
- Biến `level` chứa mức độ ghi log tối thiểu là INFO

#### Thiết lập các biến với giá trị mặc định và nhập vào
```
ADMIN_IDS = ['@ducmanh2873']
URLNETBOX = "https://172.16.66.82"  
TOKENTELEGRAM = "*****"
TOKENNETBOX = "*****"
```
Trước tiên, tôi sẽ lập các biến chứa giá trị mặc định 
- `ADMIN_IDS`: biến này sẽ lưu trữ nhưng account telegram mà có thể nhận được trả lời từ Bot
- `URLNETBOX`: biến này chứa đường link tới trang web NetBox
- `TOKENTELEGRAM`: biến này chứa giá trị token của bot telegram
- `TOKKENNETBOX`: biến này chứa giá trị token của NetBox

Sau đó, tôi vẫn sẽ cho người dùng nhập vào giá trị mà họ mong muốn
```
input1 = input(f"Enter your Telegram username[@example]: ")
if input1:                                                          
    ADMIN_IDS += input1 

input2 = input(f"Enter your Telegram-bot Token: ")
if input2:
    TOKENTELEGRAM = input2

input3 = input(f"Enter your URL NetBox[http://netbox.example.com]: ")
if input3:
    URLNETBOX = input3

input4 = input(f"Enter your NetBox Token: ")
if input4:
    TOKENNETBOX = input4
```
Các giá trị nhập vào sẽ được thêm vào hoặc trực tiếp thay thế

#### Kết nối tới NETBOX
```
nb = pynetbox.api(URLNETBOX,token=TOKENNETBOX)

nb.http_session.verify = False  

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
```
Trước tiên, tôi gán biến `nb` sẽ là kết nối tới NetBox thông qua `pynetbox`.

Sau đó, tôi sẽ tắt kiểm tra SSL

Và tắt cảnh báo SSL sử dụng `urllib3`

#### Hàm để lấy dữ liệu IP từ NetBox
```
# Function to collect information of IP
def ip_information(ip_addr):
    is_valid = check_ip(ip_addr)
    if is_valid:
        try:
            ip_info = nb.ipam.ip_addresses.get(address=ip_addr)
            if ip_info:
                if ip_info.assigned_object_type == 'virtualization.vminterface':                # IF IP was assigned to an Virtual Machine
                    msg = (                                                                     # Make the message form        
                        f"The Information of IP: \n"
                        f"IP Address:      `{ip_info.address}` \n"
                        f"IP Status:       `{ip_info.status}` \n"
                        f"IP Description:  `{ip_info.description}` \n"
                        f"Assigned:        `{ip_info.assigned_object.virtual_machine.name}` \n"
                        f"Assigned to an Virtual Machine"
                    )   
                    return msg
            
                elif ip_info.assigned_object_type == 'dcim.interface':                          # If IP was assigned to an Device
                    msg = (                                                                     # Make the message form
                        f"The Information of IP: \n"
                        # f"```\n"
                        f"IP Address:          `{ip_info.address}` \n"
                        f"IP Status:           `{ip_info.status}` \n"
                        f"IP Description:      `{ip_info.description}` \n"
                        f"Assigned:            `{ip_info.assigned_object.device.name}` \n"
                        f"Assigned to an Device"
                        # f"```\n"
                    )
                    return msg
                else: 
                    return "Can't find any information of this IP"
            else:
                return "Can't find this IP in NetBox! Please check again!"   
        except Exception as e:  
            return f"Error: {str(e)}"
```
Trước tiên, tôi sẽ kiểm tra điều kiện IP nhập vào có thỏa mãn các định dạng của IP hay không, thông qua hàm check IP

Sau đó, tôi sẽ thực hiện câu lệnh để tìm kiếm địa chỉ IP mà người dùng nhập vào và gửi lên trên netbox
```
ip_info = nb.ipam.ip_addresses.get(address=ip_addr)
```
Lúc này, sẽ có các trường hợp xảy ra:
- Nếu địa chỉ IP được gán cho VM thì sẽ trả lời lại như sau:
```
msg = (                                                                     # Make the message form        
                        f"The Information of IP: \n"
                        f"IP Address:      `{ip_info.address}` \n"
                        f"IP Status:       `{ip_info.status}` \n"
                        f"IP Description:  `{ip_info.description}` \n"
                        f"Assigned:        `{ip_info.assigned_object.virtual_machine.name}` \n"
                        f"Assigned to an Virtual Machine"
                    )   
```
- Nếu địa chỉ IP được gắn cho Device thì sẽ trả lời như sau:
```
elif ip_info.assigned_object_type == 'dcim.interface':                          # If IP was assigned to an Device
                    msg = (                                                                     # Make the message form
                        f"The Information of IP: \n"
                        # f"```\n"
                        f"IP Address:          `{ip_info.address}` \n"
                        f"IP Status:           `{ip_info.status}` \n"
                        f"IP Description:      `{ip_info.description}` \n"
                        f"Assigned:            `{ip_info.assigned_object.device.name}` \n"
                        f"Assigned to an Device"
                        # f"```\n"
                    )
```
- Nếu như không có thiết bị nào được gắn cho địa chỉ IP này:
```
return "Can't find any information of this IP"
```
- Nếu như không tìm thấy địa chỉ IP(IP không tồn tại):
```
return "Can't find this IP in NetBox! Please check again!" 
```
- Nếu như không thể kết nối đến NetBox:
```
return f"Error: {str(e)}"
```

#### Hàm để nhận và trả lời tin nhắn  
```
# Defind the message when user enter /ip
async def cmd_ip(update: Update, context: ContextTypes.DEFAULT_TYPE):       # Asynchronous def mean It can run asynchronously with other tasks without waiting for it to complete before continuing.
    ip_info = context.args                                                  # Set up value
    msg = ip_information(ip_info[0])                                        # Send message
    await update.message.reply_text(str(msg),parse_mode='Markdown')         # Form Markdown to message
```
Có một sự khác biệt ở đây là việc sử dụng hàm `async`. ***Hàm asyn***- hay tên gốc của nó là ***Asynchronous def***, là một hàm **bất đồng bộ**. 

Nó cho phép thực hiện các tác vụ đồng thời mà không cần phải chờ hoàn tất từng tác vụ trước khi tiếp tục xử lý các tác vụ khác. Hàm này thường được sử dụng khi bạn làm việc với các thao tác mất thời gian, chẳng hạn như giao tiếp qua mạng, truy xuất cơ sở dữ liệu, đọc hoặc ghi vào file, v.v.  

Ở đây, bot gửi tin nhắn và sử dụng `await` để đợi tin nhắn được gửi đi, nhưng trong thời gian đợi, nó vẫn có thể xử lý các yêu cầu khác.

Nội dung trong hàm:
- `context.args`: Truy xuất các đối số được gửi kèm theo lệnh /ip. Ví dụ: nếu người dùng gửi lệnh `/ip 192.168.1.1`, thì context.args sẽ chứa danh sách các giá trị mà người dùng nhập vào sau lệnh, trong trường hợp này là `["192.168.1.1"]`

```
await update.message.reply_text(str(msg),parse_mode='Markdown')
```
- `await`: Được sử dụng để đợi kết quả từ một thao tác bất đồng bộ, trong trường hợp này là gửi tin nhắn trả lời người dùng.
- `update.message.reply_text`: Phương thức này sẽ gửi lại một tin nhắn trả lời tới người dùng trong cuộc trò chuyện hiện tại.
- `str(msg)`: Tin nhắn trả về từ hàm ip_information sẽ được chuyển thành chuỗi để có thể gửi dưới dạng văn bản.
- `parse_mode='Markdown'`: Định dạng tin nhắn dưới dạng Markdown, cho phép sử dụng các ký tự đặc biệt như `*` để in đậm,` _ `để in nghiêng, và các định dạng khác.

#### Hàm main để chạy bot
```
# Main function to run Server
if __name__ == '__main__':
    application = ApplicationBuilder().token(TOKENTELEGRAM).build()

    # Commands
    application.add_handler(CommandHandler('start', start_command,filters.User(username=ADMIN_IDS)))
    application.add_handler(CommandHandler('help', help_command,filters.User(username=ADMIN_IDS)))
    application.add_handler(CommandHandler('device', cmd_device,filters.User(username=ADMIN_IDS)))
    application.add_handler(CommandHandler('ip', cmd_ip,filters.User(username=ADMIN_IDS)))
    application.add_handler(CommandHandler('vm', cmd_vm,filters.User(username=ADMIN_IDS)))
    application.add_handler(MessageHandler(filters.TEXT, handle_message))

    application.run_polling()
```
`if __name__ == '__main__'::` Đây là điều kiện để đảm bảo rằng phần mã bên dưới chỉ được thực thi khi file script này được chạy trực tiếp, chứ không phải khi nó được import như một module trong một file khác.

`application = ApplicationBuilder().token(TOKENTELEGRAM).build():` Dòng này khởi tạo ứng dụng bot Telegram.
- `ApplicationBuilder()`: Là một lớp được cung cấp bởi thư viện ***python-telegram-bot*** để xây dựng một đối tượng bot Telegram.
- `.token(TOKENTELEGRAM)`: Xác định token của bot, được lấy từ biến TOKENTELEGRAM.
- `.build()`: Xây dựng ứng dụng với các thiết lập đã cấu hình.

`application.add_handler(CommandHandler('start', start_command,filters.User(username=ADMIN_IDS)))`: Xử lý lệnh `/start`, giới hạn quyền sử dụng

`application.run_polling()`: Bắt đầu quá trình polling (lấy thông tin tin nhắn mới từ Telegram server). Phương pháp **polling** thường được sử dụng trong các bot Telegram để liên tục kiểm tra xem có tin nhắn mới không và sau đó xử lý chúng.
