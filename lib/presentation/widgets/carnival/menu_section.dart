import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class MenuSection extends StatefulWidget {
  const MenuSection({super.key});

  @override
  State<MenuSection> createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {
  // Only one section can be expanded at a time (accordion behavior)
  String? expandedSection = 'Veg Starters';

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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
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
    final isExpanded = expandedSection == title;

    return Container(
      width: double.infinity,
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
                // Accordion behavior: toggle current or close if already open
                if (expandedSection == title) {
                  expandedSection = null;
                } else {
                  expandedSection = title;
                }
              });
            },
            child: Container(
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
            Column(
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
          ],
        ],
      ),
    );
  }

  Widget _buildMenuItem(String name, String description) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image with rounded corners
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/corn_chart.jpg',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 70,
                height: 70,
                color: Colors.grey[200],
                child: const Icon(Icons.restaurant, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row with veg indicator and name
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF3CBD53),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3CBD53),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        name,
                        style: GoogleFonts.lexend(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF070707),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Description
                Text(
                  description,
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF828282),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                // View More link
                Row(
                  children: [
                    Text(
                      'View More',
                      style: GoogleFonts.lexend(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF7464E4),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward,
                      size: 10,
                      color: Color(0xFF7464E4),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
