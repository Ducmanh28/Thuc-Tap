# Ngày 13
## List Comprehension là gì?
Trong Python, list comprehension là một cách ngắn gọn và mạnh mẽ để tạo ra danh sách mới từ một danh sách hiện có hoặc một dãy số. Nó cho phép bạn tạo danh sách mới bằng cách áp dụng một biểu thức cho mỗi phần tử của danh sách hiện có hoặc một dãy số và lọc các phần tử theo một điều kiện nếu cần.
```
[i for i in iterable if expression]
```
**Ví dụ 1: Bạn muốn thay đổi một chuỗi thành danh sách các ký tự**
- Cách 1
```
language = 'Python'
lst = list(language) # changing the string to list
print(type(lst))     # list
print(lst)           # ['P', 'y', 't', 'h', 'o', 'n']
```
- Cách 2
```
lst = [i for i in language]
print(type(lst)) # list
print(lst)       # ['P', 'y', 't', 'h', 'o', 'n']
```

**Ví dụ 2: Bạn muốn tạo danh sách các số**
```
# Tạo danh sách số từ 0 đến 10
numbers = [i for i in range(11)]  
print(numbers)                    
# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Có thể chèn thêm biểu thức toán học
squares = [i * i for i in range(11)]
print(squares)                    
# [0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

# Cũng có thể lập một danh sách các bộ số
numbers = [(i, i * i) for i in range(11)]
print(numbers)                             
# [(0, 0), (1, 1), (2, 4), (3, 9), (4, 16), (5, 25)]
```

**Ví dụ 3: Có thể được kết hợp với biểu thức IF**
```
# Tạo danh sách số chẵn
even_numbers = [i for i in range(21) if i % 2 == 0]  
print(even_numbers)                    
# [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

# Tạo danh sách số lẻ
odd_numbers = [i for i in range(21) if i % 2 != 0]  
print(odd_numbers)                      
# [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]

# Lọc số
numbers = [-8, -7, -3, -1, 0, 1, 3, 4, 5, 7, 6, 8, 10]
positive_even_numbers = [i for i in range(21) if i % 2 == 0 and i > 0]
print(positive_even_numbers)                    
# [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

# Gộp 3 mảng
list_of_lists = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
flattened_list = [ number for row in list_of_lists for number in row]
print(flattened_list)   
# [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

## Hàm Lambda
Hàm Lambda là một hàm ẩn danh nhỏ không có tên. Nó có thể có đầu vào là bất kỳ số lượng đối số nào, nhưng chỉ có thể có một biểu thức. 

Hàm Lambda tương tự như các hàm ẩn danh trong JavaScript. Chúng ta cần nó khi chúng ta muốn viết một hàm ẩn danh bên trong một hàm khác.

### Cách tạo hàm Lambda 
Để tạo hàm lambda, chúng tôi sử dụng từ khóa `lambda`, theo sau là (các) tham số, theo sau là biểu thức. Hàm Lambda không sử dụng return nhưng trả về biểu thức một cách rõ ràng.
```
x = lambda param1, param2, param3: param1 + param2 + param2
print(x(arg1, arg2, arg3))
```
Ví dụ:
```
# Hàm bình thường
def add_two_nums(a, b):
    return a + b
print(add_two_nums(2, 3))     
# 5
# ------------------------------------------------------------
# Đổi hàm trên thành hàm lambda
add_two_nums = lambda a, b: a + b
print(add_two_nums(2,3))    
# 5

# Tự gọi
(lambda a, b: a + b)(2,3) 
# 5 

square = lambda x : x ** 2
print(square(3))    # 9
cube = lambda x : x ** 3
print(cube(3))    # 27

# Nhiều biến
multiple_variable = lambda a, b, c: a ** 2 - 3 * b + 4 * c
print(multiple_variable(5, 5, 3)) # 22
```
### Hàm Lambda bên trong một hàm khác
Sử dụng hàm Lambda bên trong một hàm khác:
```
def power(x):
    return lambda n : x ** n

cube = power(2)(3)   # function power now need 2 arguments to run, in separate rounded brackets
print(cube)          # 8
two_power_of_five = power(2)(5) 
print(two_power_of_five)  # 32
```
