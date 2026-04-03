# Một số lỗi mà có thể bạn sẽ gặp phải khi sử dụng K8S
## Lỗi connection refused
### Mô tả lỗi:
```
root@k8s-master:~# kubectl cluster-info
E0403 14:26:54.759177   85134 memcache.go:265] couldn't get current server API group list: Get "https://172.16.66.84:6443/api?timeout=32s": dial tcp 172.16.66.84:6443: connect: connection refused
E0403 14:26:54.759926   85134 memcache.go:265] couldn't get current server API group list: Get "https://172.16.66.84:6443/api?timeout=32s": dial tcp 172.16.66.84:6443: connect: connection refused
E0403 14:26:54.761658   85134 memcache.go:265] couldn't get current server API group list: Get "https://172.16.66.84:6443/api?timeout=32s": dial tcp 172.16.66.84:6443: connect: connection refused
E0403 14:26:54.762289   85134 memcache.go:265] couldn't get current server API group list: Get "https://172.16.66.84:6443/api?timeout=32s": dial tcp 172.16.66.84:6443: connect: connection refused
E0403 14:26:54.764084   85134 memcache.go:265] couldn't get current server API group list: Get "https://172.16.66.84:6443/api?timeout=32s": dial tcp 172.16.66.84:6443: connect: connection refused

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
The connection to the server 172.16.66.84:6443 was refused - did you specify the right host or port?
root@k8s-master:~# kubectl cluster-info dump
The connection to the server 172.16.66.84:6443 was refused - did you specify the right host or port?
```
Khi bạn sử dụng 1 lệnh `kubectl` nhưng lại bị lỗi ***connection refused*** thì phải làm sao?
### Nguyên nhân:
Theo như tôi tìm hiểu, có lẽ nguyên nhân là do sự 