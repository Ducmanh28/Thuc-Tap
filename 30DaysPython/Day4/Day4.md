# Ngày 4
## Chuỗi
Văn bản là một kiểu dữ liệu chuỗi. Bất kỳ kiểu dữ liệu nào được viết dưới dạng văn bản đều là một chuỗi. Bất kỳ dữ liệu nào dưới dấu ngoặc đơn, đôi hoặc ba đều là chuỗi. 

Có nhiều phương thức chuỗi khác nhau và các hàm tích hợp để xử lý các kiểu dữ liệu chuỗi. 

Để kiểm tra độ dài của một chuỗi, hãy sử dụng phương thức len().

### Tạo một chuỗi
```
letter = 'P'                # A string could be a single character or a bunch of texts
print(letter)               # P
print(len(letter))          # 1
greeting = 'Hello, World!'  # String could be made using a single or double quote,"Hello, World!"
print(greeting)             # Hello, World!
print(len(greeting))        # 13
sentence = "I hope you are enjoying 30 days of Python Challenge"
print(sentence)
```
Chuỗi nhiều dòng được tạo bằng cách sử dụng dấu ngoặc kép ba đơn (''') hoặc ba dấu ngoặc kép (""). Xem ví dụ bên dưới.
```
multiline_string = '''I am a teacher and enjoy teaching.
I didn't find anything as rewarding as empowering people.
That is why I created 30 days of python.'''
print(multiline_string)

# Another way of doing the same thing
multiline_string = """I am a teacher and enjoy teaching.
I didn't find anything as rewarding as empowering people.
That is why I created 30 days of python."""
print(multiline_string)
```
### Nối chuỗi
Chúng ta có thể kết nối các chuỗi với nhau. Hợp nhất hoặc kết nối chuỗi được gọi là ghép nối. Xem ví dụ dưới đây:
```
first_name = 'Asabeneh'
last_name = 'Yetayeh'
space = ' '
full_name = first_name  +  space + last_name
print(full_name) # Asabeneh Yetayeh
# Checking the length of a string using len() built-in function
print(len(first_name))  # 8
print(len(last_name))   # 7
print(len(first_name) > len(last_name)) # True
print(len(full_name)) # 16
```
### Trình tự thoát trong chuỗi
Trong Python và các ngôn ngữ lập trình khác, \ theo sau là một ký tự là một chuỗi thoát. Hãy để chúng tôi xem các ký tự thoát phổ biến nhất:

- \n: dòng mới
- \t: Tab có nghĩa là (8 khoảng trắng)
- \\: Dấu gạch chéo ngược
- \': Dấu nháy đơn (')
- \": Dấu ngoặc kép (")

Bây giờ, chúng ta hãy xem việc sử dụng các chuỗi thoát ở trên với các ví dụ.
```
print('I hope everyone is enjoying the Python Challenge.\nAre you ?') # line break
print('Days\tTopics\tExercises') # adding tab space or 4 spaces 
print('Day 1\t5\t5')
print('Day 2\t6\t20')
print('Day 3\t5\t23')
print('Day 4\t1\t35')
print('This is a backslash  symbol (\\)') # To write a backslash
print('In every programming language it starts with \"Hello, World!\"') # to write a double quote inside a single quote

# output
I hope every one is enjoying the Python Challenge.
Are you ?
Days	Topics	Exercises
Day 1	5	    5
Day 2	6	    20
Day 3	5	    23
Day 4	1	    35
This is a backslash  symbol (\)
In every programming language it starts with "Hello, World!"
```

### Định dạng chuỗi
#### Định dạng chuỗi kiểu cũ (% toán tử)
Trong Python có nhiều cách định dạng chuỗi. Trong phần này, chúng tôi sẽ đề cập đến một số trong số họ. Toán tử "%" được sử dụng để định dạng một tập hợp các biến được đặt trong "tuple" (danh sách kích thước cố định), cùng với một chuỗi định dạng, chứa văn bản bình thường cùng với "mã xác định đối số", các ký hiệu đặc biệt như "%s", "%d", "%f", "%.number of digitsf".

- %s - Chuỗi (hoặc bất kỳ đối tượng nào có biểu diễn chuỗi, như số)
- %d - Số nguyên
- %f - Số dấu phẩy động
- "%.number of digitsf" - Số dấu phẩy động với độ chính xác cố định
```
# Strings only
first_name = 'Asabeneh'
last_name = 'Yetayeh'
language = 'Python'
formated_string = 'I am %s %s. I teach %s' %(first_name, last_name, language)
print(formated_string)

# Strings  and numbers
radius = 10
pi = 3.14
area = pi * radius ** 2
formated_string = 'The area of circle with a radius %d is %.2f.' %(radius, area) # 2 refers the 2 significant digits after the point

python_libraries = ['Django', 'Flask', 'NumPy', 'Matplotlib','Pandas']
formated_string = 'The following are python libraries:%s' % (python_libraries)
print(formated_string) # "The following are python libraries:['Django', 'Flask', 'NumPy', 'Matplotlib','Pandas']"
```
#### Định dạng chuỗi kiểu mới (str.format)
Định dạng này được giới thiệu trong Python phiên bản 3.
```
first_name = 'Asabeneh'
last_name = 'Yetayeh'
language = 'Python'
formated_string = 'I am {} {}. I teach {}'.format(first_name, last_name, language)
print(formated_string)
a = 4
b = 3

print('{} + {} = {}'.format(a, b, a + b))
print('{} - {} = {}'.format(a, b, a - b))
print('{} * {} = {}'.format(a, b, a * b))
print('{} / {} = {:.2f}'.format(a, b, a / b)) # limits it to two digits after decimal
print('{} % {} = {}'.format(a, b, a % b))
print('{} // {} = {}'.format(a, b, a // b))
print('{} ** {} = {}'.format(a, b, a ** b))

# output
4 + 3 = 7
4 - 3 = 1
4 * 3 = 12
4 / 3 = 1.33
4 % 3 = 1
4 // 3 = 1
4 ** 3 = 64

# Strings  and numbers
radius = 10
pi = 3.14
area = pi * radius ** 2
formated_string = 'The area of a circle with a radius {} is {:.2f}.'.format(radius, area) # 2 digits after decimal
print(formated_string)
```
### Nội suy chuỗi 
Một định dạng chuỗi mới khác là nội suy chuỗi, chuỗi f. Các chuỗi bắt đầu bằng f và chúng ta có thể đưa dữ liệu vào các vị trí tương ứng của chúng.
```
a = 4
b = 3
print(f'{a} + {b} = {a +b}')
print(f'{a} - {b} = {a - b}')
print(f'{a} * {b} = {a * b}')
print(f'{a} / {b} = {a / b:.2f}')
print(f'{a} % {b} = {a % b}')
print(f'{a} // {b} = {a // b}')
print(f'{a} ** {b} = {a ** b}')
```
### Chuỗi Python dưới dạng chuỗi ký tự
Chuỗi Python là chuỗi ký tự và chia sẻ các phương thức truy cập cơ bản của chúng với các chuỗi đối tượng được sắp xếp theo thứ tự Python khác - danh sách và bộ dữ liệu. Cách đơn giản nhất để trích xuất các ký tự đơn từ chuỗi (và các thành viên riêng lẻ từ bất kỳ chuỗi nào) là giải nén chúng thành các biến tương ứng.

#### Giải nén ky tu
```
language = 'Python'
a,b,c,d,e,f = language # unpacking sequence characters into variables
print(a) # P
print(b) # y
print(c) # t
print(d) # h
print(e) # o
print(f) # n
```
Truy cập các ký tự trong chuỗi theo chỉ mục

Trong lập trình, đếm bắt đầu từ số không. Do đó, chữ cái đầu tiên của một chuỗi nằm ở chỉ số 0 và chữ cái cuối cùng của chuỗi là độ dài của chuỗi trừ một.

### Chỉ mục chuỗi
```
language = 'Python'
first_letter = language[0]
print(first_letter) # P
second_letter = language[1]
print(second_letter) # y
last_index = len(language) - 1
last_letter = language[last_index]
print(last_letter) # n
```
Nếu chúng ta muốn bắt đầu từ đầu bên phải, chúng ta có thể sử dụng lập chỉ mục âm. -1 là chỉ số cuối cùng.
```
language = 'Python'
last_letter = language[-1]
print(last_letter) # n
second_last = language[-2]
print(second_last) # o
```

### Cắt chuỗi Python
Trong python, chúng ta có thể cắt chuỗi thành các chuỗi con.
```
language = 'Python'
first_three = language[0:3] # starts at zero index and up to 3 but not include 3
print(first_three) #Pyt
last_three = language[3:6]
print(last_three) # hon
# Another way
last_three = language[-3:]
print(last_three)   # hon
last_three = language[3:]
print(last_three)   # hon
```
### Đảo ngược một chuỗi
Chúng ta có thể dễ dàng đảo ngược các chuỗi trong python.
```
greeting = 'Hello, World!'
print(greeting[::-1]) # !dlroW ,olleH
``` 
### Bỏ qua các ký tự trong khi cắt lát
Có thể bỏ qua các ký tự trong khi cắt bằng cách truyền đối số bước sang phương pháp cắt.
```
language = 'Python'
pto = language[0:6:2] #
print(pto) # Pto
``` 
### Phương thức chuỗi
Có nhiều phương thức chuỗi cho phép chúng ta định dạng chuỗi. Xem một số phương thức chuỗi trong ví dụ sau:

- capitalize(): Chuyển đổi ký tự đầu tiên của chuỗi thành chữ in hoa
```
challenge = 'thirty days of python'
print(challenge.capitalize()) # 'Thirty days of python'
```
- count(): trả về sự xuất hiện của chuỗi con trong chuỗi, count(chuỗi con, start=.., end=..). Bắt đầu là một chỉ mục bắt đầu để đếm và kết thúc là chỉ số cuối cùng để đếm.
```
challenge = 'thirty days of python'
print(challenge.count('y')) # 3
print(challenge.count('y', 7, 14)) # 1, 
print(challenge.count('th')) # 2`
```
- endswith(): Kiểm tra xem một chuỗi có kết thúc bằng một kết thúc được chỉ định hay không
```
challenge = 'thirty days of python'
print(challenge.endswith('on'))   # True
print(challenge.endswith('tion')) # False
```
- expandtabs(): Thay thế ký tự tab bằng khoảng trắng, kích thước tab mặc định là 8. Nó cần đối số kích thước tab
```
challenge = 'thirty\tdays\tof\tpython'
print(challenge.expandtabs())   # 'thirty  days    of      python'
print(challenge.expandtabs(10)) # 'thirty    days      of        python'
```
- find(): Trả về chỉ mục của lần xuất hiện đầu tiên của một chuỗi con, nếu không tìm thấy trả về -1
```
challenge = 'thirty days of python'
print(challenge.find('y'))  # 5
print(challenge.find('th')) # 0
```
- rfind(): Trả về chỉ mục của lần xuất hiện cuối cùng của một chuỗi con, nếu không tìm thấy trả về -1
```
challenge = 'thirty days of python'
print(challenge.rfind('y'))  # 16
print(challenge.rfind('th')) # 17
```
- format(): định dạng chuỗi thành một đầu ra
đẹp hơn Thông tin thêm về định dạng chuỗi, hãy kiểm tra liên kết này
```
first_name = 'Asabeneh'
last_name = 'Yetayeh'
age = 250
job = 'teacher'
country = 'Finland'
sentence = 'I am {} {}. I am a {}. I am {} years old. I live in {}.'.format(first_name, last_name, age, job, country)
print(sentence) # I am Asabeneh Yetayeh. I am 250 years old. I am a teacher. I live in Finland.

radius = 10
pi = 3.14
area = pi * radius ** 2
result = 'The area of a circle with radius {} is {}'.format(str(radius), str(area))
print(result) # The area of a circle with radius 10 is 314
```
- index(): Trả về chỉ mục thấp nhất của chuỗi con, các đối số bổ sung cho biết chỉ mục bắt đầu và kết thúc (mặc định 0 và độ dài chuỗi - 1). Nếu không tìm thấy chuỗi con, nó sẽ tăng valueError.
```
challenge = 'thirty days of python'
sub_string = 'da'
print(challenge.index(sub_string))  # 7
print(challenge.index(sub_string, 9)) # error
```
- rindex(): Trả về chỉ số cao nhất của chuỗi con, các đối số bổ sung cho biết chỉ mục bắt đầu và kết thúc (mặc định 0 và độ dài chuỗi - 1)
```
challenge = 'thirty days of python'
sub_string = 'da'
print(challenge.rindex(sub_string))  # 8
print(challenge.rindex(sub_string, 9)) # error
isalnum(): Kiểm tra ký tự chữ và số
challenge = 'ThirtyDaysPython'
print(challenge.isalnum()) # True

challenge = '30DaysPython'
print(challenge.isalnum()) # True

challenge = 'thirty days of python'
print(challenge.isalnum()) # False, space is not an alphanumeric character

challenge = 'thirty days of python 2019'
print(challenge.isalnum()) # False
```
- isalpha(): Kiểm tra xem tất cả các phần tử chuỗi có phải là ký tự bảng chữ cái hay không (a-z và A-Z)
```
challenge = 'thirty days of python'
print(challenge.isalpha()) # False, space is once again excluded
challenge = 'ThirtyDaysPython'
print(challenge.isalpha()) # True
num = '123'
print(num.isalpha())      # False
```
- isdecimal(): Kiểm tra xem tất cả các ký tự trong một chuỗi có phải là số thập phân hay không (0-9)
```
challenge = 'thirty days of python'
print(challenge.isdecimal())  # False
challenge = '123'
print(challenge.isdecimal())  # True
challenge = '\u00B2'
print(challenge.isdigit())   # False
challenge = '12 3'
print(challenge.isdecimal())  # False, space not allowed
```
- isdigit(): Kiểm tra xem tất cả các ký tự trong một chuỗi có phải là số không (0-9 và một số ký tự unicode khác cho số)
```
challenge = 'Thirty'
print(challenge.isdigit()) # False
challenge = '30'
print(challenge.isdigit())   # True
challenge = '\u00B2'
print(challenge.isdigit())   # True
```
- isnumeric(): Kiểm tra xem tất cả các ký tự trong một chuỗi có liên quan đến số hoặc số hay không (giống như isdigit(), chỉ chấp nhận nhiều ký hiệu hơn, như 1/2)
```
num = '10'
print(num.isnumeric()) # True
num = '\u00BD' # ½
print(num.isnumeric()) # True
num = '10.5'
print(num.isnumeric()) # False
```
- isidentifier(): Kiểm tra mã định danh hợp lệ - nó kiểm tra xem một chuỗi có phải là tên biến hợp lệ hay không
```
challenge = '30DaysOfPython'
print(challenge.isidentifier()) # False, because it starts with a number
challenge = 'thirty_days_of_python'
print(challenge.isidentifier()) # True
```
- islower(): Kiểm tra xem tất cả các ký tự bảng chữ cái trong chuỗi có phải là chữ thường hay không
```
challenge = 'thirty days of python'
print(challenge.islower()) # True
challenge = 'Thirty days of python'
print(challenge.islower()) # False
```
- isupper(): Kiểm tra xem tất cả các ký tự bảng chữ cái trong chuỗi có phải là chữ hoa không
```
challenge = 'thirty days of python'
print(challenge.isupper()) #  False
challenge = 'THIRTY DAYS OF PYTHON'
print(challenge.isupper()) # True
```
- join(): Trả về một chuỗi được ghép nối
```
web_tech = ['HTML', 'CSS', 'JavaScript', 'React']
result = ' '.join(web_tech)
print(result) # 'HTML CSS JavaScript React'
web_tech = ['HTML', 'CSS', 'JavaScript', 'React']
result = '# '.join(web_tech)
print(result) # 'HTML# CSS# JavaScript# React'
```
- strip(): Xóa tất cả các ký tự đã cho bắt đầu từ đầu và cuối chuỗi
```
challenge = 'thirty days of pythoonnn'
print(challenge.strip('noth')) # 'irty days of py'
```
- replace(): Thay thế chuỗi con bằng một chuỗi nhất định
```
challenge = 'thirty days of python'
print(challenge.replace('python', 'coding')) # 'thirty days of coding'
```
- split(): Tách chuỗi, sử dụng chuỗi hoặc khoảng trắng đã cho làm dấu phân cách
```
challenge = 'thirty days of python'
print(challenge.split()) # ['thirty', 'days', 'of', 'python']
challenge = 'thirty, days, of, python'
print(challenge.split(', ')) # ['thirty', 'days', 'of', 'python']
```
- title(): Trả về một chuỗi viết hoa tiêu đề
```
challenge = 'thirty days of python'
print(challenge.title()) # Thirty Days Of Python
```
- swapcase(): Chuyển đổi tất cả các ký tự viết hoa thành chữ thường và tất cả các ký tự viết thường thành ký tự viết hoa
```
challenge = 'thirty days of python'
print(challenge.swapcase())   # THIRTY DAYS OF PYTHON
challenge = 'Thirty Days Of Python'
print(challenge.swapcase())  # tHIRTY dAYS oF pYTHON
```
- startswith(): Kiểm tra xem chuỗi có bắt đầu bằng chuỗi được chỉ định không
```
challenge = 'thirty days of python'
print(challenge.startswith('thirty')) # True

challenge = '30 days of python'
print(challenge.startswith('thirty')) # False
```
