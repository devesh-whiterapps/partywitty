import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventOptionsSwitcher extends StatefulWidget {
  const EventOptionsSwitcher({super.key});

  @override
  State<EventOptionsSwitcher> createState() => _EventOptionsSwitcherState();
}

class _EventOptionsSwitcherState extends State<EventOptionsSwitcher> {
  bool _showTableOptions = false;

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

        // --- PAGINATION DOTS ---
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) => _buildDot(index == 0)),
          ),
        ),
      ],
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      width: isActive ? 20 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF7464E4) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildTicketPassList() {
    return SizedBox(
      key: const ValueKey('tickets'),
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          TableBookingCard(
            title: 'Table For 4',
            zone: 'Standard Zone',
            price: '15,000',
            perPerson: '2400',
            amount: '3000',
            features: ['Comfortable sofa seating', 'Basic snacks included', 'Standard entry'],
            hasBestValue: true,
          ),
          SizedBox(width: 16),
          TableBookingCard(
            title: 'Table For 8',
            zone: 'VIP Zone',
            price: '28,000',
            perPerson: '3500',
            amount: '4453',
            features: ['Premium bottle service', 'Priority entry access', 'Dedicated server'],
            hasBestValue: true,
          ),
        ],
      ),
    );
  }
}

class TableBookingCard extends StatelessWidget {
  final String title, zone, price, perPerson, amount;
  final List<String> features;
  final bool hasBestValue;

  const TableBookingCard({
    super.key,
    required this.title,
    required this.zone,
    required this.price,
    required this.perPerson,
    required this.amount,
    required this.features,
    required this.hasBestValue,
  });

  @override
  Widget build(BuildContext context) {
    final tableNumber = title.split(' ').last;
    final seatingTitle = zone.contains('Standard')
        ? 'Standard Seating'
        : zone.contains('VIP')
            ? 'VIP Seating'
            : 'Elite Seating';

    return Container(
      width: 282,
      height: 351,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Column(
        children: [
          _header(), // Background image + Title + Zone
          Expanded(
            child: Container(
              color: const Color(0xFFF5F5F5), // Light grey background
              padding: const EdgeInsets.fromLTRB(15, 19, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _pricingRow(tableNumber),
                  const SizedBox(height: 19),
                  Text(
                    seatingTitle,
                    style: _textStyle(16, weight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  ...features.map((f) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            const Icon(Icons.circle, size: 4, color: Color(0xFF4F4F4F)),
                            const SizedBox(width: 8),
                            Text(f, style: _textStyle(12)),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          _footer(), // Green Booking Amount Bar
        ],
      ),
    );
  }

  Widget _header() {
    return Stack(
      children: [
        // Blurred background image
        ClipRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              height: 123, // Approximately 35% of 351px
              width: 282,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/table_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // Dark overlay for better text readability
        Container(
          height: 123,
          width: 282,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4), // Semi-transparent overlay
          ),
        ),
        // Content
        Container(
          height: 123,
          width: 282,
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              // Centered Title and Zone
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lexend(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      zone,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Icon in top-left
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Icons.person_add_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              // Best Value Tag in top-right
              if (hasBestValue)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3CBD53),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Best Value',
                      style: GoogleFonts.lexend(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pricingRow(String tableNumber) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Minimum Spend', style: _textStyle(12)),
            Text('₹$price', style: _textStyle(24, weight: FontWeight.w600)),
            Text('₹$perPerson/Person', style: _textStyle(14, weight: FontWeight.w400)),
          ],
        ),
        // Glassmorphism Button
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
        )
      ],
    );
  }

  Widget _footer() {
    return Container(
      height: 53, // Approximately 15% of 351px
      padding: const EdgeInsets.symmetric(horizontal: 13),
      decoration: const BoxDecoration(
        color: Color(0xFF3CBD53), // Solid green background
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'BOOKING AMOUNT',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            '₹$amount',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
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
