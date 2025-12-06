import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/gradient_background.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'setup_screen.dart';
import 'booking_screen.dart';
import 'menu_screen.dart';

/// Main navigation screen that manages all screens and bottom navigation
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 3; // Start with booking screen

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const SetupScreen(),
    const BookingScreen(),
    const MenuScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(
            child: IndexedStack(index: _currentIndex, children: _screens),
          ),
          // Floating bottom navigation bar
          Positioned(
            left: 0,
            right: 0,
            bottom: -15,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: CustomBottomNavigation(
                  currentIndex: _currentIndex,
                  onTap: _onTabTapped,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
