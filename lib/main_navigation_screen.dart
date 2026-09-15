import 'package:flutter/material.dart';
import 'home_map_screen.dart';
import 'profile_screen.dart';
import 'leaderboard_screen.dart';
import 'admin_dashboard.dart';

class MainNavigationScreen extends StatefulWidget {
  final bool isAdmin; // Admin check flag

  const MainNavigationScreen({
    Key? key, 
    this.isAdmin = false, // Default: Non-admin user/driver
  }) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Regular users get 3 screens, Admins get 4 screens
    final List<Widget> screens = [
      const HomeMapScreen(),
      ProfileScreen(),
      if (widget.isAdmin) AdminDashboard(),
    ];

    final List<BottomNavigationBarItem> navItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: 'Map'),
      const BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
      const BottomNavigationBarItem(icon: Icon(Icons.leaderboard_rounded), label: 'Leaderboard'),
      if (widget.isAdmin)
        const BottomNavigationBarItem(
          icon: Icon(Icons.admin_panel_settings_rounded), 
          label: 'Admin',
        ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: const Color(0xFF12161F),
        selectedItemColor: const Color(0xFF00E5FF),
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        items: navItems,
      ),
    );
  }
}