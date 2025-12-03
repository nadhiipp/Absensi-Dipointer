import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'constants.dart';

class Helpers {
  // Format Date
  static String formatDate(DateTime date, {String format = AppConstants.dateFormat}) {
    return DateFormat(format, 'id_ID').format(date);
  }
  
  // Format Time
  static String formatTime(DateTime time, {String format = AppConstants.timeFormat}) {
    return DateFormat(format).format(time);
  }
  
  // Format DateTime
  static String formatDateTime(DateTime dateTime, {String format = AppConstants.dateTimeFormat}) {
    return DateFormat(format, 'id_ID').format(dateTime);
  }
  
  // Check if time is late
  static bool isLate(DateTime clockInTime) {
    final workStart = DateTime(
      clockInTime.year,
      clockInTime.month,
      clockInTime.day,
      8, // 08:00
      0,
    );
    final lateThreshold = workStart.add(Duration(minutes: AppConstants.lateThresholdMinutes));
    return clockInTime.isAfter(lateThreshold);
  }
  
  // Calculate distance between two points (Haversine formula)
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const R = 6371000; // Earth's radius in meters
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }
  
  static double _toRadians(double degree) {
    return degree * pi / 180;
  }
  
  // Check if location is within valid radius
  static bool isWithinValidRadius(double userLat, double userLon) {
    final distance = calculateDistance(
      userLat,
      userLon,
      AppConstants.officeLatitude,
      AppConstants.officeLongitude,
    );
    return distance <= AppConstants.validRadiusMeters;
  }
  
  // Get status color
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'hadir':
      case 'success':
      case 'approved':
        return const Color(0xFF4CAF50);
      case 'izin':
      case 'pending':
        return const Color(0xFFFFA726);
      case 'alpha':
      case 'rejected':
        return const Color(0xFFEF5350);
      case 'terlambat':
        return const Color(0xFFFF9800);
      default:
        return Colors.grey;
    }
  }
  
  // Show snackbar
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : const Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
  
  // Show loading dialog
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  
  // Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  // Get greeting based on time
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 15) {
      return 'Selamat Siang';
    } else if (hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }
  
  // Get month name in Indonesian
  static String getMonthName(int month) {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month - 1];
  }
  
  // Calculate working days in month
  static int getWorkingDaysInMonth(int year, int month) {
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    int workingDays = 0;
    
    for (int day = 1; day <= lastDay.day; day++) {
      final date = DateTime(year, month, day);
      // Skip weekends (Saturday = 6, Sunday = 7)
      if (date.weekday != DateTime.saturday && date.weekday != DateTime.sunday) {
        workingDays++;
      }
    }
    
    return workingDays;
  }
}
