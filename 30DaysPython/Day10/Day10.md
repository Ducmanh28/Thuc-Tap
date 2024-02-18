# Day 10
## Vòng
Cuộc sống đầy những thói quen. Trong lập trình, chúng tôi cũng thực hiện rất nhiều nhiệm vụ lặp đi lặp lại. Để xử lý các tác vụ lặp đi lặp lại, ngôn ngữ lập trình sử dụng các vòng lặp. Ngôn ngữ lập trình Python cũng cung cấp các loại hai vòng lặp sau:

- vòng lặp while
- vòng lặp for
## Vòng lặp While
Chúng tôi sử dụng từ dành riêng trong khi để thực hiện một vòng lặp while. Nó được sử dụng để thực hiện một khối các câu lệnh lặp đi lặp lại cho đến khi một điều kiện nhất định được thỏa mãn. Khi điều kiện trở nên false, các dòng mã sau vòng lặp sẽ được tiếp tục được thực thi.
```
  # syntax
while condition:
    code goes here
```
Ví dụ:
```
count = 0
while count < 5:
    print(count)
    count = count + 1
#prints from 0 to 4
```
Trong vòng lặp while ở trên, điều kiện trở nên sai khi đếm là 5. Đó là khi vòng lặp dừng lại. Nếu chúng ta quan tâm đến việc chạy khối mã khi điều kiện không còn đúng nữa, chúng ta có thể sử dụng khác.
```
  # syntax
while condition:
    code goes here
else:
    code goes here
```
Ví dụ:
```
count = 0
while count < 5:
    print(count)
    count = count + 1
else:
    print(count)
```
Điều kiện vòng lặp trên sẽ false khi count là 5 và loop dừng lại và execution bắt đầu câu lệnh else. Kết quả là 5 sẽ được in.

## Break vs Continue - Phần 1
- Break: Chúng tôi sử dụng break khi chúng tôi muốn thoát ra khỏi hoặc dừng vòng lặp.
```
# syntax
while condition:
    code goes here
    if another_condition:
        break
```
Ví dụ:
```
count = 0
while count < 5:
    print(count)
    count = count + 1
    if count == 3:
        break
```
Vòng lặp trên trong khi chỉ in 0, 1, 2, nhưng khi đến 3 thì nó dừng lại.

- Tiếp tục: Với câu lệnh continue, chúng ta có thể bỏ qua lần lặp hiện tại và tiếp tục với lần lặp tiếp theo:
```
  # syntax
while condition:
    code goes here
    if another_condition:
        continue
```
Ví dụ:
```
count = 0
while count < 5:
    if count == 3:
        count = count + 1
        continue
    print(count)
    count = count + 1
```
Vòng lặp trên trong khi chỉ in 0, 1, 2 và 4 (bỏ qua 3).

## Vòng lặp for
A for keyword được sử dụng để tạo vòng lặp for, tương tự như các ngôn ngữ lập trình khác, nhưng có một số khác biệt về cú pháp. Vòng lặp được sử dụng để lặp qua một chuỗi (nghĩa là danh sách, bộ dữ liệu, từ điển, tập hợp hoặc chuỗi).

- Đối với vòng lặp với danh sách
```
# syntax
for iterator in lst:
    code goes here
```
Ví dụ:
```
numbers = [0, 1, 2, 3, 4, 5]
for number in numbers: # number is temporary name to refer to the list's items, valid only inside this loop
    print(number)       # the numbers will be printed line by line, from 0 to 5
```
- Đối với vòng lặp với chuỗi
```
# syntax
for iterator in string:
    code goes here
```
Ví dụ:
```
language = 'Python'
for letter in language:
    print(letter)
for i in range(len(language)):
    print(language[i])
```
- Đối với vòng lặp với tuple
```
# syntax
for iterator in tpl:
    code goes here
```
Ví dụ:
```
numbers = (0, 1, 2, 3, 4, 5)
for number in numbers:
    print(number)
```
- Đối với vòng lặp với từ điển Lặp qua một từ điển cung cấp cho bạn chìa khóa của từ điển.
```
  # syntax
for iterator in dct:
    code goes here
```
Ví dụ:
```
person = {
    'first_name':'Asabeneh',
    'last_name':'Yetayeh',
    'age':250,
    'country':'Finland',
    'is_marred':True,
    'skills':['JavaScript', 'React', 'Node', 'MongoDB', 'Python'],
    'address':{
        'street':'Space street',
        'zipcode':'02210'
    }
}
for key in person:
    print(key)

for key, value in person.items():
    print(key, value) # this way we get both keys and values printed out
```
## Các vòng lặp trong tập hợp
```
# syntax
for iterator in st:
    code goes here
```
Ví dụ:
```
it_companies = {'Facebook', 'Google', 'Microsoft', 'Apple', 'IBM', 'Oracle', 'Amazon'}
for company in it_companies:
    print(company)
```
## Break vs Continue - Phần 2
- Nhắc nhở ngắn: Break: Chúng tôi sử dụng break khi chúng tôi muốn dừng vòng lặp của chúng tôi trước khi nó được hoàn thành.
```
# syntax
for iterator in sequence:
    code goes here
    if condition:
        break
```
Ví dụ:
```
numbers = (0,1,2,3,4,5)
for number in numbers:
    print(number)
    if number == 3:
        break
```
Trong ví dụ trên, vòng lặp dừng lại khi nó đạt đến 3.

- Tiếp tục: Chúng tôi sử dụng continue khi chúng tôi muốn bỏ qua một số bước trong quá trình lặp lại vòng lặp.
```
  # syntax
for iterator in sequence:
    code goes here
    if condition:
        continue
```
Ví dụ:
```
numbers = (0,1,2,3,4,5)
for number in numbers:
    print(number)
    if number == 3:
        continue
    print('Next number should be ', number + 1) if number != 5 else print("loop's end") # for short hand conditions need both if and else statements
print('outside the loop')
```
Trong ví dụ trên, nếu số bằng 3, bước sau điều kiện (nhưng bên trong vòng lặp) sẽ bị bỏ qua và việc thực thi vòng lặp tiếp tục nếu còn bất kỳ lần lặp nào.

## Chức năng Phạm vi
Hàm range() được sử dụng danh sách các số. Phạm vi (bắt đầu, kết thúc, bước) có ba tham số: bắt đầu, kết thúc và tăng dần. Theo mặc định, nó bắt đầu từ 0 và gia số là 1. Dãy phạm vi cần ít nhất 1 đối số (end). Tạo chuỗi bằng cách sử dụng phạm vi
```
lst = list(range(11)) 
print(lst) # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
st = set(range(1, 11))    # 2 arguments indicate start and end of the sequence, step set to default 1
print(st) # {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

lst = list(range(0,11,2))
print(lst) # [0, 2, 4, 6, 8, 10]
st = set(range(0,11,2))
print(st) #  {0, 2, 4, 6, 8, 10}
```
```
# syntax
for iterator in range(start, end, step):
```
Ví dụ:
```
for number in range(11):
    print(number)   # prints 0 to 10, not including 11
```
## Lồng nhau cho vòng lặp
Chúng ta có thể viết các vòng lặp bên trong một vòng lặp.
```
# syntax
for x in y:
    for t in x:
        print(t)
```
Ví dụ:
```
person = {
    'first_name': 'Asabeneh',
    'last_name': 'Yetayeh',
    'age': 250,
    'country': 'Finland',
    'is_marred': True,
    'skills': ['JavaScript', 'React', 'Node', 'MongoDB', 'Python'],
    'address': {
        'street': 'Space street',
        'zipcode': '02210'
    }
}
for key in person:
    if key == 'skills':
        for skill in person['skills']:
            print(skill)
```
## Đối với người khác
Nếu chúng ta muốn thực hiện một số thông báo khi vòng lặp kết thúc, chúng ta sử dụng khác.
```
# syntax
for iterator in range(start, end, step):
    do something
else:
    print('The loop ended')
```
Ví dụ:
```
for number in range(11):
    print(number)   # prints 0 to 10, not including 11
else:
    print('The loop stops at', number)
```
## Đèo
Trong python khi câu lệnh được yêu cầu (sau dấu chấm phẩy), nhưng chúng ta không thích thực thi bất kỳ mã nào ở đó, chúng ta có thể viết word pass để tránh lỗi. Ngoài ra, chúng ta có thể sử dụng nó như một trình giữ chỗ, cho các câu lệnh trong tương lai.

Ví dụ:
```
for number in range(6):
    pass
```     