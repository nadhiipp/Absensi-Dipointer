import 'package:flutter/material.dart';
import '../config/theme.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  
  const BottomNav({
    required this.currentIndex,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Active indicator line
          Container(
            height: 3,
            color: Colors.transparent,
            child: LayoutBuilder(
              builder: (context, constraints) {
                const itemCount = 5; // Number of navigation items
                return Row(
                  children: List.generate(itemCount, (index) {
                    return Expanded(
                      child: Container(
                        color: currentIndex == index 
                            ? AppTheme.primaryGreen 
                            : Colors.transparent,
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppTheme.primaryGreen,
            unselectedItemColor: AppTheme.textGrey,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            elevation: 0,
            backgroundColor: Colors.white,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 26),
                activeIcon: Icon(Icons.home, size: 26),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined, size: 26),
                activeIcon: Icon(Icons.account_balance_wallet, size: 26),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.volunteer_activism_outlined, size: 26),
                activeIcon: Icon(Icons.volunteer_activism, size: 26),
                label: 'Izin',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.request_quote_outlined, size: 26),
                activeIcon: Icon(Icons.request_quote, size: 26),
                label: 'Laporan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 26),
                activeIcon: Icon(Icons.person, size: 26),
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
