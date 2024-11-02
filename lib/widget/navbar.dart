import 'package:flutter/material.dart';
import 'package:health/admins/adminDashboard.dart';
import 'package:health/admins/adminsetting.dart';
import 'package:health/admins/ahealthcare.dart';
import 'package:health/admins/ausermanage.dart';
import 'package:health/users/DashboardScreen.dart';
import 'package:health/users/HealthcareScreen.dart';
import 'package:health/users/HomeScreen.dart';
import 'package:health/users/SettingScreen.dart';

class NavBarRoots extends StatefulWidget {
  final String role; // เพิ่มบทบาทของผู้ใช้ ('admin' หรือ 'user')
  
  NavBarRoots({required this.role}); // รับค่าบทบาทของผู้ใช้
  
  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectedIndex = 0;

  // สร้าง list สำหรับหน้าของ User
  final _userScreens = [
    HomeScreen(),
    DashboardScreen(),
    HealthcareScreen(),
    SettingScreen()
  ];

  // สร้าง list สำหรับหน้าของ Admin
  final _adminScreens = [
    UserManagement(),
    AdminDashboard(),
    AdminHealthcareScreen(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    // เลือกใช้หน้าของ User หรือ Admin ตามบทบาท
    final _screens = widget.role == 'admin' ? _adminScreens : _userScreens;

    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          // กำหนด items ตามบทบาทของผู้ใช้
          items: widget.role == 'admin'
              ? [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Manage Users"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard),
                      label: "Admin Dashboard"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.document_scanner), label: "Add detail"),    
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Settings"),
                ]
              : [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard_sharp), label: "Dashboard"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.newspaper), label: "Health Care"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Setting"),
                ],
        ),
      ),
    );
  }
}
