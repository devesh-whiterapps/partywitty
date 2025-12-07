import 'package:flutter/material.dart';

/// Gradient background widget for the entire app
class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white, // Base white color
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFDBF658).withOpacity(0.15), // Top right - DBF658
              Color(
                0xFFF6C656,
              ).withOpacity(0.2), // Slightly above bottom right - F6C656
              Color(0xFF7464E4).withOpacity(0.2), // Bottom left - 7464E4
            ],
            stops: [0.0, 0.65, 1.0],
          ),
        ),
        child: child,
      ),
    );
  }
}
