# Các bước thiết lập cơ bản
Trước khi có thể bắt đầu làm việc với plugin, chúng ta cần tạo ra một môi trường làm việc hoàn hảo
## Cài đặt NetBox
Việc phát triển Plugin sẽ yêu cầu một phiên bản Netbox Local. Nếu bạn chưa biết cài đặt NetBox như thế nào, có thể tham khảo tại 1 trong các đường dẫn sau:
- [Cài đặt thủ công](https://suncloud.vn/netbox-la-gi-huong-dan-cai-dat-netbox-tren-linux-chi-tiet-nhat)
- [Cài đặt tự động](https://github.com/Ducmanh28/Thuc-Tap/tree/main/Linux/03.%20Linuxvagiaothucmang/NetBox/Tools/Install)

**Lưu ý**: Phiên bản của NetBox cần phải đảm bảo > `v3.2` để Plugin có thể hoạt động được

## Clone Git Repo demo
Tiếp theo, chúng ta sẽ clone demo git repository từ GitHub
- Trước tiên chúng ta sẽ tìm 1 nơi chứa:
```
cd /opt
```
- Sau đó sẽ clone git repo về:
```
git clone --branch step00-empty https://github.com/netbox-community/netbox-plugin-demo
Cloning into 'opt'...
remote: Enumerating objects: 219, done.
remote: Counting objects: 100% (49/49), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 219 (delta 43), reused 46 (delta 43), pack-reused 170 (from 1)
Receiving objects: 100% (219/219), 27.53 KiB | 469.00 KiB/s, done.
Resolving deltas: 100% (81/81), done.
```
- Kiểm tra lại với câu lệnh `ll`:
```
root@MANHNetBoxLab:/opt# ll
total 24
drwxr-xr-x  6 root root 4096 Oct 24 22:31 ./
drwxr-xr-x 20 root root 4096 Aug 13 14:29 ../
lrwxrwxrwx  1 root root   18 Aug 20 14:05 netbox -> /opt/netbox-4.0.5//
drwxrwxr-x  8 root root 4096 Aug 20 14:42 netbox-4.0.5/
drwxr-xr-x  3 root root 4096 Oct 24 22:31 netbox-plugin-demo/
drwxr-xr-x 10 root root 4096 Oct 21 14:52 netbox-sync/
drwxr-xr-x  4 root root 4096 Oct 21 16:58 netbox-telegram/
root@MANHNetBoxLab:/opt#
```
## Thiết lập Plugin
### Tạo file `__init__.py`
