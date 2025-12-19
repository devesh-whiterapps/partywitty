import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/gradient_background.dart';
import 'event_listing_screen.dart';
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

// class _MainNavigationScreenState extends State<MainNavigationScreen> {
//   int _currentIndex = 3; // Start with booking screen
//   int _previousIndex = 3;

//   late final List<Widget> _screens;

//   @override
//   void initState() {
//     super.initState();
//     _screens = [
//       const HomeScreen(),
//       const SearchScreen(),
//       const SetupScreen(),
//       const BookingScreen(),
//       MenuScreen(onBack: _handleMenuBack),
//     ];
//   }

//   void _onTabTapped(int index) {
//     setState(() {
//       if (_currentIndex != index) {
//         _previousIndex = _currentIndex;
//       }
//       _currentIndex = index;
//     });
//   }

//   void _handleMenuBack() {
//     setState(() {
//       _currentIndex = _previousIndex;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool showBottomNav = _currentIndex != 4;

//     return Scaffold(
//       body: Stack(
//         children: [
//           GradientBackground(
//             child: IndexedStack(index: _currentIndex, children: _screens),
//           ),
//           if (showBottomNav)
//             // Floating bottom navigation bar
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: -15,
//               child: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     left: 16,
//                     right: 16,
//                     bottom: 16,
//                   ),
//                   child: CustomBottomNavigation(
//                     currentIndex: _currentIndex,
//                     onTap: _onTabTapped,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       // body: Stack(
//       //   children: [
//       //     GradientBackground(
//       //       child: AnimatedSwitcher(
//       //         duration: const Duration(milliseconds: 300),
//       //         transitionBuilder: (Widget child, Animation<double> animation) {
//       //           // Only apply slide transition when navigating to/from MenuScreen (index 4)
//       //           if (child.key == const ValueKey(4) || _previousIndex == 4) {
//       //             return SlideTransition(
//       //               position:
//       //                   Tween<Offset>(
//       //                     begin: const Offset(1.0, 0.0), // From right
//       //                     end: Offset.zero,
//       //                   ).animate(
//       //                     CurvedAnimation(
//       //                       parent: animation,
//       //                       curve: Curves.easeInOut,
//       //                     ),
//       //                   ),
//       //               child: child,
//       //             );
//       //           }
//       //           // No transition for other screens
//       //           return child;
//       //         },
//       //         child: CustomBottomNavigation(
//       //           currentIndex: _currentIndex,
//       //           onTap: _onTabTapped,
//       //         ),
//       //       ),
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// }

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0; // Start with home screen (EventListingScreen)
  int _previousIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const EventListingScreen(),
      const SearchScreen(),
      const SetupScreen(),
      const BookingScreen(),
      MenuScreen(onBack: _handleMenuBack),
    ];
  }

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = index;
    });
  }

  void _handleMenuBack() {
    setState(() {
      _currentIndex = _previousIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showBottomNav = _currentIndex != 4;

    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                if (_currentIndex == 4) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                }

                if (_previousIndex == 4) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(1, 0),
                    ).animate(animation),
                    child: child,
                  );
                }

                return FadeTransition(opacity: animation, child: child);
              },
              child: KeyedSubtree(
                key: ValueKey(_currentIndex),
                child: _screens[_currentIndex],
              ),
            ),
          ),

          // Bottom Navigation
          if (showBottomNav)
            Positioned(
              left: 0,
              right: 0,
              bottom: -15,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
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
