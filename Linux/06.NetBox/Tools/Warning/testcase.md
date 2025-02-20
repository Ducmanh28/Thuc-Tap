# Test case
## Case 1: Change Position
![#Change_position](/Anh/Screenshot_1013.png)

## Case 2: Change Rack
![#Change_rack](/Anh/Screenshot_1014.png)

## Case 3: Add Comment 
![#Add_comment](/Anh/Screenshot_1015.png)

## Case 4: Unrack
![#Un_rack](/Anh/Screenshot_1016.png)

## Case 5: Change Site
![#Change_site](/Anh/Screenshot_1017.png)

## Case 6: Add IP
![#Add_IP](/Anh/Screenshot_1018.png)

## Case 7: Add Contact
![#Add_Contact](/Anh/Screenshot_1019.png)

Phần này đang gặp lỗi như sau:
- Contact là 1 custom field gắn với Device.
- Tool hoạt động là lấy dữ liệu ***sau khi có sự thay đổi*** trên NetBox
- Mà muốn lấy được Contact thì phải lấy dữ liệu thông qua Device
- Vì vậy khi Tool lấy Contact ID ở prechange và tìm kiếm trên Device thì lúc này Contact ID ở Device đã là Contact ID của Postchange rồi ==> hiển thị không có dữ liệu ở prechange data

![#Contact_Error](/Anh/Screenshot_1020.png)
