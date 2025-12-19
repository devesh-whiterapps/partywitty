import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VenueDetailsCard extends StatelessWidget {
  final String venueName;
  final double rating;
  final int reviewCount;
  final String location;
  final String distance;
  final String serviceType;

  const VenueDetailsCard({
    super.key,
    required this.venueName,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.distance,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Venue Header
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: const NetworkImage('https://picsum.photos/40/40'),
              ),
              const SizedBox(width: 10),
              Text(
                venueName,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              _buildRatingChip(rating),
              const SizedBox(width: 8),
              _buildReviewChip(reviewCount),
            ],
          ),
          const SizedBox(height: 15),

          // Location and Distance
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  location,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF7464E4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.navigation, size: 12, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      distance,
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Service Type
          Row(
            children: [
              const Icon(Icons.restaurant, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(
                serviceType,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Service Time Info
          Row(
            children: [
              Text(
                'Service Time',
                style: GoogleFonts.lexend(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.info_outline, size: 14, color: Colors.black87),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              _buildTimeChip('️', '3 hrs'),
              const SizedBox(width: 10),
              _buildTimeChip('', '1.5 hrs'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingChip(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF7464E4),
            const Color(0xFFB5A68A),
          ],
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, size: 12, color: Colors.amber),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewChip(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF7464E4),
            const Color(0xFFB5A68A),
          ],
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        'Review ($count)',
        style: GoogleFonts.lexend(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTimeChip(String emoji, String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFDEDEDE),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Text(
            time,
            style: GoogleFonts.lexend(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}