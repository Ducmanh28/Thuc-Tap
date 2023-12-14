# Thực hành làm bài tập chia Subnet:
MỤC LỤC
- [Thực hành làm bài tập chia Subnet:](#thực-hành-làm-bài-tập-chia-subnet)
  - [Dạng 1: Dạng xuôi](#dạng-1-dạng-xuôi)
    - [Một số lưu ý trước khi thực hành làm bài tập](#một-số-lưu-ý-trước-khi-thực-hành-làm-bài-tập)
    - [Tiến hành làm bài](#tiến-hành-làm-bài)
      - [Bài 1](#bài-1)
      - [Bài 2](#bài-2)

## Dạng 1: Dạng xuôi
### Một số lưu ý trước khi thực hành làm bài tập
- Ví dụ mượn n bits từ Host để lấy làm Network
- Số Subnet tối đa: 2^n
- Số Host/Subnet: (2^m) - 2 
  - Với m là số bits còn lại phần Host
  - (-2) do 1 địa chỉ làm địa chỉ mạng, 1 địa chỉ làm địa chỉ Broadcast
- Bước nhảy: 2^x 
  - Với x = 8 - n
  - Ví dụ về bước nhảy:
  - ![](/Anh/Screenshot_83.png)
### Tiến hành làm bài
#### Bài 1
- Đề bài: Có dải địa chỉ `192.168.68.0/24`, mượn 2 bits
- Giải:
  - Số Subnet: 4
  - Số Host/Subnet: 62
  - Bước nhảy: 64
  - Liệt kê các dải mạng:
    - `192.168.68.0/26`
    - `192.168.68.64/26`
    - `192.168.68.128/26`
    - `192.168.68.192/26`  

#### Bài 2
- Đề bài: Có dải địa chỉ `14.20.32.0/19` mượn 2 bits 
- Giải: 
  - Số Subnet: 4
  - Số Host/Subnet: 2048
  - Bước nhảy: 8
  - Liệt kê các dải mạng:
    - `14.20.32.0/21`
    - `14.20.40.0/21`
    - `14.20.48.0/21`
    - `14.20.56.0/21` 
