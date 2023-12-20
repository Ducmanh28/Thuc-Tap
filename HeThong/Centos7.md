# Tìm hiểu về OS Linux
MỤC LỤC:
- [Tìm hiểu về OS Linux](#tìm-hiểu-về-os-linux)
  - [1. Centos là gì ?](#1-centos-là-gì-)
  - [2. Tiến hành cài đặt hệ điều hành CentOS 7](#2-tiến-hành-cài-đặt-hệ-điều-hành-centos-7)
  - [3. Tiến hành Set Static IP cho CentOS 7](#3-tiến-hành-set-static-ip-cho-centos-7)
    - [3.1 Cài bằng cách chỉnh sửa File:](#31-cài-bằng-cách-chỉnh-sửa-file)

## 1. Centos là gì ?
- Là một hệ điều hành mã nguồn mở và miễn phí ở cấp danh nghiệp
- Là một trong những bản phân phối Linux được phát hành dựa trên RHEL(Red Hat Enterprise Linux)
- Cấu trúc:
- ![](/Anh/Screenshot_121.png)
## 2. Tiến hành cài đặt hệ điều hành CentOS 7
- Truy cập vào [CentOS](http://isoredirect.centos.org/centos/7/isos/x86_64/) để chọn phiên bản cài đặt cho máy tính cá nhân của bạn
- Bạn có 3 đường dẫn để chọn nơi tải:
  - [Nhan Hoa](http://mirrors.nhanhoa.com/centos/7.9.2009/isos/x86_64/
)
  - [ViettelCloud](http://mirror.viettelcloud.vn/centos/7.9.2009/isos/x86_64/)
  - [BìzlyCloud](http://mirror.bizflycloud.vn/centos/7.9.2009/isos/x86_64/)

- 3 đường dẫn trên đều là phiên bản CentOS 7 - 2009. Tôi sẽ chọn Link NhanHoa
-  Sẽ có các phiên bản cho bạn lựa chọn như sau:
   -  CentOS-7-x86_64-DVD-2009.iso:
   Phiên bản DVD này chứa tất cả các gói có thể được cài đặt bằng trình cài đặt. Đây là phiên bản được đề xuất cho hầu hết người dùng.

    - CentOS-7-x86_64-NetInstall-2009.iso:
   Đây là phiên bản cài đặt và cứu hộ mạng. Trình cài đặt sẽ hỏi nơi cần tìm các gói cần cài đặt. Phiên bản này hữu ích nhất nếu bạn có bản sao cục bộ của các gói CentOS.

   - CentOS-7-x86_64-Mọi thứ-2009.iso:
   Phiên bản này chứa bộ gói hoàn chỉnh dành cho CentOS Linux 7. Nó có thể được sử dụng để cài đặt hoặc điền vào máy nhân bản cục bộ. Phiên bản này cần ổ flash USB 16 GB vì nó quá lớn đối với các ISO DVD.
   
   - CentOS-7-x86_64-Minimal-2009.iso
    Phiên bản này là cài đặt một hệ thống CentOS Linux 7 rất cơ bản, với các gói tối thiểu cần thiết để có một hệ thống chức năng.
- Do nhu cầu mới học, tôi sẽ chỉ sử dụng phiên bản Minimal
- Tiến hành cài đặt trên **VMWare Workstation Pro**
  - Vào VMWare, tại màn hình chính của ứng dụng, tiến hành bấm tổ hợp phím `Ctrl + N` để thiết lập một máy chủ mới.
  - ![](/Anh/Screenshot_85.png)
    - Có 2 option trong mục này:
      - Typical: Cài đặt theo các bước đơn giản, ngắn gọn
      - Custom: Tạo máy chủ với các yêu cầu nâng cao hơn
      - Tôi sẽ cài đặt theo các bước đơn giản 
  - ![](/Anh/Screenshot_86.png)
    - Tiến hành chọn file hệ hiều hành để cài cho máy ảo
    - Chọn **Browse** để tìm nơi lưu file Ubuntu Server mà bạn vừa tải
    - ![](/Anh/Screenshot_122.png)
    - Sau khi chọn xong đường dẫn, chọn **Open** để mở file hệ điều hành
    - Sau đó, chọn **Next** để tiếp tục quá trình cài đặt
    - ![](/Anh/Screenshot_123.png)
    - Tiến hành đặt tên cho máy ảo
    - Sau đó, chọn đường dẫn lưu máy ảo. Lưu ý, nên xếp vào các Folder cho gọn gàng
    - Sau đó, bấm **Next** để tiếp tục tiến trình
    - Sau đó, tiếp tục quá trình khởi tạo máy ảo như bình thường
    - Khởi động máy ảo để bắt đầu quá trình cài CentOS 7
      - Tiến hành chọn kiểu cài đặt:
      - ![](/Anh/Screenshot_124.png)
      - Nhấn `Enter` để tiếp tục quá trình
      - ![](/Anh/Screenshot_125.png)
      - Tiến hành chọn ngôn ngữ:
      - ![](/Anh/Screenshot_126.png)
      - Chọn vùng thời gian
      - ![](/Anh/Screenshot_127.png)
      - Cài đặt USer và RootPassword
      - ![](/Anh/Screenshot_128.png)  
      - Bây giờ là quá trình chờ đợi để cài đặt
      - ![](/Anh/Screenshot_129.png)  
      - Tiến hành đăng nhập và bạn đã hoàn thành khởi tạo máy ảo sử dụng CentOS 7
      - ![](/Anh/Screenshot_130.png)

## 3. Tiến hành Set Static IP cho CentOS 7
- Nhập lệnh `ip a` hoặc `ip addr show` để tiến hành xem IP
- Nếu như không hiện ra địa chỉ IPv4 như sau:
- ![](/Anh/Screenshot_131.png)
- Thì nghĩa là card mạng ens33 chưa được bật. Tiến hành bật lên bằng câu lệnh `ifup ens33`
- ![](/Anh/Screenshot_132.png)
- Bật hoàn tất.
- Tiến hành kiểm tra IP lại:
- ![](/Anh/Screenshot_133.png)
- Lúc này, IP đã hiện là: `192.168.142.140/24`
### 3.1 Cài bằng cách chỉnh sửa File:
- Ở Ubuntu Server ta chỉnh sửa file `00-installer-config.yaml` trong **Netplan** thì ở trong CentOS 7, ta chỉnh file trong đường dẫn như sau: `sysconfig/network-scripts/ifcfg-ens33`
- Thực hiện dùng trình soạn thảo VI:
- Câu lệnh hoàn chỉnh: `vi /etc/sysconfig/network-scripts/ifcfg-ens33`
- File khi chưa chỉnh sửa:
- ![](/Anh/Screenshot_134.png)
- Tiến hành chỉnh sửa như sau(Lưu ý bấm I để vào chế độ chỉnh sửa trong VI)
- ![](/Anh/Screenshot_135.png)
- ```
    BOOTPROTO=static
    ONBOOT=yes
    IPADDR=192.168.142.145
    PREFIX=24
    GATEWAY=192.168.142.2
    DNS1=8.8.8.8
    DNS2=8.8.4.4
    ```
- Sau khi chỉnh sửa xong, bấm `ESC` để thoát chế độ chỉnh sửa, `:x` để lưu và thoát khỏi VI
- Sau khi thoát, tiến hành reboot lại máy ảo, hoặc reset mạng,...
  - `reboot`
  - `systemctl restart network`
  - `ifdown ens33`
- Sau đó, tiến hành kiểm tra lại IP và ping thử ra Internet:
  - ![](/Anh/Screenshot_137.png)
  - IP lúc này đã được đổi thành `192.168.142.145/24`
  - Việc ping ra Internet cũng đã hoàn thành. Vây chúng ta đã thiết lập IP tĩnh thành công
  - 