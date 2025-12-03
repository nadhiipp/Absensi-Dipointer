import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../config/theme.dart';
import '../config/routes.dart';
import '../utils/helpers.dart';
import '../widgets/stat_card.dart';
import '../widgets/activity_item.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/custom_card.dart';
import 'history_screen.dart';
import 'leave_request_screen.dart';
import 'report_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _userName = 'User';
  String _currentTime = '';
  String _currentDate = '';
  Timer? _timer;
  
  // Dummy statistics
  final int _totalPresent = 22;
  final int _totalPermission = 1;
  final int _totalAbsent = 0;
  final int _totalLate = 2;
  
  final List<Widget> _screens = const [
    HomeContent(),
    HistoryScreen(),
    LeaveRequestScreen(),
    ReportScreen(),
    ProfileScreen(),
  ];
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
    _updateDateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDateTime();
    });
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? 'User';
    });
  }
  
  void _updateDateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = Helpers.formatTime(now);
      _currentDate = Helpers.formatDate(now);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (_currentIndex != 0) {
      return _screens[_currentIndex];
    }
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Helpers.getGreeting(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _userName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.person,
                            size: 32,
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _currentDate,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _currentTime,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Statistics Cards
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Statistik Absensi Bulan Ini',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.3,
                      children: [
                        StatCard(
                          title: 'Total Hadir',
                          value: '$_totalPresent',
                          icon: Icons.check_circle,
                          color: AppTheme.successColor,
                          gradient: AppTheme.cardGradient,
                        ),
                        StatCard(
                          title: 'Izin',
                          value: '$_totalPermission',
                          icon: Icons.event_note,
                          color: AppTheme.warningColor,
                        ),
                        StatCard(
                          title: 'Alpha',
                          value: '$_totalAbsent',
                          icon: Icons.cancel,
                          color: AppTheme.errorColor,
                        ),
                        StatCard(
                          title: 'Terlambat',
                          value: '$_totalLate',
                          icon: Icons.access_time,
                          color: const Color(0xFFFF9800),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Quick Actions
                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomCard(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.attendance);
                            },
                            gradient: AppTheme.primaryGradient,
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.login,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Clock In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomCard(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.attendance);
                            },
                            color: Colors.white,
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.logout,
                                  color: AppTheme.primaryGreen,
                                  size: 32,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Clock Out',
                                  style: TextStyle(
                                    color: AppTheme.primaryGreen,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomCard(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.leaveRequest);
                            },
                            color: Colors.white,
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.event_available,
                                  color: AppTheme.primaryGreen,
                                  size: 32,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Request Izin',
                                  style: TextStyle(
                                    color: AppTheme.primaryGreen,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Recent Activity
                    const Text(
                      'Aktivitas Terbaru',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ActivityItem(
                      title: 'Clock In',
                      subtitle: 'Berhasil absen masuk',
                      status: 'Success',
                      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
                      icon: Icons.login,
                    ),
                    ActivityItem(
                      title: 'Clock Out',
                      subtitle: 'Berhasil absen pulang',
                      status: 'Success',
                      dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 8)),
                      icon: Icons.logout,
                    ),
                    ActivityItem(
                      title: 'Request Izin',
                      subtitle: 'Izin sakit - Menunggu persetujuan',
                      status: 'Pending',
                      dateTime: DateTime.now().subtract(const Duration(days: 2)),
                      icon: Icons.event_note,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent();
  
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
