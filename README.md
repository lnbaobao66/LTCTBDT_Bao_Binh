# NutriTrack (btl_mobile)

Dự án Flutter về theo dõi dinh dưỡng và sức khỏe. Mã nguồn được lấy từ `LTTBDD_Bao_Binh.zip`. Lịch sử Git trong repository này được **tái dựng từ bản ZIP** để nhóm dễ trình bày các mốc chức năng; ngày commit là ngày tạo repository, không phải ngày phát triển gốc.

## Các mốc

1. Khởi tạo Flutter và cấu hình các nền tảng.
2. Giới thiệu ứng dụng và màn hình mục tiêu.
3. Đăng ký, đăng nhập và trang chủ.
4. Hồ sơ cá nhân và cài đặt.
5. Báo cáo sức khỏe và nhắc uống nước.
6. Giao diện quét, so sánh thực phẩm và cấu trúc còn lại.

## Chạy thử

Cần cài Flutter SDK phù hợp với `pubspec.yaml`. Chạy `flutter pub get`, sau đó `flutter run`. Trên Windows, việc build plugin có thể cần bật Developer Mode.

## Trạng thái hiện tại

Nhiều số liệu là dữ liệu mẫu; các service và model trong `lib/` còn trống. Đăng ký chỉ lưu trong bộ nhớ, camera/AI và lưu nhắc uống nước chưa được kết nối. Một số nút gọi route chưa khai báo. Xem mã nguồn để biết chi tiết.
