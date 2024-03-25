# Thực hành làm bài tập chia Subnet:
MỤC LỤC
- [Thực hành làm bài tập chia Subnet:](#thực-hành-làm-bài-tập-chia-subnet)
  - [Dạng 1: Dạng xuôi](#dạng-1-dạng-xuôi)
    - [Một số lưu ý trước khi thực hành làm bài tập](#một-số-lưu-ý-trước-khi-thực-hành-làm-bài-tập)
    - [Tiến hành làm bài](#tiến-hành-làm-bài)
      - [Bài 1](#bài-1)
      - [Bài 2](#bài-2)
      - [Bài 3](#bài-3)
      - [Bài 4](#bài-4)
      - [Bài 5:](#bài-5)
      - [Bài 6:](#bài-6)
      - [Bài 7:](#bài-7)
      - [Bài 8:](#bài-8)
      - [Bài 9:](#bài-9)

## Dạng 1: Dạng xuôi
### Một số lưu ý trước khi thực hành làm bài tập
- Ví dụ mượn n bits từ Host để lấy làm Network
- Số Subnet tối đa: 2^n
- Số Host/Subnet: (2^m) - 2 
  - Với m là số bits còn lại phần Host
  - (-2) do 1 địa chỉ làm địa chỉ mạng, 1 địa chỉ làm địa chỉ Broadcast
- Bước nhảy: 2^x 
  - Với x = (32 - pre - bits mượn)%8
  - Ví dụ về bước nhảy:
  - ![](/Anh/Screenshot_83.png)
### Tiến hành làm bài
#### Bài 1
- Đề bài: Có dải địa chỉ `14.20.32.0/19`, mượn 1 bits
- Giải:
  - Subnets: 2
  - Host/Subnet: 4094
  - Jump: 16
  - Subnet 1: `14.10.32.0/20`
  - Subnet 2: `14.10.48.0/20`

#### Bài 2
- Đề bài: Có dải địa chỉ `14.20.32.0/19` mượn 2 bits 
- Giải: 
  - Số Subnet: 4
  - Số Host/Subnet: 2046
  - Bước nhảy: 8
  - Liệt kê các dải mạng:
    - `14.20.32.0/21`
    - `14.20.40.0/21`
    - `14.20.48.0/21`
    - `14.20.56.0/21` 

#### Bài 3
- Đề bài: Có dải địa chỉ `14.20.32.0/19` mượn 3 bits 
- Giải:
  - Số Subnet: 8
  - Số Host/Subnet: 1022
  - Bước nhảy: 4
  - Liệt kê các dải mạng:
    - Subnet 1: `14.20.32.0/22`
    - Subnet 2: `14.20.36.0/22`
    - Subnet 3: `14.20.40.0/22`
    - Subnet 4: `14.20.44.0/22`
    - Subnet 5: `14.20.48.0/22`
    - Subnet 6: `14.20.52.0/22`
    - Subnet 7: `14.20.56.0/22`
    - Subnet 8: `14.20.60.0/22`
#### Bài 4 
- Đề bài: Có dải địa chỉ `14.20.32.0/19` mượn 4 bits 
- Giải:
  - Số Subnet: 8
  - Số Host/Subnet: 1022
  - Bước nhảy: 4
  - Liệt kê các dải mạng:
    - Subnet 1:  `14.20.32.0/23`
    - Subnet 2:  `14.20.34.0/23`
    - Subnet 3:  `14.20.36.0/23`
    - Subnet 4:  `14.20.38.0/23`
    - Subnet 5:  `14.20.40.0/23`
    - Subnet 6:  `14.20.42.0/23`
    - Subnet 7:  `14.20.44.0/23`
    - Subnet 8:  `14.20.46.0/23`
    - Subnet 9:  `14.20.48.0/23`
    - Subnet 10: `14.20.50.0/23`
    - Subnet 11: `14.20.52.0/23`
    - Subnet 12: `14.20.54.0/23`
    - Subnet 13: `14.20.56.0/23`
    - Subnet 14: `14.20.58.0/23`
    - Subnet 15: `14.20.60.0/23`
    - Subnet 16: `14.20.62.0/23`
#### Bài 5:
- Đề bài: Có dải địa chỉ `192.168.68.0/24` mượn 1 bits
- Giải:
  - Số Subnet: 2
  - Số Host/Subnet: 126
  - Bước nhảy: 128
  - Liệt kê các dải mạng:
    - Subnet 1: `192.168.68.0/25`
    - Subnet 2: `192.168.68.128/25`
#### Bài 6:
- Đề bài: Có dải địa chỉ `192.168.68.0/24` mượn 2 bits
- Giải:
  - Số Subnet: 4
  - Số Host/Subnet: 62
  - Bước nhảy: 64
  - Liệt kê các dải mạng:
    - Subnet 1: `192.168.68.0/26`
    - Subnet 2: `192.168.68.64/26`
    - Subnet 3: `192.168.68.128/26`
    - Subnet 4: `192.168.68.192/26`
#### Bài 7:
- Đề bài: Có dải địa chỉ `192.168.68.0/24` mượn 3 bits
- Giải:
  - Số Subnet: 8
  - Số Host/Subnet: 30
  - Bước nhảy: 32
  - Liệt kê các dải mạng:
    - Subnet 1: `192.168.68.0/27`
    - Subnet 2: `192.168.68.32/27`
    - Subnet 3: `192.168.68.64/27`
    - Subnet 4: `192.168.68.96/27`
    - Subnet 5: `192.168.68.128/27`
    - Subnet 6: `192.168.68.160/27`
    - Subnet 7: `192.168.68.192/27`
    - Subnet 8: `192.168.68.224/27`
#### Bài 8:
- Đề bài: Có dải địa chỉ `192.168.68.0/24` mượn 4 bits
- Giải:
  - Số Subnet: 8
  - Số Host/Subnet: 14
  - Bước nhảy: 16
  - Liệt kê các dải mạng:
    - Subnet 1: `190.168.68.0/28`
    - Subnet 2: `190.168.68.16/28`
    - Subnet 3: `190.168.68.32/28`
    - Subnet 4: `190.168.68.48/28`
    - Subnet 5: `190.168.68.64/28`
    - Subnet 6: `190.168.68.80/28`
    - Subnet 7: `190.168.68.96/28`
    - Subnet 8: `190.168.68.112/28`
    - Subnet 9: `190.168.68.128/28`
    - Subnet 10: `190.168.68.144/28`
    - Subnet 11: `190.168.68.160/28`
    - Subnet 12: `190.168.68.176/28`
    - Subnet 13: `190.168.68.192/28`
    - Subnet 14: `190.168.68.208/28`
    - Subnet 15: `190.168.68.224/28`
    - Subnet 16: `190.168.68.240/28`
#### Bài 9:
- Đề bài: Có dải địa chỉ `172.16.0.0/16` mượn 1 bits
- Giải:
  - Số Subnet: 2
  - Số Host/Subnet: 32766
  - Bước nhảy: 16
  - Liệt kê các dải mạng:
    - 