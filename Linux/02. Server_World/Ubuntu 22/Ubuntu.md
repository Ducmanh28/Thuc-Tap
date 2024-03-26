# Tìm hiểu về hệ điều hành Ubuntu
MỤC LỤC:
- [Tìm hiểu về hệ điều hành Ubuntu](#tìm-hiểu-về-hệ-điều-hành-ubuntu)
  - [Ubuntu là gì ?](#ubuntu-là-gì-)
  - [Sự khác biệt giữa Ubuntu Server và Desktop](#sự-khác-biệt-giữa-ubuntu-server-và-desktop)
  - [Tiến hành cài đặt Ubuntu Server](#tiến-hành-cài-đặt-ubuntu-server)
  - [So sánh Package và Lib](#so-sánh-package-và-lib)
    - [Package](#package)
    - [Library:](#library)
  - [Tiến hành cài IP tĩnh](#tiến-hành-cài-ip-tĩnh)
    - [Một số lưu ý trước khi tiến hành cài IP](#một-số-lưu-ý-trước-khi-tiến-hành-cài-ip)
    - [Sử dụng cách sửa file](#sử-dụng-cách-sửa-file)
    - [Sử dụng NetworkManager](#sử-dụng-networkmanager)
  - [Link tham khảo:](#link-tham-khảo)

## Ubuntu là gì ?
- Là một hệ điều hành mã nguồn mở
- Được phát triển dựa trên Linux/Debian GNU
- Là phiên bản tùy biến Linux phổ biến nhất

## Sự khác biệt giữa Ubuntu Server và Desktop
- Ubuntu Server không có GUI
- Các máy chủ thường được quản lý từ xa bằng SSH
- Các gói Ubuntu Server tập trung vào việc cho phép kết nối với máy khách cũng như bảo mật
- Trong khi các ứng dụng Ubuntu Desktop tập trung vào việc sử dụng trên máy chủ

## Tiến hành cài đặt Ubuntu Server
- Tiến hành chọn phiên bản Ubuntu Server tại trang chủ của [Ubuntu](https://ubuntu.com/download/server)
- Sẽ có 3 tùy chọn: 
- ![](/Anh/Screenshot_84.png)
  - Option 1: Cài đặt máy chủ thủ công - Phương pháp truyền thống, cho phép kiểm soát toàn bộ quá trình cài đặt
  - Option 2: VMs Ubuntu tức thì - Tùy chọn này cho phép triển khai các máy ảo một cách nhanh chóng
  - Option 3: Cung cấp máy chủ tự động - Cho phép cài đặt và cấu hình Ubuntu Server trên một số lượng lớn máy chủ
- Ở đây, tôi sẽ lựa chọn cài đặt theo Option 1 
- Tiến hành download file hệ thống.
- Tiến hành cài đặt trên **VMWareWorkstation 16 Pro**
- Vào VMWare, tại màn hình chính của ứng dụng, tiến hành bấm tổ hợp phím `Ctrl + N` để thiết lập một máy chủ mới.
- ![](/Anh/Screenshot_85.png)
  - Có 2 option trong mục này:
    - Typical: Cài đặt theo các bước đơn giản, ngắn gọn
    - Custom: Tạo máy chủ với các yêu cầu nâng cao hơn
    - Tôi sẽ cài đặt theo các bước đơn giản 
- ![](/Anh/Screenshot_86.png)
  - Tiến hành chọn file hệ hiều hành để cài cho máy ảo
  - Chọn **Browse** để tìm nơi lưu file Ubuntu Server mà bạn vừa tải
  - ![](/Anh/Screenshot_87.png)
  - Sau khi chọn xong đường dẫn, chọn **Open** để mở file hệ điều hành
  - Sau đó, chọn **Next** để tiếp tục quá trình cài đặt
- ![](/Anh/Screenshot_88.png)
  - Tiến hành đặt tên cho máy ảo
  - Sau đó, chọn đường dẫn lưu máy ảo. Lưu ý, nên xếp vào các Folder cho gọn gàng
  - Sau đó, bấm **Next** để tiếp tục tiến trình
- ![](/Anh/Screenshot_89.png)
  - Tiến hành thiết lập dung lượng ổ đĩa cứng cho máy ảo. Nên để mặc định theo hướng dẫn
  - Có 2 Option về phân chia ổ cứng
    - Lưu tất cả trên 1 File
    - Chia ra làm các ổ nhỏ. Nên chọn cái này để dễ quản lý
    - Sau đó bấm **Next** để tiếp tục
- ![](/Anh/Screenshot_90.png)
  - Tiến hành kiểm tra lại về những lựa chọn mà bạn đã chọn cho máy ảo như:
    - Tên
    - Vị trí lưu
    - Hệ điều hành
    - Ổ cứng
    - RAM
    - Chế độ mạng
  - Nếu bạn chưa ưng ý ở chỗ nào, muốn chỉnh sửa thêm, hãy chọn **Customize Hardware** 
    - ![](/Anh/Screenshot_91.png)
    - Gồm 2 bảng chính
      - Bảng thứ nhất sẽ chọn các danh mục mà bạn muốn sửa như:
        - RAM
        - Số nhân CPU
        - Ổ đĩa
        - Cơ chế mạng,...
      - Bảng còn lại sẽ hiện thông tin của danh mục bạn đã chọn ở bên trái
    - Sau khi ưng ý, chọn Close để đóng bảng
  - Bấm **Finish** để hoàn thành tiến trình tạo máy ảo
- ![](/Anh/Screenshot_92.png)
  - Có 3 danh mục cài đặt để bạn chọn
    - Tiến hành cài đặt hệ điều hành
    - Cài đặt với HWE Kernel
    - Thử RAM
- ![](/Anh/Screenshot_93.png)
  - Chọn ngôn ngữ mà bạn muốn
  - Tôi sẽ dùng *English*
- ![](/Anh/Screenshot_94.png)
  - Lựa chọn xem bạn có muốn cài phiên bản mới nhất hay không
  - Tôi chọn Tiếp tục nhưng không cập nhật
- ![](/Anh/Screenshot_95.png)
  - Chọn ngôn ngữ bàn phím
  - Tôi sẽ dùng *English*
- ![](/Anh/Screenshot_96.png)
  - Chọn kiểu cài đặt mà bạn muốn
    - Cài Ubuntu Server
    - Cài Ubuntu Server nhưng là một phiên bản nhỏ
    - Cài theo một ứng dụng bên thứ 3
  - Tôi chọn cài Ubuntu Server theo phiên bản cơ bản
- ![](/Anh/Screenshot_97.png)
  - Tiến hành chọn thiết lập mạng
  - Ban đầu, hãy để theo mặc định thiết lập với DHCP được bật
- ![](/Anh/Screenshot_98.png)
  - Ubuntu Server sẽ tiến hành test thử mạng bằng cách gửi các gói tin đi
  - Nếu có sự phản hồi như trong ảnh nghĩa là thành công và lúc này, bạn có thể bấm **Done** để tiếp tục
- ![](/Anh/Screenshot_99.png)
    - Một vài vấn đề liên quan đến phân vùng ổ cứng
    - Bạn hãy để mặc định theo Ubuntu là lựa chọn tối ưu nhất
    - Hoặc bạn cũng có thể tự thiết lập theo ý thích cá nhân
- ![](/Anh/Screenshot_100.png)
  - Tiến hành kiểm tra lại mọi thứ
  - Nếu bạn thấy đã ổn, hãy bấm **Done** để tiếp tục
- ![](/Anh/Screenshot_101.png)
  - Tiến hành thiết lập thông tin cá nhân, thông tin đăng nhập
- Đối với các mục còn lại, bạn chỉ cần bấm **Done** liên tục 
- ![](/Anh/Screenshot_102.png)
  - Màn hình bắt đầu quá trình cài đặt và thiết lập
  - Sau khi mọi thứ đã hoàn thành màn hình sẽ hiện thị
  - ![](/Anh/Screenshot_103.png)
  - Chọn **Reboot now** để khởi động lại
  - ![](/Anh/Screenshot_102.png)
- ![](/Anh/Screenshot_104.png)
  - Lúc này, tiến hành đăng nhập
  - Lưu ý: Mật khẩu sẽ không được hiển thị

- Đến đây, quá trình cài đặt Ubuntu Server đã hoàn tất.
## So sánh Package và Lib
- Trong Linux, package và library (thư viện) đều là những thành phần quan trọng, nhưng chúng có những khác biệt cơ bản:
### Package
- Package là một tập hợp các file đã được biên dịch sẵn, thường bao gồm mã nhị phân của ứng dụng và các file liên quan khác
- Package giúp việc cài đặt và quản lý phần mềm trở nên dễ dàng hơn
- Các package trong Linux có thể có định dạng khác nhau tùy thuộc vào hệ thống phân phối Linux. 
  - Ví dụ, Red Hat và CentOS sử dụng định dạng .rpm, trong khi Debian và Ubuntu sử dụng định dạng `.deb1`
### Library:
- Library là một tập hợp các hàm và thủ tục đã được biên dịch, giúp lập trình viên không cần phải viết lại những chức năng phổ biến2.
- Có hai loại thư viện chính: 
  - thư viện tĩnh (static libraries): Thư viện tĩnh được liên kết vào chương trình tại thời điểm biên dịch
  - thư viện động (dynamic libraries): Thư viện động được liên kết vào chương trình khi chương trình đang chạy. Thư viện động giúp tiết kiệm bộ nhớ và không gian trên máy tính, và cho phép tái sử dụng mã
- Vì vậy, mặc dù cả package và library đều chứa mã đã được biên dịch, nhưng chúng được sử dụng trong các bối cảnh khác nhau và phục vụ các mục đích khác nhau
## Tiến hành cài IP tĩnh
### Một số lưu ý trước khi tiến hành cài IP
- Nhập `sudo su` để tiến hành chỉnh sửa file với quyền ROOT
- VI và NANO: Là 2 trình soạn thảo văn bản dòng lệnh phổ biến trong Linux
  - NANO: Là trình soạn thảo đơn giản, dễ dùng. Là một trình soạn thảo không chế độ - tức là không cần vào chế độ để chỉnh sửa
  - VI: Là trình soạn thảo mạnh mẽ hợn, phức tạp hơn. Là một trình soạn thảo dựa trên chế độ. Ở đây, muốn vào chế độ chỉnh sửa file, ta sử dụng phím I. Muốn thoát ấn `ESC` và muốn lưu + thoát bấm `:x` 
### Sử dụng cách sửa file
  - Tiến hành nhập lệnh `ip addr show` hoặc `ip a` để xem địa chỉ IP hiện tại 
  - ![](/Anh/Screenshot_106.png)
  - Với DHCP đang được bật, IP hiện tại của tôi đang là `192.168.142.138/24`, thuộc dải mạng `192.168.142.0/24`
  - Nhưng tôi đang sử dụng chế độ mạng NAT nên mạng này sẽ không cùng với dải mạng máy chính
  - ![](/Anh/Screenshot_110.png)
  - IP máy chính hiện tại đang là `192.168.68.74/24`
  - Ta sẽ thực hiện cài IP tĩnh theo dải mạng của dải NAT
  - Để đặt được IP tĩnh, ta tiến hành chỉnh sửa file mạng trong Ubuntu Server. Cụ thể file cần chỉnh sửa ở đây là file `00-installer-config.yaml`
  - Ta tiến hành chỉnh sửa với quyền Root bằng cách nhập lệnh `sudo su`
  - ![](/Anh/Screenshot_112.png)
  - Ta tiến hành vào `vi` để chỉnh sửa file.
  - Đưa đường dẫn đi tới file. File sẽ nằm trong `netplan`
  - Câu lệnh hoàn chỉnh sẽ là `sudo vi /etc/netplan/00-installer-config.yaml`
  - Sau khi tiến hành nhập lệnh, Ubuntu Server sẽ tiến hành hỏi bạn mật khẩu
  - ![](/Anh/Screenshot_111.png)
  - Và rồi sau khi vào file ở trình soạn thảo VI, ta sẽ tiến hành bấm phím `I` để tiến vào chế độ chỉnh sửa và thực hiện chỉnh sửa file như sau:
  - ``` 
      #This is the network config written by 'subiquity'
      network:
        ethernets:
          ens33:
                dhcp4: no
                addresses: [192.168.142.113/24]
                nameservers:
                      addresses: [8.8.8.8, 8.8.4.4]
                routes:
                - to: default
                  via: 192.168.142.2
        version: 2
    ```
- 
- Sau khi tiến hành nhập xong, ta bấm `ESC` để thoát chế độ **Insert** và tiến hành bấm `:x` để thoát và lưu file
- Dòng lệnh như sau hiện ra nghĩa là đã lưu thành công
- ![](/Anh/Screenshot_113.png)
- Nhập `netplan apply` để tiến hành lưu những chỉnh sửa vừa rồi
- Nhập `ip a` để xem IP:
- ![](/Anh/Screenshot_115.png)
- IP lúc này đã được chuyển thành `192.168.142.113/24`
- Tiến hành ping thử ra Internet:
- ![](/Anh/Screenshot_116.png)
- Ta thấy, quá trình Ping ra `google.com` đã thành công. Vậy ta đã đặt xong IP tĩnh cho Ubuntu Server bằng cách chỉnh file netplan

### Sử dụng NetworkManager
- Nhập lệnh `nmcli device status` để xem các kết nối trong **NetworkManager**
- Nếu hiện lỗi không có kết nối nào như sau:
- ![](/Anh/Screenshot_117.png)
- Thì do Ubuntu Server ưu tiên **netplan** hơn **NetworkManager** nên ta phải cấp quyền ưu tiên cho **NetworkManager** bằng cách chỉnh sửa trong File **netplan/00-installer-config.yaml** như sau:
- ```
  network:
    version: 2
    renderer: NetworkManager
  ```
- Sau khi chỉnh sửa xong, nhập lệnh `netplan apply` để cập nhật nội dung file vừa chỉnh sửa. Sau đó `reboot` để khởi động lại
- Nhập `ip a` để xem IP hiện tại:
- ![](/Anh/Screenshot_118.png)
- IP hiện tại đang là `192.168.142.112/24`
- Ta sẽ tiến hành đổi IP thành `192.168.142.125/24`
  - Lưu ý đổi tên Connection:
    - `nmcli con mod [tên cũ] connection.id [tên mới]`
- Ta sẽ đổi tên từ "Wire Connection 1" thành "ens33"
  - Nhập lệnh: `nmcli con mod "Wire Connection 1" connection.id ens33`
- Bây giờ ta tiến hành set IP tĩnh:
  - Thực chất nó là viết tắt của nmcli connection modify
  - SetIP: `nmcli con mod ens33 ipv4.addr 192.168.142.125/24`
  - SetGateWay: `nmcli con mod ens33 ipv4.gateway 192.168.142.2`
  - SetDNS: `nmcli con mod ens33 ipv4.dns 8.8.8.8`
  - Chuyển IP sang chế độ thủ công: `nmcli con mod ens33 ipv4.method manual`
  - Bật chế độ kết nối tự động: `nmcli con mod ens33 connection.autoconnect yes`
- Để có thể lưu cấu hình này, ta tiến hành reset lại mạng hoặc reboot:
  - `systemctl restart NetworkManager`
  - `reboot`
- Tiến hành nhập `ip addr show` để xem IP:
  - ![](/Anh/Screenshot_119.png)
  - Ta có thể thấy IP lúc này đã được đổi thành `192.168.142.125/24`
  - Tiến hành Ping thử ra Internet:
  - ![](/Anh/Screenshot_120.png)
  - Qúa trình ping thành công nghĩa là việc set IP tĩnh đã hoàn thành.

## Link tham khảo:
- [Anh Quang](https://github.com/thanhquang99/thuctap2023/blob/main/thuctap/linux/iptinh.md)
- [Ubuntu Network Manager](https://www.configserverfirewall.com/ubuntu-linux/ubuntu-network-manager/)
- [Ubuntu Server](https://linuxize.com/post/how-to-configure-static-ip-address-on-ubuntu-20-04/)