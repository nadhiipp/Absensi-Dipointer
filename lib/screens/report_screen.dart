import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../config/theme.dart';
import '../utils/helpers.dart';
import '../widgets/custom_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/bottom_nav.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'leave_request_screen.dart';
import 'profile_screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen();
  
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _currentIndex = 3;
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;
  
  final List<Widget> _screens = const [
    HomeScreen(),
    HistoryScreen(),
    LeaveRequestScreen(),
    ReportScreen(),
    ProfileScreen(),
  ];
  
  // Dummy statistics
  final int _totalWorkingDays = 22;
  final int _totalPresent = 20;
  final int _totalPermission = 1;
  final int _totalAbsent = 0;
  final int _totalLate = 2;
  
  double get _attendancePercentage {
    return (_totalPresent / _totalWorkingDays) * 100;
  }
  
  void _showMonthPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Periode'),
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
              setState(() {});
            },
            child: const Text('Terapkan'),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    if (_currentIndex != 3) {
      return _screens[_currentIndex];
    }
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Laporan Bulanan'),
        backgroundColor: AppTheme.primaryGreen,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: _showMonthPicker,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Period Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.assessment,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 8),
                Text(
                  '${Helpers.getMonthName(_selectedMonth)} $_selectedYear',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Attendance Percentage
          CustomCard(
            child: Column(
              children: [
                const Text(
                  'Persentase Kehadiran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 60,
                          sections: [
                            PieChartSectionData(
                              value: _totalPresent.toDouble(),
                              color: AppTheme.successColor,
                              title: '',
                              radius: 30,
                            ),
                            PieChartSectionData(
                              value: _totalPermission.toDouble(),
                              color: AppTheme.warningColor,
                              title: '',
                              radius: 30,
                            ),
                            PieChartSectionData(
                              value: _totalAbsent.toDouble(),
                              color: AppTheme.errorColor,
                              title: '',
                              radius: 30,
                            ),
                            PieChartSectionData(
                              value: _totalLate.toDouble(),
                              color: const Color(0xFFFF9800),
                              title: '',
                              radius: 30,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${_attendancePercentage.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                          const Text(
                            'Kehadiran',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildLegend(),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Statistics Cards
          const Text(
            'Ringkasan Statistik',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          
          const SizedBox(height: 12),
          
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.3,
            children: [
              StatCard(
                title: 'Hari Kerja',
                value: '$_totalWorkingDays',
                icon: Icons.calendar_today,
                color: AppTheme.infoColor,
              ),
              StatCard(
                title: 'Hadir',
                value: '$_totalPresent',
                icon: Icons.check_circle,
                color: AppTheme.successColor,
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
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Weekly Chart
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kehadiran Mingguan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 5,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum'];
                              if (value.toInt() < days.length) {
                                return Text(
                                  days[value.toInt()],
                                  style: const TextStyle(fontSize: 12),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [
                          BarChartRodData(
                            toY: 4,
                            color: AppTheme.primaryGreen,
                            width: 20,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                        ]),
                        BarChartGroupData(x: 1, barRods: [
                          BarChartRodData(
                            toY: 4,
                            color: AppTheme.primaryGreen,
                            width: 20,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                        ]),
                        BarChartGroupData(x: 2, barRods: [
                          BarChartRodData(
                            toY: 4,
                            color: AppTheme.primaryGreen,
                            width: 20,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                        ]),
                        BarChartGroupData(x: 3, barRods: [
                          BarChartRodData(
                            toY: 4,
                            color: AppTheme.primaryGreen,
                            width: 20,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                        ]),
                        BarChartGroupData(x: 4, barRods: [
                          BarChartRodData(
                            toY: 4,
                            color: AppTheme.primaryGreen,
                            width: 20,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Summary Text
          CustomCard(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.info_outline,
                      color: AppTheme.primaryGreen,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Ringkasan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Dari $_totalWorkingDays hari kerja di bulan ${Helpers.getMonthName(_selectedMonth)}, Anda hadir $_totalPresent hari dengan persentase kehadiran ${_attendancePercentage.toStringAsFixed(1)}%.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                    height: 1.5,
                  ),
                ),
                if (_totalLate > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Terdapat $_totalLate kali keterlambatan.',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFFF9800),
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
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
  
  Widget _buildLegend() {
    return Column(
      children: [
        _buildLegendItem('Hadir', AppTheme.successColor, _totalPresent),
        const SizedBox(height: 8),
        _buildLegendItem('Izin', AppTheme.warningColor, _totalPermission),
        const SizedBox(height: 8),
        _buildLegendItem('Alpha', AppTheme.errorColor, _totalAbsent),
        const SizedBox(height: 8),
        _buildLegendItem('Terlambat', const Color(0xFFFF9800), _totalLate),
      ],
    );
  }
  
  Widget _buildLegendItem(String label, Color color, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
        Text(
          '$value hari',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
