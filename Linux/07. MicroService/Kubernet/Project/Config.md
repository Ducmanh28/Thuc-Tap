# Cấu hình
Mục này sẽ hướng dẫn cấu hình dữ liệu cho trang web
## Cấu hình dữ liệu NetBox
Bạn sẽ cần cấu hình dữ liệu cơ bản như Sites, Racks, Device, VM, IPAMs,...

Bạn cũng có thể nhập liệu dữ liệu tự động từ vcenter hoặc sử dụng công cụ netbox_import_tools của Học chủ động - công cụ này hỗ trợ nhập liệu tự động từ Excel vào NetBox

Mẫu:

![](/Anh/Screenshot_1074.png)

## Cấu hình dữ liệu MySQL
Ở mục này, mặc định các dữ liệu cơ bản đã được tôi cấu hình sẵn trong chương trình. Bạn có thể truy cập với tài khoản và mật khẩu admin mặc định ở trong `.env_sample` 

Bạn có thể truy cập vào MySQL với quyền ADMIN, thoải mái sửa chữa và nâng cấp, tạo dữ liệu mới. Tuy nhiên để tránh lỗi xảy ra, vui lòng không xóa bảng hay chỉnh sửa các nội dung trong bảng!