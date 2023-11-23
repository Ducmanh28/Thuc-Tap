# Tầng Trình diễn
MỤC LỤC
- [1. Tầng trình diễn là gì?](#1-tầng-trình-diễn-là-gì)
- [2. Các chức năng](#2-các-chức-năng)
- [3. Dịch vụ](#3-dịch-vụ)
- [4. Cách mà tầng trình diễn hoạt động](#4-cách-mà-tầng-trình-diễn-hoạt-động)
- [5.Một số giao thức](#5-một-số-giao-thức-trong-tầng-trình-diễn)
## 1. Tầng trình diễn là gì?
- Là tầng thứ 6 trong mô hình OSI
- Đáp ứng nhu cầu dịch vụ mà **tầng Application** đòi hỏi
- Phát hành những yêu cầu dịch vụ với **tầng Session**
- Chịu trách nhiệm phân phát và định dạng dữ liệu cho **tầng Application**

## 2. Các chức năng
- Dịch: Tầng này nhận dữ liệu từ lớp Ứng dụng, Presentation sẽ chuyển định dạng từ chữ và số sang dạng nhị phân mà máy tính hiểu được
- Nén: Trước khi dữ liệu được truyền, tầng dịch giúp giảm số lượng bit được dùng để biểu diễn dữ liệu gốc. 
- Mã hóa/giải mã: Để duy trì tính toàn vẹn của dữ liệu, trước khi dữ liệu được chuyển đi thì nó sẽ được mã hóa. Và ở phía người nhận, nó sẽ được giải mã. Giao thức SSL(Secure Sockets Layer) được sử dụng để mã hóa và giải mã

## 3. Dịch vụ
- Đảm nhiệm viêc định dạng dữ liệu khi truyền 
- Thực hiện chuyển đổi dữ liệu(thường đc thực hiện bởi các giao thức TCP ở tầng khác)
- Nén và mã hóa các file dữ liệu, giảm bớt khối lượng(sử dụng các thuật toán như Huffman, LZW, Base64)
- Mã hóa, giải mã dữ liệu để dảm bảo an toàn thông tin( sử dụng các thuật toán như: MD, SHA hay AES)
- Quản lý phiên và đồng bộ hóa dữ liệu (thường đc thực hiện bởi các gia thức TCP ở tầng khác)

## 4. Cách mà tầng trình diễn hoạt động:
- Hoạt động như một tầng dữ liệu trên mạng
- Trên máy tính truyền, nó làm nhiệm vụ dịch dữ liệu được gửi từ tầng Application sang một dạng format chung
- Tại máy nhận, tầng này làm nhiệm vụ dịch dữ liệu từ dạng format cung sang định dạng của tầng ứng dụng

## 5. Một số giao thức trong tầng trình diễn:
### 5.1 SSL (Secure Sockets Layer): 
Là 1 tiêu chuẩn công nghệ bảo mật mã hóa thông tin liên lạc giữa máy chủ web và trình duyệt. Tiêu chuẩn này hoạt động và đảm bảo rằng dữ liệu được truyền giữa máy chủ và trình duyệt của người dùng là riêng tư và đầy đủ.
### 5.2 TLS (Transport Layer Security): 
Đây là thế hệ sau của SSL, một giao thức mật mã được thiết kế để cung cấp thông tin liên lạc an toàn qua mạng máy tính
### 5.3 XML (eXtensible Markup Language):
Giao thức sử dụng để lưu trữ và truyền tải dữ liệu dưới dạng văn bản, cho phép các ứng dụng khác nhau dễ dàng trao đổi thông tin qua mạng
### 5.4 MIDI (Musical Instrument Digital Interface): 
Giao thức kỹ thuật cho phép các thiết bị âm nhạc kỹ thuật số như keyboard, synthesizer, máy thu âm tương tác với nhau và giao tiếp với máy tính
### 5.5 ASCII (American Standard Code for Information Interchange):
Được sử dụng để mã hóa và truyền thông tin dưới dạng ký tự.
### 5.6EBCDIC (Extended Binary Coded Decimal Interchange Code): \
Được sử dụng trong hệ thống máy tính của IBM và máy tính mainframe, mã hóa các ký tự trong hệ thống này.
### 5.7 MIME (Multipurpose Internet Mail Extensions): 
Sử dụng để mở rộng khả năng của email để có thể chuyển tải các loại dữ liệu đa phương tiện như hình ảnh, âm thanh, video
## 6. Một số định dạng video 
- File AVI(Audio Video Interleave): AVI là file không nén --> cho ra chất lượng video, âm thanh tốt, hình ảnh rõ nét hơn các file khác
- File WMV(Windows Media Video): Định dạng file được sử dụng rộng rãi trên mạng nhờ chất lượng hình ảnh tốt, kích thước nhỏ, giúp người dùng dễ tải, chia sẻ qua email
- File MP4(Moving Pictures Expert Group 4): Là định dạng được sử dụng phổ biến. Được ưa chuộng bởi sự tương thích cao, đa số trình xem video đều sử dụng được. Chất lượng hình ảnh đẹp nhưng 0 bằng so với file AVI

## 7. Các định dạng audio
- File MP3(Motion Pictures Expert Group 1 Layer 3): Là file âm thanh được tạo bằng cách cắt các dải âm thanh có âm sắc cao và thấp bằng cách nén âm thanh. Là file được sử dụng phổ biến vì nó nhẹ, dễ tải, dễ chia sẻ. Nhược điểm của nó là sẽ cho chất lượng âm thanh thấp so với bản gốc
- File WAV(WaveForm Audio File Format): nặng nhưng chất lượng âm thanh tốt
- File WMA(Windows Media Audio): định dạng độc quyền do Windows phát triển để cạnh tranh với MP3. Tuy kích thước file WMA < MP3 nhưng lại cho chất lượng tương đương. Nhưng do tính chất độc quyền nên nó bị giới hạn các thiết bị sử dụng

## 8. Các định dạng ảnh
- JPEG(Joint Photographic Expert Group) và JPG: là những loại tệp được sử dụng phổ biến trên internet. Một trong những nhược điểm là chất lượng hình ảnh giảm khi kích thước tệp giảm
- PNG(Portable Network Graphics): là định dạng mà ng dùng có thể chỉnh sửa nhưng hình ảnh không bị giảm về mặt chất lượng. PNG được sử dụng trong hầu hết các dự án Web vì nó cho phép lưu hình ảnh này với nhiều màu sắc hơn trên nền trong suốt. Điều này giúp cho chất lượng hình ảnh trên web sắc nét hơn rất nhiều. Tuy nhiên người ta không dùng để in vì thường hình ảnh sẽ có độ phân giải thấp
- GIF(Graphics Interchanger Fomart): Phổ biến nhất ở dạng hình động. Ở dạng tối giản nhất, GIF được tạo từ tối đa 256 màu 

