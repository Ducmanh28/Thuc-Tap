# Ngày 14
## Hàm nâng cao
Trong Python, hàm được coi là các lớp hạng nhất, hàm cho phép bạn thực hiện những điều sau:
- Một hàm có thể lấy một hoặc nhiều hàm làm tham số
- Một hàm có thể được trả về như là kết quả của một hàm khác
- Một chức năng có thể được sửa đổi
- Một hàm có thể được gán cho một biến

## Hàm có chức năng như một tham số
```
def sum_numbers(nums):  # Hàm bình thường
    return sum(nums)    # Một hàm lạm dụng hàm tổng tích hợp

def higher_order_function(f, lst):  # hàm như một tham số
    summation = f(lst)
    return summation
result = higher_order_function(sum_numbers, [1, 2, 3, 4, 5])
print(result)       # 15
```

## Hàm có chức năng như một giá trị trả về
```
def square(x):          # a square function
    return x ** 2

def cube(x):            # a cube function
    return x ** 3

def absolute(x):        # an absolute value function
    if x >= 0:
        return x
    else:
        return -(x)

def higher_order_function(type): # a higher order function returning a function
    if type == 'square':
        return square
    elif type == 'cube':
        return cube
    elif type == 'absolute':
        return absolute

result = higher_order_function('square')
print(result(3))       
# 9
result = higher_order_function('cube')
print(result(3))       
# 27
result = higher_order_function('absolute')
print(result(-3))      
# 3
```

## Hàm lồng nhau
Python cho phép một hàm lồng nhau truy cập vào phạm vi bên ngoài của hàm bao quanh. Điều này được gọi là Đóng cửa. Chúng ta hãy xem cách đóng cửa hoạt động trong Python. Trong Python, closure được tạo ra bằng cách lồng một hàm vào bên trong một hàm đóng gói khác và sau đó trả về hàm bên trong. 
```
def add_ten():
    ten = 10
    def add(num):
        return num + ten
    return add

closure_result = add_ten()
print(closure_result(5))  # 15
print(closure_result(10))  # 20
```

## Tính trang trí
Trình trang trí là một mẫu thiết kế trong Python cho phép người dùng thêm chức năng mới vào một đối tượng hiện có mà không cần sửa đổi cấu trúc của nó. Người trang trí thường được gọi trước định nghĩa của một chức năng bạn muốn trang trí.
### Tạo trang trí
Để tạo một chức năng trang trí, chúng ta cần một chức năng bên ngoài với chức năng bao bọc bên trong.
```
# Normal function
def greeting():
    return 'Welcome to Python'
def uppercase_decorator(function):
    def wrapper():
        func = function()
        make_uppercase = func.upper()
        return make_uppercase
    return wrapper
g = uppercase_decorator(greeting)
print(g())          # WELCOME TO PYTHON

## Let us implement the example above with a decorator

'''This decorator function is a higher order function
that takes a function as a parameter'''
def uppercase_decorator(function):
    def wrapper():
        func = function()
        make_uppercase = func.upper()
        return make_uppercase
    return wrapper
@uppercase_decorator
def greeting():
    return 'Welcome to Python'
print(greeting())   # WELCOME TO PYTHON
```
### Áp dụng nhiều trang trí cho một hàm duy nhất
```
#Các chức năng trang trí này là các chức năng bậc cao hơn
lấy các hàm làm tham số
# First Decorator
def uppercase_decorator(function):
    def wrapper():
        func = function()
        make_uppercase = func.upper()
        return make_uppercase
    return wrapper

# Second decorator
def split_string_decorator(function):
    def wrapper():
        func = function()
        splitted_string = func.split()
        return splitted_string

    return wrapper

@split_string_decorator
@uppercase_decorator     # order with decorators is important in this case - .upper() function does not work with lists
def greeting():
    return 'Welcome to Python'
print(greeting())   # WELCOME TO PYTHON
```
### Các tham số trong hàm trang trí
Hầu hết thời gian chúng ta cần các hàm của mình để lấy các tham số, vì vậy chúng ta có thể cần xác định một trình trang trí chấp nhận các tham số.
```
def decorator_with_parameters(function):
    def wrapper_accepting_parameters(para1, para2, para3):
        function(para1, para2, para3)
        print("I live in {}".format(para3))
    return wrapper_accepting_parameters

@decorator_with_parameters
def print_full_name(first_name, last_name, country):
    print("I am {} {}. I love to teach.".format(
        first_name, last_name, country))

print_full_name("Asabeneh", "Yetayeh",'Finland')
```
## Các hàm bậc cao được tích hợp sẵn
Một số hàm bậc cao hơn được tích hợp sẵn mà đã được đề cập trong phần này là map(), lọc và giảm. Hàm Lambda có thể được chuyển dưới dạng tham số và trường hợp sử dụng tốt nhất của hàm lambda là ở các hàm như ánh xạ, lọc và giảm.
### Python - Hàm map()
Hàm map() là một hàm tích hợp sẵn lấy một hàm và có thể lặp lại làm tham số.
```
map(function, iterable)
```
Một số ví dụ:
```
numbers = [1, 2, 3, 4, 5] # iterable
def square(x):
    return x ** 2
numbers_squared = map(square, numbers)
print(list(numbers_squared))    # [1, 4, 9, 16, 25]
# Lets apply it with a lambda function
numbers_squared = map(lambda x : x ** 2, numbers)
print(list(numbers_squared))    # [1, 4, 9, 16, 25]
```

```
numbers_str = ['1', '2', '3', '4', '5']  # iterable
numbers_int = map(int, numbers_str)
print(list(numbers_int))    # [1, 2, 3, 4, 5]
```

```
names = ['Asabeneh', 'Lidiya', 'Ermias', 'Abraham']  # iterable

def change_to_upper(name):
    return name.upper()

names_upper_cased = map(change_to_upper, names)
print(list(names_upper_cased))    # ['ASABENEH', 'LIDIYA', 'ERMIAS', 'ABRAHAM']

# Let us apply it with a lambda function
names_upper_cased = map(lambda name: name.upper(), names)
print(list(names_upper_cased))    # ['ASABENEH', 'LIDIYA', 'ERMIAS', 'ABRAHAM']
```
Những gì bản đồ thực sự làm là lặp lại trên một danh sách
### Python - Hàm filter()
Hàm filter() gọi hàm được chỉ định trả về boolean cho mỗi mục của iterable (danh sách) được chỉ định. Nó lọc các mục đáp ứng các tiêu chí lọc.
```
filter(function, iterable)
```
Một số ví dụ:
```
# Lets filter only even nubers
numbers = [1, 2, 3, 4, 5]  # iterable

def is_even(num):
    if num % 2 == 0:
        return True
    return False

even_numbers = filter(is_even, numbers)
print(list(even_numbers))       # [2, 4]
```
```
numbers = [1, 2, 3, 4, 5]  # iterable

def is_odd(num):
    if num % 2 != 0:
        return True
    return False

odd_numbers = filter(is_odd, numbers)
print(list(odd_numbers))       # [1, 3, 5]
```
```
# Filter long name
names = ['Asabeneh', 'Lidiya', 'Ermias', 'Abraham']  # iterable
def is_name_long(name):
    if len(name) > 7:
        return True
    return False

long_names = filter(is_name_long, names)
print(list(long_names))         # ['Asabeneh']
```

### Python - Hàm reduce()
Hàm reduce() được định nghĩa trong mô-đun functools và chúng ta nên nhập nó từ mô-đun này. Giống như bản đồ và bộ lọc, nó có hai tham số, một hàm và một lần lặp. Tuy nhiên, nó không trả về một lần lặp khác, thay vào đó nó trả về một giá trị duy nhất
```
numbers_str = ['1', '2', '3', '4', '5']  # iterable
def add_two_nums(x, y):
    return int(x) + int(y)

total = reduce(add_two_nums, numbers_str)
print(total)    # 15
```