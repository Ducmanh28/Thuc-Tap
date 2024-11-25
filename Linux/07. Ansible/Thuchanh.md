# Thực hành Ansible cơ bản
Mục này ghi lại quá trình thực hiện thực hành Ansible cơ bản
## Chuẩn bị
Cần ít nhất 2 máy ảo:
- VM: `172.16.66.82` đóng vai trò làm Control Node
- VM: `172.16.66.83` đóng vai trò làm Managed Node(Targer Node)
- Thêm 1 con ubuntu 22, centos

Máy đóng vai trò làm Control Node cần cài đặt Ansible

Cả 2 thiết bị đều cần cài đặt SSH

Cấu hình 2 thiết bị chỉ cần các cấu hình cơ bản vì đây chỉ là bài test sử dụng đơn giản

## Thực hành
### Thiết lập trên Control Node
#### Cài đặt Ansible
Sử dụng câu lệnh sau:
```
sudo apt update

sudo apt install ansible -y
```
Tìm cách cài Ansible bằng pip, chỉ định phiên bản `2.14.x`(2.12)

Kiểm tra phiên bản:

```
root@MANHNetBoxLab:~# ansible --version
ansible 2.10.8
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.10.12 (main, Sep 11 2024, 15:47:36) [GCC 11.4.0]
```
#### Tạo SSH Key
Mẫu khởi tạo ví dụ như sau:
```
root@MANHNetBoxLab:~/.ssh# ssh-keygen -t rsa -b 2048
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rsa
Your public key has been saved in /root/.ssh/id_rsa.pub
The key fingerprint is:
SHA256: ***
root@MANHNetBoxLab
The key's randomart image is:
***
```
File key sẽ được lưu mặc định ở: `~/.ssh/id_rsa`

#### Copy Key sang Managed Node
Copy key tới từng Managed Node:
```
ssh-copy-id user@<managed_node_ip>
```
Ví dụ:
```
root@MANHNetBoxLab:~/.ssh# ssh-copy-id root@172.16.66.83
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
The authenticity of host '172.16.66.83 (172.16.66.83)' can't be established.
ED25519 key fingerprint is SHA256:pi6GBJIL0q8lY+w2xRyz38YtBP97DnGWD1N2+JNHT5s.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
/etc/ssh/ssh_config line 53: Unsupported option "gssapiauthentication"
root@172.16.66.83's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'root@172.16.66.83'"
and check to make sure that only the key(s) you wanted were added.
```
Kiểm tra kết nối:
```
root@MANHNetBoxLab:~/.ssh# ssh root@172.16.66.83
/etc/ssh/ssh_config line 53: Unsupported option "gssapiauthentication"
Welcome to Ubuntu 22.04.4 LTS (GNU/Linux 5.15.0-125-generic x86_64)
```
#### Tạo file `inventory`
File `inventory` sẽ là file được sử dụng để quản lý các Managed Node
```
vim inventory
```
Sau đó thêm vào nội dung sau:
```
[remote]
172.16.66.83 ansible_user=root
```
### Thiết lập trên Managed Node
Trên mỗi Managed Node thực hiện như sau:
#### Kiểm tra cài đặt Open SSH
Đảm bảo SSH Server được cài đặt để cho phép các kết nối
```
sudo apt update
sudo apt install openssh-server -y
```
Kiểm tra trạng thái SSH 
```
root@MANH-API:~# systemctl status sshd
● sshd.service - OpenSSH server daemon
     Loaded: loaded (/etc/systemd/system/sshd.service; enabled; vendor preset: enabled)
```
### Thực hành Ansible
#### Kiểm tra kết nối
Sử dụng câu lệnh sau:
```
ansible -i inventory remote -m ping
```
Mẫu đầu ra:
```
root@MANHNetBoxLab:/home/ducmanh/ansible-project# ansible -i inventory remote -m ping
172.16.66.83 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```
Note: Tìm hiểu cách dùng các module shell, apt, copy, (các lệnh Linux). Ví dụ kiểm tra version OS.
Tìm hiểu cơ chế ad-hoc(dùng các lệnh đơn lẻ trên Control để tương tác với Target Node)

#### Khởi chạy lệnh cơ bản 
Ansible ad-hoc là một cách sử dụng Ansible để thực hiện các tác vụ nhanh chóng mà không cần phải viết một playbook phức tạp. Ad-hoc commands giúp bạn chạy các lệnh một lần trên các máy chủ (hosts) mà không cần phải lưu trữ lại các tác vụ này.

Ansible ad-hoc command có cấu trúc cơ bản sau:
```
ansible <host_pattern> -m <module> -a "<module_arguments>"
```
- `<host_pattern>`: Chỉ định các máy chủ để thực thi lệnh, có thể là nhóm máy trong file inventory, hoặc một địa chỉ IP cụ thể.
- `-m <module>`: Module Ansible cần sử dụng (ví dụ: ping, file, yum, copy, ...).
- `-a "<module_arguments>"`: Các tham số cần truyền cho module được chọn

Một số ví dụ sử dụng:
- Sao chép tệp:
```
ansible 172.16.66.83 -m copy -a "src=test.txt dest=/ducmanh28/file.txt"
```
- Kiểm tra phiên bản hệ điều hành:
```
ansible 172.16.66.83 -m shell -a "cat /etc/os-release" -i inventory
```
- Tạo 1 thư mục mới:
```
ansible 172.16.66.83 -m file -a "path=/home/ducmanh287/testdir state=directory"
```

- Xem trạng thái tường lửa:
```
ansible 172.16.66.83 -m command -a "firewall-cmd --state"
```
- Tạo user mới:
```
ansible 172.16.66.83 -m user -a "name=ansibleuser state=present"
```
#### Khởi chạy với Playbook
Trong thư mục dự án, khởi tạo file `create_file.yml` và thêm vào nội dung như sau:
```
- name: Simplycreatefile
  hosts: 172.16.66.83
  become: yes
  tasks:
    - name: Check exist and create file hello.txt
      file:
        path: /home/ducmanh/hello.txt
        state: touch
    - name: Add text into file
      copy:
        content: "Welcome to Ansible!\n"
        dest: /home/ducmanh/hello.txt
```
Chạy file với câu lệnh sau ở Control Node:
```
ansible-playbook -i inventory create_file.yml
```
Kiểm tra kết quả ở Managed Node:

![](/Anh/Screenshot_982.png)
