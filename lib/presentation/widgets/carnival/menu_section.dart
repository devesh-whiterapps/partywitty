import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class MenuSection extends StatefulWidget {
  const MenuSection({super.key});

  @override
  State<MenuSection> createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {
  Map<String, bool> expandedSections = {
    'Veg Starters': true,
    'Veg Main course': false,
    'Desert': false,
    'Alcohol': false,
  };

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
              'Pass Menu Menu',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            _buildVegNonVegToggle(),
          ],
        ),
        const SizedBox(height: 10),

        // Menu Sections
        Column(
          children: [
            _buildExpandableSection('Veg Starters', '(Select Any 3)'),
            const SizedBox(height: 10),
            _buildExpandableSection('Veg Main course', '(Select Any 3)'),
            const SizedBox(height: 10),
            _buildExpandableSection('Desert', '(Select Any 3)'),
            const SizedBox(height: 10),
            _buildExpandableSection('Alcohol', '(Select Any 2)'),
          ],
        ),
      ],
    );
  }

  Widget _buildVegNonVegToggle() {
    return Container(
      width: 100, // Fixed width for wider button
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF3CBD53), // Bright green background
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Veg',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          // Veg indicator icon in white circle
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(4),
            child: Image.asset(
              'assets/icons/veg_indicator.png',
              width: 18,
              height: 18,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(String title, String subtitle) {
    final isExpanded = expandedSections[title] ?? false;

    return Container(
      width: 410,
      height: isExpanded ? 450 : null,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header - width: 380, height: 20
          GestureDetector(
            onTap: () {
              setState(() {
                expandedSections[title] = !isExpanded;
              });
            },
            child: Container(
              width: 380,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ), // Add vertical padding for better clickability
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Texts - width: 197, height: 20, gap: 10px
                  Row(
                    children: [
                      // Veg Starters - width: 92, height: 20
                      Text(
                        title,
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF070707),
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // (Select Any 3) - width: 95, height: 18
                      Text(
                        subtitle,
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF7464E4),
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                  // Arrow - rotated 180 deg when expanded
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Transform.rotate(
                      angle: isExpanded ? 3.14159 : 0,
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content - shown when expanded
          if (isExpanded) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: 324, // Match card width
              child: Column(
                children: [
                  ...List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _buildMenuItem(
                        'Corn Chaat',
                        'Lorem Ipsum is simply dummy',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuItem(String name, String description) {
    return Container(
      width: 324,
      height: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF), // Pure white only
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: const DecorationImage(
                image: AssetImage('assets/images/corn_chart.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Details
          Expanded(
            child: SizedBox(
              height: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Row with veg indicator and name
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1.33),
                        child: Image.asset(
                          'assets/icons/veg_indicator.png',
                          width: 14,
                          height: 14,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          name,
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF070707),
                            height: 1.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  // Description
                  Text(
                    description,
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF4F4F4F),
                      height: 1.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // View More
                  Text(
                    'View More',
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF070707),
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
