# Mục này tìm hiểu về phần mềm PostMan, cách sử dụng nó

## PostMan là gì 
Hiểu đơn giản, PostMan là một App Extensions-một ứng dụng mã nguồn mở. 

PostMan là 1 công cụ mạnh mẽ để phát triển, kiểm thử và quản lý API.

PostMan cung cấp cho bạn giao diện đồ họa dễ sử dụng để gửi các yêu cầu HTTP và nhận phản hồi, giúp các nhà phát triển kiểm thử API một cách nhanh chóng mà không cần phải viết mã.

## Tại sao nên dùng PostMan
Post Man mang lại nhiều lợi ích, đặc biệt là trong quá trình phát triển và kiểm thử API
- PostMan cung cấp giao diện đồ họa dễ sử dụng, phù hợp cho cả người mới và chuyên gia
- Bạn có thể gửi đầy đủ các phương thức như: GET, POST, PUT, DELETE,... để thực hiện mọi thao tác với API
- PostMan hỗ trợ tích hợp các công cụ CI/CD (Các phương pháp, công cụ hỗ trợ tự động hóa) và cho phép lưu trữ các bộ sưu tập để chia sẻ
- Tính năng kiểm thử tự động giúp bạn nhanh chóng kiểm tra các trường hợp kiểm thử API mà không cần thực hiện thủ công

## Hướng dẫn sử dụng PostMan 
### Cài đặt PostMan
Các bạn truy cập vào trang chủ PostMan

Lựa chọn phiên abanr phù hợp để tải xuống và cài đặt. 

### Màn hình chính của PostMan
![](/Anh/Screenshot_908.png)

Như các bạn có thể thấy, giao diện người dùng của PostMan khá thân thiện và dễ sử dụng
### Các mã trạng thái của PostMan
Để sử dụng tốt PostMan, chúng ta cần nắm rõ thông tin về các mã trạng thái để có thể dễ dàng kiểm tra lỗi nếu có.
#### 1xx - Informational (Thông tin)
- 100 Continue: Máy khách có thể tiếp tục yêu cầu.
- 101 Switching Protocols: Máy chủ chấp nhận yêu cầu chuyển đổi giao thức.
#### 2xx - Success (Thành công)
- 200 OK: Yêu cầu thành công, dữ liệu trả về như mong đợi.
- 201 Created: Tài nguyên mới được tạo thành công.
- 202 Accepted: Yêu cầu được chấp nhận nhưng chưa xử lý xong.
- 204 No Content: Yêu cầu thành công nhưng không có nội dung trả về.
#### 3xx - Redirection (Chuyển hướng)
- 301 Moved Permanently: Tài nguyên đã được chuyển vĩnh viễn sang URL mới.
- 302 Found: Tài nguyên tạm thời được chuyển đến URL khác.
- 304 Not Modified: Tài nguyên không thay đổi kể từ lần yêu cầu trước đó.
#### 4xx - Client Error (Lỗi phía máy khách)
- 400 Bad Request: Yêu cầu không hợp lệ.
- 401 Unauthorized: Không có quyền truy cập (cần xác thực).
- 403 Forbidden: Không được phép truy cập tài nguyên.
- 404 Not Found: Không tìm thấy tài nguyên.
- 405 Method Not Allowed: Phương thức HTTP không được phép trên tài nguyên này.
- 429 Too Many Requests: Gửi quá nhiều yêu cầu trong một khoảng thời gian ngắn.
#### 5xx - Server Error (Lỗi phía máy chủ)
- 500 Internal Server Error: Lỗi phía máy chủ không xác định.
- 501 Not Implemented: Phương thức không được hỗ trợ trên máy chủ.
- 502 Bad Gateway: Máy chủ nhận phản hồi không hợp lệ từ máy chủ khác.
- 503 Service Unavailable: Máy chủ hiện không khả dụng (quá tải hoặc bảo trì).
- 504 Gateway Timeout: Máy chủ không nhận được phản hồi kịp thời từ máy chủ khác.
## Thao tác với dữ liệu sử dụng PostMan
### Hướng dẫn tạo 1 Request
Trước khi tiến hành thao tác với dữ liệu qua PIM . Dữ liệu mẫu sẽ được lấy mẫu tại [đây](https://jsonplaceholder.typicode.com/users)

Sau khi Send, bạn sẽ nhận được response như ở dưới, đúng với nội dung dữ liệu trên trang web:

![](/Anh/Screenshot_910.png)

Lưu ý: Request bạn vừa thực hành ở trên là không an toàn, dữ liệu mở do server không yêu cầu xác thực. Nếu như bạn cố gắng truy cập đến 1 trang web dữ liệu được bảo mật nhưng bạn không có API Token để truy cập thì PostMan sẽ hiển thị lỗi như sau:

![](/Anh/Screenshot_911.png)

### Hướng dẫn làm việc với Request yêu cầu xác thực
Như các bạn cũng biết, khi sử dụng một ứng dụng nào đó thì chúng ta hay phải tạo một tài khoản để có thể đăng nhập vào ứng dụng đó.

Khi vào một trang web bán hàng chẳng hạn, khi bạn muốn thực hiện chức năng thêm vào giỏ hàng thì yêu cầu bạn phải đăng nhập mới có thể thực hiện chức năng đó. Đúng vậy có những chắc năng mà bạn phải đăng nhập mới có thể thưc hiện được.

Để có thể test một chức năng trên postman mà yêu cầu bạn phải đăng nhập thì postman cho phép bạn truyền lên header của nó một biến Authorization có value là dạng chuối mã hóa Base64. Giá trị này chính là giá trị access_token của user khi user đó đăng nhập vào hệ thống.

Thực hiện test thử:
- Trước tiên chúng ta thêm đường dẫn tới API NetBox như bình thường: `https://www.netboxlab.local/api/?format=json`
- Sau đó, chúng ta cấu hình ở mục `Authorization` như sau:
  - Chọn kiểu Auth Type là **API Key** 
  - Nhập Key là: `Authorization`
  - Value: `Token  <Token....>`
  - Add to: Header

![](/Anh/Screenshot_912.png)  
- Cuối cùng, chúng ta được kết quả của trang web như sau:

![](/Anh/Screenshot_913.png)

### Post Data lên NetBox 
Để post được data lên NetBox, chúng ta sẽ cần có API Token của NetBox. Bạn có thể tự tạo cho mình 1 API Token và cấp các quyền riêng cho Account của token đó.
#### Cách tạo 1 API Token
Bạn sẽ cần quyền truy cập admin NetBox để có thể tạo token.
- Truy cập vào Admin --> Authentication --> API Tokens
- Tạo 1 api token như sau:

![](/Anh/Screenshot_914.png)

Lưu ý: NetBox sẽ không hiển thị API Token của bạn. Để thuận tiện sử dụng, bạn có thể copy token và dán vào mục description. Nhưng việc này sẽ gây ra vấn đề bảo mật. Không khuyến khích sử dụng
#### Post data lên NetBox
Trước tiên, chúng ta cần xác định kiểu dữ liệu muốn post, post dữ liệu tại đâu. Ở đây, tôi muốn thêm 1 device role.
- Kiểu dữ liệu: JSON
- Đường link nhận dữ liệu:  `https://www.netboxlab.local/api/dcim/device-roles/`
- Trước tiên, tạo 1 Request mới
- Trong tab Authorization, lựa chọn như sau:

![](/Anh/Screenshot_915.png)
- Gắn URL vào mục URL
- Chuyển sang Tab Body, tiến hành chọn kiểu JSON. Đối với Device Roles, sẽ có các mục bắt buộc có thông tin như sau:
    - Name: Tên 
    - Slug: Ký hiệu
    - Color: Màu
    - VM Roles: Cho phép tạo VM hay không ?
- Với các thông tin bắt buộc như trên, dữ liệu nhập vào dạng JSON của chúng ta sẽ như sau:
```
{
  "name": "TestAPI",
  "slug": "testapi",
  "color": "ff0000",
  "vm_role": false
}
```
- Cuối cùng, nếu thành công sẽ cho ra kết quả hiển thị như sau:

![](/Anh/Screenshot_916.png)
- Tiến hành kiểm tra trên NetBox

![](/Anh/Screenshot_917.png)

### Patch và Put
Chúng ta sử dụng Patch khi muốn cập nhật 1 phần thông tin. Put sẽ được sử dụng khi chúng ta muốn cập nhật tất cả thông tin.

Các bước thực hiện ban đầu về phần tạo Request, lấy API, lấy đường Link và xác thực tương tự như GET và POST.
#### Patch data
Đối với URL của Patch hoặc Put data, chúng ta cần chỉ đích rõ device roles mà mình muốn chỉnh sửa bằng cách thêm vào 1 id. Ví dụ: `https://www.netboxlab.local/api/dcim/device-roles/6/`

Sau khi hoàn thành các bước khởi tạo, chúng ta thực hiện thêm đoạn code sau vào phần body để đổi tên Device Roles từ **TESTAPI** --> **Patch TESTAPI**
```
{
    "name": "Patch TESTAPI"
}
```
Kết quả:

![](/Anh/Screenshot_918.png)
#### Put data
Tương tự với Patch data. Chúng ta chuyển từ Patch thành Put và thêm vào nội dung sau:
```
{
  "name": "Put TestAPI",
  "slug": "put-testapi",
  "color": "00ff00",
  "vm_role": true
}
```
Kết quả hiển thị:

![](/Anh/Screenshot_919.png)

#### Lưu ý
Vậy nếu chúng ta cố tình thực hiện sai, thì sao.
- Đối với Patch data, bạn có thể nhập đầy đủ thông tin và dữ liệu vẫn sẽ được đưa lên NetBox.
- Tuy nhiên, khi bạn sử dụng Put data và nhập thiếu 1 trong số các trường dữ liệu thì kết quả sẽ hiển thị lỗi 

![](/Anh/Screenshot_920.png)

### Delete data
Đối với việc xóa dữ liệu bằng Postman rất dễ dàng. Bạn chỉ cần chọn phương thức, nhập xác thực và đường link url của device roles muốn xóa.

![](/Anh/Screenshot_921.png)

### Head Method trong PostMan
Chức năng: Gửi yêu cầu để lấy phần header của phản hồi mà không nhận phần body. Điều này giúp kiểm tra xem một tài nguyên có tồn tại hoặc kiểm tra siêu dữ liệu (metadata) như Content-Type, Content-Length mà không cần tải toàn bộ nội dung

Sử dụng như thế nào:
- Mở Postman, chọn HEAD từ danh sách phương thức HTTP
- Nhập URL của tài nguyên bạn muốn kiểm tra
- Nhấn "Send"
- Kiểm tra phần header của phản hồi để lấy thông tin về tài nguyên
- Phần header của phản hồi sẽ hiển thị thông tin về các phương thức HTTP được phép trong trường Allow

Ví dụ:

![](/Anh//Screenshot_922.png)

### Options Method trong PostMan
Chức năng: Xác định những phương thức HTTP nào được phép trên một tài nguyên cụ thể, hiển thị các thông tin về các trường dữ liệu, các dữ liệu bắt buộc, cách nhập,.... Điều này hữu ích khi bạn cần biết tài nguyên đó hỗ trợ những phương thức nào (GET, POST, PUT, DELETE, v.v.), cho bạn biết cách nhập sao cho đúng

Sử dụng như thế nào:
- Mở Postman, chọn OPTIONS từ danh sách phương thức HTTP
- Nhập URL của tài nguyên bạn muốn kiểm tra
- Nhấn "Send"
- Phần header của phản hồi sẽ hiển thị thông tin về các phương thức HTTP được phép trong trường Allow
- Phần Body sẽ cho chúng ta toàn bộ thông tin về dữ liệu trong trang

Ví dụ:

![](/Anh//Screenshot_923.png)