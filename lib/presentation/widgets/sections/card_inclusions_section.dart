import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

/// Reusable inclusions section
class CardInclusionsSection extends StatelessWidget {
  final List<String> inclusions;
  final int maxVisible;
  final VoidCallback? onMoreTap;

  const CardInclusionsSection({
    super.key,
    required this.inclusions,
    this.maxVisible = 2,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Inclusion',
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xff070707),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Flexible(
              child: Text.rich(
                TextSpan(
                  children: [
                    ...inclusions
                        .take(maxVisible)
                        .expand(
                          (item) => [
                            TextSpan(
                              text: '• $item',
                              style: GoogleFonts.lexend(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff4F4F4F),
                              ),
                            ),
                            const TextSpan(text: '  '),
                          ],
                        ),
                  ],
                ),
              ),
            ),
            Builder(
              builder: (context) => GestureDetector(
                onTap: () {
                  onMoreTap?.call();
                  // Show ticket inclusion bottom sheet
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) =>
                        _buildTicketInclusionBottomSheet(context),
                  );
                },
                child: Text(
                  '  10+ More',
                  style: GoogleFonts.lexend(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff7464E4),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Helper function to build Ticket Inclusion bottom sheet
Widget _buildTicketInclusionBottomSheet(BuildContext context) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 50,
                    height: 6,
                    decoration: BoxDecoration(
                      color: const Color(0xff4F4F4F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Title
                Text(
                  'Ticket Inclusion',
                  style: GoogleFonts.lexend(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff000000),
                  ),
                ),
                const SizedBox(height: 20),
                // Expandable sections
                _InclusionSection(
                  title: 'Breads',
                  isWhiteBackground: true,
                  items: const [
                    'Paneer Tikka',
                    'Veg Spring Rolls',
                    'Chicken Tikka',
                    'Crispy Corn',
                    'Fish Fingers',
                  ],
                ),
                const SizedBox(height: 12),
                _InclusionSection(
                  title: 'Main Course:',
                  isWhiteBackground: true,
                  items: const [
                    'Butter Chicken',
                    'Paneer Butter Masala',
                    'Dal Makhani',
                    'Veg Biryani / Chicken Biryani',
                    'Naan / Roti',
                  ],
                ),
                const SizedBox(height: 12),
                _InclusionSection(
                  title: 'Desserts:',
                  isWhiteBackground: true,
                  items: const [
                    'Gulab Jamun',
                    'Brownie with Ice Cream',
                    'Rasmalai',
                    'Pastries',
                  ],
                ),
                const SizedBox(height: 12),
                _InclusionSection(
                  title: 'Drinks:',
                  isWhiteBackground: true,
                  items: const [
                    'Mocktails',
                    'Soft Drinks',
                    'Fresh Juices',
                    'Coffee / Tea',
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

/// Expandable inclusion section widget
class _InclusionSection extends StatefulWidget {
  final String title;
  final List<String> items;
  final bool isWhiteBackground;

  const _InclusionSection({
    required this.title,
    required this.items,
    this.isWhiteBackground = false,
  });

  @override
  State<_InclusionSection> createState() => _InclusionSectionState();
}

class _InclusionSectionState extends State<_InclusionSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isWhiteBackground
            ? Colors.white
            : const Color(0xFFF9F9F9CC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff000000),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xff4F4F4F),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.only(top: 8, right: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF4F4F4F),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item,
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff4F4F4F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
