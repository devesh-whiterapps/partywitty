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
                    builder: (context) => _TicketInclusionBottomSheet(),
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

/// Ticket Inclusion Bottom Sheet with managed state
class _TicketInclusionBottomSheet extends StatefulWidget {
  const _TicketInclusionBottomSheet();

  @override
  State<_TicketInclusionBottomSheet> createState() =>
      _TicketInclusionBottomSheetState();
}

class _TicketInclusionBottomSheetState
    extends State<_TicketInclusionBottomSheet> {
  String? expandedSection;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
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
                    id: 'breads',
                    title: 'Breads',
                    isWhiteBackground: true,
                    items: const [
                      'Paneer Tikka',
                      'Veg Spring Rolls',
                      'Chicken Tikka',
                      'Crispy Corn',
                      'Fish Fingers',
                    ],
                    isExpanded: expandedSection == 'breads',
                    onTap: () {
                      setState(() {
                        if (expandedSection == 'breads') {
                          expandedSection = null;
                        } else {
                          expandedSection = 'breads';
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  _InclusionSection(
                    id: 'main_course',
                    title: 'Main Course:',
                    isWhiteBackground: true,
                    items: const [
                      'Butter Chicken',
                      'Paneer Butter Masala',
                      'Dal Makhani',
                      'Veg Biryani / Chicken Biryani',
                      'Naan / Roti',
                    ],
                    isExpanded: expandedSection == 'main_course',
                    onTap: () {
                      setState(() {
                        if (expandedSection == 'main_course') {
                          expandedSection = null;
                        } else {
                          expandedSection = 'main_course';
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  _InclusionSection(
                    id: 'desserts',
                    title: 'Desserts:',
                    isWhiteBackground: true,
                    items: const [
                      'Gulab Jamun',
                      'Brownie with Ice Cream',
                      'Rasmalai',
                      'Pastries',
                    ],
                    isExpanded: expandedSection == 'desserts',
                    onTap: () {
                      setState(() {
                        if (expandedSection == 'desserts') {
                          expandedSection = null;
                        } else {
                          expandedSection = 'desserts';
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  _InclusionSection(
                    id: 'drinks',
                    title: 'Drinks:',
                    isWhiteBackground: true,
                    items: const [
                      'Mocktails',
                      'Soft Drinks',
                      'Fresh Juices',
                      'Coffee / Tea',
                    ],
                    isExpanded: expandedSection == 'drinks',
                    onTap: () {
                      setState(() {
                        if (expandedSection == 'drinks') {
                          expandedSection = null;
                        } else {
                          expandedSection = 'drinks';
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Expandable inclusion section widget (now stateless)
class _InclusionSection extends StatelessWidget {
  final String id;
  final String title;
  final List<String> items;
  final bool isWhiteBackground;
  final bool isExpanded;
  final VoidCallback onTap;

  const _InclusionSection({
    required this.id,
    required this.title,
    required this.items,
    required this.isExpanded,
    required this.onTap,
    this.isWhiteBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isWhiteBackground ? Colors.white : const Color(0xFFF9F9F9CC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
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
                children: items.map((item) {
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
