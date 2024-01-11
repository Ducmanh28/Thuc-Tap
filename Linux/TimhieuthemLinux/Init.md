# Tìm hiểu lệnh Init
- init là cha của tất cả các process. 
- Vai trò chính của init là tạo ra các process bằng chạy các chương trình được quy định trong tập tin /etc/inittab. 
- Mỗi init sẽ có các process khác nhau. 
- Trong linux có 6 mức khởi động (run level)
  - Run level 0 (init 0): chế độ tắt máy
  - Run level 1 (init 1): chế độ này chỉ sử dụng được 1 người dùng
  - Run level 2 (init 2): chế độ đa người dùng nhưng không có dịch vụ NFS
  - Run level 3 (linit 3): chế độ đa người dùng, có đầy đủ các dịch vụ
  - Run level 4 (linit 4): chưa được sử dụng
  - Run level 5 (linit 5): chế độ đồ họa
  - Run level 6 (linit 6): khởi động lại máy
- Cú pháp để sử dụng:
  - `init <Run_Levels>`
  - Ví dụ: 
    - `init 0` để tắt máy
    - `init 6` để khởi động lại   