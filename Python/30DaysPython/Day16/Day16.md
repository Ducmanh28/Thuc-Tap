# Day 16: Date in Python
## Ngày giờ của Python
Python có mô-đun datetime để xử lý ngày và giờ.
```
import datetime
print(dir(datetime))
['MAXYEAR', 'MINYEAR', '__builtins__', '__cached__', '__doc__', '__file__', '__loader__', '__name__', '__package__', '__spec__', 'date', 'datetime', 'datetime_CAPI', 'sys', 'time', 'timedelta', 'timezone', 'tzinfo']
```
Với `dir` hoặc trợ giúp các lệnh tích hợp, có thể biết các chức năng có sẵn trong một mô-đun nhất định. Như các bạn thấy, trong module datetime có rất nhiều hàm, tuy nhiên chúng ta sẽ tập trung vào date, datetime, time và timedelta. Hãy để se xem từng cái một.

## Lấy thông tin ngày giờ
```
from datetime import datetime
now = datetime.now()
print(now)                      # 2021-07-08 07:34:46.549883
day = now.day                   # 8
month = now.month               # 7
year = now.year                 # 2021
hour = now.hour                 # 7
minute = now.minute             # 38
second = now.second
timestamp = now.timestamp()
print(day, month, year, hour, minute)
print('timestamp', timestamp)
print(f'{day}/{month}/{year}, {hour}:{minute}')  # 8/7/2021, 7:38
```
Dấu thời gian hoặc dấu thời gian Unix là số giây trôi qua từ ngày 1 tháng 1 năm 1970 UTC.

## Định dạng đầu ra ngày bằng strftime
```
from datetime import datetime
new_year = datetime(2020, 1, 1)
print(new_year)      # 2020-01-01 00:00:00
day = new_year.day
month = new_year.month
year = new_year.year
hour = new_year.hour
minute = new_year.minute
second = new_year.second
print(day, month, year, hour, minute) #1 1 2020 0 0
print(f'{day}/{month}/{year}, {hour}:{minute}')  # 1/1/2020, 0:0
```
Định dạng ngày giờ bằng phương pháp `strftime` 
```
from datetime import datetime
# current date and time
now = datetime.now()
t = now.strftime("%H:%M:%S")
print("time:", t)
time_one = now.strftime("%m/%d/%Y, %H:%M:%S")
# mm/dd/YY H:M:S format
print("time one:", time_one)
time_two = now.strftime("%d/%m/%Y, %H:%M:%S")
# dd/mm/YY H:M:S format
print("time two:", time_two)
time: 01:05:01
time one: 12/05/2019, 01:05:01
time two: 05/12/2019, 01:05:01
```
Dưới đây là tất cả các biểu tượng strftime mà chúng tôi sử dụng để định dạng thời gian. Một ví dụ về tất cả các định dạng cho mô-đun này.

![](/Anh/Screenshot_477.png)

## String to Time Sử dụng strptime
Dưới đây là một chiếc mũ tài liệu giúp hiểu định dạng.
```
from datetime import datetime
date_string = "5 December, 2019"
print("date_string =", date_string)
date_object = datetime.strptime(date_string, "%d %B, %Y")
print("date_object =", date_object)
```
```
date_string = 5 December, 2019
date_object = 2019-12-05 00:00:00
```
## Sử dụng ngày từ datetime
```
from datetime import date
d = date(2020, 1, 1)
print(d)
print('Current date:', d.today())    # 2019-12-05
# date object of today's date
today = date.today()
print("Current year:", today.year)   # 2019
print("Current month:", today.month) # 12
print("Current day:", today.day)     # 5
```
## Các đối tượng thời gian để đại diện cho thời gian
```
from datetime import time
# time(hour = 0, minute = 0, second = 0)
a = time()
print("a =", a)
# time(hour, minute and second)
b = time(10, 30, 50)
print("b =", b)
# time(hour, minute and second)
c = time(hour=10, minute=30, second=50)
print("c =", c)
# time(hour, minute, second, microsecond)
d = time(10, 30, 50, 200555)
print("d =", d)
```
Đầu ra
- A = 00:00:00
- B = 10:30:50
- C = 10:30:50
- D = 10:30:50.200555

## Sự khác biệt giữa hai điểm trong thời gian sử dụng
```
today = date(year=2019, month=12, day=5)
new_year = date(year=2020, month=1, day=1)
time_left_for_newyear = new_year - today
# Time left for new year:  27 days, 0:00:00
print('Time left for new year: ', time_left_for_newyear)

t1 = datetime(year = 2019, month = 12, day = 5, hour = 0, minute = 59, second = 0)
t2 = datetime(year = 2020, month = 1, day = 1, hour = 0, minute = 0, second = 0)
diff = t2 - t1
print('Time left for new year:', diff) # Time left for new year: 26 days, 23: 01: 00
```
## Sự khác biệt giữa hai điểm trong thời gian sử dụng timedelata
```
from datetime import timedelta
t1 = timedelta(weeks=12, days=10, hours=4, seconds=20)
t2 = timedelta(days=7, hours=5, minutes=3, seconds=30)
t3 = t1 - t2
print("t3 =", t3)
```

```
    date_string = 5 December, 2019
    date_object = 2019-12-05 00:00:00
    t3 = 86 days, 22:56:50
```