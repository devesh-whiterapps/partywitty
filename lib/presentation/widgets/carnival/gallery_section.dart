import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../screens/gallery_detail_screen.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gallery',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          _buildCategorySection('Ambiance', 31, context),
          const SizedBox(height: 50),
          _buildCategorySection('Food', 21, context),
          const SizedBox(height: 50),
          _buildCategorySection('Beverages', 56, context),
        ],
      ),
    );
  }

  Widget _buildCategorySection(String title, int count, BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: GestureDetector(
            onTap: () {
              String imagePath;
              imagePath = 'assets/images/Frame 427319585.png';

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalleryDetailScreen(
                    category: title,
                    imagePath: imagePath,
                  ),
                ),
              );
            },
            child: _buildImageCard(category: title, count: count),
          ),
        ),
      ],
    );
  }

  Widget _buildImageCard({required String category, required int count}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Base image
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/Frame 427319585.png',
            width: 280,
            height: 280,
            fit: BoxFit.cover,
          ),
        ),
        // Text overlay
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$count+',
              style: GoogleFonts.lexend(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              'Picture',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
