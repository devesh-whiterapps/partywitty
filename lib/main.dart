import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        // Apply Lexend font to all text
        textTheme: GoogleFonts.lexendTextTheme(),
        // Apply Lexend to other text styles
        primaryTextTheme: GoogleFonts.lexendTextTheme(),
        // Apply Lexend to input decoration text
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.lexend(),
          hintStyle: GoogleFonts.lexend(),
        ),
        // Apply Lexend to app bar
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.lexend(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        // Apply Lexend to button text
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(textStyle: GoogleFonts.lexend()),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(textStyle: GoogleFonts.lexend()),
        ),
        // Apply Lexend to dialog text
        dialogTheme: DialogThemeData(
          titleTextStyle: GoogleFonts.lexend(),
          contentTextStyle: GoogleFonts.lexend(),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}
