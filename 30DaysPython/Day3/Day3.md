# Khám phá Các Toán Tử Trong Python
Python là một ngôn ngữ lập trình mạnh mẽ với một loạt các toán tử cho phép bạn thực hiện các phép tính và so sánh khác nhau một cách dễ dàng và linh hoạt

## Toán Tử Số Học
### Cộng, Trừ, Nhân và Chia
Toán tử số học cơ bản nhất trong Python bao gồm:

- Cộng (+): Dùng để cộng hai giá trị với nhau.
- Trừ (-): Dùng để trừ giá trị bên trái cho giá trị bên phải.
- Nhân (*): Dùng để nhân hai giá trị với nhau.
- Chia (/): Dùng để chia giá trị bên trái cho giá trị bên phải.

```
a = 10
b = 5

print(a + b)  # Kết quả: 15
print(a - b)  # Kết quả: 5
print(a * b)  # Kết quả: 50
print(a / b)  # Kết quả: 2.0
```
### Chia Lấy Phần Nguyên (//) và Chia Lấy Dư (%)
Ngoài ra, Python cũng cung cấp hai toán tử khác liên quan đến chia là:

- Chia lấy phần nguyên (//): Trả về kết quả của phép chia với phần thập phân bị loại bỏ.
- Chia lấy dư (%): Trả về phần dư của phép chia.
```
print(a // b)  # Kết quả: 2
print(a % b)   # Kết quả: 0
```
## Toán Tử So Sánh
So Sánh Bằng (==) và Khác (!=). Toán tử so sánh cho phép bạn so sánh hai giá trị và trả về một giá trị boolean:
- So sánh bằng (==): Trả về True nếu hai giá trị bằng nhau, ngược lại trả về False.
- So sánh khác (!=): Trả về True nếu hai giá trị không bằng nhau, ngược lại trả về False.
```
x = 10
y = 5

print(x == y)  # Kết quả: False
print(x != y)  # Kết quả: True
```
So sánh hơn(nhỏ) và hơn hoặc bằng(nhỏ hoặc bằng)
- So sánh hơn(hơn hoặc bằng): Trả về true nếu giá trị x > y hoặc x = y.
- So sánh nhỏ(nhỏ hoặc bằng): Trả về true nếu giá trị x < y hoặc x = y.
```
x = 7 
y = 9
z = 9

print(x > y)    # Kết quả: False
print(x >= y)   # Kết quả: False
print(x < y)    # Kết quả: True
print(x <= y)   # Kết quả: True
print(y <= z)   # Kết quả: True
print(y >= z)   # Kết quả: True
```
## Toán Tử Logic
Và (and), Hoặc (or) và Không (not)

Toán tử logic cho phép bạn kết hợp nhiều điều kiện và kiểm tra chúng:
- Và (and): Trả về True nếu cả hai điều kiện đều là True.
- Hoặc (or): Trả về True nếu ít nhất một trong hai điều kiện là True.
- Không (not): Đảo ngược giá trị của biểu thức.
```
p = True
q = False

print(p and q)  # Kết quả: False
print(p or q)   # Kết quả: True
print(not p)    # Kết quả: False
```