# Mục này tìm hiểu các kiến thức lý thuyết cơ bản về Ansible

## 1. Ansible là gì?
Ansible là một công cụ tự động hóa mạnh mẽ dành cho quản lý cấu hình, triển khai ứng dụng và quản lý hệ thống từ xa.

Ansible là một công cụ quản lý cấu hình và triển khai phần mềm miễn phí và mã nguồn mở, được sử dụng để tự động hóa các tác vụ CNTT. 

Nó được phát triển bởi Red Hat và cộng đồng mã nguồn mở, với mục đích chính là đơn giản hóa việc quản lý và triển khai các ứng dụng, hệ thống và cấu hình trên nhiều máy chủ một cách dễ dàng, hiệu quả và an toàn.

## 2. Lịch sử hình thành và phát triển
Ansible được phát triển lần đầu bởi Michael DeHaan và ra mắt công khai vào năm 2012 như một giải pháp tự động hóa không cần agent (agentless)

**2012**: 
- Michael DeHaan, một kỹ sư phần mềm từng làm việc tại Red Hat, đã phát triển Ansible với mục tiêu tạo ra một công cụ tự động hóa đơn giản, dễ triển khai và không cần cài đặt phần mềm trên các máy đích.
- Ansible ra đời nhằm khắc phục những hạn chế của các công cụ tự động hóa khác thời điểm đó, như Puppet và Chef, vốn đòi hỏi cài đặt agent và có quy trình phức tạp.
- Công cụ này được viết bằng Python và sử dụng giao thức SSH để kết nối, giúp loại bỏ sự phụ thuộc vào phần mềm agent.

**Hiện nay**:
- Sau khi trải qua quá trình dài, từng được phát triển thành 1 công ty riêng nhưng đã được Red Hat mua lại. Hiện nay, Ansible vẫn đang thuộc về Red Hat
- Đến nay, Ansible tiếp tục được cải tiến và cập nhật để đáp ứng nhu cầu phức tạp trong tự động hóa đám mây, container, mạng và bảo mật.
- Ansible vẫn giữ vững vị thế là công cụ tự động hóa hàng đầu, với một cộng đồng mã nguồn mở lớn và sự hỗ trợ mạnh mẽ từ Red Hat và IBM.

## 3. Lý do nên dùng Ansible
**Dễ sử dụng**: Ansible có cú pháp YAML đơn giản và dễ học, không cần kiến thức lập trình sâu. Các cấu hình cũng dễ đọc và duy trì.

**Không cần agent**: Ansible kết nối qua SSH mà không cần cài phần mềm agent trên các máy đích, giúp giảm tải quản lý và tăng tính bảo mật.

**Idempotency**: Các tác vụ của Ansible đảm bảo khi thực thi nhiều lần vẫn giữ hệ thống ổn định, chỉ thay đổi nếu cần thiết, giúp tránh lỗi lặp.

**Cộng đồng mạnh và tài liệu phong phú**: Ansible có cộng đồng mã nguồn mở lớn, tài liệu phong phú, nhiều module sẵn có và dễ mở rộng, phù hợp với hầu hết các hệ thống.

**Hỗ trợ đa nền tảng**: Ansible dễ dàng tích hợp với các công nghệ đám mây, container, và thiết bị mạng, giúp tự động hóa linh hoạt từ ứng dụng đến hạ tầng mạng.

==> Với những ưu điểm này, Ansible là lựa chọn hàng đầu cho các nhu cầu tự động hóa nhanh chóng, an toàn, và dễ triển khai.

## 4. Ansible bao gồm những gì?
Ansible có cấu trúc đơn giản nhưng hiệu quả, bao gồm các thành phần chính như sau:
### Control Node
Là thành phần đóng vai trò như Server

Đây là máy chủ trung tâm nơi Ansible được cài đặt và từ đó các lệnh tự động hóa được gửi đi.

Người dùng sẽ viết Playbook và thực thi lệnh từ Control Node đến các máy đích thông qua SSH.
### Managed Node
Là thành phần đóng vai trò như Client

Là các máy đích mà Ansible quản lý và thực thi tác vụ.

Không cần cài đặt Ansible trên các Managed Nodes, chỉ cần có SSH và quyền truy cập từ Control Node.

### Inventory
Inventory là tệp danh sách các Managed Nodes, giúp Ansible biết sẽ kết nối và quản lý những máy nào.

Inventory có thể được định nghĩa dưới dạng file văn bản (thường là hosts hoặc inventory), với định dạng phổ biến là INI hoặc YAML, ví dụ:
```
[webservers]
server1 ansible_host=192.168.1.10 ansible_user=root
server2 ansible_host=192.168.1.11 ansible_user=root
```
### Playbook
Là trái tim của Ansible, nơi định nghĩa các tác vụ cần thực hiện, được viết bằng YAML.

Một Playbook có thể chứa nhiều "play" (chạy trên các nhóm máy khác nhau) và mỗi "play" chứa nhiều "task" mô tả từng tác vụ cụ thể.
Ví dụ đơn giản về Playbook:
```
- name: Cài đặt Apache và khởi động dịch vụ
  hosts: webservers
  become: yes
  tasks:
    - name: Cài đặt Apache
      apt:
        name: apache2
        state: present
    - name: Khởi động dịch vụ Apache
      service:
        name: apache2
        state: started
```
### Modules
Modules là các đoạn mã thực thi tác vụ cụ thể trên các máy đích, như quản lý gói, tạo thư mục, hoặc thiết lập cấu hình.

Ansible có hàng trăm module tích hợp sẵn (ví dụ: apt, yum, service, file, copy), đồng thời người dùng cũng có thể viết module tùy chỉnh.

### Plugins
Plugins mở rộng tính năng của Ansible, hỗ trợ nhiều nhiệm vụ khác nhau như xử lý kết nối, tìm kiếm dữ liệu, hoặc in ra kết quả tùy biến.

Các loại plugin thông dụng:
- **Connection Plugins**: Xử lý cách Ansible kết nối tới máy đích (ví dụ: SSH, local).
- **Lookup Plugins**: Tìm kiếm dữ liệu bên ngoài như file, database, hoặc các dịch vụ đám mây.
- **Callback Plugins**: Tùy chỉnh cách Ansible hiển thị thông tin phản hồi sau khi thực thi tác vụ.

### Roles
Roles giúp tổ chức Playbook và các thành phần liên quan (task, variables, handler, template, file) theo một cấu trúc thư mục chuẩn.

Khi sử dụng roles, Ansible có thể dễ dàng tái sử dụng cấu hình, phù hợp cho các dự án phức tạp.

### Variables
Variables là các biến lưu trữ giá trị động, cho phép người dùng tái sử dụng và tùy chỉnh các Playbook mà không cần thay đổi mã nguồn.

Biến có thể được định nghĩa trong Playbook, Inventory, hoặc các file biến riêng biệt, và được gọi dễ dàng trong Playbook.

### Handlers
Handlers là các task đặc biệt chỉ được thực thi khi có thay đổi trạng thái trong các task khác (ví dụ: chỉ restart dịch vụ khi có thay đổi cấu hình).

Các handler thường được dùng để tối ưu hóa tác vụ, giúp đảm bảo dịch vụ chỉ được khởi động lại khi cần.

### Templates
Ansible sử dụng Jinja2 làm công cụ template, cho phép tạo ra file cấu hình động với nội dung thay đổi theo biến trong Playbook.
Ví dụ template file nginx.conf.j2:
```
server {
  listen {{ nginx_port }};
  server_name {{ server_name }};
}
```

### Ansible Galaxy
Ansible Galaxy là thư viện cộng đồng, nơi người dùng có thể tải và chia sẻ roles với cộng đồng.

Thông qua Galaxy, người dùng có thể nhanh chóng tích hợp các roles đã có sẵn vào dự án của mình.

## 5. Cách mà Ansible hoạt động
### Xác định các máy đích trong Inventory
Ansible sử dụng file Inventory để xác định các máy đích (Managed Nodes) cần quản lý.

Inventory chứa thông tin địa chỉ IP hoặc hostname của các máy, kèm theo các thông tin như user, mật khẩu, và có thể phân chia các máy thành nhóm (ví dụ: webservers, databases).
### Kết nối đến Managed Nodes qua SSH
Ansible sử dụng SSH để kết nối từ Control Node (máy chạy Ansible) đến Managed Nodes.

Do không cần agent trên các máy đích, Ansible chỉ yêu cầu SSH và Python trên máy đích để có thể thực hiện các tác vụ.

Các thông tin kết nối như user, cổng SSH, mật khẩu hoặc key SSH có thể được định nghĩa trong file Inventory hoặc khai báo trực tiếp khi chạy lệnh.
### Sử dụng Playbook để định nghĩa các tác vụ
Ansible thực thi các tác vụ thông qua Playbook, một tệp YAML chứa các “plays” và “tasks” mô tả công việc cần thực hiện trên các nhóm máy.

Mỗi play trong Playbook xác định một nhóm máy và các tác vụ cần thực hiện, mỗi task đại diện cho một hành động cụ thể.
### Thực thi các task với các Module
Các task trong Playbook thường sử dụng Module để thực thi các hành động, như cài đặt phần mềm, tạo file, hoặc quản lý dịch vụ.

Module được gửi đến máy đích qua SSH và thực thi trực tiếp trên máy đích. Kết quả trả về được Ansible thu thập và hiển thị cho người dùng.
### Kiểm tra idempotency để tránh thực thi lặp
Ansible tuân theo nguyên tắc "idempotent" (bất biến), nghĩa là mỗi task chỉ thay đổi trạng thái hệ thống khi cần thiết.

Ví dụ, nếu một gói phần mềm đã được cài đặt, Ansible sẽ không cài lại, điều này giúp tránh lỗi lặp và duy trì hệ thống ổn định.
### Sử dụng Handlers để tối ưu hóa task
Nếu cần thực hiện một hành động khi có thay đổi (như restart dịch vụ sau khi thay đổi cấu hình), Ansible sử dụng Handler.

Handlers chỉ được kích hoạt nếu có sự thay đổi ở một task nào đó, giúp tối ưu hóa quá trình thực thi và đảm bảo các dịch vụ chỉ được khởi động lại khi cần thiết.
### Quản lý cấu hình động với Templates và Variables
Ansible hỗ trợ Jinja2 templates để tạo ra file cấu hình động, với nội dung được điều chỉnh theo biến và điều kiện.

Templates và Variables giúp các Playbook linh hoạt, dễ dàng áp dụng trên nhiều hệ thống khác nhau mà không cần thay đổi mã nguồn.
### Thu thập và hiển thị kết quả
Ansible thu thập kết quả sau mỗi task và hiển thị lại cho người dùng, bao gồm trạng thái thành công, thất bại hoặc đã được bỏ qua.

Thông tin này giúp người dùng nắm rõ tình trạng của từng task trên mỗi máy đích, giúp phát hiện lỗi và xử lý nhanh chóng.

## 6. Một số ứng dụng của Ansible
**Quản lý cấu hình**: Ansible có thể tự động hóa việc cấu hình hệ thống, bao gồm các cài đặt hệ điều hành, ứng dụng và dịch vụ. Nó giúp đảm bảo rằng các hệ thống được cấu hình theo các tiêu chuẩn và yêu cầu bảo mật thống nhất.

**Triển khai phần mềm**: Ansible có thể tự động hóa quá trình triển khai phần mềm trên nhiều máy khách. Nó giúp đơn giản hóa việc cài đặt, cập nhật và gỡ bỏ phần mềm, đồng thời đảm bảo rằng tất cả các máy khách đều có phiên bản phần mềm mới nhất.

**Quản lý cơ sở hạ tầng đám mây**: Ansible có thể tự động hóa các tác vụ quản lý cơ sở hạ tầng đám mây, chẳng hạn như tạo và quản lý máy ảo, lưu trữ dữ liệu và mạng. Điều này giúp các tổ chức quản lý cơ sở hạ tầng đám mây của mình một cách hiệu quả và tiết kiệm chi phí.
