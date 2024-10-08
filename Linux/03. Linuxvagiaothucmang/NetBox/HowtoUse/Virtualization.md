# Hướng dẫn thêm 1 VM trên NetBox
## Lý thuyết
Theo như tài liệu của NetBox, các máy ảo và cụm ảo hóa có thể được mô hình hóa trong NetBox cùng với cơ sở hạ tầng vật lý.

Địa chỉ IP và các tài nguyên khác được gán cho các đối tượng này giống như các đối tượng vật lý, cung cấp sự tích hợp liền mạch giữa mạng vật lý và ảo

### Cluster
Là một hoặc nhiều thiết bị chủ vật lý mà các máy ảo có thể chạy trên đó. Mỗi Cluster phải có một loại định dạng và hiển thị rõ trạng thái hoạt động của Cluster. Đồng thời, Cluster cũng có thể được gán vào 1 nhóm(Cluster Group)

Mỗi Cluster có thể chỉ định một hoặc nhiều thiết bị làm máy chủ, tuy nhiên đây là tùy chọn

### Virtual Machine
Là một phiên bản điện toán ảo hóa. Chúng hoạt động trong NetBox rất giống với các đối tượng thiết bị, nhưng không có bất kỳ thuộc tính vật lý nào. 

Ví dụ: Một máy ảo có thể có các giao diện được gán cho nó với địa chỉ IP và VLAN, tuy nhiên giao diện của nó không thể được kết nối qua cáp (vì chúng là ảo)

Mỗi máy ảo cũng có thể xác định tài nguyên tính toán, bộ nhớ và lưu trữ của nó.

### Thứ tự thêm
![](/Anh/Screenshot_945.png)

Như ta có thể thấy theo hình vẽ, **Cluster Type** và **Cluster Group** là 2 thành phần cần được thêm vào trước.

Tiếp sau đó, chúng ta sẽ thêm **Cluster** và **Platform**

Sau đó, chúng ta mới tiến hành thêm **Virtual Machine** và cuối cùng là thêm **VMInterface**(nếu có)

## Thực hành thêm
Trước tiên, tôi sẽ thêm **Cluster Type**

![](/Anh/Screenshot_945.png)

Sau đó, tôi thêm **Cluster Group**

![](/Anh/Screenshot_946.png)

Tiếp theo sẽ thêm **Cluster**

![](/Anh/Screenshot_948.png)

**Platform** đã có sẵn từ khi thêm Device nên tôi sẽ không thêm

Cuối cùng, chúng ta tạo được 1 VM với các thông tin như sau:

![](/Anh/Screenshot_949.png)