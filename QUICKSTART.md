# Quick Start Guide 🚀

Get the Absensi Dipointer app running in 5 minutes!

## Prerequisites

- Flutter SDK installed ([Download](https://docs.flutter.dev/get-started/install))
- Android Studio or VS Code with Flutter extension
- Android Emulator or iOS Simulator (or physical device)

## Installation Steps

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/nadhiipp/Absensi-Dipointer.git
cd Absensi-Dipointer
```

### 2️⃣ Install Dependencies
```bash
flutter pub get
```

### 3️⃣ Run the App
```bash
flutter run
```

That's it! The app should now be running on your device/emulator.

## Demo Login

Use any valid credentials:
- **Email**: `user@example.com` (or any valid email format)
- **Password**: `123456` (minimum 6 characters)

## Navigation Guide

After login, you'll see the main dashboard with 5 tabs:

### 🏠 Home Tab
- View attendance statistics
- See real-time clock
- Quick actions: Clock In/Out, Request Leave
- Recent activities

### 📜 Riwayat Tab (History)
- View past attendance records
- Filter by month/year
- See detailed clock in/out times

### 📝 Izin Tab (Leave Request)
- Submit new leave requests
- View request history
- Check approval status

### 📊 Laporan Tab (Reports)
- Monthly attendance summary
- Visual charts (Pie & Bar)
- Attendance percentage
- Statistics overview

### 👤 Profile Tab
- View personal information
- Edit profile
- Update profile photo
- Logout

## Key Features to Try

### ✅ Clock In Process
1. Go to Home tab
2. Tap "Clock In" in Quick Actions
3. App will check your GPS location
4. Take a selfie
5. Tap "Clock In" button
6. See confirmation message

### ✅ Request Leave
1. Go to Izin tab
2. Tap the "+" button
3. Select leave type
4. Choose start and end dates
5. Enter reason
6. (Optional) Attach a file
7. Submit request

### ✅ View Reports
1. Go to Laporan tab
2. See pie chart with attendance percentage
3. View bar chart for weekly attendance
4. Check detailed statistics
5. Change month/year using top-right icon

## Troubleshooting

### App won't start?
```bash
flutter clean
flutter pub get
flutter run
```

### GPS not working?
- Enable Location Services on your device
- Grant location permission when prompted
- For emulator: Set location in emulator settings

### Camera not working?
- Grant camera permission when prompted
- Use physical device (camera may not work in emulator)

### Build errors?
Check Flutter installation:
```bash
flutter doctor
```

## Project Structure

```
lib/
├── config/          # Theme & routes
├── models/          # Data models
├── screens/         # All 8 screens
├── widgets/         # Reusable components
├── services/        # GPS & Camera services
├── utils/           # Helpers & constants
└── main.dart        # App entry point
```

## Customization

### Change Office Location
Edit `lib/utils/constants.dart`:
```dart
static const double officeLatitude = YOUR_LAT;
static const double officeLongitude = YOUR_LONG;
static const double validRadiusMeters = 100.0;
```

### Change Work Hours
Edit `lib/utils/constants.dart`:
```dart
static const String workStartTime = '08:00';
static const String workEndTime = '17:00';
```

## Next Steps

1. ✅ Explore all features
2. ✅ Try clock in/out with different scenarios
3. ✅ Create leave requests
4. ✅ View reports and charts
5. ✅ Edit your profile
6. 📖 Read [FEATURES.md](FEATURES.md) for complete feature list
7. 📖 Read [SETUP.md](SETUP.md) for detailed setup
8. 🔧 Integrate with your backend API

## Common Commands

```bash
# Run app
flutter run

# Run with specific device
flutter run -d <device_id>

# Build release APK
flutter build apk --release

# Run tests
flutter test

# Check code quality
flutter analyze

# Format code
flutter format lib/
```

## Features Overview

| Feature | Status | Description |
|---------|--------|-------------|
| 🔐 Authentication | ✅ | Splash, Login with validation |
| 🏠 Dashboard | ✅ | Statistics, Quick actions, Activities |
| ⏰ Attendance | ✅ | GPS validation, Camera selfie |
| 📜 History | ✅ | Filter, View past records |
| 📝 Leave Request | ✅ | Form, File upload, Status |
| 📊 Reports | ✅ | Charts, Statistics, Summary |
| 👤 Profile | ✅ | View, Edit, Settings, Logout |
| 🎨 Modern UI | ✅ | Green theme, Cards, Animations |

## Screen Flow

```
Splash Screen (3s)
    ↓
Login Screen
    ↓
Home Dashboard ←→ Bottom Navigation
    ├─→ Riwayat
    ├─→ Izin
    ├─→ Laporan
    └─→ Profile
```

## Support

Need help?
- 📖 Read the [README.md](README.md)
- 📋 Check [FEATURES.md](FEATURES.md) for complete feature list
- 🛠 See [SETUP.md](SETUP.md) for detailed setup guide
- 🐛 Report issues on GitHub

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design](https://material.io/design)

---

Happy coding! 🎉
