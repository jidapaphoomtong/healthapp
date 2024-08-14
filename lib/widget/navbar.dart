import 'package:flutter/material.dart';
import 'package:health/users/DashboardScreen.dart';
import 'package:health/users/HealthcareScreen.dart';
import 'package:health/users/HomeScreen.dart';
import 'package:health/users/SettingScreen.dart';

class NavBarRoots extends StatefulWidget{
  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectedIndex = 0;
  final _screen = [
    HomeScreen(),
    // homescreen
    DashboardScreen(),
    // //history 
    HealthcareScreen(),
    // // information
    SettingScreen()
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,

      body: _screen[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontWeight:  FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: _selectedIndex,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled),
            label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_sharp),
            label: "Health Check"),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper),
            label: "Health Care"),
            BottomNavigationBarItem(icon: Icon(Icons.settings),
            label: "Setting"),
            ],
        ),
      ),
    );
  }
}