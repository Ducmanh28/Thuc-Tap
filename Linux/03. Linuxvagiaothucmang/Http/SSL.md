# Mục này tìm hiểu về SSL
## SSL là gì
SSL là viết tắt của Secure Sockets Layer, nó là một công nghệ tiêu chuẩn cho phép thiết lập kết nối được mã hóa an toàn giữa máy chủ web(host) và trình duyệt web ở trên máy client. 

Kết nối này sẽ đảm bảo rằng dữ liệu được truyền giữa host và client được duy trì một cách riêng tư, đáng tin cậy. 

SSL hiện nay đã được sử dụng bởi hàng triệu trang web để bảo về các giao dịch trực tuyến của họ với khách hàng.

Có thể nói rằng, SSL giống như một xương sống trong việc đảm bảo an toàn trên Internet. Nó giúp bảo vệ những thông tin nhạy cảm khi chúng được truyền qua mạng máy tính trên thế giới.

## SSL dùng để làm gì?
SSL được sử dụng để bảo vệ dữ liệu được truyền giữa người dùng và trang web, hoặc giữa 2 hệ thống. Nó đảm bảo dữ liệu được truyền giữa máy chủ và máy khách đều được giữ riêng tư và an toàn. SSL sẽ cung cấp các chức năng chính như sau:
- Mã hóa(Encryption): Dữ liệu sẽ được mã hóa để ngăn chặn việc có bên thứ 3 đọc được trong quá trình truyền tải.
- Tính toàn vẹn dữ liệu(Data Integrity): Đảm bảo rằng dữ liệu không bị thay đổi hoặc làm sai lệch trong quá trình truyền tải
- Xác thực(Authentication): Xác minh rằng bạn đang giao tiếp với máy chủ đúng và không phải là một kẻ mạo danh

## Cấu tạo của SSL:
SSL sẽ bao gồm các thành phần sau:
- Chứng chỉ SSL(SSL Certificate): Có 2 kiểu chứng chỉ SSL. Một là chứng chỉ SSL Local(Chứng chỉ tự kí). Kiểu còn lại là Certìicate Authority - CA(Chứng chỉ được cấp).
- Khóa công khai và riêng tư: Khóa công khai được chia sẻ với mọi người và được sử dụng để mã hóa dữ liệu. Khóa riêng tư được giữ bởi máy chủ và được dùng để giải mã dữ liệu.
- Phiên bản SSL: Có nhiều phiên bản SSL. Mỗi phiên bản có một mức độ bảo mật khác nhau. Ngày nay, nó đã tiến hóa thành TLS.