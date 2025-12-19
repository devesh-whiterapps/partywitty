import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventInfoCard extends StatelessWidget {
  const EventInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Date and Time Row
          _buildDateTimeRow(),
          const SizedBox(height: 10),

          // Event Title
          _buildEventTitle(),
          const SizedBox(height: 10),

          // Venue Info Row
          _buildVenueInfoRow(),
          const SizedBox(height: 16),

          // Location Row
          _buildLocationRow(),
        ],
      ),
    );
  }

  Widget _buildDateTimeRow() {
    return Row(
      children: [
        Text(
          '29 Dec 25',
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.2,
            color: const Color(0xFF4F4F4F),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: Color(0xFF4F4F4F),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '10:00 PM Onwards',
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.2,
            color: const Color(0xFF4F4F4F),
          ),
        ),
      ],
    );
  }

  Widget _buildEventTitle() {
    return Text(
      'Tuesday Tunes @connaught club house@01 July 2025 ( DJ Night)',
      style: GoogleFonts.lexend(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: const Color(0xFF070707),
      ),
    );
  }

  Widget _buildVenueInfoRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // F-Bar Logo
        Image.asset(
          'assets/icons/f_bar_logo.png',
          width: 24,
          height: 24,
          errorBuilder: (context, error, stackTrace) {
            // Fallback if image doesn't load
            return Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFF1A00D1),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'F',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10),
        Text(
          'F-bar',
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.2,
            color: const Color(0xFF111827),
          ),
        ),
        const SizedBox(width: 6),
        Row(
          children: [
            const Icon(Icons.star, color: Color(0xFFFFC107), size: 18),
            const SizedBox(width: 6),
            Text(
              '4.1',
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(width: 6),
        Text(
          'Review (03)',
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, color: Colors.grey[600], size: 18),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            'DLP Phase 3, Gurugram',
            style: GoogleFonts.lexend(
              fontSize: 14,
              height: 1.2,
              color: Colors.grey[700],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFEDE9FE), // Light purple background
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.directions,
                  color: Color(0xFF7C3AED), size: 14),
              const SizedBox(width: 4),
              Text(
                '1.2 Kms',
                style: GoogleFonts.lexend(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7C3AED),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

