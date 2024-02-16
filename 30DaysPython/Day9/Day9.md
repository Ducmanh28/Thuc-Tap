# Day 9
## Điều kiện
Theo mặc định, các câu lệnh trong tập lệnh Python được thực thi tuần tự từ trên xuống dưới. Nếu logic xử lý yêu cầu như vậy, luồng thực thi tuần tự có thể được thay đổi theo hai cách:

- Thực thi có điều kiện: một khối gồm một hoặc nhiều câu lệnh sẽ được thực thi nếu một biểu thức nhất định là đúng
- Thực thi lặp đi lặp lại: một khối gồm một hoặc nhiều câu lệnh sẽ được thực thi lặp đi lặp lại miễn là một biểu thức nhất định là đúng. Trong phần này, chúng tôi sẽ đề cập đến nếu, khác, các tuyên bố elif. Các toán tử so sánh và logic mà chúng ta đã học được trong các phần trước sẽ hữu ích ở đây.
## Nếu điều kiện
Trong python và các ngôn ngữ lập trình khác, từ khóa if được sử dụng để kiểm tra xem một điều kiện có đúng hay không và để thực thi mã khối. Hãy nhớ vết lõm sau dấu hai chấm.
```
# syntax
if condition:
    this part of code runs for truthy conditions
```
Ví dụ: 
```
a = 3
if a > 0:
    print('A is a positive number')
# A is a positive number
```
Như bạn có thể thấy trong ví dụ trên, 3 lớn hơn 0. Điều kiện là đúng và mã khối đã được thực thi. Tuy nhiên, nếu điều kiện là sai, chúng tôi không thấy kết quả. Để xem kết quả của điều kiện giả dối, chúng ta nên có một khối khác, sẽ là khối khác.

## Nếu khác
Nếu điều kiện là true, khối đầu tiên sẽ được thực thi, nếu không điều kiện khác sẽ chạy.
```
# syntax
if condition:
    this part of code runs for truthy conditions
else:
     this part of code runs for false conditions
```
**Ví dụ:**
```
a = 3
if a < 0:
    print('A is a negative number')
else:
    print('A is a positive number')
```
Điều kiện trên chứng minh sai, do đó khối khác đã được thực thi. Làm thế nào về nếu tình trạng của chúng tôi nhiều hơn hai? Chúng ta có thể sử dụng _ elif_.

## Nếu Elif khác
Trong cuộc sống hàng ngày, chúng ta đưa ra quyết định hàng ngày. Chúng tôi đưa ra quyết định không phải bằng cách kiểm tra một hoặc hai điều kiện mà bằng nhiều điều kiện. Tương tự như cuộc sống, lập trình cũng có đầy đủ các điều kiện. Chúng tôi sử dụng elif khi chúng tôi có nhiều điều kiện.
```
# syntax
if condition:
    code
elif condition:
    code
else:
    code
```
**Ví dụ:**
```
a = 0
if a > 0:
    print('A is a positive number')
elif a < 0:
    print('A is a negative number')
else:
    print('A is zero')
```
## Dieu kien ngắn
```
# syntax
code if condition else code
```
**Ví dụ:**
```
a = 3
print('A is positive') if a > 0 else print('A is negative') # first condition met, 'A is positive' will be printed
```
## Điều kiện lồng nhau
Điều kiện có thể được lồng nhau
```
# syntax
if condition:
    code
    if condition:
    code
```
**Ví dụ:**
```
a = 0
if a > 0:
    if a % 2 == 0:
        print('A is a positive and even integer')
    else:
        print('A is a positive number')
elif a == 0:
    print('A is zero')
else:
    print('A is a negative number')
```
Chúng ta có thể tránh viết điều kiện lồng nhau bằng cách sử dụng toán tử logic và.

## Nếu điều kiện và toán tử logic
```
# syntax
if condition and condition:
    code
```
**Ví dụ:**
```
a = 0
if a > 0 and a % 2 == 0:
        print('A is an even and positive integer')
elif a > 0 and a % 2 !=  0:
     print('A is a positive integer')
elif a == 0:
    print('A is zero')
else:
    print('A is negative')
```
## Toán tử if và hoặc logic
```
# syntax
if condition or condition:
    code
```
**Ví dụ:**
```
user = 'James'
access_level = 3
if user == 'admin' or access_level >= 4:
        print('Access granted!')
else:
    print('Access denied!')
```