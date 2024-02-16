# Ngày 6:
## Tuples
Bộ dữ liệu là một tập hợp các kiểu dữ liệu khác nhau được sắp xếp và không thể thay đổi (bất biến). Tuples được viết bằng dấu ngoặc tròn, (). Khi một bộ dữ liệu được tạo ra, chúng ta không thể thay đổi giá trị của nó. Chúng ta không thể sử dụng các phương thức thêm, chèn, loại bỏ trong một bộ vì nó không thể sửa đổi (mutable). Không giống như danh sách, tuple có ít phương pháp. Các phương pháp liên quan đến tuples:

- tuple(): để tạo một bộ trống
- count(): để đếm số lượng của một mục được chỉ định trong một bộ dữ liệu
- index(): để tìm chỉ mục của một mục được chỉ định trong một bộ dữ liệu
- Toán tử: để nối hai hoặc nhiều bộ và tạo một bộ mới
## Tạo một Tuple
- Bộ dữ liệu trống: Tạo một bộ trống
```
# syntax
empty_tuple = ()
# or using the tuple constructor
empty_tuple = tuple()
```
- Bộ dữ liệu với các giá trị ban đầu
```
# syntax
tpl = ('item1', 'item2','item3')
fruits = ('banana', 'orange', 'mango', 'lemon')
```
## Chiều dài tuple
Chúng ta sử dụng phương thức len() để lấy chiều dài của một tuple.
```
# syntax
tpl = ('item1', 'item2', 'item3')
len(tpl)
```
## Truy cập Tuple Items
Lập chỉ mục tích cực Tương tự như kiểu dữ liệu danh sách, chúng tôi sử dụng lập chỉ mục dương hoặc âm để truy cập các mục tuple. Truy cập các phần tu tuple

![](/Anh/Screenshot_441.png)

```
# Syntax
tpl = ('item1', 'item2', 'item3')
first_item = tpl[0]
second_item = tpl[1]
fruits = ('banana', 'orange', 'mango', 'lemon')
first_fruit = fruits[0]
second_fruit = fruits[1]
last_index =len(fruits) - 1
last_fruit = fruits[las_index]
```
Lập chỉ mục tiêu cực Lập chỉ mục phủ định có nghĩa là bắt đầu từ cuối, -1 đề cập đến mục cuối cùng, -2 đề cập đến mục cuối cùng thứ hai và âm của danh sách / độ dài bộ đề cập đến mục đầu tiên. Tuple Lập chỉ mục âm

# Syntax
tpl = ('item1', 'item2', 'item3','item4')
first_item = tpl[-4]
second_item = tpl[-3]
fruits = ('banana', 'orange', 'mango', 'lemon')
first_fruit = fruits[-4]
second_fruit = fruits[-3]
last_fruit = fruits[-1]
Cắt lát bộ
Chúng ta có thể cắt ra một bộ phụ bằng cách chỉ định một loạt các chỉ mục nơi bắt đầu và nơi kết thúc trong tuple, giá trị trả về sẽ là một bộ mới với các mục được chỉ định.

Phạm vi của các chỉ số tích cực

# Syntax
tpl = ('item1', 'item2', 'item3','item4')
all_items = tpl[0:4]         # all items
all_items = tpl[0:]         # all items
middle_two_items = tpl[1:3]  # does not include item at index 3
fruits = ('banana', 'orange', 'mango', 'lemon')
all_fruits = fruits[0:4]    # all items
all_fruits= fruits[0:]      # all items
orange_mango = fruits[1:3]  # doesn't include item at index 3
orange_to_the_rest = fruits[1:]
Phạm vi của các chỉ số tiêu cực

# Syntax
tpl = ('item1', 'item2', 'item3','item4')
all_items = tpl[-4:]         # all items
middle_two_items = tpl[-3:-1]  # does not include item at index 3 (-1)
fruits = ('banana', 'orange', 'mango', 'lemon')
all_fruits = fruits[-4:]    # all items
orange_mango = fruits[-3:-1]  # doesn't include item at index 3
orange_to_the_rest = fruits[-3:]
Thay đổi bộ dữ liệu thành danh sách
Chúng ta có thể thay đổi bộ dữ liệu thành danh sách và danh sách thành bộ dữ liệu. Tuple là bất biến, nếu chúng ta muốn sửa đổi một tuple, chúng ta nên thay đổi nó thành một danh sách.

# Syntax
tpl = ('item1', 'item2', 'item3','item4')
lst = list(tpl)
fruits = ('banana', 'orange', 'mango', 'lemon')
fruits = list(fruits)
fruits[0] = 'apple'
print(fruits)     # ['apple', 'orange', 'mango', 'lemon']
fruits = tuple(fruits)
print(fruits)     # ('apple', 'orange', 'mango', 'lemon')
Kiểm tra một mục trong bộ dữ liệu
Chúng ta có thể kiểm tra xem một mục có tồn tại hay không trong một bộ dữ liệu sử dụng in, nó trả về một boolean.

# Syntax
tpl = ('item1', 'item2', 'item3','item4')
'item2' in tpl # True
fruits = ('banana', 'orange', 'mango', 'lemon')
print('orange' in fruits) # True
print('apple' in fruits) # False
fruits[0] = 'apple' # TypeError: 'tuple' object does not support item assignment
Tham gia Tuples
Chúng ta có thể nối hai hoặc nhiều bộ bằng toán tử +

# syntax
tpl1 = ('item1', 'item2', 'item3')
tpl2 = ('item4', 'item5','item6')
tpl3 = tpl1 + tpl2
fruits = ('banana', 'orange', 'mango', 'lemon')
vegetables = ('Tomato', 'Potato', 'Cabbage','Onion', 'Carrot')
fruits_and_vegetables = fruits + vegetables
Xóa Tuples
Không thể loại bỏ một mục duy nhất trong một tuple, nhưng có thể xóa chính bộ dữ liệu bằng del.

# syntax
tpl1 = ('item1', 'item2', 'item3')
del tpl1
fruits = ('banana', 'orange', 'mango', 'lemon')
del fruits