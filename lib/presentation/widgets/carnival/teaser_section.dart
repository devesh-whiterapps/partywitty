import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeaserSection extends StatelessWidget {
  const TeaserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Teaser',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    'View all',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const Icon(Icons.arrow_forward, size: 16, color: Colors.black87),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),

        // Teaser Videos
        SizedBox(
          height: 507,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildTeaserCard(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTeaserCard() {
    return Container(
      width: 317,
      height: 507,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFD2D2D2), width: 0.91),
      ),
      child: Stack(
        children: [
          // Video Thumbnail
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: const DecorationImage(
                image: AssetImage('assets/images/dummy_videoImg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),

          // Category Tag (Bottom-Left)
          Positioned(
            bottom: 10,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: const BoxDecoration(
                color: Color(0xFF3CBD53),
                borderRadius: BorderRadius.horizontal(right: Radius.circular(50)),
              ),
              child: Text(
                'Ambience',
                style: GoogleFonts.urbanist(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Volume Button (Top-Right)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFDCDBF4),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.volume_up,
                size: 16,
                color: Colors.black87,
              ),
            ),
          ),

          // Play Button (Center)
          Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
              child: const Icon(
                Icons.play_arrow,
                size: 24,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}