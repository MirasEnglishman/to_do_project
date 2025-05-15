import 'package:to_do_project/presentation/notification/notification_screen.dart';
import 'package:to_do_project/presentation/profile/profile_screen.dart';
import 'package:to_do_project/presentation/quote/quote_screen.dart';
import 'package:to_do_project/presentation/tasks/tasks_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    TasksScreen(),
    QuoteScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF6A1B9A),
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.task_alt), 
            label: 'navigation.tasks'.tr()
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.quora_rounded), 
            label: 'navigation.quote'.tr()
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications_active), 
            label: 'navigation.notifications'.tr()
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle), 
            label: 'navigation.profile'.tr()
          ),
        ],
      ),
    );
  }
}
