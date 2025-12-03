# Absensi Dipointer

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
</p>

Aplikasi absensi lengkap dengan Flutter - Smart Attendance System dengan fitur GPS tracking, camera selfie, dan laporan lengkap.

## 📱 Fitur Utama

### 🔐 Autentikasi
- **Splash Screen** dengan animasi
- **Login Page** dengan validasi form
- Persistent login dengan SharedPreferences

### 🏠 Dashboard/Home
- Header dengan greeting dan avatar user
- **Card statistik absensi** dengan gradient hijau (Total Hadir, Izin, Alpha, Terlambat)
- **Quick Actions**: Clock In, Clock Out, Request Izin
- **Recent Activity**: Riwayat absensi terbaru dengan status
- Tanggal dan jam real-time

### ⏰ Clock In/Out
- Tombol Clock In dan Clock Out
- **Integrasi kamera** untuk foto selfie saat absen
- **Integrasi GPS** untuk validasi lokasi (radius 100m)
- Timestamp otomatis
- Status validasi lokasi (dalam/luar radius)

### 📜 Riwayat Absensi
- List riwayat absensi dengan filter bulan/tahun
- Detail setiap absensi (tanggal, jam masuk, jam keluar, status, lokasi)
- Indikator status dengan warna (hijau=hadir, kuning=izin, merah=alpha)

### 📝 Request Izin/Cuti
- Form pengajuan izin dengan:
  - Jenis izin (Sakit, Cuti Tahunan, Izin Pribadi, dll)
  - Tanggal mulai dan selesai dengan date picker
  - Keterangan/alasan
  - Upload lampiran foto/dokumen
- List pengajuan izin dengan status (pending, approved, rejected)
- Ringkasan status pengajuan

### 📊 Laporan Bulanan
- Rekap absensi per bulan dengan filter
- **Pie chart** untuk visualisasi persentase kehadiran
- **Bar chart** untuk kehadiran mingguan
- Total hari kerja, hadir, izin, alpha
- Persentase kehadiran
- Ringkasan narasi

### 👤 Profile
- Foto profil user dengan fitur upload
- Informasi user (nama, email, NIP/NIK, departemen, jabatan)
- **Edit profile** dengan form validasi
- Menu pengaturan (Ubah Password, Notifikasi, Bantuan, Tentang)
- Logout dengan konfirmasi

## 🎨 Desain

### Tema
- **Warna utama**: Hijau (#2E7D32) dengan kombinasi putih
- **Style**: Card-based layout dengan shadow/elevation
- **Gradient**: Gradient hijau untuk card statistik utama
- **Typography**: Clean dan modern dengan Google Fonts (Poppins)
- **Bottom Navigation**: 5 tab (Home, Riwayat, Izin, Laporan, Profile)

## 🏗️ Struktur Project

```
lib/
├── main.dart                           # Entry point aplikasi
├── config/
│   ├── theme.dart                     # Konfigurasi tema dan warna
│   └── routes.dart                    # Routing aplikasi
├── models/
│   ├── user_model.dart                # Model data user
│   ├── attendance_model.dart          # Model data absensi
│   └── leave_request_model.dart       # Model data pengajuan izin
├── screens/
│   ├── splash_screen.dart             # Splash screen dengan animasi
│   ├── login_screen.dart              # Login page
│   ├── home_screen.dart               # Dashboard utama
│   ├── attendance_screen.dart         # Clock In/Out dengan GPS & Camera
│   ├── history_screen.dart            # Riwayat absensi
│   ├── leave_request_screen.dart      # Request izin/cuti
│   ├── report_screen.dart             # Laporan bulanan dengan chart
│   └── profile_screen.dart            # Profile & settings
├── widgets/
│   ├── custom_card.dart               # Card wrapper reusable
│   ├── stat_card.dart                 # Card untuk statistik
│   ├── activity_item.dart             # Item aktivitas terbaru
│   ├── bottom_nav.dart                # Bottom navigation bar
│   └── custom_button.dart             # Custom button dengan loading state
├── services/
│   ├── location_service.dart          # Service untuk GPS/Location
│   └── camera_service.dart            # Service untuk Camera
└── utils/
    ├── constants.dart                 # Konstanta aplikasi
    └── helpers.dart                   # Helper functions
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # UI & Icons
  cupertino_icons: ^1.0.6
  google_fonts: ^6.1.0
  
  # Date & Time
  intl: ^0.18.1
  
  # Location Services
  geolocator: ^10.1.0
  permission_handler: ^11.0.1
  
  # Camera & Image
  camera: ^0.10.5+5
  image_picker: ^1.0.4
  
  # Charts
  fl_chart: ^0.65.0
  
  # State Management
  provider: ^6.1.1
  
  # Local Storage
  shared_preferences: ^2.2.2
  
  # Path
  path_provider: ^2.1.1
  path: ^1.8.3
```

## 🚀 Cara Instalasi

### Prasyarat
- Flutter SDK (3.0.0 atau lebih baru)
- Dart SDK (included with Flutter)
- Android Studio / VS Code dengan Flutter extension
- Emulator Android atau iOS / Device fisik

### Langkah Instalasi

1. **Clone repository**
   ```bash
   git clone https://github.com/nadhiipp/Absensi-Dipointer.git
   cd Absensi-Dipointer
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run aplikasi**
   ```bash
   # Untuk Android
   flutter run
   
   # Untuk iOS (Mac only)
   flutter run -d ios
   
   # Untuk web
   flutter run -d chrome
   ```

## 📱 Platform Support

- ✅ Android (API 21+)
- ✅ iOS (iOS 11.0+)
- ⚠️ Web (dengan batasan untuk camera dan GPS)

## ⚙️ Konfigurasi

### GPS Location
Ubah koordinat kantor di `lib/utils/constants.dart`:
```dart
static const double officeLatitude = -6.2088;
static const double officeLongitude = 106.8456;
static const double validRadiusMeters = 100.0;
```

### Work Hours
Ubah jam kerja di `lib/utils/constants.dart`:
```dart
static const String workStartTime = '08:00';
static const String workEndTime = '17:00';
static const int lateThresholdMinutes = 15;
```

## 🔑 Login Demo

Untuk testing, gunakan kredensial apapun:
- Email: `test@example.com` (atau email valid lainnya)
- Password: `123456` (minimal 6 karakter)

## 📸 Screenshots

*Screenshots akan ditambahkan setelah aplikasi berjalan*

## 🎯 Fitur Tambahan (Roadmap)

- [ ] Integrasi dengan backend API
- [ ] Push notification
- [ ] Face recognition untuk absensi
- [ ] Export laporan ke PDF
- [ ] Multi-language support
- [ ] Dark mode theme
- [ ] Offline mode dengan sync
- [ ] Biometric authentication

## 🛠️ Development

### Build Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ipa --release
```

### Testing

```bash
flutter test
```

### Code Format

```bash
flutter format lib/
```

### Analyze Code

```bash
flutter analyze
```

## 📝 Catatan

- Aplikasi menggunakan **dummy data** untuk demo
- Responsive untuk berbagai ukuran layar
- Implementasi smooth animations dan transitions
- Consistent icon usage (Material Icons)
- Loading states dan error handling
- Form validation di semua input

## 👥 Kontributor

- **Nadhi** - Initial work

## 📄 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## 💬 Support

Jika ada pertanyaan atau masalah, silakan buat issue di repository ini.
