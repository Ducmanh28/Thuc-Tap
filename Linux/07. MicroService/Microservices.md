# Microservices

## 1. MicroServices là gì?
Hiểu theo nghĩa đơn giản, MicroService là 1 kiểu kiến trúc phần mềm, trong đó 1 ứng dụng sẽ được cấu hình thành tập hợp các dịch vụ nhỏ, độc lập với nhau.

Mỗi dịch vụ sẽ đảm nhiệm 1 chức năng riêng, có thể phát triển, triển khai, mở rộng và cập nhật mà không gây ảnh hưởng tới dịch vụ khác.

Các dịch vụ này thường giao tiếp qua mạng (API hoặc message queue), có thể sử dụng ngôn ngữ lập trình và cơ sở dữ liệu khác nhau và thường được đóng gói, triển khai phân tán trên nhiều servers hoặc container.

## 2. Monolith Application
Là một kiểu kiến trúc phần mềm mà ở đó toàn bộ ứng dụng được xây dựng, phát triển, triển khai trên 1 thực thể duy nhất.

Tất cả thành phần chức năng của ứng dụng như giao diện, cơ sở dữ liệu, logic nghiệp vụ,... đều được đóng gói và liên kết chặt chẽ trong một mã nguồn hoặc 1 đơn vị triển khai duy nhất.

Các module trong Monolith Application liên kết chặt chẽ với nhau, vì vậy mà mọi sự thay đỏi, bảo trì, cập nhật đều phải thực hiện trên toàn bộ hệ thống, dẫn đến việc 1 thay đổi nhỏ cũng sẽ ảnh hưởng tới toàn bộ ứng dụng.

## 3. So sánh
|**Tiêu chí**|**MicroServices**|**Monolith**|
|--|--|--|
|**Cấu trúc**|Ứng dụng chia thành nhiều dịch vụ nhỏ, chức năng riêng biệt|Ứng dụng là 1 khối code lớn triển khai đồng thời mọi chức năng|
|**Triển khai**|Mỗi dịch vụ có thể triển khai và cập nhật riêng lẻ|Cần triển khai lại toàn bộ ứng dụng khi có sự thay đổi|
|**Quản lý lỗi**|Lỗi chỉ ảnh hưởng tới dịch vụ đó, hệ thống vẫn có thể hoạt động bình thường|Lỗi ở bất kỳ phần nào có thể gây sập toàn bộ hệ thống|
|**Tính mở rộng**|Mở rộng từng dịch vụ độc lập, tiết kiệm tài nguyên|Mở rộng toàn bộ hệ thống|
|**Công nghệ sử dụng**|Mỗi dịch vụ có thể dùng 1 công nghệ khác nhau|Sử dụng chung cho toàn bộ hệ thống|
|**Phát triển và bảo trì**|Nhiều nhóm phát triển độc lập|Nhóm phải phối hợp chặt chẽ|
|**Kiểm thử**|Phức tạp vì phải kiểm thử từng dịch vụ nhỏ lẻ|Kiểm thử toàn bộ hệ thống|
|**Phụ thuộc**|Ít phụ thuộc vì các nhóm có thể làm việc độc lập|Phụ thuộc chặt chẽ vào nhau|
|**Chi phí bảo trì**|Dễ bảo trì dịch vụ riêng, đòi hỏi có công cụ giám sát|Đơn giản khi ứng dụng nhỏ, khó mở rộng khi lớn|
|**Kiểm soát lỗi**|Dùng chiến lược như Circuit Breaker để giảm rủi ro|Lỗi nhỏ cũng có thể ảnh hưởng tới toàn bộ hệ thống|
|**Hiệu suất**|Tối ưu riêng từng dịch vụ theo nhu cầu|Khó tối ưu tổng thể do tài nguyên chia sẻ|
|**Độ phức tạp**|Quản lý phức tạp, đòi hỏi DevOps phải giám sát chuyên sâu|Đơn giản lúc đầu, khó khi muốn mở rộng|
|**Tính linh hoạt**|Linh hoạt thêm hoặc loại bỏ dịch vụ độc lập|Thay đổi sẽ ảnh hưởng tới toàn hệ thống|
|**Nhất quán dữ liệu**|Đồng bộ qua API hoặc message queue|Dữ liệu nằm chung trong hệ thống|
|**Độ tin cậy**|Lỗi dịch vụ sẽ không làm sập hệ thống|Lỗi bất kỳ ở đâu cũng đều có thể gây sập hệ thống|
|--|--|--|

## 4. Vậy kiến trúc MicroService là gì?
Nó được xác định bởi 1 tập hợp các đặc điểm chung mà hầu hết các kiến trúc hiện nay có:
- Phân tách ứng dụng thành các dịch vụ
- Tổ chức xoay quanh năng lực nghiệp vụ
- Quản trị phi tập chung
- Thiết kế để chịu lỗi
- Thiết kế có khả năng tiến hóa
- Giao tiếp thông minh, cơ chế đơn giản

## 5. Ưu và nhược điểm
**Ưu điểm**:
- Dễ mở rộng quy mô
- Khả năng chịu lỗi cao
- Dễ hiểu và quản lý codebase
- Cho phép thử nghiệm và sử dụng công nghệ đa dạng
- Triển khai độc lập
- Hỗ trợ tự động hóa quy trình

**Nhược điểm**:
- Giao tiếp phức tạp giữa các dịch vụ dễ gặp lỗi
- Tăng yêu cầu tài nguyên
- Khó khăn trong test và debug toàn cục
- Phức tạp trong quản lý hệ thống
- Không phù hợp với các ứng dụng nhỏ

## 6. Khi nào thì nên sử dụng MicroService
Để tối ưu trong việc sử dụng MicroService thì chúng ta nên sử dụng trong các trường hợp sau:
- Phát triển ứng dụng Native, App/Web/Mobile lớn hoặc cần mở rộng liên tục
- Xây dựng và thiết kế Web API
- Tích hợp với các hệ thống bên ngoài hoặc module IoT
- Yêu cầu cập nhật, bảo trì, thử nghiệm và ra mắt sản phẩm liên tục
- Hệ thống đang gặp khó khăn với monolithic

## 7. Một số lưu ý khi sử dụng
Để tối ưu trong việc sử dụng MicroService, có một số nguyên tắc cần tuân theo:
- Nguyên tắc Single Responsibility (SRP)
- Phân chia dịch vụ dựa trên logic nghiệp vụ thực tế
- Đảm bảo khả năng phát triển và triển khai độc lập
- Thiết kế hướng nghiệp vụ, tránh tạo dịch vụ nhỏ chỉ để phục vụ kiến trúc
- Xác định kích thước hợp lý cho mỗi microservice
- Giữ interface giao tiếp đơn giản, rõ ràng