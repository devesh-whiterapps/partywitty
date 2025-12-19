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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF3CBD53), // Bright green background
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Veg',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          // Veg indicator icon from assets
          Image.asset(
            'assets/icons/veg_indicator.png',
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(String title, String subtitle) {
    final isExpanded = expandedSections[title] ?? false;
    final isAlcohol = title == 'Alcohol';

    return Container(
      width: 410,
      height: isExpanded && !isAlcohol ? 450 : null,
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
            onTap: isAlcohol ? null : () {
              setState(() {
                expandedSections[title] = !isExpanded;
              });
            },
            child: Container(
              width: 380,
              padding: const EdgeInsets.symmetric(vertical: 8), // Add vertical padding for better clickability
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
                  // Arrow - width: 16, height: 16, rotated 180 deg when expanded
                  // Hide arrow for Alcohol section
                  if (!isAlcohol)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Transform.rotate(
                        angle: isExpanded ? 3.14159 : 0, // 180 degrees = π radians
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

          // Content - adjusted width to match card width
          // Don't show content for Alcohol section
          if (isExpanded && !isAlcohol) ...[
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
      width: 324, // Reduced by 56 to fix overflow (380 - 56 = 324)
      height: 80, // Reduced by 10 to fix overflow (90 - 10 = 80)
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0x80FFFFFF), // #FFFFFF80
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Row(
            children: [
              // Image - width: 70, height: 70, border-radius: 4px
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

              // Details - adjusted width to fit (324 - 10 padding - 70 image - 10 gap - 10 padding = 224)
              Expanded(
                child: SizedBox(
                  height: 60, // Adjusted height (80 - 10 padding top - 10 padding bottom = 60)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Row with veg indicator and name
                      Row(
                        children: [
                          // Veg indicator image - width: 13.333333015441895, height: 13.333333015441895, border-radius: 1.33px
                          ClipRRect(
                            borderRadius: BorderRadius.circular(1.33),
                            child: Image.asset(
                              'assets/icons/veg_indicator.png',
                              width: 13.333333015441895,
                              height: 13.333333015441895,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Corn Chaat - flexible width
                          Flexible(
                            child: Text(
                              name,
                              style: GoogleFonts.lexend(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF070707),
                                height: 1.5, // line-height: 24px
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
        ),
      ),
    );
  }
}
