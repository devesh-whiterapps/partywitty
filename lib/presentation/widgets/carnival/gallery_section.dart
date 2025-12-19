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
              if (title == 'Food') {
                imagePath = 'assets/images/food.png';
              } else if (title == 'Ambiance') {
                imagePath = 'assets/images/ambiance.png';
              } else {
                imagePath = 'assets/images/beverages.png';
              }
              
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
            child: _buildImageCard(category: title),
          ),
        ),
      ],
    );
  }

  Widget _buildImageCard({required String category}) {
    String imagePath;
    
    if (category == 'Food') {
      imagePath = 'assets/images/food.png';
    } else if (category == 'Ambiance') {
      imagePath = 'assets/images/ambiance.png';
    } else {
      imagePath = 'assets/images/beverages.png';
    }

    return Image.asset(
      imagePath,
      width: 180,
      height: 180,
      fit: BoxFit.cover,
    );
  }
}