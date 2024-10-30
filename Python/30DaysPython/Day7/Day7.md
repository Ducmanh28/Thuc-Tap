# Day7
## Bộ
Set là một tập hợp các vật phẩm. Hãy để tôi đưa bạn trở lại bài học Toán tiểu học hoặc trung học của bạn. Định nghĩa Toán học của một tập hợp cũng có thể được áp dụng trong Python. Tập hợp là một tập hợp các phần tử riêng biệt không có thứ tự và không được lập chỉ mục. Trong tập hợp Python được sử dụng để lưu trữ các mục duy nhất và có thể tìm thấy sự hợp nhất, giao điểm, sự khác biệt, sự khác biệt đối xứng, tập con, siêu tập hợp và tập rời rạc giữa các tập hợp.

## Tạo một học phần
Chúng ta sử dụng hàm set() built-in.

- Tạo một tập hợp trống
```
# syntax
st = set()
```
- Tạo một nhóm với các mục ban đầu
```
# syntax
st = {'item1', 'item2', 'item3', 'item4'}
```
Ví dụ:
```
# syntax
fruits = {'banana', 'orange', 'mango', 'lemon'}
```
## Lấy độ dài của thiết lập
Chúng ta sử dụng phương thức len() để tìm độ dài của một tập hợp.
```
# syntax
st = {'item1', 'item2', 'item3', 'item4'}
len(st)
```
Ví dụ:
```
fruits = {'banana', 'orange', 'mango', 'lemon'}
len(fruits)
```
## Truy cập các mục trong một nhóm
Chúng tôi sử dụng các vòng lặp để truy cập các mục. Chúng ta sẽ thấy điều này trong phần vòng lặp
## Kiểm tra một mục
Để kiểm tra xem một mục có tồn tại trong danh sách chúng tôi sử dụng trong nhà điều hành thành viên hay không.
```
# syntax
st = {'item1', 'item2', 'item3', 'item4'}
print("Does set st contain item3? ", 'item3' in st) # Does set st contain item3? True
```
Ví dụ:
```
fruits = {'banana', 'orange', 'mango', 'lemon'}
print('mango' in fruits ) # True
```
## Thêm mục vào nhóm
Khi một bộ được tạo, chúng tôi không thể thay đổi bất kỳ mục nào và chúng tôi cũng có thể thêm các mục bổ sung.

- Thêm một mục bằng add()
```
# syntax
st = {'item1', 'item2', 'item3', 'item4'}
st.add('item5')
```
Ví dụ:
```
fruits = {'banana', 'orange', 'mango', 'lemon'}
fruits.add('lime')
```
- Thêm nhiều mục bằng cách sử dụng update() Update() cho phép thêm nhiều mục vào một bộ. Update() lấy một đối số list.
```
# syntax
st = {'item1', 'item2', 'item3', 'item4'}
st.update(['item5','item6','item7'])
```
Ví dụ:
```
fruits = {'banana', 'orange', 'mango', 'lemon'}
vegetables = ('tomato', 'potato', 'cabbage','onion', 'carrot')
fruits.update(vegetables)
```
## Loại bỏ các mục khỏi một nhóm
Chúng ta có thể xóa một item khỏi một tập hợp bằng phương thức remove(). Nếu không tìm thấy item remove() method sẽ gây ra lỗi, vì vậy bạn nên kiểm tra xem item có tồn tại trong tập hợp đã cho hay không. Tuy nhiên, phương thức discard() không gây ra bất kỳ lỗi nào.
```
# syntax
st = {'item1', 'item2', 'item3', 'item4'}
st.remove('item2')
```
- Các phương thức pop() loại bỏ một mục ngẫu nhiên khỏi danh sách và nó trả về mục bị xóa.

Ví dụ:
```
fruits = {'banana', 'orange', 'mango', 'lemon'}
fruits.pop()  # removes a random item from the set
```
Nếu chúng tôi quan tâm đến mục bị xóa.
```
fruits = {'banana', 'orange', 'mango', 'lemon'}
removed_item = fruits.pop() 
```
## Xóa các mục trong một nhóm
Nếu chúng ta muốn xóa hoặc làm trống tập hợp, chúng ta sử dụng phương pháp clear.
```
# syntax
st = {'item1', 'item2', 'item3', 'item4'}
st.clear()
```
Ví dụ:
```
fruits = {'banana', 'orange', 'mango', 'lemon'}
fruits.clear()
print(fruits) # set()
```
## Xóa học phần
Nếu chúng ta muốn xóa chính tập hợp, chúng ta sử dụng toán tử del.
```
# syntax
st = {'item1', 'item2', 'item3', 'item4'}
del st
```
Ví dụ:
```
fruits = {'banana', 'orange', 'mango', 'lemon'}
del fruits
```
## Chuyển đổi danh sách thành thiết lập
Chúng tôi có thể chuyển đổi danh sách để thiết lập và thiết lập vào danh sách. Chuyển đổi danh sách để đặt sẽ loại bỏ các bản sao và chỉ các mục duy nhất sẽ được đặt trước.
```
# syntax
lst = ['item1', 'item2', 'item3', 'item4', 'item1']
st = set(lst)  # {'item2', 'item4', 'item1', 'item3'} - the order is random, because sets in general are unordered
```
Ví dụ:
```
fruits = ['banana', 'orange', 'mango', 'lemon','orange', 'banana']
fruits = set(fruits) # {'mango', 'lemon', 'banana', 'orange'}
```
## Tham gia bộ
Chúng ta có thể nối hai tập hợp bằng phương thức union() hoặc update().

Liên minh Phương thức này trả về một tập hợp mới
```
# syntax
st1 = {'item1', 'item2', 'item3', 'item4'}
st2 = {'item5', 'item6', 'item7', 'item8'}
st3 = st1.union(st2)
```
Ví dụ:
```
fruits = {'banana', 'orange', 'mango', 'lemon'}
vegetables = {'tomato', 'potato', 'cabbage','onion', 'carrot'}
print(fruits.union(vegetables)) # {'lemon', 'carrot', 'tomato', 'banana', 'mango', 'orange', 'cabbage', 'potato', 'onion'}
Cập nhật Phương thức này chèn một tập hợp vào một tập hợp nhất định

# syntax
st1 = {'item1', 'item2', 'item3', 'item4'}
st2 = {'item5', 'item6', 'item7', 'item8'}
st1.update(st2) # st2 contents are added to st1
```
Ví dụ:
```
fruits = {'banana', 'orange', 'mango', 'lemon'}
vegetables = {'tomato', 'potato', 'cabbage','onion', 'carrot'}
fruits.update(vegetables)
print(fruits) # {'lemon', 'carrot', 'tomato', 'banana', 'mango', 'orange', 'cabbage', 'potato', 'onion'}
```
## Tìm các hạng mục giao lộ
Giao lộ trả về một tập hợp các mục nằm trong cả hai bộ. Xem ví dụ
```
# syntax
st1 = {'item1', 'item2', 'item3', 'item4'}
st2 = {'item3', 'item2'}
st1.intersection(st2) # {'item3', 'item2'}
```
Ví dụ:
```
whole_numbers = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
even_numbers = {0, 2, 4, 6, 8, 10}
whole_numbers.intersection(even_numbers) # {0, 2, 4, 6, 8, 10}

python = {'p', 'y', 't', 'h', 'o','n'}
dragon = {'d', 'r', 'a', 'g', 'o','n'}
python.intersection(dragon)     # {'o', 'n'}
```

## Kiểm tra tập con và siêu tập hợp
Một tập hợp có thể là một tập con hoặc siêu tập hợp của các tập hợp khác:

- Tập con: issubset()
- Siêu bộ: issuperset
```
# syntax
st1 = {'item1', 'item2', 'item3', 'item4'}
st2 = {'item2', 'item3'}
st2.issubset(st1) # True
st1.issuperset(st2) # True
```
Ví dụ:
```
whole_numbers = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
even_numbers = {0, 2, 4, 6, 8, 10}
whole_numbers.issubset(even_numbers) # False, because it is a super set
whole_numbers.issuperset(even_numbers) # True

python = {'p', 'y', 't', 'h', 'o','n'}
dragon = {'d', 'r', 'a', 'g', 'o','n'}
python.issubset(dragon)     # False
```

## Kiểm tra sự khác biệt giữa hai bộ
Nó trả về sự khác biệt giữa hai bộ.
```
# syntax
st1 = {'item1', 'item2', 'item3', 'item4'}
st2 = {'item2', 'item3'}
st2.difference(st1) # set()
st1.difference(st2) # {'item1', 'item4'} => st1\st2
```
Ví dụ:
```
whole_numbers = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
even_numbers = {0, 2, 4, 6, 8, 10}
whole_numbers.difference(even_numbers) # {1, 3, 5, 7, 9}

python = {'p', 'y', 't', 'o','n'}
dragon = {'d', 'r', 'a', 'g', 'o','n'}
python.difference(dragon)     # {'p', 'y', 't'}  - the result is unordered (characteristic of sets)
dragon.difference(python)     # {'d', 'r', 'a', 'g'}
```
## Tìm sự khác biệt đối xứng giữa hai bộ
Nó trả về sự khác biệt đối xứng giữa hai bộ. Nó có nghĩa là nó trả về một tập hợp chứa tất cả các mục từ cả hai tập hợp, ngoại trừ các mục có trong cả hai tập hợp, về mặt toán học: (A \ B) ∪ (B \ A)
```
# syntax
st1 = {'item1', 'item2', 'item3', 'item4'}
st2 = {'item2', 'item3'}
# it means (A\B)∪(B\A)
st2.symmetric_difference(st1) # {'item1', 'item4'}
```
Ví dụ:
```
whole_numbers = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
some_numbers = {1, 2, 3, 4, 5}
whole_numbers.symmetric_difference(some_numbers) # {0, 6, 7, 8, 9, 10}

python = {'p', 'y', 't', 'h', 'o','n'}
dragon = {'d', 'r', 'a', 'g', 'o','n'}
python.symmetric_difference(dragon)  # {'r', 't', 'p', 'y', 'g', 'a', 'd', 'h'}
```
## Tham gia bộ
Nếu hai bộ không có một mục hoặc vật phẩm chung, chúng tôi gọi chúng là tập rời rạc. Chúng ta có thể kiểm tra xem hai tập hợp là khớp hay rời rạc bằng phương thức isdisjoint().
```
# syntax
st1 = {'item1', 'item2', 'item3', 'item4'}
st2 = {'item2', 'item3'}
st2.isdisjoint(st1) # False
```
Vi du:
```
even_numbers = {0, 2, 4 ,6, 8}
even_numbers = {1, 3, 5, 7, 9}
even_numbers.isdisjoint(odd_numbers) # True, because no common item

python = {'p', 'y', 't', 'h', 'o','n'}
dragon = {'d', 'r', 'a', 'g', 'o','n'}
python.isdisjoint(dragon)  # False, there are common items {'o', 'n'}
```