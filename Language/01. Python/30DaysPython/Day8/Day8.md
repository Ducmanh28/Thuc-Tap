# Day 8
## Dictionaries
Từ điển là một tập hợp các kiểu dữ liệu không có thứ tự, có thể sửa đổi (có thể thay đổi) được ghép nối (khóa: giá trị).

## Tạo từ điển
Để tạo từ điển, chúng ta sử dụng dấu ngoặc nhọn, {} hoặc hàm tích hợp dict().
```
# syntax
empty_dict = {}
# Dictionary with data values
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
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
```
Từ điển ở trên cho thấy một giá trị có thể là bất kỳ kiểu dữ liệu nào: chuỗi, boolean, danh sách, tuple, tập hợp hoặc từ điển.

## Độ dài từ điển
Nó kiểm tra số lượng cặp 'khóa: giá trị' trong từ điển.
```
# syntax
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
print(len(dct)) # 4
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
print(len(person)) # 7
```
## Truy cập các mục từ điển
Chúng ta có thể truy cập các mục Từ điển bằng cách tham khảo tên khóa của nó.
```
# syntax
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
print(dct['key1']) # value1
print(dct['key4']) # value4
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
print(person['first_name']) # Asabeneh
print(person['country'])    # Finland
print(person['skills'])     # ['JavaScript', 'React', 'Node', 'MongoDB', 'Python']
print(person['skills'][0])  # JavaScript
print(person['address']['street']) # Space street
print(person['city'])       # Error
```
Truy cập một mục theo tên khóa sẽ gây ra lỗi nếu khóa không tồn tại. Để tránh lỗi này, trước tiên chúng ta phải kiểm tra xem khóa có tồn tại hay chúng ta có thể sử dụng phương thức get. Phương thức get trả về None, là kiểu dữ liệu đối tượng NoneType, nếu khóa không tồn tại.
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
print(person.get('first_name')) # Asabeneh
print(person.get('country'))    # Finland
print(person.get('skills')) #['HTML','CSS','JavaScript', 'React', 'Node', 'MongoDB', 'Python']
print(person.get('city'))   # None
```
### Thêm mục vào từ điển
Chúng ta có thể thêm các cặp khóa và giá trị mới vào từ điển
```
# syntax
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
dct['key5'] = 'value5'
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
person['job_title'] = 'Instructor'
person['skills'].append('HTML')
print(person)
```
## Sửa đổi các mục trong từ điển
Chúng ta có thể sửa đổi các mục trong từ điển
```
# syntax
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
dct['key1'] = 'value-one'
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
person['first_name'] = 'Eyob'
person['age'] = 252
```
## Kiểm tra các phím trong từ điển
Chúng tôi sử dụng toán tử in để kiểm tra xem khóa có tồn tại trong từ điển hay không
```
# syntax
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
print('key2' in dct) # True
print('key5' in dct) # False
```
## Xóa cặp khóa và giá trị khỏi từ điển
POP (KEY): Xóa mục có tên khóa được chỉ định:

popitem(): xóa mục cuối cùng

DEL: Xóa một mục có tên khóa được chỉ định
```
# syntax
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
dct.pop('key1') # removes key1 item
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
dct.popitem() # removes the last item
del dct['key2'] # removes key2 item
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
person.pop('first_name')        # Removes the firstname item
person.popitem()                # Removes the address item
del person['is_married']        # Removes the is_married item
```
## Thay đổi từ điển thành danh sách các mục
Phương thức items() thay đổi từ điển thành một danh sách các tuple.
```
# syntax
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
print(dct.items()) # dict_items([('key1', 'value1'), ('key2', 'value2'), ('key3', 'value3'), ('key4', 'value4')])
```
## Xóa từ điển
Nếu chúng ta không muốn các mục trong từ điển, chúng ta có thể xóa chúng bằng phương thức clear()
```
# syntax
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
print(dct.clear()) # None
```
## Xóa từ điển
Nếu chúng ta không sử dụng từ điển, chúng ta có thể xóa nó hoàn toàn
```
# syntax
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
del dct
```
## Sao chép từ điển
Chúng ta có thể sao chép từ điển bằng phương thức copy(). Sử dụng bản sao chúng ta có thể tránh đột biến từ điển gốc.
```
# syntax
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
dct_copy = dct.copy() # {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
```
## Lấy khóa từ điển dưới dạng danh sách
Phương thức keys() cung cấp cho chúng ta tất cả các khóa của một từ điển dưới dạng danh sách.
```
# syntax
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
keys = dct.keys()
print(keys)     # dict_keys(['key1', 'key2', 'key3', 'key4'])
```
## Lấy giá trị từ điển dưới dạng danh sách
Phương thức values cung cấp cho chúng ta tất cả các giá trị của một từ điển dưới dạng danh sách.
```
# syntax
dct = {'key1':'value1', 'key2':'value2', 'key3':'value3', 'key4':'value4'}
values = dct.values()
print(values)     # dict_values(['value1', 'value2', 'value3', 'value4'])
```