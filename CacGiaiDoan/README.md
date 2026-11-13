# Lộ trình tự xây dựng NutriTrack từ con số 0

Thư mục này chứa **6 bản chụp mã nguồn tăng dần** của dự án Flutter trong `LTTBDD_Git`. Mỗi tệp ZIP là một dự án độc lập, chứa toàn bộ những gì đã có đến cuối giai đoạn đó. Bạn có thể giải nén từng bản để chạy thử, rồi xem phần mã mới so với giai đoạn trước để tự viết lại.

> **Nguồn gốc:** Các mốc Git và ZIP ở đây được **tái dựng từ bản mã nguồn cuối**, không phải lịch sử phát triển gốc hay bằng chứng ai đã viết mã vào thời điểm nào. Bản `NutriTrack_GiaiDoan1` ở thư mục cha là một bộ khởi tạo Android được tạo riêng; nó không phải commit đầu tiên của chuỗi ZIP này.

## Sáu giai đoạn

| Giai đoạn | Bản chụp | Việc tự code theo thứ tự | Kết quả quan sát được |
| --- | --- | --- | --- |
| 1. Khởi tạo Flutter | `01_Khoi_tao_Flutter.zip` | Tạo dự án Flutter; xem `pubspec.yaml`, `android/`, `lib/main.dart`; viết màn hình chữ NutriTrack tối thiểu. | Ứng dụng mở được và hiển thị tên. |
| 2. Giới thiệu và mục tiêu | `02_Gioi_thieu_Muc_tieu.zip` | Viết màu, chữ, theme, nút dùng chung; tạo 3 màn onboarding; khai báo route và màn đầu tiên. | Chuyển được qua luồng giới thiệu → mục tiêu → thiết lập. |
| 3. Tài khoản và trang chủ | `03_Dang_nhap_Trang_chu.zip` | Tạo form đăng ký và đăng nhập, kiểm tra dữ liệu nhập; nối route đến trang chủ; dựng các thẻ và lối tắt trên dashboard. | Đăng ký và đăng nhập trong phiên chạy hiện tại, vào được trang chủ. |
| 4. Hồ sơ và cài đặt | `04_Ho_so_Cai_dat.zip` | Viết `UserManager`; tạo trang hồ sơ, sửa thông tin, cài đặt, đổi mật khẩu và chọn ngôn ngữ; nối các route liên quan. | Sửa tên/chiều cao/cân nặng và thấy thông tin đổi trên giao diện. |
| 5. Báo cáo và nước uống | `05_Bao_cao_Nhac_nuoc.zip` | Dựng màn báo cáo tuần và màn nhắc uống nước; nối từ dashboard/báo cáo. | Xem được hai giao diện với số liệu mẫu. |
| 6. Quét và so sánh | `06_Quet_So_sanh.zip` | Dựng giao diện quét mã, chi tiết dinh dưỡng, so sánh thực phẩm; xem lại các service/model dự kiến. | Có các màn giao diện để phát triển tiếp. |

## Cách học và viết lại từng giai đoạn

1. Bắt đầu bằng giai đoạn 1. Chỉ xem ZIP đó, tự tạo dự án bằng `flutter create btl_mobile` và tự viết `lib/main.dart` trước khi đối chiếu đáp án.
2. Sang giai đoạn tiếp theo, dùng bảng dưới đây để biết **file nào mới**. Viết giao diện trước, sau đó nối điều hướng trong `lib/routes/app_routes.dart` và thử toàn bộ đường đi bằng ứng dụng.
3. Sau mỗi giai đoạn, chạy `flutter pub get`, `flutter analyze`, `flutter run`. Khi gặp nút chưa hoạt động, đối chiếu phần “Giới hạn hiện tại” bên dưới; không coi nút đó là chức năng đã hoàn thành.
4. Nếu dùng Git để lưu bài tự làm, tạo commit thật sau khi chính bạn hoàn tất từng giai đoạn. Các commit trong `LTTBDD_Git` chỉ là tài liệu đối chiếu.

### File cần tập trung ở từng lần nâng cấp

**1 → 2:** `lib/core/constants/app_colors.dart`, `app_strings.dart`, `app_text_styles.dart`; `lib/core/theme/light_theme.dart`; `lib/core/widgets/base_button.dart`; ba file trong `lib/features/onboarding/`; `lib/routes/app_routes.dart`; `lib/main.dart`.

**2 → 3:** `lib/features/auth/login_screen.dart`, `register_screen.dart`; `lib/features/home/home_screen.dart`; cập nhật `lib/routes/app_routes.dart`.

**3 → 4:** `lib/core/services/user_manager.dart`; các file trong `lib/features/profile/` và `lib/features/settings/`; cập nhật route.

**4 → 5:** `lib/features/reports/weekly_report_screen.dart`, `lib/features/hydration/water_reminder_screen.dart`; cập nhật route.

**5 → 6:** `lib/features/scanner/barcode_scanner_screen.dart`, `nutrition_detail_screen.dart`; `lib/features/ai_compare/compare_nutrition_screen.dart`. Các file trong `lib/models/`, `lib/services/`, `lib/widgets/` ở bản cuối hiện còn trống.

## Chạy một bản ZIP

Giải nén ZIP vào một thư mục riêng, mở terminal trong thư mục đó rồi chạy:

```powershell
flutter pub get
flutter run
```

Muốn xem chính xác mã được thêm ở mỗi mốc mà không cần giải nén, dùng Git trong `LTTBDD_Git`:

```powershell
git log --reverse --oneline
git diff 29e7a19 207f0ad -- lib
```

Đổi hai mã commit để xem cặp giai đoạn khác. Các commit theo thứ tự là `250a31f`, `29e7a19`, `207f0ad`, `b2b9e42`, `5afb60f`, `1a6830f`.

## Giới hạn hiện tại và bước phát triển tiếp

- Đăng ký/đăng nhập đang dùng dữ liệu trong bộ nhớ; đóng ứng dụng rồi mở lại sẽ không giữ tài khoản. Đây chưa phải hệ thống xác thực thật.
- Báo cáo, lượng nước, gợi ý AI và dữ liệu quét phần lớn là nội dung mẫu. Nút lưu nhắc uống nước chưa lưu cài đặt.
- Một số lối tắt trên trang chủ gọi route chưa khai báo như `/ai_scan`, `/journal`, `/statistics`, `/suggest_meal`, `/qr_scan`, `/compare`; các màn quét và so sánh trong giai đoạn 6 chưa được nối đầy đủ vào luồng chính.
- Để biến ứng dụng thành sản phẩm hoạt động, bước kế tiếp là thiết kế model dữ liệu, lưu cục bộ hoặc backend, tính toán chỉ số từ nhật ký thực, kết nối máy quét/camera và sửa các route còn thiếu. Những phần này **chưa có trong 6 ZIP**.
