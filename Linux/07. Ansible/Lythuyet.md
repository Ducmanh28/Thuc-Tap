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
