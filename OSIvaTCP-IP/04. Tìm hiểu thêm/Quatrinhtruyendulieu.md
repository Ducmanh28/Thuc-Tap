MỤC LỤC
- [I. Điều gì xảy ra ở máy tính khi chúng ta tìm kiếm "Google.com" trên trình duyệt và ấn Enter ?](#i-điều-gì-xảy-ra-ở-máy-tính-khi-chúng-ta-tìm-kiếm-googlecom-trên-trình-duyệt-và-ấn-enter-)
  - [1. Quá trình vào ứng dụng trình duyệt:](#1-quá-trình-vào-ứng-dụng-trình-duyệt)
  - [2. Gói tin từ tầng Application sau đó sẽ được chuyển xuống tầng Presentation](#2-gói-tin-từ-tầng-application-sau-đó-sẽ-được-chuyển-xuống-tầng-presentation)
  - [3. Tiến hành thiết lập phiên làm việc giữa trình duyệt và Server Google](#3-tiến-hành-thiết-lập-phiên-làm-việc-giữa-trình-duyệt-và-server-google)
  - [4. Phân chia gói tin thành các gói dữ liệu TCP để chuẩn bị cho việc vận chuyển](#4-phân-chia-gói-tin-thành-các-gói-dữ-liệu-tcp-để-chuẩn-bị-cho-việc-vận-chuyển)
  - [5. Chia nhỏ thành các Packets để vận chuyển qua Internet](#5-chia-nhỏ-thành-các-packets-để-vận-chuyển-qua-internet)
  - [6. Gói gọn các gói tin IP vào trong một khung Ethernet](#6-gói-gọn-các-gói-tin-ip-vào-trong-một-khung-ethernet)
  - [7. Bắt đầu chuyển các khung Ethernet thành các tín hiệu vật lý](#7-bắt-đầu-chuyển-các-khung-ethernet-thành-các-tín-hiệu-vật-lý)
  - [8. Khi Server Google đã nhận được gói tin HTTP GET](#8-khi-server-google-đã-nhận-được-gói-tin-http-get)
  - [9. Khi chúng ta nhận được các gói tin mà Server Google gửi lại:](#9-khi-chúng-ta-nhận-được-các-gói-tin-mà-server-google-gửi-lại)
- [II. Một số tìm hiểu thêm](#ii-một-số-tìm-hiểu-thêm)
  - [1. FireWall](#1-firewall)
  - [2. Cân bằng tải](#2-cân-bằng-tải)
  - [3. Máy chủ web](#3-máy-chủ-web)
  - [4. Máy chủ ứng dụng](#4-máy-chủ-ứng-dụng)
  - [5. Cơ sở dữ liệu](#5-cơ-sở-dữ-liệu)
- [III. Tổng kết](#iii-tổng-kết)

# I. Điều gì xảy ra ở máy tính khi chúng ta tìm kiếm "Google.com" trên trình duyệt và ấn Enter ?

Khi muốn tìm kiếm một điều gì đó, ví dụ như **Facebook**, **Youtube**, **Wiki**,... chúng ta chỉ đơn giản truy cập vào các trình duyệt, ấn vào ô tìm kiếm trong trình duyệt nội dung mà mình muốn hướng tới, sau đó bấm *Enter* và dường như chỉ vài tíc tắc sau, trang Web mà chúng ta cần đã được hiện ra trên màn hình hiển thị. Nhưng thật ra, trong 1 vài tíc tắc ấy, có nhiều thứ đã xảy ra. Có rất nhiều giao thức được sử dụng, các kết nối được thiết lập,.... Và hôm nay, chúng ta cùng đi tìm hiểu về những gì xảy ra trong vài tíc tắc ấy. 

Để cho dễ hiểu và dễ nắm bắt thông qua những gì chúng ta đã được biết. Và dễ cho việc phân tích hơn, tôi sẽ phân tích quá trình này dựa theo mô hình OSI.

## 1. Quá trình vào ứng dụng trình duyệt:
- Nói đến ứng dụng trình duyệt, hay những công cụ, những app giúp bạn tìm kiếm thì chắc chắn những thứ này nằm ở tầng thứ 7 của mô hình OSI-tầng Application. 
- Ngay khi bạn truy cập vào ứng dụng, các thiết nối đã bắt đầu được thiết lập giữa máy của bạn và ứng dụng tìm kiếm. 
- Khi bạn gõ chữ "g" ở mục tìm kiếm(nếu không phải lần đầu tiên bạn gõ), các gợi ý tìm kiếm sẽ ngay lập tức xuất hiện. 
  - Các ứng dụng sẽ lưu những nội dung tìm kiếm của bạn ở trong bộ nhớ để những lần sau khi bạn tìm kiếm app sẽ đề xuất
  - Hoặc, các tìm kiếm liên quan đến chữ "g" sẽ được đề xuất tới bạn, điều này liên quan tới thuật toán gợi ý tìm kiếm cũng như chắt lọc thông tin người dùng của từng App
  - Nhưng tóm lại, hầu hết các thuật toán sẽ sắp xếp và ưu tiên kết quả dựa trên lịch sử tìm kiếm, dấu trang, cookie và các tìm kiếm phổ biến từ internet nói chung
- Vậy ngay khi bạn ấn **Enter** thì sao?
  - Lúc này, trình duyệt sẽ kiểm tra trong bộ nhớ cache xem trang web "google.com" đã được lưu trữ hay chưa? Nếu đã có rồi, trình duyệt sẽ sử dụng phiên bản đã lưu trữ để hiển thị trang web thay vì tải lại từ trên máy chủ
  - Nếu không có trong bộ nhớ cache, trình duyệt sẽ thực hiện một DNS Lookup, để tìm địa chỉ IP tương ứng với tên miền "google.com"
  - Khi đã có địa chỉ IP của Server Google, trình duyệt sẽ thiết lập kết nối tới Server Google 
  - Trình duyệt sẽ sử dụng giao thức HTTP hoặc HTTPS để gửi yêu cầu của mình tới máy chủ

## 2. Gói tin từ tầng Application sau đó sẽ được chuyển xuống tầng Presentation
- Yêu cầu mà chúng ta gửi đi sẽ được chuyển thành 1 định dạng khác mà máy tính có thể hiểu được. 
- Sau đó gói tin HTTPS này sẽ được đóng gói lại để chuẩn bị cho việc vận chuyển
- Ở tầng này, các giao thức mã hóa và bảo mật như SSL, TLS được thiết lập để bảo mật cho gói tin. 
- Sau khi check thấy mọi thứ đều ổn, gói tin sẽ được chuyển xuống tầng Session

## 3. Tiến hành thiết lập phiên làm việc giữa trình duyệt và Server Google
- Một phiên kết nối sẽ được tầng Session thiết lập và duy trì giữa trình duyệt trên máy tính của bạn và Server của Google để chuẩn bị cho việc truyền gói dữ liệu đi
- Điều này cho phép trình duyệt của bạn và máy chủ Google duy trì một kết nối trong suốt quá trình trao đổi thông tin
- Tầng phiên sau đó cũng sẽ thực hiện chuyển gói tin xuống cho tầng Transport
## 4. Phân chia gói tin thành các gói dữ liệu TCP để chuẩn bị cho việc vận chuyển
- Gói tin HTTP mà ta nhận được từ trên tầng Application lúc này sẽ được chia nhỏ thành các TCP Segment, trong gói tin này sẽ có thêm các trường cổng Port để giúp cho việc vận chuyển. Cũng như các trường số thứ tự cho việc ghép các gói tin lại thành gói tin hoàn chỉnh ở bên phía nhận
- TCP sẽ thực hiện quá trình kết nối tới Server Google bằng quy tắc bắt tay 3 bước.
- Sau khi thiết lập kết nối thành công, gói tin mới được gửi đi
- Gói dữ liệu sau khi được chia thành các TCP Segment sẽ được vận chuyển xuống tầng Network để đóng gói và chuẩn bị vận chuyển

## 5. Chia nhỏ thành các Packets để vận chuyển qua Internet
- Ở đây, các gói tin TCP Segment sẽ được chia thành các Packets, mỗi Packets sẽ được gắn thêm địa chỉ IP nguồn và đích để vận chuyển thông qua Internet. Các địa chỉ IP này sẽ được lấy từ thông tin máy tính cá nhân và thông qua DNS để lấy địa chỉ của Google Server
- Các giao thức định tuyến đường đi cũng sẽ được hoạt động ở tầng này, nó sẽ xác định đường đi tốt nhất cho gói tin.

## 6. Gói gọn các gói tin IP vào trong một khung Ethernet
- Từ máy tin cá nhân của bạn, giao thức ARP sẽ được sử dụng để tìm kiếm địa chỉ MAC của Router chính nhà bạn, sau đó sẽ được thiết lập kết nối từ máy tính cá nhân tới Router và gói tin ban đầu cũng sẽ được gửi tới Router. Phần còn lại của việc chuyển tiếp gói tin sẽ do Router đảm nhận
- Sau khi đóng gói vào các khung Ethernet xong, các gói dữ liệu này sẽ được chuyển xuống tầng Vật Lý

## 7. Bắt đầu chuyển các khung Ethernet thành các tín hiệu vật lý
- Giữa các thiết bị vật lý với nhau, chỉ có thể giao tiếp bằng các tín hiệu điện tắt bật
- Các khung Ethernet sẽ được chuyển hóa thành các tín hiệu 0,1 và được thực hiện truyền qua các đường truyền vật lý.
- Các tín hiệu sẽ có dạng tín hiệu điện hoặc quang học tùy theo bạn dùng cáp quang hay cáp dây, các tín hiệu này sẽ được truyền tới các switch --> Router --> tới ISP --> ra Internet thông qua sóng vô tuyến --> tới Server Google

## 8. Khi Server Google đã nhận được gói tin HTTP GET
- Server Google nhận được các tín hiệu mà máy chúng ta đã chuyển đi, nó sẽ thực hiện giải mã, ghép nối các gói tin này lại thành một bản tin hoàn chỉnh. 
- Sau khi biết đấy là một bản tin HTTP GET, Server Google sẽ thực hiện kết nối tới trang Web và lấy nội dung, thông tin trang web, sau đó thực hiện gửi lại gói tin HTTP cho chúng ta, bao gồm các tệp ngôn ngữ để hiện thị trang Web.
- Quá trình gửi bây giờ đã đơn giản hơn do các thiết nối đã được thiết lập, gói tin cứ thế được chuyển đi

## 9. Khi chúng ta nhận được các gói tin mà Server Google gửi lại:
- Các gói tin mà Google gửi tới trình duyệt sẽ được ghép nối thông qua 7 tầng của mô hình OSI và hiện lên cho chúng ta
- Các file dữ liệu như HTML, CSS, Java,... sẽ bắt đầu chạy để hiện thị ra trang Web mà chúng ta cần tìm
- ![](/Anh/Screenshot_78.png)
- Như có thể thấy, chúng ta đã tải xuống rất nhiều File
- Và để có thể hiện ra giao diện đồ họa như thế này, quá trình Render các file code đã được diễn ra.
- Hình ảnh mà chúng ta đang thấy chính là được thể hiện ở tầng 7 - Tầng Application. 
- Lúc này, việc truyền dữ liệu giữa trình duyệt và trang web sẽ được bảo mật và mã hóa bởi HTTPS. Vậy nên đối với HTTPS, sẽ có thêm một vài quá trình thiết lập kết nối an toàn, bảo mật dữ liệu và mã hóa - giải mã các gói dữ liệu


# II. Một số tìm hiểu thêm
## 1. FireWall
- Các gói tin khi được Server Google gửi về trình duyệt nằm trong máy tính của chúng ta sẽ được kiểm tra bởi FireWall của mỗi máy.
- Nếu phát hiện gói tin độc hại, chúng sẽ bị dừng và kết nối sẽ không được thực hiện

## 2. Cân bằng tải
- Sau khi kết nối HTTPS được thiết lập, yêu cầu được gửi đến bộ cân bằng tải.
- Bộ cân bằng tải là một thiết bị hoặc phần mềm phân phối lưu lượng mạng đến trên nhiều máy chủ web. 
- Điều này giúp cân bằng tải trên mỗi máy chủ và ngăn không cho bất kỳ một máy chủ nào bị quá tải lưu lượng.

## 3. Máy chủ web
- Một trong những máy chủ web nhận được yêu cầu HTTPS từ bộ cân bằng tải. Sau khi nhận được yêu cầu, máy chủ web xử lý nó bằng cách định vị tài nguyên hoặc trang web cần thiết. 
- Phản hồi sau đó được máy chủ web trả về máy tính của bạn.

## 4. Máy chủ ứng dụng
- Trong một số trường hợp, máy chủ web có thể không có thông tin cần thiết để thực hiện yêu cầu. 
- Trong những trường hợp như vậy, máy chủ web gửi yêu cầu đến một máy chủ ứng dụng. Máy chủ ứng dụng chịu trách nhiệm thực thi bất kỳ mã phía máy chủ nào được yêu cầu để tạo phản hồi.
- Ví dụ: nếu bạn đang truy cập một ứng dụng web yêu cầu bạn đăng nhập, máy chủ ứng dụng sẽ xác minh thông tin đăng nhập của bạn trước khi phục vụ nội dung được yêu cầu.

## 5. Cơ sở dữ liệu
- Trong một số trường hợp, máy chủ ứng dụng có thể cần lấy thông tin được yêu cầu từ cơ sở dữ liệu. 
- Cơ sở dữ liệu nhận được yêu cầu từ máy chủ ứng dụng, lấy dữ liệu cần thiết và sau đó đưa nó trở lại máy chủ ứng dụng.

# III. Tổng kết
- Những gì tôi viết và tìm hiểu được tất nhiên cũng chỉ là các quá trình cơ bản và sẽ không thể hoàn toàn đầy đủ chi tiết tất cả các sự việc diễn ra. Để tóm tắt lại, chúng ta có thể nhìn thông qua sơ đồ sau: 
- ![](/Anh/Screenshot_79.png)