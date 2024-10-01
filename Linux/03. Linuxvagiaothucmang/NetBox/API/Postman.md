# Mục này tìm hiểu về phần mềm PostMan, cách sử dụng nó
Mục lục
- [Mục này tìm hiểu về phần mềm PostMan, cách sử dụng nó](#mục-này-tìm-hiểu-về-phần-mềm-postman-cách-sử-dụng-nó)
  - [PostMan là gì](#postman-là-gì)
  - [Tại sao nên dùng PostMan](#tại-sao-nên-dùng-postman)
  - [Hướng dẫn sử dụng PostMan](#hướng-dẫn-sử-dụng-postman)
    - [Cài đặt PostMan](#cài-đặt-postman)
    - [Màn hình chính của PostMan](#màn-hình-chính-của-postman)
    - [Các mã trạng thái của PostMan](#các-mã-trạng-thái-của-postman)
      - [1xx - Informational (Thông tin)](#1xx---informational-thông-tin)
      - [2xx - Success (Thành công)](#2xx---success-thành-công)
      - [3xx - Redirection (Chuyển hướng)](#3xx---redirection-chuyển-hướng)
      - [4xx - Client Error (Lỗi phía máy khách)](#4xx---client-error-lỗi-phía-máy-khách)
      - [5xx - Server Error (Lỗi phía máy chủ)](#5xx---server-error-lỗi-phía-máy-chủ)
    - [Các dạng Auth Type của PostMan](#các-dạng-auth-type-của-postman)
  - [Thao tác với dữ liệu sử dụng PostMan](#thao-tác-với-dữ-liệu-sử-dụng-postman)
    - [Hướng dẫn tạo 1 Request](#hướng-dẫn-tạo-1-request)
    - [Hướng dẫn làm việc với Request yêu cầu xác thực](#hướng-dẫn-làm-việc-với-request-yêu-cầu-xác-thực)
      - [Thực hiện test](#thực-hiện-test)
    - [Post Data lên NetBox](#post-data-lên-netbox)
      - [Cách tạo 1 API Token](#cách-tạo-1-api-token)
      - [Post data lên NetBox](#post-data-lên-netbox-1)
    - [Patch và Put](#patch-và-put)
      - [Patch data](#patch-data)
      - [Put data](#put-data)
      - [Lưu ý](#lưu-ý)
    - [Delete data](#delete-data)
    - [Head Method trong PostMan](#head-method-trong-postman)
    - [Options Method trong PostMan](#options-method-trong-postman)
  - [Tham số hóa các Request](#tham-số-hóa-các-request)
    - [Cách tạo biến môi trường](#cách-tạo-biến-môi-trường)
    - [Sử dụng các biến môi trường](#sử-dụng-các-biến-môi-trường)
  - [Scripts và tự động hóa trong PostMan](#scripts-và-tự-động-hóa-trong-postman)
    - [Phân Loại](#phân-loại)
      - [Pre-request Scripts](#pre-request-scripts)
      - [Tests Scripts](#tests-scripts)
      - [Global Scripts (Tùy Chỉnh)](#global-scripts-tùy-chỉnh)
      - [Collection-level Scripts](#collection-level-scripts)
    - [Một số Scripts hữu ích](#một-số-scripts-hữu-ích)
      - [Tạo và Lưu Token từ Phản Hồi](#tạo-và-lưu-token-từ-phản-hồi)
      - [Kiểm Tra Status Code](#kiểm-tra-status-code)
      - [Kiểm Tra Nội Dung Phản Hồi](#kiểm-tra-nội-dung-phản-hồi)
      - [Tạo Timestamp và Lưu Vào Biến](#tạo-timestamp-và-lưu-vào-biến)
      - [Tạo UUID Mới](#tạo-uuid-mới)
      - [Kiểm Tra Thời Gian Phản Hồi](#kiểm-tra-thời-gian-phản-hồi)
      - [Xác Thực Thông Tin Đăng Nhập](#xác-thực-thông-tin-đăng-nhập)
      - [Trích Xuất Dữ Liệu từ Phản Hồi](#trích-xuất-dữ-liệu-từ-phản-hồi)
      - [Lặp Qua Một Mảng và Kiểm Tra Mỗi Phần Tử](#lặp-qua-một-mảng-và-kiểm-tra-mỗi-phần-tử)
      - [Đặt Biến Để Sử Dụng Trong Yêu Cầu Tiếp Theo](#đặt-biến-để-sử-dụng-trong-yêu-cầu-tiếp-theo)
    - [Kiểm thử 1 số Scripts vào NetBox](#kiểm-thử-1-số-scripts-vào-netbox)
      - [Tìm kiếm DeviceRoles theo tên](#tìm-kiếm-deviceroles-theo-tên)
      - [Kiểm tra thời gian phản hồi](#kiểm-tra-thời-gian-phản-hồi-1)
      - [Lọc ra các biến id](#lọc-ra-các-biến-id)

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

Lựa chọn phiên bản phù hợp để tải xuống và cài đặt. 

### Màn hình chính của PostMan
![](/Anh/Screenshot_909.png)

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

### Các dạng Auth Type của PostMan
1. **No Auth**
- Không sử dụng bất kỳ phương thức xác thực nào.
- Dùng khi API không yêu cầu xác thực hoặc chỉ để thử nghiệm.

2. **API Key**
- API key được gửi dưới dạng một tham số URL, một trường trong phần Header, hoặc một phần của Body.
- Thường sử dụng cho các API công khai hoặc khi muốn kiểm soát truy cập dễ dàng.

3. **Bearer Token**
- Sử dụng một chuỗi token duy nhất để xác thực.
- Token thường được gửi trong phần Header với cấu trúc: `Authorization: Bearer <token>`

4. **Basic Auth**
- Sử dụng tên người dùng và mật khẩu mã hóa bằng Base64.
Thường được dùng cho các API yêu cầu xác thực đơn giản.

5. **Digest Auth**
- Cách xác thực bảo mật hơn Basic Auth, mã hóa thông tin đăng nhập bằng các thuật toán băm (hashing).
- Phù hợp với các API yêu cầu xác thực nâng cao.

6. **OAuth 1.0**
- Xác thực sử dụng khóa công khai và khóa bí mật cùng với token.
Dùng cho các dịch vụ cũ hoặc các API yêu cầu OAuth 1.0.

7. **OAuth 2.0**
- Phương thức xác thực hiện đại và bảo mật hơn, dựa trên việc cấp và quản lý token.
- Phổ biến với các dịch vụ như Google, Facebook, GitHub.

8. **NTLM Auth (Windows NT LAN Manager)**
- Sử dụng để xác thực trong các môi trường mạng Windows.
- Phù hợp với các ứng dụng nội bộ yêu cầu xác thực Windows.

9. **AWS Signature**
- Được sử dụng để xác thực các yêu cầu gửi đến AWS APIs.
Yêu cầu AWS Access Key, Secret Key và các thông số khác.

10. **Hawk Authentication**
- Một loại xác thực dựa trên mã băm tương tự như HMAC (Hash-based Message Authentication Code).
- Bảo vệ API khỏi việc thay đổi dữ liệu hoặc tấn công replay.

11. **AWS IAM Auth**
- Dùng cho các yêu cầu xác thực với Amazon Web Services (AWS) bằng cách sử dụng IAM roles.

12. **Akamai EdgeGrid**
- Sử dụng khi cần xác thực với Akamai APIs, cung cấp bảo mật nâng cao cho các dịch vụ web.

## Thao tác với dữ liệu sử dụng PostMan
### Hướng dẫn tạo 1 Request
Trước khi tiến hành thao tác với dữ liệu thât, dữ liệu mẫu sẽ được lấy mẫu tại [đây](https://jsonplaceholder.typicode.com/users)

- Trước tiên, chúng ta chọn phương thức(ví dụ là GET), 
- tiếp đến là nhập đường link dẫn tới nơi lấy data. 
- Sau khi Send, bạn sẽ nhận được response như ở dưới, đúng với nội dung dữ liệu trên trang web:

![](/Anh/Screenshot_910.png)

Lưu ý: Request bạn vừa thực hành ở trên là không an toàn, dữ liệu mở do server không yêu cầu xác thực. Nếu như bạn cố gắng truy cập đến 1 trang web dữ liệu được bảo mật nhưng bạn không có API Token để truy cập thì PostMan sẽ hiển thị lỗi như sau:

![](/Anh/Screenshot_911.png)

### Hướng dẫn làm việc với Request yêu cầu xác thực
Như các bạn cũng biết, khi sử dụng một ứng dụng nào đó thì chúng ta hay phải tạo một tài khoản để có thể đăng nhập vào ứng dụng đó.

Khi vào một trang web bán hàng chẳng hạn, khi bạn muốn thực hiện chức năng thêm vào giỏ hàng thì yêu cầu bạn phải đăng nhập mới có thể thực hiện chức năng đó. Đúng vậy có những chắc năng mà bạn phải đăng nhập mới có thể thưc hiện được.


#### Thực hiện test
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

## Tham số hóa các Request
Tham số hóa dữ liệu là một trong những tính năng hữu ích nhất của Postman. 

Để tạo cùng một request với dữ liệu khác nhau, bạn có thể sử dụng các biến với tham số. Những dữ liệu này có thể từ một tệp dữ liệu hoặc biến môi trường. 

Tham số hóa giúp tránh lặp lại các thử nghiệm tương tự và có thể sử dụng để kiểm thử tự động.

Environment trong Postman là nơi mà mà bạn có thể tạo để quản lý các biến giá trị như URL, token, và các thông số khác, giúp bạn dễ dàng thay đổi hoặc kiểm tra API trên các môi trường khác nhau (ví dụ: Development, Staging, Production) mà không cần sửa đổi trực tiếp các yêu cầu.
### Cách tạo biến môi trường
Các biến môi trường sẽ được lưu ở trong môi trường. Vì vậy, trước khi tạo các biến, chúng ta cần tạo 1 môi trường.

![](/Anh/Screenshot_924.png)

Tiến hành thêm các biến:
- Thêm các biến với "Variable" - Tên biến. Ví dụ: "baseUrl" 
- "Initial Value" - Gía trị của biến. Ví dụ: `https://www.netboxlab.local`

![](/Anh/Screenshot_925.png)

### Sử dụng các biến môi trường
Ở góc trên phải của Postman, chọn environment mà bạn muốn sử dụng

Thay thế các giá trị cố định trong yêu cầu bằng cú pháp `{{variable_name}}`. Ví dụ: `{{baseUrl}}/api/devices/`

![](/Anh/Screenshot_926.png)

## Scripts và tự động hóa trong PostMan
Một tính năng hữu ích khi sử dụng PostMan là tính năng tự động hóa bằng các Scripts

Scripts trong Postman được sử dụng để thực hiện các tác vụ tự động trước hoặc sau khi gửi yêu cầu API. Nó được chia làm các loại chính
- Pre-request Scripts
- Test Scripts
- Global Scripts
- Collection-level Scripts
### Phân Loại
#### Pre-request Scripts
Vị trí: Chạy trước khi gửi yêu cầu API.

Mục đích: Chuẩn bị các tham số hoặc thực hiện các phép toán cần thiết trước khi yêu cầu được gửi.

Sử dụng: Tạo token, thiết lập biến, hoặc chuẩn bị dữ liệu cho yêu cầu.

Ví dụ:
- Tạo timestamp.
- Lưu API key vào biến môi trường.
#### Tests Scripts
Vị trí: Chạy sau khi nhận phản hồi từ API.

Mục đích: Kiểm tra kết quả của phản hồi, xác thực dữ liệu, hoặc lưu trữ thông tin cho các yêu cầu sau.

Sử dụng: Kiểm tra status code, nội dung của phản hồi, hoặc lưu giá trị từ phản hồi.

Ví dụ:
- Kiểm tra xem phản hồi có chứa trường cụ thể.
- Lưu token từ phản hồi vào biến môi trường.
#### Global Scripts (Tùy Chỉnh)
Vị trí: Có thể được sử dụng trong bất kỳ yêu cầu nào trong bộ sưu tập.

Mục đích: Tạo các hàm hoặc biến mà bạn muốn sử dụng nhiều lần trong các yêu cầu khác nhau.

Sử dụng: Tạo các hàm hỗ trợ hoặc biến chung cho tất cả các yêu cầu.

Ví dụ:
- Tạo hàm để xử lý dữ liệu trả về.
#### Collection-level Scripts
Vị trí: Chạy trước và sau tất cả các yêu cầu trong một bộ sưu tập.

Mục đích: Thiết lập môi trường cho toàn bộ bộ sưu tập hoặc kiểm 
tra cuối cùng sau khi tất cả yêu cầu đã được thực hiện.

Sử dụng: Thiết lập biến cho toàn bộ bộ sưu tập hoặc kiểm tra tổng thể.

Ví dụ:
- Thiết lập thông tin cấu hình cho bộ sưu tập.
- Kiểm tra tổng quát kết quả của tất cả các yêu cầu trong bộ sưu tập.
### Một số Scripts hữu ích
#### Tạo và Lưu Token từ Phản Hồi
```
// Lưu token từ phản hồi vào biến môi trường
pm.test("Token is stored", function () {
    let jsonData = pm.response.json();
    pm.environment.set("authToken", jsonData.token);
});
```
#### Kiểm Tra Status Code
```
// Kiểm tra xem status code có phải là 200 hay không
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});
```
#### Kiểm Tra Nội Dung Phản Hồi
```
// Kiểm tra xem phản hồi có chứa trường 'data'
pm.test("Response has data field", function () {
    let jsonData = pm.response.json();
    pm.expect(jsonData).to.have.property('data');
});
```
#### Tạo Timestamp và Lưu Vào Biến
```
// Tạo timestamp và lưu vào biến môi trường
pm.environment.set("timestamp", new Date().toISOString());
```
#### Tạo UUID Mới
```
// Tạo UUID mới và lưu vào biến môi trường
const uuid = require('uuid');
pm.environment.set("uniqueId", uuid.v4());
```
#### Kiểm Tra Thời Gian Phản Hồi
```
// Kiểm tra thời gian phản hồi (response time)
pm.test("Response time is less than 200ms", function () {
    pm.expect(pm.response.responseTime).to.be.below(200);
});
```
#### Xác Thực Thông Tin Đăng Nhập
```
// Kiểm tra thông tin đăng nhập thành công
pm.test("Login successful", function () {
    let jsonData = pm.response.json();
    pm.expect(jsonData.message).to.eql('Login successful');
});
```
#### Trích Xuất Dữ Liệu từ Phản Hồi
```
// Lưu giá trị 'id' từ phản hồi vào biến môi trường
let jsonData = pm.response.json();
pm.environment.set("userId", jsonData.id);
```
#### Lặp Qua Một Mảng và Kiểm Tra Mỗi Phần Tử
```
// Kiểm tra tất cả các mục trong mảng 'items' có thuộc tính 'id'
pm.test("All items have id", function () {
    let jsonData = pm.response.json();
    jsonData.items.forEach(item => {
        pm.expect(item).to.have.property('id');
    });
});
```
#### Đặt Biến Để Sử Dụng Trong Yêu Cầu Tiếp Theo
```
// Đặt giá trị từ biến môi trường cho yêu cầu tiếp theo
pm.request.headers.add({ key: "Authorization", value: `Bearer ${pm.environment.get("authToken")}` });
```

### Kiểm thử 1 số Scripts vào NetBox
#### Tìm kiếm DeviceRoles theo tên 
Scripts:
```
let jsonData = pm.response.json();
let roleExists = jsonData.results.some(role => role.name === "SAN Storage");
pm.test("Device role exists", function () {
    pm.expect(roleExists).to.be.true;
});
```
Kết quả:

![](/Anh/Screenshot_927.png)

#### Kiểm tra thời gian phản hồi
Scripts:
```
pm.test("Response time is acceptable", function () {
    pm.expect(pm.response.responseTime).to.be.below(200);
});
```
Kết quả:

![](/Anh/Screenshot_928.png)

#### Lọc ra các biến id
Scripts:
```
// Lấy dữ liệu phản hồi JSON
let responseData = pm.response.json();

// Kiểm tra xem có dữ liệu trong results không
pm.test("Check if results exist", function () {
    pm.expect(responseData.results).to.be.an('array').that.is.not.empty;
});

// Lưu id của từng đối tượng vào một mảng
let ids = responseData.results.map(item => item.id);

// Lưu mảng id vào biến môi trường
pm.environment.set("deviceRoleIds", JSON.stringify(ids));

// In ra console để kiểm tra
console.log("Device Role IDs: ", ids);
```
Kết quả:

![](/Anh/Screenshot_929.png)
