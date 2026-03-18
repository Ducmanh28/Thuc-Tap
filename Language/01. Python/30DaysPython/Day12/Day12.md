# Ngày 12
## Module là gì
Là một tệp chứa một tập hợp các chức năng có thể được đưa vào một ứng dụng. Một module có thể là một tệp chứa một biến duy nhát, một hàm hoặc một cơ sở ma lớn

### Cách tạo Module
Tạo một tệp có tên **mymodule.py** bên trong thư mục dự án và viết một số mã cơ bản như sau:
```
# mympdule.py file
def tqo_full_name(firstname, lastname):
    return firstname + ' ' + lastname 
```
Tạo tệp **main.py** để chạy thử file chương trình

### Nhập module
Để nhập một tệp, chúng ta sử dụng từ khoá `import` và tên của tệp
```
# main.py file
import mymodule
print(mymodule.tao_full_name('Duc','Manh'))

#Kết quả: Duc Manh
```
### Nhập các hàm từ một Module
Chúng ta có thể có nhiều chức năng, biến trong một tệp và chúng ta có thể nhập tất cả các chức năng, các biến khác nhau.

Tạo thêm một số hàm trong file **mymodule.py**
```
def tinhtong(num1,num2):
    return num1+num2

trongluc = 9.8
listeven = {2,4,6,8}

def tinhtich(num1,num2):
    return num1*num2
```

Ở file **main.py** thực hiện sử dụng module như sau:
```
#main.py file

from mymodule import tao_full_name, tinhtich, tinhtong, trongluc, listeven
print(tao_full_name('Duc','Manh'))
print(tinhtong(5,29))
print(tinhtich(4,3))

mass = 100;
weight = mass * trongluc
print(weight)
print(listeven)

#Kết quả:
#Duc Manh
#34
#12
#980.0000000000001
#{8, 2, 4, 6} 
```
### Ta cũng có thể đổi tên các hàm này
Trong quá trình nhập, chúng ta có thể đổi tên của mô-đun.
```
# main.py file
from mymodule import tao_full_name as fullname, tinhtong as total, listeven as l, trongluc as g, tinhtich as tich
print(fullname('Duc','Manh'))
print(total(1, 9))
mass = 100;
weight = mass * g
print(weight)
print(l)
```

## Các Module được tích hợp
### Module hệ điều hành
Sử dụng mô-đun hệ điều hành python có thể tự động thực hiện nhiều tác vụ hệ điều hành. Mô-đun hệ điều hành trong Python cung cấp các chức năng để tạo, thay đổi thư mục làm việc hiện tại và xóa thư mục (thư mục), tìm nạp nội dung của nó, thay đổi và xác định thư mục hiện tại.
```
# Nhập module
import os
# Tạo một thư mục
os.mkdir('directory_name')
# Thay đổi đường dẫn thư mục hiệu tại
os.chdir('path')
# Xem đường dẫn tới thư mục hiện tại
os.getcwd()
# Xoá thư mục
os.rmdir()
```
### Module System
Mô-đun sys cung cấp các hàm và biến được sử dụng để thao tác các phần khác nhau của môi trường thời gian chạy Python. Hàm sys.argv trả về một danh sách các đối số dòng lệnh được truyền đến tập lệnh Python. Mục tại index 0 trong danh sách này luôn là tên của script, tại index 1 là đối số được truyền từ dòng lệnh.

Ví dụ: Tệp `script.py`
```
import sys
print('Welcome {}. Enjoy  {} challenge!'.format(sys.argv[1], sys.argv[2]))
```

Bây giờ để kiểm tra cách thức hoạt động của tập lệnh này, tôi đã viết trong dòng lệnh:
```
python script.py Asabeneh 30DaysOfPython

# Kết quả:
# Welcome Asabeneh. Enjoy  30DayOfPython challenge! 
```

Một số lệnh sys hữu ích:
```
# Để thoát khỏi sys
sys.exit()
# Để biết biến số nguyên lớn nhất cần có
sys.maxsize
# Để biết đường dẫn 
sys.path
# Để biết phiên bản Python đang sử dụng
sys.version
```
### Module Thống kê
Mô-đun thống kê cung cấp các chức năng thống kê toán học của dữ liệu số. Các hàm thống kê phổ biến được định nghĩa trong mô-đun này: trung bình, trung vị, chế độ, stdev, v.v.

```
from statistics import * # importing all the statistics modules
ages = [20, 20, 4, 24, 25, 22, 26, 20, 23, 22, 26]
print(mean(ages))       # ~22.9
print(median(ages))     # 23
print(mode(ages))       # 20
print(stdev(ages))      # ~2.3
```

### Module Toán học:
Mô-đun chứa nhiều phép toán và hằng số.

```
import math
print(math.pi)           # 3.141592653589793, pi constant
print(math.sqrt(2))      # 1.4142135623730951, square root
print(math.pow(2, 3))    # 8.0, exponential function
print(math.floor(9.81))  # 9, rounding to the lowest
print(math.ceil(9.81))   # 10, rounding to the highest
print(math.log10(100))   # 2, logarithm with 10 as base
```
Bây giờ, chúng tôi đã nhập mô-đun toán học chứa rất nhiều chức năng có thể giúp chúng tôi thực hiện các phép tính toán học. Để kiểm tra xem mô-đun có những hàm nào, chúng ta có thể sử dụng `help(math)` hoặc `dir(math)`. Điều này sẽ hiển thị các chức năng có sẵn trong mô-đun. 

Nếu chúng ta chỉ muốn nhập một hàm cụ thể từ mô-đun, chúng ta nhập nó như sau:
```
from math import pi
print(pi)
```
Cũng có thể nhập nhiều chức năng cùng một lúc
```
from math import pi, sqrt, pow, floor, ceil, log10
print(pi)                 # 3.141592653589793
print(sqrt(2))            # 1.4142135623730951
print(pow(2, 3))          # 8.0
print(floor(9.81))        # 9
print(ceil(9.81))         # 10
print(math.log10(100))    # 2
```
Nhưng nếu chúng ta muốn nhập tất cả các hàm trong mô-đun toán học, chúng ta có thể sử dụng * .
```
from math import *
print(pi)                  # 3.141592653589793, pi constant
print(sqrt(2))             # 1.4142135623730951, square root
print(pow(2, 3))           # 8.0, exponential
print(floor(9.81))         # 9, rounding to the lowest
print(ceil(9.81))          # 10, rounding to the highest
print(math.log10(100))     # 2
```

### Module chuỗi
Một mô-đun chuỗi là một mô-đun hữu ích cho nhiều mục đích.
```
import string
print(string.ascii_letters) # abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
print(string.digits)        # 0123456789
print(string.punctuation)   # !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
```

### Module ngẫu nhiên
Bây giờ bạn đã quen thuộc với việc nhập các mô-đun. Hãy để chúng tôi làm thêm một lần nhập khẩu để làm quen với nó. Hãy để chúng tôi nhập mô-đun ngẫu nhiên cung cấp cho chúng tôi một số ngẫu nhiên từ 0 đến 0,9999.... Mô-đun ngẫu nhiên có rất nhiều chức năng nhưng trong phần này chúng ta sẽ chỉ sử dụng ngẫu nhiên và randint.
```
from random import random, randint
print(random())   # Nó không nhận một tham số đầu vào nào; Nó trả về một giá trị trong khoảng 0 và 0.9999
print(randint(5, 20)) # Nó trả về một số ngẫu nhiên trong khoảng [5, 20]
```


