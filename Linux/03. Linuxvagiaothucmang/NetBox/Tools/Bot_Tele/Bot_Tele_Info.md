# Mục này nghiên cứu cách tạo ra Bot_Tele_Info

## Tổng quan
Tool được sử dụng để hiển thị ra thông tin chi tiết của 1 device khi mà người dùng nhập vào 1 thông tin gì đó của Device như IP, Name,...

Tool sẽ thông qua Bot Telegram để hoạt động. Các thao tác sẽ được thực hiện thông qua Telegram. Ví dụ khi người dùng nhập IP vào ô chat, thông tin về Device gắn với IP đó sẽ hiện ra.

Sử dụng ngôn ngữ Python thay vì BashScripts. Có thể chạy trên đa nền tảng để có thể đảm bảo Tool luôn chạy trên cả Windows hay Mac hoặc Linux.

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

### Making tool
#### Tổng quan về cách mà tool hoạt động.
Để có thể nắm bắt được cách phát triên, cách mà tool thực sự hoạt động thì trước tiên chúng ta phải nắm rõ quy trình hoạt động của API. Để hiểu biết rõ hơn về API, các bạn có thể tham khảo tại [đây]()