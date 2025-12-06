import 'package:flutter/material.dart';
import 'presentation/screens/main_navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Partywitty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Bottom Sheet Demo')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               backgroundColor: Colors.transparent,
//               builder: (context) => const TicketInclusionBottomSheet(),
//             );
//           },
//           child: const Text('Show Ticket Inclusion'),
//         ),
//       ),
//     );
//   }
// }

// class TicketInclusionBottomSheet extends StatelessWidget {
//   const TicketInclusionBottomSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.7,
//       decoration: const BoxDecoration(
//         color: Color(0xFFB8B8B8),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24),
//           topRight: Radius.circular(24),
//         ),
//       ),
//       child: Column(
//         children: [
//           // Top indicator
//           Container(
//             margin: const EdgeInsets.only(top: 12),
//             width: 120,
//             height: 5,
//             decoration: BoxDecoration(
//               color: const Color(0xFF6B6B6B),
//               borderRadius: BorderRadius.circular(2.5),
//             ),
//           ),

//           // Title
//           const Padding(
//             padding: EdgeInsets.all(24.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Ticket Inclusion',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),

//           // List items
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 children: [
//                   _buildMenuItem('Starters:', false),
//                   const SizedBox(height: 16),
//                   _buildMenuItem('Main Course:', true),
//                   const SizedBox(height: 16),
//                   _buildMenuItem('Desserts:', false),
//                   const SizedBox(height: 16),
//                   _buildMenuItem('Drinks:', false),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMenuItem(String title, bool isHighlighted) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: isHighlighted
//             ? Border.all(color: const Color(0xFF8B5CF6), width: 3)
//             : null,
//       ),
//       child: Container(
//         decoration: isHighlighted
//             ? BoxDecoration(
//                 border: Border.all(
//                   color: const Color(0xFF8B5CF6),
//                   width: 2,
//                   strokeAlign: BorderSide.strokeAlignInside,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               )
//             : null,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const Icon(
//                 Icons.keyboard_arrow_down,
//                 size: 28,
//                 color: Colors.black,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Bottom Sheet Demo')),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 backgroundColor: Colors.transparent,
//                 builder: (context) => const TicketInclusionBottomSheet(),
//               );
//             },
//             child: const Text('Show Ticket Inclusion'),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TicketInclusionBottomSheet extends StatelessWidget {
//   const TicketInclusionBottomSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.7,
//       decoration: const BoxDecoration(
//         color: Color(0xFFB8B8B8),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24),
//           topRight: Radius.circular(24),
//         ),
//       ),
//       child: Column(
//         children: [
//           // Top indicator
//           Container(
//             margin: const EdgeInsets.only(top: 12),
//             width: 120,
//             height: 5,
//             decoration: BoxDecoration(
//               color: const Color(0xFF6B6B6B),
//               borderRadius: BorderRadius.circular(2.5),
//             ),
//           ),

//           // Title
//           const Padding(
//             padding: EdgeInsets.all(24.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Ticket Inclusion',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),

//           // List items
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 children: [
//                   _buildMenuItem('Starters:', false),
//                   const SizedBox(height: 16),
//                   _buildMenuItem('Main Course:', true),
//                   const SizedBox(height: 16),
//                   _buildMenuItem('Desserts:', false),
//                   const SizedBox(height: 16),
//                   _buildMenuItem('Drinks:', false),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMenuItem(String title, bool isHighlighted) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: isHighlighted
//             ? Border.all(color: const Color(0xFF8B5CF6), width: 3)
//             : null,
//       ),
//       child: Container(
//         decoration: isHighlighted
//             ? BoxDecoration(
//                 border: Border.all(
//                   color: const Color(0xFF8B5CF6),
//                   width: 2,
//                   strokeAlign: BorderSide.strokeAlignInside,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               )
//             : null,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const Icon(
//                 Icons.keyboard_arrow_down,
//                 size: 28,
//                 color: Colors.black,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
