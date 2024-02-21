# Ngày 11: Hàm trong Python

## Hàm là gì?
Một hàm là một khối mã hoặc câu lệnh lập trình có thể tái sử dụng được thiết kế để thực hiện một tác vụ nhất định. Để định nghĩa hoặc khai báo một hàm, Python cung cấp từ khóa *def*. Sau đây là cú pháp để xác định một hàm. Khối hàm của mã chỉ được thực thi nếu hàm được gọi hoặc gọi.
```
# Khai báo hàm
def tên_hàm():
    codes...
    codes...
# Gọi hàm:
tên_hàm()
```
### Hàm không có tham số
Hàm có thể được khai báo mà không có tham số:

Ví dụ:
```
def tạo_tên_đầy_đủ():
    first_name = 'Luong'
    last_name = 'Manh'
    space = ' '
    full_name = first_name + space + last_name
    print(full_name)
tạo_tên_đầy_đủ()
# Kết quả in ra: Luong Manh
```
### Hàm trả về một giá trị -P1:
Hàm cũng có thể trả về các giá trị, nếu một hàm không có câu lệnh trả về, giá trị của hàm là None. Từ bây giờ, chúng ta nhận được một giá trị từ một hàm khi chúng ta gọi hàm và in nó.

Ví dụ:
```
def tạo_tên_đầy_đủ():
    first_name = 'Luong'
    last_name = 'Manh'
    space = ' '
    full_name = first_name + space + last_name
    return fullname
print(tạo_tên_đầy_đủ())

# Kết quả in ra: Luong Manh
```
### Hàm có chứa tham số
Trong một hàm, chúng ta có thể truyền các kiểu dữ liệu khác nhau (số, chuỗi, boolean, danh sách, tuple, từ điển hoặc tập hợp) dưới dạng tham số
- Tham số đơn: Nếu hàm của chúng ta lấy một tham số, chúng ta nên gọi hàm của chúng ta bằng một đối số
```
def tên_hàm(tham số):
    codes 
    codes

tên_hàm(đối số)
```
**Ví dụ:**
```
def cong(number):
    return 1 + number

print(cong(90))
# Kết quả 91
```

- Hai tham số: Một hàm có thể có hoặc không có tham số hoặc tham số. Một hàm cũng có thể có hai hoặc nhiều tham số. Nếu hàm của chúng ta lấy tham số, chúng ta nên gọi nó bằng các đối số. Kiểm tra một hàm với hai tham số:
```
def tên_hàm(number1,number2)
    codes
    codes
    ...

tên_hàm(number1,number2)
```

**Ví dụ:**
```
def Nhan(a,b)
    return a*b

print(Nhan(9,5))
# Kết quả: 45
```
- Lưu ý: Khi khoá các giá trị: Nếu chúng ta truyền các đối số với khóa và giá trị, thứ tự của các đối số không quan trọng.
```
def axb(a,b):
    code
    code

axb(b=5,a=6)
```
**Ví dụ:**
```
def axb(a,b)
    return a*b

print(axb(b=8,a=5))
# Kết quả in ra: 40
```
### Hàm trả về một giá trị-P2:
Nếu chúng ta không trả về một giá trị với một hàm, thì hàm của chúng ta sẽ trả về *Không* theo mặc định. Để trả về một giá trị với một hàm, chúng ta sử dụng từ khóa return theo sau là biến chúng ta đang trả về. Chúng ta có thể trả về bất kỳ loại kiểu dữ liệu nào từ một hàm.
- Trả về chuỗi: 
```
def print_name(firstname):
    return firstname
print_name('Asabeneh') # Asabeneh

def print_full_name(firstname, lastname):
    space = ' '
    full_name = firstname  + space + lastname
    return full_name
print_full_name(firstname='Asabeneh', lastname='Yetayeh')
```
- Trả về một số:
```
def add_two_numbers (num1, num2):
    total = num1 + num2
    return total
print(add_two_numbers(2, 3))

def calculate_age (current_year, birth_year):
    age = current_year - birth_year
    return age;
print('Age: ', calculate_age(2019, 1819))
```
- Trả về một boolean:
```
def is_even (n):
    if n % 2 == 0:
        print('even')
        return True    # return stops further execution of the function, similar to break 
    return False
print(is_even(10)) # True
print(is_even(7)) # False
```
- Trả về danh sách:
```
def find_even_numbers(n):
    evens = []
    for i in range(n + 1):
        if i % 2 == 0:
            evens.append(i)
    return evens
print(find_even_numbers(10))
```
### Hàm với các tham số mặc định
Đôi khi chúng ta truyền các giá trị mặc định vào các tham số, khi chúng ta gọi hàm. Nếu chúng ta không truyền các đối số khi gọi hàm, các giá trị mặc định của chúng sẽ được sử dụng.
```
def tên_hàm(a = 5):
    code
    code

tên_hàm()
tên_hàm(10)
```
Ví dụ:
```
def tonga(a = 5):
    print a + 10 

tonga()
# Kết quả 15
tonga(10)
# Kết quả 20
```
### Số lượng đối số tuỳ ý
Nếu chúng ta không biết số lượng đối số mà chúng ta truyền vào hàm của mình, chúng ta có thể tạo một hàm có thể lấy số lượng đối số tùy ý bằng cách thêm `*` trước tên tham số.
```
def tinh_tong(*nums):
    total = 0
    for num in nums:
        total+=num
    return total

print(tinh_tong(1,2,3,4,5))
# Kết quả: 15
```

### Hàm là tham số của một hàm khác
Một hàm có thể đóng vai trò là một tham số của hàm khác
```
def square_number (n):
    return n * n
def do_something(f, x):
    return f(x)
print(do_something(square_number, 3)) 

# Kết quả 27
```

## Bài tập:
### 1. Khai báo một hàm add_two_numbers. Nó mất hai tham số và nó trả về một tổng.
```
def add_two_numbers(a,b):
    return a+b
```

### 2. Khai báo một hàm có tên sum_of_numbers, có 1 tham số n. In ra tổng từ 1 đến n
```
def Sum(n):
    total = 0
    for i in range(0,n+1,1):
        total+=i
    print total

Sum(10)
# Kết quả: 55
```

### 3. Khai báo một hàm có tên evens_and_odds . Lấy 1 số nguyên dương làm tham số. Đếm số lẻ và chẵn trong khoảng từ 0 đến số đó
```
def even_and_odds(n):
    counteven = 0
    countodd = 0
    for i in range(0,n+1,1):
        if i%2 == 0:
            counteven+=1
        else:
            countodd+=1
    print(counteven)
    print(countodd)
even_and_odds(100)
#Kết quả:
51
50 
```
### 4. Viết một hàm gọi là is_prime, kiểm tra xem một số có phải là số nguyên tố hay không.
Số nguyên tố là số chỉ chia hết cho 1 và chính nó
```
def is_prime(n):
    count = 0
    for i in range(2,n,1):
        if n%i == 0:
            count+=1
    if count == 0:
        print("Is_prime")
    else:
        print("Not_prime")
is_prime(9)
# Kết quả: Not_prime
is_Prime(7)
# Kết quả: Is_prime
```


