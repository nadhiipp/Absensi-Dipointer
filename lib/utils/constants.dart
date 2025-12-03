class AppConstants {
  // App Info
  static const String appName = 'Absensi Dipointer';
  static const String appVersion = '1.0.0';
  
  // Office Location (example coordinates)
  static const double officeLatitude = -6.2088;
  static const double officeLongitude = 106.8456;
  static const double validRadiusMeters = 100.0; // 100 meters radius
  
  // Storage Keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserId = 'user_id';
  static const String keyUserName = 'user_name';
  static const String keyUserEmail = 'user_email';
  static const String keyUserPhoto = 'user_photo';
  static const String keyUserNip = 'user_nip';
  static const String keyUserDepartment = 'user_department';
  static const String keyUserPosition = 'user_position';
  
  // Date Formats
  static const String dateFormat = 'dd MMMM yyyy';
  static const String timeFormat = 'HH:mm:ss';
  static const String dateTimeFormat = 'dd MMMM yyyy, HH:mm';
  
  // API Endpoints (for future backend integration)
  static const String baseUrl = 'https://api.example.com';
  static const String loginEndpoint = '/auth/login';
  static const String clockInEndpoint = '/attendance/clock-in';
  static const String clockOutEndpoint = '/attendance/clock-out';
  
  // Leave Types
  static const List<String> leaveTypes = [
    'Sakit',
    'Cuti Tahunan',
    'Izin Pribadi',
    'Cuti Menikah',
    'Cuti Melahirkan',
    'Dinas Luar',
    'Lainnya',
  ];
  
  // Attendance Status
  static const String statusPresent = 'Hadir';
  static const String statusPermission = 'Izin';
  static const String statusAbsent = 'Alpha';
  static const String statusLate = 'Terlambat';
  
  // Work Hours
  static const String workStartTime = '08:00';
  static const String workEndTime = '17:00';
  static const int lateThresholdMinutes = 15;
}
