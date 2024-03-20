# Sử dụng Tcpdump
Việc sử dụng Tcpdump cũng khá đơn giản, nếu như bạn đã từng sử dụng WireShark trên Window thì Tcpdump cũng sẽ gần gần giống như WireShark
## Cài đặt:
Cài đặt Tcpdump rất dễ dàng như sau:
```
# Đối với Ubuntu Server
sudo apt update
sudo apt upgrade

sudo apt install -y tcpdump

# Đối với CentOS
sudo yum update
sudo yum upgrade

sudo yum install -y tcpdump
```

## Sử dụng Tcpdump trên UbuntuServer
### Kiểm tra các giao diện mạng mà tcpdump thấy:
Một máy đôi khi có thể có nhiều giao diện mạng, và để thấy được nó chúng ta có thể sử dụng 2 cách như sau:
- Dùng bằng lệnh của Ubuntu SV:
```
root@ubuntusv:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:0c:29:4c:39:28 brd ff:ff:ff:ff:ff:ff
    altname enp2s1
    inet 192.168.217.128/24 metric 100 brd 192.168.217.255 scope global dynamic ens33
       valid_lft 1697sec preferred_lft 1697sec
    inet6 fe80::20c:29ff:fe4c:3928/64 scope link
       valid_lft forever preferred_lft forever
```
- Hoặc có thể dùng tcpdump để kiểm tra với options `-D`
```
root@ubuntusv:~# tcpdump -D
1.ens33 [Up, Running, Connected]
2.any (Pseudo-device that captures on all interfaces) [Up, Running]
3.lo [Up, Running, Loopback]
4.bluetooth0 (Bluetooth adapter number 0) [Wireless, Association status unknown]
5.bluetooth-monitor (Bluetooth Linux Monitor) [Wireless]
6.nflog (Linux netfilter log (NFLOG) interface) [none]
7.nfqueue (Linux netfilter queue (NFQUEUE) interface) [none]
8.dbus-system (D-Bus system bus) [none]
9.dbus-session (D-Bus session bus) [none]
```
### Lọc tất cả các gói tin trong 1 giao diện mạng
```
# Lọc tất cả các gói tin trong mạng ens33
root@ubuntusv:~# tcpdump -i ens33
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on ens33, link-type EN10MB (Ethernet), snapshot length 262144 bytes
08:48:39.879665 IP ubuntusv.ssh > 192.168.217.1.51834: Flags [P.], seq 1608694389:1608694501, ack 1506248011, win 501, length 112

# Có thể thêm options -V để hiển thị thông tin chi tiết hơn như sau:
root@ubuntusv:~# tcpdump -i ens33 -v
tcpdump: listening on ens33, link-type EN10MB (Ethernet), snapshot length 262144 bytes
08:50:15.038640 IP (tos 0x10, ttl 64, id 19459, offset 0, flags [DF], proto TCP (6), length 104)
    ubuntusv.ssh > 192.168.217.1.51834: Flags [P.], cksum 0x342e (incorrect -> 0xb36f), seq 1608757813:1608757877, ack 1506250811, win 501, length 64

# Hoặc cũng có thể lọc trong tất cả giao diện mạng
root@ubuntusv:~# tcpdump -i any
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
09:07:23.608488 ens33 Out IP ubuntusv.ssh > 192.168.217.1.51834: Flags [P.], seq 1609316245:1609316341, ack 1506276251, win 501, length 96
09:07:23.612124 ens33 Out IP ubuntusv.ssh > 192.168.217.1.51834: Flags [P.], seq 96:272, ack 1, win 501, length 176
09:07:23.692395 lo    In  IP localhost.43382 > localhost.domain: 9337+ [1au] PTR? 1.217.168.192.in-addr.arpa. (55)
```
### Lọc các gói tin theo hostname
Để băt các gói tin theo 1 hostname nào đó, chúng ta có thể làm theo như bên dưới
```
# Lọc theo tên Server
ducmanh287@ubuntusv:~$ sudo tcpdump -i ens33 host ubuntusv
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on ens33, link-type EN10MB (Ethernet), snapshot length 262144 bytes

# Lọc khi có đích là 1 máy có ip cụ thể
ducmanh287@ubuntusv:~$ sudo tcpdump -i ens33 dst host 192.168.217.132
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on ens33, link-type EN10MB (Ethernet), snapshot length 262144 bytes
09:16:12.554733 IP ubuntusv > 192.168.217.132: ICMP echo reply, id 3, seq 30, length 64
09:16:12.607224 IP 192.168.217.1.53528 > 192.168.217.132.ssh: Flags [.], ack 3794301156, win 4105, length 0
09:16:13.601133 IP ubuntusv > 192.168.217.132: ICMP echo reply, id 3, seq 31, length 64
```

### Lọc theo mạng
Lọc các gói tin khi có địa IP cụ thể và show ra địa chỉ ip:
```
ducmanh287@ubuntusv:~$ sudo tcpdump -i ens33 net 192.168.217.128 -n
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on ens33, link-type EN10MB (Ethernet), snapshot length 262144 bytes
09:24:22.085798 IP 192.168.217.128.22 > 192.168.217.1.51834: Flags [P.], seq 1609881781:1609881957, ack 1506324731, win 638, length 176
09:24:22.086041 IP 192.168.217.1.51834 > 192.168.217.128.22: Flags [.], ack 176, win 4103, length 0
09:24:22.168183 IP 192.168.217.128.22 > 192.168.217.1.51834: Flags [P.], seq 176:368, ack 1, win 638, length 192
09:24:22.221393 IP 192.168.217.1.51834 > 192.168.217.128.22: Flags [.], ack 368, win 4102, length 0
```
### Lọc theo Port numbers
Việc lọc theo port number cũng rất dễ dàng khi sử dụng tcpdump
```
# Lọc các gói tin trên mạng ens33 và có port 22, đồng thời hiển thị IP để có thể thấy được port
ducmanh287@ubuntusv:~$ sudo tcpdump -i ens33 port 22 -n
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on ens33, link-type EN10MB (Ethernet), snapshot length 262144 bytes
09:29:02.154153 IP 192.168.217.128.22 > 192.168.217.1.51834: Flags [P.], seq 1610033893:1610034069, ack 1506333387, win 661, length 176
09:29:02.154438 IP 192.168.217.1.51834 > 192.168.217.128.22: Flags [.], ack 176, win 4105, length 0
09:29:02.240208 IP 192.168.217.128.22 > 192.168.217.1.51834: Flags [P.], seq 176:368, ack 1, win 661, length 192
09:29:02.289038 IP 192.168.217.1.51834 > 192.168.217.128.22: Flags [.], ack 368, win 4104, length 0
09:29:02.344345 IP 192.168.217.128.22 > 192.168.217.1.51834: Flags [P.], seq 368:464, ack 1, win 661, length 96

# Vậy còn khi muốn chỉ hiển thị ip nguồn thông qua port 22 thì sao?
ducmanh287@ubuntusv:~$ sudo tcpdump -i ens33 src host 192.168.217.1 and port 22 -n
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on ens33, link-type EN10MB (Ethernet), snapshot length 262144 bytes
09:31:35.050036 IP 192.168.217.1.51834 > 192.168.217.128.22: Flags [.], ack 1610120725, win 4101, length 0
09:31:35.175414 IP 192.168.217.1.51834 > 192.168.217.128.22: Flags [.], ack 129, win 4106, length 0
09:31:35.283863 IP 192.168.217.1.51834 > 192.168.217.128.22: Flags [.], ack 193, win 4106, length 0
```

### Lọc theo Protocols
Tương tự như WireShark, tcpdump cũng có thể lọc các gói tin theo một giao thức cụ thể nào đó:
```
# Lọc các gói tin của giao thức icmp
ducmanh287@ubuntusv:~$ sudo tcpdump -i ens33 icmp
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on ens33, link-type EN10MB (Ethernet), snapshot length 262144 bytes
09:34:02.030290 IP 192.168.217.132 > ubuntusv: ICMP echo request, id 5, seq 1, length 64
09:34:02.030316 IP ubuntusv > 192.168.217.132: ICMP echo reply, id 5, seq 1, length 64
09:34:03.091121 IP 192.168.217.132 > ubuntusv: ICMP echo request, id 5, seq 2, length 64
09:34:03.091153 IP ubuntusv > 192.168.217.132: ICMP echo reply, id 5, seq 2, length 64

# Vậy nếu muốn lọc các gói tin không phải giao thức icmp thì sao?
ducmanh287@ubuntusv:~$ sudo tcpdump -i ens33 not icmp
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on ens33, link-type EN10MB (Ethernet), snapshot length 262144 bytes
09:35:53.858287 IP ubuntusv.ssh > 192.168.217.1.51834: Flags [P.], seq 1610263621:1610263813, ack 1506351531, win 729, length 192
09:35:53.858561 IP 192.168.217.1.51834 > ubuntusv.ssh: Flags [.], ack 192, win 4105, length 0
09:35:53.944578 IP ubuntusv.34283 > _gateway.domain: 39945+ [1au] PTR? 1.217.168.192.in-addr.arpa. (55)
09:35:54.038324 ARP, Request who-has ubuntusv tell _gateway, length 46
09:35:54.038352 ARP, Reply ubuntusv is-at 00:0c:29:4c:39:28 (oui Unknown), length 28
09:35:54.038430 IP _gateway.domain > ubuntusv.34283: 39945 NXDomain 0/1/1 (132)
09:35:54.038632 IP ubuntusv.34283 > _gateway.domain: 39945+ PTR? 1.217.168.192.in-addr.arpa. (44)
```
### Lưu trữ các gói dữ liệu
Khi bạn sử dụng tcpdump, có lẽ bạn sẽ cần phải lưu trữ các dữ liệu đã bắt được để phân tích. Việc lưu trữ dữ liệu vào 1 file đối với tcpdump được thực hiện như sau:
```
# Trước tiên, chúng ta cần tạo file chứa các gói dữ liệu này. File được tạo sẽ là 1 file có đuôi `.pcap`
# Sau đó sẽ sử dụng options của tcpdump cho việc lưu trữ file.
# Thực hiện như sau:
ducmanh287@ubuntusv:~$ sudo tcpdump -w /home/ducmanh287/tcpdump/output.pcap -c 25
tcpdump: listening on ens33, link-type EN10MB (Ethernet), snapshot length 262144 bytes
25 packets captured
36 packets received by filter
0 packets dropped by kernel
```
Kiểm tra nội dung file bằng lệnh sau:
```
ducmanh287@ubuntusv:~$ cat /home/ducmanh287/tcpdump/output.pcap
```
![](/Anh/Screenshot_502.png)

Chúng ta không thể đọc nội dung file này mà cần có tcpdump mới có thể đọc được
```
ducmanh287@ubuntusv:~$ tcpdump -r /home/ducmanh287/tcpdump/output.pcap
```
![](/Anh/Screenshot_503.png)