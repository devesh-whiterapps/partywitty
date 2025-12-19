import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Reusable event type/category section
class CardEventTypeSection extends StatelessWidget {
  final String category;
  final IconData icon;

  const CardEventTypeSection({
    super.key,
    required this.category,
    this.icon = Icons.theater_comedy_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xff4F4F4F)),
        const SizedBox(width: 4),
        Text(
          category,
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xff4F4F4F),
          ),
        ),
      ],
    );
  }
}
