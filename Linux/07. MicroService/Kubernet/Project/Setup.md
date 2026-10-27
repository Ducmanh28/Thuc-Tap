# Quy trình cài đặt
Mục này nêu ra các mục cần cài đặt trên hệ thống này
## K8S
Vì được triển khai bằng K8S, vậy nên chúng ta cần có K8S trên cả 3 VM. Vui lòng tham khảo tại đây để xem hướng dẫn cài đặt K8S.

## NetBox
Sau khi cài đặt K8S trên cả 3 VM và kết nối thành công, chúng ta sẽ bắt đầu cài đặt NetBox. Thay vì cài đặt thủ công, chúng ta sẽ sử dụng K8S để cài đặt NetBox để đảm bảo:
- Tính nhất quán: Toàn bộ hệ thống (Netbox, MySQL, Backend, Frontend) nằm chung một kiến trúc giúp quản lý Network (Service, Ingress) và Security (Secrets) đồng bộ
- Self-healing: Nếu Pod Netbox bị lỗi, K8s sẽ tự khởi động lại 
- Dễ dàng mở rộng: Sau này khi dữ liệu "Truth data" lớn lên, có thể tách Database của Netbox sang node khác chỉ bằng vài dòng cấu hình

### Cài đặt StorageClass
Netbox, PostgreSQL và Redis đều cần Persistent Volume (PV) để lưu dữ liệu. Chúng ta sẽ dùng ổ cứng cục bộ của các node.

```Bash
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
```
Thiết lập local-path làm StorageClass mặc định của cụm:

```Bash
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```
Kiểm tra lại: `kubectl get sc` (Đảm bảo có chữ (default) cạnh local-path)

### Cài đặt Helm
Nếu Master chưa có Helm, cài đặt thông qua script chính thức:

```Bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
Thêm repository của Netbox:

```Bash
helm repo add netbox https://charts.netbox.oss.netboxlabs.com/
helm repo update
```
### Tạo file cấu hình values.yaml
Tạo một file tên là netbox-values.yaml trên Master. File này sẽ ghi đè các cấu hình mặc định của Helm Chart, thiết lập password và cấu hình mạng dạng NodePort để bạn có thể truy cập thẳng từ laptop.

```YAML
# netbox-values.yaml
superuser:
  name: admin
  email: admin@local.dev
  password: adminpassword 

service:
  type: NodePort
  port: 80
  nodePort: "32080"
postgresql:
  enabled: true
  auth:
    postgresPassword: supersecretpostgres
    password: netboxdbpassword
    database: netbox
  primary:
    persistence:
      enabled: true
      size: 5Gi
redis:
  enabled: true
  auth:
    password: netboxredispassword
  master:
    persistence:
      enabled: true
      size: 1Gi
worker:
  enabled: true
```
### Triển khai Netbox
Tạo một namespace riêng cho hạ tầng quản lý để dễ kiểm soát, sau đó cài đặt Netbox:

```Bash
# Tạo namespace
kubectl create namespace netbox-system

# Triển khai bằng Helm
helm install my-netbox netbox/netbox -f netbox-values.yaml -n netbox-system
```
### Kiểm tra và Truy cập
Quá trình khởi tạo Pods, đặc biệt là Database và chạy script Migration của Netbox sẽ mất khoảng 3-5 phút.

Kiểm tra trạng thái các Pod:

```Bash
MANH-U82:~# kubectl get pods -n netbox-system -w
NAME                              READY   STATUS                  RESTARTS        AGE
my-netbox-56c5d8f896-gtjl5        0/1     Running                 1 (3m56s ago)   22m
my-netbox-postgresql-0            1/1     Running                 0               22m
my-netbox-valkey-primary-0        1/1     Running                 0               22m
my-netbox-valkey-replicas-0       1/1     Running                 0               22m
my-netbox-valkey-replicas-1       1/1     Running                 0               20m
my-netbox-valkey-replicas-2       1/1     Running                 0               19m
my-netbox-worker-8d95f64f-c8z6f   0/1     Init:CrashLoopBackOff   7 (95s ago)     22m
```
Khi tất cả các Pod (netbox, postgresql, redis, worker) chuyển sang trạng thái Running và READY 1/1, hệ thống đã sẵn sàng.

Để xem chi tiết quá trình cài đặt:
```Bash
root@MANH-U82:~# kubectlogs -f my-netbox-56c5d8f896-gtjl5 -n netbox-system
Defaulted container "netbox" out of: netbox, init-dirs (init)
⚙️ Applying database migrations
🧬 loaded config '/etc/netbox/config/configuration.py'
🧬 loaded config '/etc/netbox/config/extra.py'
🧬 loaded config '/etc/netbox/config/logging.py'
🧬 loaded config '/etc/netbox/config/plugins.py'
Operations to perform:
  Apply all migrations: account, auth, circuits, contenttypes, core, dcim, django_rq, extras, ipam, sessions, social_django, taggit, tenancy, thumbnail, users, virtualization, vpn, wireless
Running migrations:
  Applying virtualization.0023_squashed_0036... OK
  Applying virtualization.0037_protect_child_interfaces... OK
  Applying virtualization.0038_virtualdisk... OK
  Applying virtualization.0039_virtualmachine_serial_number... OK
  Applying virtualization.0040_convert_disk_size... OK
  Applying virtualization.0041_charfield_null_choices... OK
  Applying virtualization.0042_vminterface_vlan_translation_policy... OK
  Applying virtualization.0043_qinq_svlan... OK
```
**Lưu ý**: *Quá trình này thường tốn vài phút tùy thuộc vào tốc độ **đọc/ghi** file trên VM!*

Kiểm thử: Truy cập: *`http://172.16.66.82:30080`*

![](/Anh/Screenshot_1073.png)

## MySQL
Sau khi cài đặt thành công NetBox, chúng ta sẽ thực hiện cài đặt MySQL

Chúng ta sẽ sử dụng StatefulSet thay vì Deployment. Khác với Deployment (vốn dành cho các ứng dụng không trạng thái - stateless), StatefulSet cung cấp các tính năng quan trọng cho Database:

- Định danh mạng cố định: Pod sẽ có tên không đổi (ví dụ mysql-0), giúp các ứng dụng khác kết nối ổn định.

- Gắn kết dữ liệu bền vững: Mỗi Pod được gắn chặt với một Volume (PVC) cụ thể. Khi Pod bị xóa và tạo lại, nó sẽ tự động kết nối lại đúng ổ đĩa cũ, đảm bảo dữ liệu không bị mất hoặc xáo trộn.

Sử dụng file YAML sau:
```YAML
apiVersion: v1
kind: Service
metadata:
  name: mysql-service
  namespace: default
spec:
  ports:
  - port: 3306
    name: mysql
  selector:
    app: mysql
  clusterIP: None # Headless Service giúp định danh Pod cố định

---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
  namespace: default
spec:
  serviceName: "mysql-service"
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:8.0
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: "RootPassword@2026"
        - name: MYSQL_DATABASE
          value: "app_database"
        - name: MYSQL_USER
          value: "app_user"
        - name: MYSQL_PASSWORD
          value: "AppPassword@2026"
        ports:
        - containerPort: 3306
          name: mysql
        volumeMounts:
        - name: mysql-data
          mountPath: /var/lib/mysql
  volumeClaimTemplates:
  - metadata:
      name: mysql-data
    spec:
      accessModes: [ "ReadWriteOnce" ]
      storageClassName: "local-path" # Sử dụng StorageClass hiện có của bạn
      resources:
        requests:
          storage: 2Gi # Dung lượng đã được hạ xuống mức tối thiểu để test
```
Thực thi cài đặt:
```bash
kubectl apply -f mysql-statefulset.yaml
```
Kiểm tra:
```bash
(myenv) root@MANH-U82:/home/ducmanh/cloud_portal# kubectl get pods -l app=mysql
NAME      READY   STATUS    RESTARTS   AGE
mysql-0   1/1     Running   0          1d
```
Kiểm tra pvc:
```bash
(myenv) root@MANH-U82:/home/ducmanh/cloud_portal# kubectl get pvc
NAME                 STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
mysql-data-mysql-0   Bound    pvc-763eb196-f876-40b4-bd04-3360ef1137cc   3Gi        RWO            local-path     <unset>                 1d
```
Sau đó, nếu bạn muốn truy cập vào My_SQL để cấu hình, sửa chữa dữ liệu thì bạn có thể dùng:
```bash
kubectl exec -it mysql-0 -- mysql -u app_user -pAppPassword@2026 app_database
```
Sample data sẽ trông như sau:
```bash
mysql> show tables; 
+------------------------+ 
| Tables_in_app_database | 
+------------------------+ 
| audit_logs | 
| contracts | 
| customers | 
| invoices | 
| pricing_plans | 
| provision_requests | 
| roles | 
| task_execution_steps | 
| users | 
+------------------------+
```

Vậy là chúng ta đã hoàn tất Setup
