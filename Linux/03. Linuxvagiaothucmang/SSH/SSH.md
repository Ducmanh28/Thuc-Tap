# Mục này sẽ thực hiện cấu hình SSH
Trước khi làm việc với SSH, thực hiện tạo các User để thực hành. Ví dụ tạo như sau:
- User A: Được phép SSH
- User B: Không được phép SSH

## Tiến hành tạo User
Sử dụng câu lệnh `adduser`

- Tạo User 1
```
root@MANH-U22-Server:~# sudo adduser user1
Adding user `user1' ...
Adding new group `user1' (1001) ...
Adding new user `user1' (1001) with group `user1' ...
Creating home directory `/home/user1' ...
Copying files from `/etc/skel' ...
New password: 123456
Retype new password: 123456
passwd: password updated successfully
Changing the user information for user1
Enter the new value, or press ENTER for the default
        Full Name []: User A
        Room Number []: 1
        Work Phone []: 12345
        Home Phone []: 12345
        Other []: no
Is the information correct? [Y/n] Y
```
- Tạo User 2
```
root@MANH-U22-Server:~# sudo adduser user2
Adding user `user2' ...
Adding new group `user2' (1002) ...
Adding new user `user2' (1002) with group `user2' ...
Creating home directory `/home/user2' ...
Copying files from `/etc/skel' ...
New password: 123456
Retype new password: 123456
passwd: password updated successfully
Changing the user information for user2
Enter the new value, or press ENTER for the default
        Full Name []: User B
        Room Number []: 1
        Work Phone []: 123456
        Home Phone []: 123456
        Other []: no
Is the information correct? [Y/n] Y
```
## Cấp quyền sudo cho User
Có một số cách mà chúng ta có thể sử dụng để cấp quyền ***sudo*** cho một User.
- Sử dụng `adduser` với nhóm **sudo**ư
```
sudo adduser userA sudo
```
- Chỉnh sửa tệp 
  - Chỉnh sửa trực tiếp nội dung trong tệp `/etc/sudoers`
  - Chỉnh sửa gián bằng cách tạo 1 tệp mới trong `/etc/sudoers.d/...`
  - Thêm vào nội dung: `user1 ALL=(ALL:ALL) ALL`
- Thêm user vào nhóm ***sudo***
```
sudo usermod -aG sudo user2 
```
Lưu ý rằng: 
- Bạn nên sử dụng **visudo** để đảm bảo tính an toàn
- Xác minh sau khi thực hiện
```
su - user1

sudo whoami
```
## Phân quyền SSH cho User
Mô hình thực hiện:

![](/Anh/Screenshot_711.png)

Giải thích mô hình:
- Gồm 2 thiết bị:
  - Ubuntu Client
  - Ubuntu Server
- 2 User:
  - User A
  - User B
- Hành động:
  - User A được phép sử dụng để SSH
  - User B không được phép sử dụng để SSH

Thực hiện: Để có thể phân quyền SSH cho các User, chúng ta thực hiện cấu hình ở trong mục `/etc/ssh/sshd_config` hoặc thêm file cấu hình mới trong `/etc/ssh/sshd_config.d/...`
```
# Thực hiện tạo file
sudo vim /etc/ssh/sshd_config.d/permissions_ssh.conf

# Thực hiện phân quyền
AllowUsers user1
DenyUsers user2

# Lưu và thoát, sau đó kiểm tra
sudo sshd -t

# Khởi động lại dịch vụ
sudo systemctl restart ssh
```
Kiểm tra trạng thái đối với User A
```
root@MANH-U22-client:~# ssh user1@172.16.66.81
The authenticity of host '172.16.66.81 (172.16.66.81)' can't be established.
ED25519 key fingerprint is SHA256:pi6GBJIL0q8lY+w2xRyz38YtBP97DnGWD1N2+JNHT5s.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '172.16.66.81' (ED25519) to the list of known hosts.
user1@172.16.66.81's password: 123456

user1@MANH-U22-Server:~$
```
Kiểm tra đối với User B
```
root@MANH-U22-client:~# ssh user2@172.16.66.81
user2@172.16.66.81's password:
Permission denied, please try again.
```
## BashScripts cấp quyền login SSH
BS này sẽ sử dụng lệnh `sed` để chỉnh sửa nội dung file `sshd_config`. 
### Lệnh sed
Lệnh sed (viết tắt của "stream editor") là một công cụ mạnh mẽ trên hệ điều hành Linux và các hệ thống tương tự Unix, được sử dụng để xử lý và biên tập văn bản trong luồng (stream) hoặc tệp tin. 

Cú pháp cơ bản của lệnh `sed`
```
sed [tùy chọn] 'lệnh' tệp
```
Một số tùy chọn cơ bản của lệnh:
- `-n, --quiet, --silent`: Chỉ hiển thị đầu ra được xử lý (tức là chỉ hiển thị những dòng đã được thay đổi).
- `-e script, --expression=script`: Thêm các lệnh xử lý vào tập lệnh từ dòng dòng lệnh.
- `-f script-file, --file=script-file`: Đọc lệnh xử lý từ tệp script-file.
- `-r, --regexp-extended`: Sử dụng biểu thức chính quy mở rộng (ERE) thay vì biểu thức chính quy cơ bản (BRE).
- `-i[SUFFIX], --in-place[=SUFFIX]`: Thay đổi nội dung của tệp đầu vào. Tùy chọn có thể được cung cấp để tạo một bản sao lưu của tệp gốc với tiền tố là SUFFIX.
- `-l N, --line-length=N`: Xác định độ dài tối đa của mỗi dòng đầu ra.
- `-u, --unbuffered`: Ghi đầu ra mà không làm trễ hoặc lưu trữ nội dung nếu có thay đổi nhiều dòng.
- `--follow-symlinks`: Theo dõi các liên kết tượng trưng và mở chúng.
- `-z, --null-data`: Xử lý dữ liệu đầu vào như là một loạt byte NULL, chứ không phải là một dòng mới.
- `--version`: Hiển thị thông tin về phiên bản sed và thoát.
- `--help`: Hiển thị trợ giúp về cách sử dụng sed và thoát.

Một số ví dụ:
```
# Sử dụng tùy chọn -n để chỉ hiển thị các dòng đã được xử lý:
sed -n 's/apple/orange/p' fruits.txt

# Sử dụng tùy chọn -i để chỉnh sửa trực tiếp nội dung của tệp:
sed -i 's/old/new/g' file.txt

# Sử dụng tùy chọn -e để thêm nhiều biểu thức thay thế:
sed -e 's/apple/orange/g' -e 's/banana/grape/g' fruits.txt

# Sử dụng tùy chọn -r để sử dụng biểu thức chính quy mở rộng(cho phép sử dụng các ký tự đặc biệt một cách tiện lợi hơn):
sed -r 's/(apple|banana)/orange/g' fruits.txt

#Sử dụng tùy chọn -f để đọc lệnh từ một tập tin:
sed -f script.sed fruits.txt
```
## BashScripts
Mô hình hoạt động của Scripts

![](/Anh/Screenshot_712.png)

Hướng dẫn sử dụng các bạn tham khảo tại [đây](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/SSH/README.md)

Nội dung của BashScripts được hiển thị tại [đây](https://github.com/Ducmanh28/Thuc-Tap/blob/main/Linux/03.%20Linuxvagiaothucmang/SSH/Acess_SSH.sh)
