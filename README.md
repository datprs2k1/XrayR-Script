# XrayR full việt hóa 
Một khung phụ trợ Xray có thể dễ dàng hỗ trợ nhiều bảng.

Một khung công tác back-end dựa trên Xray, hỗ trợ các giao thức V2ay, Trojan, Shadowsocks, cực kỳ dễ dàng mở rộng và hỗ trợ kết nối nhiều bảng điều khiển


## Cài đặt 
***Cài đặt tự động***
```
bash <(curl -Ls https://raw.githubusercontent.com/datprs2k1/XrayR-Script/main/XrayR_Setup.sh)
```
## Cấu hình xrayr
Sử dụng `nano` hoặc `vi` để vào thư mục cấu hình
```
vi /etc/XrayR/config.yml
```
```
nano /etc/XrayR/config.yml
```
Hoặc gọi xrayr rồi bấm phím `0`

1: dòng `PanelType` : Tên kiểu web (ví dụ `V2board`, `SSpanel`,... chữ đầu viết hoa)

2: dòng `ApiHost` : Địa chỉ web muốn liên kết (ví dụ `https://domain.com/`)

3: dòng `ApiKey` : key của web (lấy trên web admin / cấu hình hệ thống / máy chủ `chìa khóa giao tiếp`)

4: dòng `NodeID` : `ID` server (lấy trên web admin / Quản lý nút / tên `ID nút`)

5: dòng `certdomain` : `IP` của server muốn đưa lên web

Thêm dòng `DisableSniffing: true` giữa 2 dòng `ControllerConfig:` và `ListenIP: 0.0.0.0` để fix lỗi zalo 

>XrayR 1.4.1 mặc định đã tắt nên k cần tắt nữa
```
      RuleListPath:           # /etc/XrayR/rulelist Đường dẫn đến tệp danh sách quy tắc cục bộ
    ControllerConfig:
      DisableSniffing: true   # Tắt sniffing để fix lỗi zalo 
      ListenIP: 0.0.0.0       # Địa chỉ IP bạn muốn nghe
      SendIP: 0.0.0.0         # Địa chỉ IP bạn muốn gửi gói
```
Nếu bị lỗi xrayr không chạy thì bỏ dòng `DisableSniffing: true` đi nhé 

Dòng nào có ngoặc kép nhớ để ý viết trong ngoặc kép

Cấu hình xong nhớ khởi động lại xrayr nhé.

Nên sử dụng VPS sạch để cài đặt tránh lỗi vặt 

## Video demo
[Tại đây](https://youtu.be/nKE_xBWgNM0)


