# Day5: List
## Danh sách
Có bốn kiểu dữ liệu thu thập trong Python:
- Danh sách: là một bộ sưu tập được sắp xếp và thay đổi (có thể sửa đổi). Cho phép các thành viên trùng lặp.
- Tuple: là một tập hợp được sắp xếp và không thể thay đổi hoặc không thể sửa đổi (bất biến). Cho phép các thành viên trùng lặp.
- Set: là một bộ sưu tập không có thứ tự, không được lập chỉ mục và không thể sửa đổi, nhưng chúng ta có thể thêm các mục mới vào bộ. Thành viên trùng lặp không được phép.
- Từ điển: là một tập hợp không có thứ tự, có thể thay đổi (có thể sửa đổi) và được lập chỉ mục. Không có thành viên trùng lặp.
Danh sách là tập hợp các kiểu dữ liệu khác nhau được sắp xếp và có thể sửa đổi (có thể thay đổi). Một danh sách có thể trống hoặc nó có thể có các mục kiểu dữ liệu khác nhau.

## Cách tạo danh sách
Trong Python, chúng ta có thể tạo danh sách theo hai cách:

- Sử dụng chức năng tích hợp sẵn danh sách
```
# syntax
lst = list()
empty_list = list() # this is an empty list, no item in the list
print(len(empty_list)) # 0
```
- Sử dụng dấu ngoặc vuông, []
```
# syntax
lst = []
empty_list = [] # this is an empty list, no item in the list
print(len(empty_list)) # 0
```
Danh sách có giá trị ban đầu. Chúng ta sử dụng len() để tìm độ dài của một danh sách.
```
fruits = ['banana', 'orange', 'mango', 'lemon']                     # list of fruits
vegetables = ['Tomato', 'Potato', 'Cabbage','Onion', 'Carrot']      # list of vegetables
animal_products = ['milk', 'meat', 'butter', 'yoghurt']             # list of animal products
web_techs = ['HTML', 'CSS', 'JS', 'React','Redux', 'Node', 'MongDB'] # list of web technologies
countries = ['Finland', 'Estonia', 'Denmark', 'Sweden', 'Norway']

# Print the lists and its length
print('Fruits:', fruits)
print('Number of fruits:', len(fruits))
print('Vegetables:', vegetables)
print('Number of vegetables:', len(vegetables))
print('Animal products:',animal_products)
print('Number of animal products:', len(animal_products))
print('Web technologies:', web_techs)
print('Number of web technologies:', len(web_techs))
print('Countries:', countries)
print('Number of countries:', len(countries))
```
```
output
Fruits: ['banana', 'orange', 'mango', 'lemon']
Number of fruits: 4
Vegetables: ['Tomato', 'Potato', 'Cabbage', 'Onion', 'Carrot']
Number of vegetables: 5
Animal products: ['milk', 'meat', 'butter', 'yoghurt']
Number of animal products: 4
Web technologies: ['HTML', 'CSS', 'JS', 'React', 'Redux', 'Node', 'MongDB']
Number of web technologies: 7
Countries: ['Finland', 'Estonia', 'Denmark', 'Sweden', 'Norway']
Number of countries: 5
```
- Danh sách có thể có các mục thuộc các kiểu dữ liệu khác nhau
```
lst = ['Asabeneh', 250, True, {'country':'Finland', 'city':'Helsinki'}] # list containing different data types
```
### Truy cập các mục danh sách bằng cách sử dụng lập chỉ mục tích cực

Chúng tôi truy cập từng mục trong danh sách bằng cách sử dụng chỉ mục của chúng. Chỉ mục danh sách bắt đầu từ 0. Hình dưới đây cho thấy rõ ràng nơi chỉ mục bắt đầu List index

![](/Anh/Screenshot_438.png)
```
fruits = ['banana', 'orange', 'mango', 'lemon']
first_fruit = fruits[0] # we are accessing the first item using its index
print(first_fruit)      # banana
second_fruit = fruits[1]
print(second_fruit)     # orange
last_fruit = fruits[3]
print(last_fruit) # lemon
# Last index
last_index = len(fruits) - 1
last_fruit = fruits[last_index]
```
### Truy cập các mục danh sách bằng cách sử dụng lập chỉ mục phủ định

Lập chỉ mục phủ định có nghĩa là bắt đầu từ cuối, -1 đề cập đến mục cuối cùng, -2 đề cập đến mục cuối cùng thứ hai.

![](/Anh/Screenshot_440.png)

``
List negative indexing

fruits = ['banana', 'orange', 'mango', 'lemon']
first_fruit = fruits[-4]
last_fruit = fruits[-1]
second_last = fruits[-2]
print(first_fruit)      # banana
print(last_fruit)       # lemon
print(second_last)      # mango
```
Giải nén các mục danh sách
lst = ['item1','item2','item3', 'item4', 'item5']
first_item, second_item, third_item, *rest = lst
print(first_item)     # item1
print(second_item)    # item2
print(third_item)     # item3
print(rest)           # ['item4', 'item5']
# First Example
fruits = ['banana', 'orange', 'mango', 'lemon','lime','apple']
first_fruit, second_fruit, third_fruit, *rest = fruits 
print(first_fruit)     # banana
print(second_fruit)    # orange
print(third_fruit)     # mango
print(rest)           # ['lemon','lime','apple']
# Second Example about unpacking list
first, second, third,*rest, tenth = [1,2,3,4,5,6,7,8,9,10]
print(first)          # 1
print(second)         # 2
print(third)          # 3
print(rest)           # [4,5,6,7,8,9]
print(tenth)          # 10
# Third Example about unpacking list
countries = ['Germany', 'France','Belgium','Sweden','Denmark','Finland','Norway','Iceland','Estonia']
gr, fr, bg, sw, *scandic, es = countries
print(gr)
print(fr)
print(bg)
print(sw)
print(scandic)
print(es)
```
### Cắt Mục từ Danh sách
- Lập chỉ mục tích cực: Chúng ta có thể chỉ định một loạt các chỉ số dương bằng cách chỉ định bắt đầu, kết thúc và bước, giá trị trả về sẽ là một danh sách mới. (giá trị mặc định cho start = 0, end = len(lst) - 1 (mục cuối cùng), bước = 1)
```
fruits = ['banana', 'orange', 'mango', 'lemon']
all_fruits = fruits[0:4] # it returns all the fruits
# this will also give the same result as the one above
all_fruits = fruits[0:] # if we don't set where to stop it takes all the rest
orange_and_mango = fruits[1:3] # it does not include the first index
orange_mango_lemon = fruits[1:]
orange_and_lemon = fruits[::2] # here we used a 3rd argument, step. It will take every 2cnd item - ['banana', 'mango']
```
- Lập chỉ mục âm: Chúng ta có thể chỉ định một loạt các chỉ số phủ định bằng cách chỉ định bắt đầu, kết thúc và bước, giá trị trả về sẽ là một danh sách mới.
```
fruits = ['banana', 'orange', 'mango', 'lemon']
all_fruits = fruits[-4:] # it returns all the fruits
orange_and_mango = fruits[-3:-1] # it does not include the last index,['orange', 'mango']
orange_mango_lemon = fruits[-3:] # this will give starting from -3 to the end,['orange', 'mango', 'lemon']
reverse_fruits = fruits[::-1] # a negative step will take the list in reverse order,['lemon', 'mango', 'orange', 'banana']
```
### Sửa đổi danh sách
Danh sách là một tập hợp các mục có thứ tự có thể thay đổi hoặc có thể sửa đổi. Cho phép sửa đổi danh sách trái cây.
```
fruits = ['banana', 'orange', 'mango', 'lemon']
fruits[0] = 'avocado'
print(fruits)       #  ['avocado', 'orange', 'mango', 'lemon']
fruits[1] = 'apple'
print(fruits)       #  ['avocado', 'apple', 'mango', 'lemon']
last_index = len(fruits) - 1
fruits[last_index] = 'lime'
print(fruits)        #  ['avocado', 'apple', 'mango', 'lime']
```
### Kiểm tra các mục trong danh sách
Kiểm tra một mục nếu nó là một thành viên của một danh sách sử dụng trong toán tử. Xem ví dụ bên dưới.
```
fruits = ['banana', 'orange', 'mango', 'lemon']
does_exist = 'banana' in fruits
print(does_exist)  # True
does_exist = 'lime' in fruits
print(does_exist)  # False
```
### Thêm mục vào danh sách
Để thêm item vào cuối danh sách hiện có, chúng ta sử dụng phương thức append().
```
# syntax
lst = list()
lst.append(item)
fruits = ['banana', 'orange', 'mango', 'lemon']
fruits.append('apple')
print(fruits)           # ['banana', 'orange', 'mango', 'lemon', 'apple']
fruits.append('lime')   # ['banana', 'orange', 'mango', 'lemon', 'apple', 'lime']
print(fruits)
```
### Chèn mục vào danh sách
Chúng ta có thể sử dụng phương thức insert() để chèn một mục duy nhất tại một chỉ mục được chỉ định trong danh sách. Lưu ý rằng các mục khác được chuyển sang phải. Các phương thức insert() lấy hai đối số:index và một item để chèn.
```
# syntax
lst = ['item1', 'item2']
lst.insert(index, item)
fruits = ['banana', 'orange', 'mango', 'lemon']
fruits.insert(2, 'apple') # insert apple between orange and mango
print(fruits)           # ['banana', 'orange', 'apple', 'mango', 'lemon']
fruits.insert(3, 'lime')   # ['banana', 'orange', 'apple', 'lime', 'mango', 'lemon']
print(fruits)
```
- Loại bỏ các mục khỏi danh sách
Phương pháp loại bỏ loại bỏ một mục được chỉ định khỏi danh sách
```
# syntax
lst = ['item1', 'item2']
lst.remove(item)
fruits = ['banana', 'orange', 'mango', 'lemon', 'banana']
fruits.remove('banana')
print(fruits)  # ['orange', 'mango', 'lemon', 'banana'] - this method removes the first occurrence of the item in the list
fruits.remove('lemon')
print(fruits)  # ['orange', 'mango', 'banana']
```
### Xóa mục bằng Pop
Phương thức pop() loại bỏ chỉ mục được chỉ định, (hoặc mục cuối cùng nếu chỉ mục không được chỉ định):
```
# syntax
lst = ['item1', 'item2']
lst.pop()       # last item
lst.pop(index)
fruits = ['banana', 'orange', 'mango', 'lemon']
fruits.pop()
print(fruits)       # ['banana', 'orange', 'mango']

fruits.pop(0)
print(fruits)       # ['orange', 'mango']
```
### Xóa các mục bằng Del
Từ khóa del loại bỏ chỉ mục được chỉ định và nó cũng có thể được sử dụng để xóa các mục trong phạm vi chỉ mục. Nó cũng có thể xóa hoàn toàn danh sách
```
# syntax
lst = ['item1', 'item2']
del lst[index] # only a single item
del lst        # to delete the list completely
fruits = ['banana', 'orange', 'mango', 'lemon', 'kiwi', 'lime']
del fruits[0]
print(fruits)       # ['orange', 'mango', 'lemon', 'kiwi', 'lime']
del fruits[1]
print(fruits)       # ['orange', 'lemon', 'kiwi', 'lime']
del fruits[1:3]     # this deletes items between given indexes, so it does not delete the item with index 3!
print(fruits)       # ['orange', 'lime']
del fruits
print(fruits)       # This should give: NameError: name 'fruits' is not defined
```
### Xóa các mục danh sách
Phương thức clear() làm trống danh sách:
```
# syntax
lst = ['item1', 'item2']
lst.clear()
fruits = ['banana', 'orange', 'mango', 'lemon']
fruits.clear()
print(fruits)       # []
```
### Sao chép danh sách
Có thể sao chép một danh sách bằng cách gán lại nó cho một biến mới theo cách sau: list2 = list1. Bây giờ, list2 là một tham chiếu của list1, bất kỳ thay đổi nào chúng tôi thực hiện trong list2 cũng sẽ sửa đổi bản gốc, list1. Nhưng có rất nhiều trường hợp chúng tôi không muốn sửa đổi bản gốc, thay vào đó chúng tôi muốn có một bản sao khác. Một trong những cách để tránh vấn đề trên là sử dụng copy().
```
# syntax
lst = ['item1', 'item2']
lst_copy = lst.copy()
fruits = ['banana', 'orange', 'mango', 'lemon']
fruits_copy = fruits.copy()
print(fruits_copy)       # ['banana', 'orange', 'mango', 'lemon']
```
### Danh sách tham gia
Có một số cách để nối hoặc ghép nối hai hoặc nhiều danh sách trong Python.

- Toán tử Plus (+)
```
# syntax
list3 = list1 + list2
positive_numbers = [1, 2, 3, 4, 5]
zero = [0]
negative_numbers = [-5,-4,-3,-2,-1]
integers = negative_numbers + zero + positive_numbers
print(integers) # [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]
fruits = ['banana', 'orange', 'mango', 'lemon']
vegetables = ['Tomato', 'Potato', 'Cabbage', 'Onion', 'Carrot']
fruits_and_vegetables = fruits + vegetables
print(fruits_and_vegetables ) # ['banana', 'orange', 'mango', 'lemon', 'Tomato', 'Potato', 'Cabbage', 'Onion', 'Carrot']
```
Tham gia bằng phương thức extend() Phương thức extend() cho phép thêm danh sách vào một danh sách. Xem ví dụ bên dưới.
```
# syntax
list1 = ['item1', 'item2']
list2 = ['item3', 'item4', 'item5']
list1.extend(list2)
num1 = [0, 1, 2, 3]
num2= [4, 5, 6]
num1.extend(num2)
print('Numbers:', num1) # Numbers: [0, 1, 2, 3, 4, 5, 6]
negative_numbers = [-5,-4,-3,-2,-1]
positive_numbers = [1, 2, 3,4,5]
zero = [0]

negative_numbers.extend(zero)
negative_numbers.extend(positive_numbers)
print('Integers:', negative_numbers) # Integers: [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]
fruits = ['banana', 'orange', 'mango', 'lemon']
vegetables = ['Tomato', 'Potato', 'Cabbage', 'Onion', 'Carrot']
fruits.extend(vegetables)
print('Fruits and vegetables:', fruits ) # Fruits and vegetables: ['banana', 'orange', 'mango', 'lemon', 'Tomato', 'Potato', 'Cabbage', 'Onion', 'Carrot']
```
### Đếm các mục trong danh sách
Phương thức count() trả về số lần một mục xuất hiện trong danh sách:
```
# syntax
lst = ['item1', 'item2']
lst.count(item)
fruits = ['banana', 'orange', 'mango', 'lemon']
print(fruits.count('orange'))   # 1
ages = [22, 19, 24, 25, 26, 24, 25, 24]
print(ages.count(24))           # 3
```
### Tìm chỉ mục của một mục
Phương thức index() trả về chỉ mục của một mục trong danh sách:
```
# syntax
lst = ['item1', 'item2']
lst.index(item)
fruits = ['banana', 'orange', 'mango', 'lemon']
print(fruits.index('orange'))   # 1
ages = [22, 19, 24, 25, 26, 24, 25, 24]
print(ages.index(24))           # 2, the first occurrence
```
### Đảo ngược danh sách
Phương thức reverse() đảo ngược thứ tự của một danh sách.
```
# syntax
lst = ['item1', 'item2']
lst.reverse()
fruits = ['banana', 'orange', 'mango', 'lemon']
fruits.reverse()
print(fruits) # ['lemon', 'mango', 'orange', 'banana']
ages = [22, 19, 24, 25, 26, 24, 25, 24]
ages.reverse()
print(ages) # [24, 25, 24, 26, 25, 24, 19, 22]
```
### Sắp xếp các mục danh sách
Để sắp xếp danh sách, chúng ta có thể sử dụng phương thức sort() hoặc các hàm tích hợp sẵn sorted(). Phương thức sort() sắp xếp lại các mục danh sách theo thứ tự tăng dần và sửa đổi danh sách ban đầu. Nếu một đối số của phương thức sort() reverse bằng true, nó sẽ sắp xếp danh sách theo thứ tự giảm dần.

- sort(): phương thức này sửa đổi danh sách ban đầu
```
# syntax
lst = ['item1', 'item2']
lst.sort()                # ascending
lst.sort(reverse=True)    # descending
```
Ví dụ:
```
fruits = ['banana', 'orange', 'mango', 'lemon']
fruits.sort()
print(fruits)             # sorted in alphabetical order, ['banana', 'lemon', 'mango', 'orange']
fruits.sort(reverse=True)
print(fruits) # ['orange', 'mango', 'lemon', 'banana']
ages = [22, 19, 24, 25, 26, 24, 25, 24]
ages.sort()
print(ages) #  [19, 22, 24, 24, 24, 25, 25, 26]

ages.sort(reverse=True)
print(ages) #  [26, 25, 25, 24, 24, 24, 22, 19]
```
- sorted(): trả về danh sách có thứ tự mà không sửa đổi danh sách gốc Ví dụ:
```
fruits = ['banana', 'orange', 'mango', 'lemon']
print(sorted(fruits))   # ['banana', 'lemon', 'mango', 'orange']
# Reverse order
fruits = ['banana', 'orange', 'mango', 'lemon']
fruits = sorted(fruits,reverse=True)
print(fruits)     # ['orange', 'mango', 'lemon', 'banana']
```