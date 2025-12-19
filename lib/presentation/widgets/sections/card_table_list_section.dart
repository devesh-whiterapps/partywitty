import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shared table booking data that can be used across the app
class TableBookingData {
  static List<Map<String, dynamic>> get tableOptions => [
    {
      'tableName': 'Table For 4',
      'zone': 'Standard Zone',
      'minSpend': '₹15,000',
      'perPerson': '₹2400/Person',
      'seatingType': 'Standard Seating',
      'features': [
        'Comfortable sofa seating',
        'Basic snacks included',
        'Standard entry',
      ],
      'bookingAmount': '₹3000',
      'bookFor': 'Book for 4',
      'bookingColor': const Color(0xFF3CBD53),
      'bookingBgColor': const Color(0xFF3CBD53).withOpacity(0.1),
      'hasBestValue': true,
    },
    {
      'tableName': 'Table for 8',
      'zone': 'VIP Zone',
      'minSpend': '₹28,000',
      'perPerson': '₹3500/Person',
      'seatingType': 'VIP Lounge Zone',
      'features': [
        'Premium bottle service',
        'Priority entry access',
        'Dedicated server',
      ],
      'bookingAmount': '₹4453',
      'bookFor': 'Book for 8',
      'bookingColor': const Color(0xFFA89D28),
      'bookingBgColor': const Color(0xFFA89D28).withOpacity(0.1),
      'hasBestValue': false,
    },
    {
      'tableName': 'Table For 10',
      'zone': 'Elite Zone',
      'minSpend': '₹40,000',
      'perPerson': '₹4000/Person',
      'seatingType': 'Elite Stage View',
      'features': [
        'Front stage positioning',
        'Dedicated steward service',
        'Premium cocktails included',
      ],
      'bookingAmount': '₹3000',
      'bookFor': 'Book for 10',
      'bookingColor': const Color(0xFFD4AF37),
      'bookingBgColor': const Color(0xFFD4AF37).withOpacity(0.1),
      'hasBestValue': false,
    },
  ];
}

/// Horizontal scrolling table booking cards with indicators
class CardTableBookingListSection extends StatefulWidget {
  final double height;

  const CardTableBookingListSection({super.key, this.height = 351});

  @override
  State<CardTableBookingListSection> createState() =>
      _CardTableBookingListSectionState();
}

class _CardTableBookingListSectionState
    extends State<CardTableBookingListSection> {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tableOptions = TableBookingData.tableOptions;
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                final cardWidth = 282.0 + 10.0; // card width + gap
                final newIndex = (_scrollController.offset / cardWidth).round();
                if (newIndex != _currentIndex &&
                    newIndex >= 0 &&
                    newIndex < tableOptions.length) {
                  setState(() => _currentIndex = newIndex);
                }
              }
              return false;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                children: List.generate(
                  tableOptions.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      right: index < tableOptions.length - 1 ? 10 : 0,
                    ),
                    child: _buildTableCard(tableOptions[index]),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Page indicators
        _buildIndicators(tableOptions.length),
      ],
    );
  }

  Widget _buildIndicators(int count) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.19),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              count,
              (index) => Container(
                width: index == _currentIndex ? 20 : 5,
                height: 5,
                margin: EdgeInsets.only(right: index < count - 1 ? 5 : 0),
                decoration: BoxDecoration(
                  color: const Color(0xFF7464E4),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableCard(Map<String, dynamic> data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(
          width: 282,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Header with image background
              Stack(
                children: [
                  // Background image
                  Container(
                    height: 90,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/view.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Dark overlay
                  Container(
                    height: 90,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  // Best Value badge
                  if (data['hasBestValue'] == true)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3CBD53).withOpacity(0.1),
                            ),
                            child: Text(
                              'Best Value',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF3CBD53),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Table info with icon
                  Positioned(
                    left: 20,
                    top: 0,
                    bottom: 0,
                    child: Row(
                      children: [
                        // User icon in circle
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/fi-rr-user-add.svg',
                            width: 28,
                            height: 28,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF4F4F4F),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Table name and zone
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data['tableName'],
                              style: GoogleFonts.lexend(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              data['zone'],
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Content section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Minimum Spend row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left - Price info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Minimum Spend',
                                style: GoogleFonts.lexend(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                              Text(
                                data['minSpend'],
                                style: GoogleFonts.lexend(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                              Text(
                                data['perPerson'],
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                            ],
                          ),
                          // Right - Book button
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0x4DFFFFFF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              data['bookFor'],
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF4F4F4F),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 19),
                      // Seating type
                      Text(
                        data['seatingType'],
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4F4F4F),
                        ),
                      ),
                      const SizedBox(height: 9),
                      // Features list
                      ...List.generate(
                        (data['features'] as List<String>).length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '•  ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF4F4F4F),
                                  height: 1.7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  (data['features'] as List<String>)[index],
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF4F4F4F),
                                    height: 1.7,
                                  ),
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
              // Bottom booking amount bar
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(color: data['bookingBgColor']),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BOOKING AMOUNT',
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: data['bookingColor'],
                          ),
                        ),
                        const SizedBox(width: 11),
                        Text(
                          data['bookingAmount'],
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: data['bookingColor'],
                          ),
                        ),
                      ],
                    ),
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
