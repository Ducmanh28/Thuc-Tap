# Day 2: Hàm có sẵn và biến
## Hàm có sẵn
Cũng như C++, C,... Python cũng sở hữu các hàm được tích hợp sẵn - nghĩa là Bạn có thể sử dụng mà không cần phải thiết lập hay cấu hình. 

Một số hàm được sử dụng phổ biến như:
- `print()` để in ra giá trị
- `type()` để kiểm tra kiểu dữ liệu
- `len()` để đếm số chữ
- `int()` dữ liệu kiểu số nguyên
- `float()` dữ liệu kiểu số thập phân
- `min()` tìm giá trị nhỏ nhất 
- `max()` tìm giá trị lớn nhất
- `input()` lấy dữ liệu người dùng nhập vào
- .........

Dưới đây là các hàm có sẵn ở Python, hoặc bạn có thể tham khảo tại [đây](https://docs.python.org/3.9/library/functions.html)

![](/Anh/Screenshot_433.png)

Mỗi hàm sẽ có chức năng khác nhau, các dữ liệu đầu vào khác nhau dựa trên kiểu hàm và giá trị trả về của hàm(nếu có). Trong quá trình tìm hiểu, chúng ta sẽ lần lượt sử dụng các hàm này. Không những thế, sau này chúng ta cũng có thể tự tạo ra hàm của riêng mình.

## Biến
### Biến là gì?
- Biến là tên của một vùng trong bộ nhớ RAM, được dùng để lưu trữ dữ liệu.
- Chúng ta gán thông tin cho một biến để nó lưu trữ, sau đó có thể lấy ra sử dụng trong các dòng code tiếp theo.
- Biến có thể lưu trữ nhiều kiểu dữ liệu như số, chuỗi ký tự, mảng, tập hợp, v.v.

### Quy tắc đặt tên biến:
- Tên của biến phải bắt đầu bằng một chữ hoặc một ký tự gạch dưới (_)
- Không thể bắt đầu tên biến bằng một con số
- Trong tên biến, có thể sử dụng số, chữ và dấu gạch dưới
- Tên biến phải là duy nhất và không trùng lặp với tên của các biến khác trong cùng một phạm vi làm việc
- Tên biến phân biệt chữ hoa và chữ thường

### Khai báo biến
Các biến không tự động có sẵn. Muốn máy tính biết được biến này ở đâu, chứa nội dung gì, kiểu dữ liệu gì thì chúng ta phải thực hiện khai báo biến. Khi chúng ta gán một kiểu dữ liệu nhất định cho một biến, nó được gọi là khai báo biến
- Vậy gán ở đây là gì? Gán có nghĩa là lưu trữ dữ liệu trong biến. Dấu bằng trong Python không phải là đẳng thức như trong Toán học mà nó chính là toán tử **gán**
- Dưới đây sẽ là một số ví dụ về gán biến và đặt tên biến hợp quy định
```
name = "Duc Manh"
age = 21
is_married = False
num1 = 10
_if 
```
- Đặt tên biến không hợp lệ:
```
first-name
first@name
first$name
num-1
1num
```

Bạn cũng có thể khai báo nhiều biến trong một dòng
```
first_name, last_name, country, age, is_married = 'Asabeneh', 'Yetayeh', 'Helsink', 250, True
```
Sử dụng cùng với hàm nhập giá trị đầu vào `input()`
```
name = input("What is your name?")
```
Kết quả:

![](/Anh/Screenshot_436.png)

## Kiểu dữ liệu
Trong Python cũng như các ngôn ngữ lập trình khác, một biến luôn có kiểu dữ liệu. Một số kiểu dữ liệu cơ bản trong Python:

- int: đây là kiểu dữ liệu được dùng để lưu trữ các số nguyên (1, 2, 3, 4, ...).
- float: đây là kiểu dữ liệu dùng để lưu trữ các biến kiểu số thực (1.43, 5.34, 3.333, ...).
- bool: đây là kiểu dữ liệu dùng để lưu trữ các giá trị luận lý (True hoặc False)
- str: đây là kiểu dữ liệu dùng để lưu trữ các xâu ký tự ("Viet Nam", "Codelearn", ...)
- Ngoài ra trong Python còn một số kiểu dữ liệu khác như list, set, dict, tuple, complex nhưng chưa cần quan tâm tới các kiêu dữ liệu này vội. Các kiểu dữ liệu này sẽ được sử dụng trong các ngày tiếp theo.

Để kiểm tra kiểu dữ liệu của biến, bạn có thể sử dụng hàm type(). Ví dụ:
```
name = "DucManh"
date_of_birth = 28
pi = 3.14

print(type(name))
print(type(date_of_birth))
print(type(pi))
```
Kết quả sẽ hiển thị như sau:
```
<class 'str'>
<class 'int'>
<class 'float'>
```

Chuyển đổi kiểu dữ liệu:
- Chúng ta có thể chuyển kiểu dữ liệu bằng cách dùng các hàm dữ liệu như `int()`, `string()`, `float()`,...
- Ví dụ nhé
```
# int to float
num_int = 10
print('num_int',num_int)         # 10
num_float = float(num_int)
print('num_float:', num_float)   # 10.0
```