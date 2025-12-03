import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../utils/helpers.dart';
import '../widgets/custom_card.dart';
import '../widgets/bottom_nav.dart';
import 'home_screen.dart';
import 'leave_request_screen.dart';
import 'report_screen.dart';
import 'profile_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen();
  
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _currentIndex = 1;
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;
  
  final List<Widget> _screens = const [
    HomeScreen(),
    HistoryScreen(),
    LeaveRequestScreen(),
    ReportScreen(),
    ProfileScreen(),
  ];
  
  // Dummy attendance data
  final List<Map<String, dynamic>> _attendanceHistory = [
    {
      'date': DateTime.now(),
      'clockIn': '08:00',
      'clockOut': '17:00',
      'status': 'Hadir',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'clockIn': '08:15',
      'clockOut': '17:05',
      'status': 'Terlambat',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'clockIn': '08:05',
      'clockOut': '17:00',
      'status': 'Hadir',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'clockIn': '-',
      'clockOut': '-',
      'status': 'Izin',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'clockIn': '08:00',
      'clockOut': '17:00',
      'status': 'Hadir',
    },
  ];
  
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Riwayat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              value: _selectedMonth,
              decoration: const InputDecoration(
                labelText: 'Bulan',
              ),
              items: List.generate(12, (index) {
                return DropdownMenuItem(
                  value: index + 1,
                  child: Text(Helpers.getMonthName(index + 1)),
                );
              }),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedMonth = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _selectedYear,
              decoration: const InputDecoration(
                labelText: 'Tahun',
              ),
              items: List.generate(5, (index) {
                final year = DateTime.now().year - index;
                return DropdownMenuItem(
                  value: year,
                  child: Text('$year'),
                );
              }),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedYear = value;
                  });
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Helpers.showSnackBar(context, 'Filter diterapkan');
            },
            child: const Text('Terapkan'),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    if (_currentIndex != 1) {
      return _screens[_currentIndex];
    }
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            setState(() {
              _currentIndex = 0;
            });
          },
        ),
        title: const Text('Deposit Management'),
        backgroundColor: AppTheme.primaryGreen,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppTheme.errorColor,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 8,
                    minHeight: 8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Activity Overview Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.account_balance_wallet, 
                         color: AppTheme.textSecondary, size: 18),
                    SizedBox(width: 6),
                    Text(
                      'Now balance',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '180 Hari',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _showFilterDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add Deposit',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Status Row
          Row(
            children: [
              Expanded(
                child: _buildStatusItem('Complete', 15, AppTheme.successColor, Icons.check_circle),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatusItem('Pending', 3, AppTheme.warningColor, Icons.schedule),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatusItem('Remaining', 4, AppTheme.infoColor, Icons.hourglass_empty),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Payout Schedule
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Payout Schedule',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: const [
                    Text(
                      '2025',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, size: 18),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Month Scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildMonthItem('Jan', true, '150'),
                _buildMonthItem('Feb', true, '150'),
                _buildMonthItem('Mar', false, '150'),
                _buildMonthItem('New Month', false, ''),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Recent Activity
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          
          // Attendance List
          ..._attendanceHistory.map((attendance) {
            return _buildAttendanceCard(attendance);
          }).toList(),
        ],
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
  
  Widget _buildStatusItem(String label, int count, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMonthItem(String month, bool completed, String amount) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: completed ? AppTheme.primaryGreen : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          if (completed)
            const Icon(
              Icons.check_circle,
              color: AppTheme.primaryGreen,
              size: 24,
            )
          else
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade400, width: 2),
              ),
            ),
          const SizedBox(height: 8),
          Text(
            month,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: completed ? AppTheme.textPrimary : AppTheme.textSecondary,
            ),
          ),
          if (amount.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              '\$$amount',
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildAttendanceCard(Map<String, dynamic> attendance) {
    final date = attendance['date'] as DateTime;
    final clockIn = attendance['clockIn'] as String;
    final clockOut = attendance['clockOut'] as String;
    final status = attendance['status'] as String;
    final statusColor = Helpers.getStatusColor(status);
    
    return CustomCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Helpers.formatDate(date),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.login,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Clock In',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      clockIn,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Clock Out',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      clockOut,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (status == 'Hadir' || status == 'Terlambat') ...[
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Dalam radius kantor',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
