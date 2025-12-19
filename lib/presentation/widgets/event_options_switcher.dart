import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EventOptionsSwitcher extends StatefulWidget {
  const EventOptionsSwitcher({super.key});

  @override
  State<EventOptionsSwitcher> createState() => _EventOptionsSwitcherState();
}

class _EventOptionsSwitcherState extends State<EventOptionsSwitcher> {
  bool _showTableOptions = false;
  int _currentTableIndex = 0;
  final ScrollController _tableScrollController = ScrollController();

  @override
  void dispose() {
    _tableScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- HEADER SECTION ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _showTableOptions ? 'Table Options' : 'Ticket Options',
              style: GoogleFonts.lexend(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () => setState(() => _showTableOptions = !_showTableOptions),
              child: Text(
                _showTableOptions ? 'View Tickets Options' : 'View Table Options',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  color: const Color(0xFF7464E4),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // --- CONTENT SECTION ---
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _showTableOptions ? _buildTableOptionsList() : _buildTicketPassList(),
        ),

        const SizedBox(height: 15),

        // --- INDICATORS (only show for table options) ---
        if (_showTableOptions)
          Center(child: _buildIndicators(3, _currentTableIndex))
        else
          Center(child: _buildIndicators(2, 0)),
      ],
    );
  }


  Widget _buildTicketPassList() {
    return SizedBox(
      key: const ValueKey('tickets'),
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        itemCount: 2,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Image.asset('assets/images/event_pass.png', height: 220, fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget _buildTableOptionsList() {
    return SizedBox(
      key: const ValueKey('tables'),
      height: 351, // Fixed height per spec
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            final cardWidth = 282.0 + 16.0; // card width + gap
            final newIndex = (_tableScrollController.offset / cardWidth).round();
            if (newIndex != _currentTableIndex &&
                newIndex >= 0 &&
                newIndex < 3) {
              setState(() => _currentTableIndex = newIndex);
            }
          }
          return false;
        },
        child: ListView(
          controller: _tableScrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          children: const [
            TableBookingCard(
              title: 'Table For 4',
              zone: 'Standard Zone',
              price: '15,000',
              perPerson: '2400',
              amount: '3000',
              features: ['Comfortable sofa seating', 'Basic snacks included', 'Standard entry'],
              hasBestValue: true,
              bookingColor: Color(0xFF3CBD53),
            ),
            SizedBox(width: 16),
            TableBookingCard(
              title: 'Table For 8',
              zone: 'VIP Zone',
              price: '28,000',
              perPerson: '3500',
              amount: '4453',
              features: ['Premium bottle service', 'Priority entry access', 'Dedicated server'],
              hasBestValue: false,
              bookingColor: Color(0xFFA89D28),
            ),
            SizedBox(width: 16),
            TableBookingCard(
              title: 'Table For 10',
              zone: 'Elite Zone',
              price: '40,000',
              perPerson: '4000',
              amount: '3000',
              features: ['Front stage positioning', 'Dedicated steward service', 'Premium cocktails included'],
              hasBestValue: false,
              bookingColor: Color(0xFFD4AF37),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicators(int count, int currentIndex) {
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
              (index) => Padding(
                padding: EdgeInsets.only(
                  right: index < count - 1 ? 5 : 0,
                ),
                child: Image.asset(
                  'assets/images/indicator.png',
                  width: index == currentIndex ? 20 : 5,
                  height: 5,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to colored container if image not found
                    return Container(
                      width: index == currentIndex ? 20 : 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7464E4),
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TableBookingCard extends StatelessWidget {
  final String title, zone, price, perPerson, amount;
  final List<String> features;
  final bool hasBestValue;
  final Color bookingColor;

  const TableBookingCard({
    super.key,
    required this.title,
    required this.zone,
    required this.price,
    required this.perPerson,
    required this.amount,
    required this.features,
    required this.hasBestValue,
    this.bookingColor = const Color(0xFF3CBD53),
  });

  @override
  Widget build(BuildContext context) {
    final tableNumber = title.split(' ').last;
    final seatingTitle = zone.contains('Standard')
        ? 'Standard Seating'
        : zone.contains('VIP')
            ? 'VIP Seating'
            : 'Elite Seating';

    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
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
              _header(), // Background image + Title + Zone
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
                                '₹$price',
                                style: GoogleFonts.lexend(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                              Text(
                                '₹$perPerson/Person',
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
                            width: 85,
                            height: 31,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0x4DFFFFFF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Book For $tableNumber',
                              style: _textStyle(12, weight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 19),
                      // Seating type
                      Text(
                        seatingTitle,
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4F4F4F),
                        ),
                      ),
                      const SizedBox(height: 9),
                      // Features list
                      ...List.generate(
                        features.length,
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
                                  features[index],
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
              _footer(), // Booking Amount Bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Stack(
      children: [
        // Background image
        Container(
          height: 90,
          width: 282,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/table_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Dark overlay
        Container(
          height: 90,
          width: 282,
          color: Colors.black.withOpacity(0.2),
        ),
        // Best Value badge
        if (hasBestValue)
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
                  placeholderBuilder: (context) => const Icon(
                    Icons.person_add_outlined,
                    color: Color(0xFF4F4F4F),
                    size: 18,
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
                    title,
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    zone,
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
    );
  }

  Widget _footer() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: bookingColor.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BOOKING AMOUNT',
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: bookingColor,
                ),
              ),
              const SizedBox(width: 11),
              Text(
                '₹$amount',
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: bookingColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle(double size, {Color? color, FontWeight? weight}) {
    return GoogleFonts.lexend(
      fontSize: size,
      fontWeight: weight ?? FontWeight.w500,
      color: color ?? const Color(0xFF4F4F4F),
      height: 1.0, // Matches "line-height: 100%"
    );
  }
}
