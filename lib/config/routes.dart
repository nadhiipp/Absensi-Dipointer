import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/attendance_screen.dart';
import '../screens/history_screen.dart';
import '../screens/leave_request_screen.dart';
import '../screens/report_screen.dart';
import '../screens/profile_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String attendance = '/attendance';
  static const String history = '/history';
  static const String leaveRequest = '/leave-request';
  static const String report = '/report';
  static const String profile = '/profile';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case attendance:
        return MaterialPageRoute(builder: (_) => const AttendanceScreen());
      case history:
        return MaterialPageRoute(builder: (_) => const HistoryScreen());
      case leaveRequest:
        return MaterialPageRoute(builder: (_) => const LeaveRequestScreen());
      case report:
        return MaterialPageRoute(builder: (_) => const ReportScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
