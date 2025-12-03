# Setup Guide - Absensi Dipointer

## Quick Start

### 1. Install Flutter

Pastikan Flutter SDK sudah terinstall di komputer Anda. Jika belum, ikuti panduan di:
https://docs.flutter.dev/get-started/install

Verifikasi instalasi:
```bash
flutter --version
flutter doctor
```

### 2. Clone & Setup Project

```bash
# Clone repository
git clone https://github.com/nadhiipp/Absensi-Dipointer.git
cd Absensi-Dipointer

# Get dependencies
flutter pub get

# Run the app
flutter run
```

## Platform Specific Setup

### Android

1. **Permissions sudah dikonfigurasi** di `android/app/src/main/AndroidManifest.xml`:
   - Location (GPS)
   - Camera
   - Storage (untuk menyimpan foto)

2. **Minimum SDK**: API 21 (Android 5.0)

3. **Build & Run**:
   ```bash
   flutter run -d android
   ```

### iOS

1. **Permissions sudah dikonfigurasi** di `ios/Runner/Info.plist`:
   - Camera Usage
   - Photo Library Usage
   - Location When In Use

2. **Minimum iOS Version**: 11.0

3. **Setup CocoaPods** (required for iOS):
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Build & Run**:
   ```bash
   flutter run -d ios
   ```

## Testing Credentials

Aplikasi menggunakan authentication sederhana untuk demo. Gunakan kredensial apapun yang valid:

- **Email**: Any valid email format (e.g., `user@example.com`)
- **Password**: Minimum 6 characters (e.g., `123456`)

## Configuration

### 1. Office Location (GPS Coordinates)

Edit `lib/utils/constants.dart`:
```dart
// Default: Jakarta coordinates
static const double officeLatitude = -6.2088;
static const double officeLongitude = 106.8456;
static const double validRadiusMeters = 100.0; // 100 meters
```

### 2. Work Hours

Edit `lib/utils/constants.dart`:
```dart
static const String workStartTime = '08:00';
static const String workEndTime = '17:00';
static const int lateThresholdMinutes = 15;
```

## Features Overview

### 🏠 Home Dashboard
- Real-time clock and date
- Attendance statistics (Present, Permission, Absent, Late)
- Quick actions (Clock In, Clock Out, Request Leave)
- Recent activities

### ⏰ Attendance
- GPS location validation
- Camera selfie capture
- Clock In/Out with timestamp
- Location radius check

### 📜 History
- Monthly attendance records
- Filter by month/year
- Status indicators with colors

### 📝 Leave Request
- Multiple leave types
- Date range picker
- File attachment support
- Status tracking (Pending, Approved, Rejected)

### 📊 Reports
- Monthly statistics
- Pie chart for attendance percentage
- Bar chart for weekly attendance
- Attendance summary

### 👤 Profile
- User information display
- Profile photo upload
- Edit profile functionality
- Settings menu
- Logout

## Troubleshooting

### Common Issues

**1. "Flutter command not found"**
- Pastikan Flutter SDK sudah ditambahkan ke PATH
- Run `flutter doctor` untuk verifikasi

**2. "Plugin not found" errors**
- Run `flutter pub get`
- Restart IDE/Editor

**3. GPS/Location not working**
- Pastikan Location Services aktif di device
- Grant location permissions saat diminta
- Check AndroidManifest.xml dan Info.plist permissions

**4. Camera not working**
- Grant camera permissions saat diminta
- Test di device fisik (camera mungkin tidak tersedia di emulator)

**5. Build errors**
- Clean build: `flutter clean`
- Get dependencies: `flutter pub get`
- Rebuild: `flutter run`

## Development Tips

### Hot Reload
Saat development, gunakan hot reload untuk melihat perubahan secara instant:
- Press `r` in terminal untuk hot reload
- Press `R` untuk hot restart
- Press `q` untuk quit

### Debug Mode
```bash
flutter run --debug
```

### Release Build
```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS (Mac only)
flutter build ios --release
```

### Code Analysis
```bash
# Analyze code
flutter analyze

# Format code
flutter format lib/
```

## Next Steps

1. **Backend Integration**: Connect to real API endpoints
2. **Firebase**: Add Firebase for authentication and database
3. **Push Notifications**: Implement FCM for notifications
4. **Testing**: Add unit tests and widget tests
5. **CI/CD**: Setup automated testing and deployment

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Material Design](https://material.io/design)
- [Flutter Packages](https://pub.dev/)

## Support

Jika mengalami masalah atau ada pertanyaan:
- Buat issue di GitHub repository
- Check existing issues untuk solusi
- Baca documentation di README.md
