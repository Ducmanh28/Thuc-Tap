# Ngày 15
## Các loại lỗi trong Python
Khi chúng ta viết mã, thông thường chúng ta mắc lỗi đánh máy hoặc một số lỗi phổ biến khác. Nếu code của chúng ta không chạy được, trình thông dịch Python sẽ hiển thị một thông báo, chứa phản hồi với thông tin về nơi xảy ra sự cố và loại lỗi. Đôi khi nó cũng sẽ cung cấp cho chúng ta các đề xuất về một bản sửa lỗi có thể. 

Hiểu các loại lỗi khác nhau trong ngôn ngữ lập trình sẽ giúp chúng ta gỡ lỗi mã của mình một cách nhanh chóng và nó cũng giúp chúng ta làm tốt hơn những gì chúng ta làm.

## Cú pháp lỗi
Ví dụ 1: **SyntaxError**
```
print 'hello world'
```
Code này sẽ không chạy được mà thay vào đó, terminal sẽ hiển thị:
```
 File "d:\Git\Thuc-Tap\30DaysPython\Day15\Day15.py", line 1
    print 'hello world'
    ^^^^^^^^^^^^^^^^^^^
SyntaxError: Missing parentheses in call to 'print'. Did you mean print(...)?
```
Điều này nghĩa là trong đoạn code thiếu đi dấu `()` ở sau `print`

Sửa lại như sau:
```
print('hello world')
# hello world
```

## NameError
Ví dụ : 
```
print(age)
```
Dễ thấy biến `age` chưa được khai báo và lúc này lỗi sẽ hiển thị như sau
```
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'age' is not defined
```
Để sửa lỗi cũng rất đơn giản, chúng ta chỉ cần khai báo lại biến `age`
```
>>> print(age)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'age' is not defined
>>> age = 20
>>> print(age)
20
```

## Lỗi chỉ mục
Ví dụ: Index Error
```
lst = [1,2,3,4,5]
print(lst[5])
```
Tất nhiên, đoạn code trên sẽ không thể chạy được mà sẽ hiển thị ra lỗi như sau:
```
>>> lst = [1,2,3,4,5]
>>> print(lst[5])
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
IndexError: list index out of range
```
Vì danh sách chỉ có các vị trí từ 0 - 4 nên khi nhập 5 nó đã nằm ngoài danh sách và không tổn tại. Để lấy ra phần tử ở vị trí thứ 5, chúng ta chỉ cần nhập
```
>>> lst = [1,2,3,4,5]
>>> print(lst[4])
5
```
## Module not Found Error
Ví dụ: ModuleNotFoundError
```
>>> import maths
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ModuleNotFoundError: No module named 'maths'
```
Chúng ta đã nhập sai tên module, thực chất tên đúng là `math`. Sửa lại bằng cách chỉnh sửa câu lệnh như sau:
```
import math
```

