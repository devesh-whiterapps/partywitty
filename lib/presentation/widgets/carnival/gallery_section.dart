import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  String selectedTab = 'All';

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
              'Gallery',
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

        // Tabs
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F1F6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTab('All'),
                _buildTab('Ambiance'),
                _buildTab('Beverages'),
                _buildTab('Food'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Gallery Grid
        SizedBox(
          height: 400,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildGalleryCategory('Ambiance', 31),
              const SizedBox(width: 20),
              _buildGalleryCategory('Food', 21),
              const SizedBox(width: 20),
              _buildGalleryCategory('Beverages', 56),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String title) {
    final isSelected = selectedTab == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7464E4) : const Color(0xFFD4C6E1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildGalleryCategory(String title, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.lexend(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            // Background images
            Container(
              width: 280,
              height: 350,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _buildGalleryImage(260, 140),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: _buildGalleryImage(120, 140),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: _buildGalleryImage(120, 140),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: _buildGalleryImage(260, 140),
                  ),
                ],
              ),
            ),

            // Overlay with count
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF7464E4).withOpacity(0.8),
                      const Color(0xFF1A00D1).withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$count+',
                        style: GoogleFonts.lexend(
                          fontSize: 31,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Picture',
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGalleryImage(double width, double height) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/300/200'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }
}