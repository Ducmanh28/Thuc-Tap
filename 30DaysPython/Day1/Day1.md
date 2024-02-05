# Ngày thứ nhất: Giới thiệu về Python:

# Câu lệnh in ra cơ bản:
```
print()
```
Đây là một hàm dùng để in ra màn hình giá trị bên trong `()`
- Nhập `print()` và nhập nội dung cần in ra vào `()`

# Vậy nhập gì bên trong hàm `print()` ? 
Bạn có thể nhập dữ liệu kiểu text:
- Bằng cách sử dụng dấu `""`, bạn có thể in ra màn hình nội dung text trong `""`
- Ví dụ nhé:
```
print("Hello Python")  # Dòng này sẽ in ra chữ: Hello Python

print("2 + 2 = 4")  # Dòng này sẽ in ra: 2 + 2 = 4
```

Hoặc bạn cũng có thể in ra kiểu số
- Đối với kiểu số thực, số nguyên,... bạn nhập trực tiếp giá trị:
- Ví dụ:
```
print(5) # Sẽ in ra số: 5
```

Thậm chí kể cả một phép tính
- Như các ngôn ngữ lập trình khác, chúng ta cũng có thể thực hiện tính toán ở hàm Print()
- Ví dụ nhé:
```
print(5 + 5)    # Dòng này sẽ in ra: 10 vì (5 + 5 = 10)


# Kết hợp giữa text và phép tính, các giá trị ở trong hàm Print() sẽ được ngăn cách nhau bởi dấu phẩy ",". Chúng ta được kết quả như sau:

print("5 + 5 = ",5 + 5)    # Dòng này sẽ hiển thị ra màn hình: 5 + 5 = 10
```
## Một số phép tính cơ bản:
Ở Python, các phép toán được nhập và sử dụng rất dễ dàng. Bạn có thể tham khảo đoạn code sau:
```
print(2 + 3)   # phép cộng(+)
print(3 - 1)   # phép trừ(-)
print(2 * 3)   # phép nhân(*)
print(3 / 2)   # Phép chia (/)
print(3 ** 2)  # Phép lũy thừa(**)
print(3 % 2)   # Phép chia lấy dư(%)
print(3 // 2)  # Phép chia lấy phần nguyên và làm tròn(//)
```
Kết quả của đoạn code trên sẽ như sau:
```
5
2
6
1.5
9
1
1
```
## Kiểm tra dữ liệu bên trong
Để kiểm tra kiểu dữ liệu mà bạn đã nhập trong hàm print() rất đơn giản
- Hàm `type()` sẽ cho chúng ta biết nội dung trong `()` là kiểu dữ liệu gì
- Hàm `print()` sẽ in ra giá trị bên trong `()`
- Lúc này, ta chỉ cần lồng hàm `type()` vào bên trong hàm `print()`
- Ví dụ như sau:
```
print(type("Hello"))         # String 

print(type(10))              # Int

print(type(1+1))             # Int

print(type(3j+1))            # Complex
```

# Thực hành một số bài tập:
In ra một số nội dung cơ bản: 
![](/Anh/Screenshot_431.png)

Viết bài toán In ra màn hình chu vi và diện tích của một hình chữ nhật có chiều dài 15, chiều rộng 8
- Đặt chiều dài là `d` và rộng là `r`
- Như đã biết `P = (d * r)*2` và `V = d*r`
- Vậy việc của chúng ta đơn giản như sau:
```
print("P = 2 x (15 + 8) = ",(15+8)*2)   # In ra chu vi

print("V = 15 x 8 = ",15*8)             # In ra diện tích
```
- Kết quả:
- ![](/Anh/Screenshot_432.png)