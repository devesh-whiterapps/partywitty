import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventBookingToggle extends StatefulWidget {
  const EventBookingToggle({super.key});

  @override
  State<EventBookingToggle> createState() => _EventBookingToggleState();
}

class _EventBookingToggleState extends State<EventBookingToggle> {
  // State variable to track which view to show
  bool showTableOptions = false;
  int currentTableIndex = 0;
  int currentTicketIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with Toggle Link
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                showTableOptions ? 'Table Options' : 'Ticket Options',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4F4F4F),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showTableOptions = !showTableOptions;
                  });
                },
                child: Text(
                  showTableOptions ? 'View Tickets Options' : 'View Table Options',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    color: const Color(0xFF7464E4), // Purple color
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Animated Switcher for smooth transition between Ticket Pass and Table Cards
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: showTableOptions 
            ? _buildTableCarousel() 
            : _buildTicketPassCarousel(),
        ),
      ],
    );
  }

  // Ticket Pass Carousel
  Widget _buildTicketPassCarousel() {
    final tickets = [
      {
        'title': 'General Pass (Domestic Liquor & Food) || Single',
        'date': '26 DEC 25',
        'time': '10:00 PM ONWARDS',
        'bookingAmount': 3000,
        'mrp': 20000,
        'offerPrice': 18000,
      },
      {
        'title': 'General Pass (Domestic Liquor & Food) || Couple',
        'date': '26 DEC 25',
        'time': '10:00 PM ONWARDS',
        'bookingAmount': 5000,
        'mrp': 35000,
        'offerPrice': 32000,
      },
    ];

    return Column(
      key: const ValueKey('ticket'),
      children: [
        SizedBox(
          height: 400,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.85),
            onPageChanged: (index) {
              setState(() {
                currentTicketIndex = index;
              });
            },
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TicketPassCard(
                  title: ticket['title'] as String,
                  date: ticket['date'] as String,
                  time: ticket['time'] as String,
                  bookingAmount: ticket['bookingAmount'] as int,
                  mrp: ticket['mrp'] as int,
                  offerPrice: ticket['offerPrice'] as int,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        // Pagination indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            tickets.length,
            (index) => Container(
              width: index == currentTicketIndex ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: index == currentTicketIndex
                    ? const Color(0xFF7464E4)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Table Options Carousel
  Widget _buildTableCarousel() {
    final tables = [
      {
        'title': 'Table For 4',
        'zone': 'Standard Zone',
        'price': '15,000',
        'perPerson': '2400',
        'amount': '3000',
        'features': [
          'Comfortable sofa seating',
          'Basic snacks included',
          'Standard entry',
        ],
        'hasBestValue': true,
      },
      {
        'title': 'Table For 8',
        'zone': 'VIP Zone',
        'price': '28,000',
        'perPerson': '3500',
        'amount': '4453',
        'features': [
          'Premium bottle service',
          'Priority entry access',
          'Dedicated server',
        ],
        'hasBestValue': true,
      },
      {
        'title': 'Table For 10',
        'zone': 'Elite Zone',
        'price': '40,000',
        'perPerson': '4000',
        'amount': '3000',
        'features': [
          'Front stage positioning',
          'Dedicated steward service',
          'Premium cocktails included',
        ],
        'hasBestValue': false,
      },
    ];

    return Column(
      key: const ValueKey('table'),
      children: [
        SizedBox(
          height: 520,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.85),
            onPageChanged: (index) {
              setState(() {
                currentTableIndex = index;
              });
            },
            itemCount: tables.length,
            itemBuilder: (context, index) {
              final table = tables[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TableBookingCard(
                  title: table['title'] as String,
                  zone: table['zone'] as String,
                  price: table['price'] as String,
                  perPerson: table['perPerson'] as String,
                  amount: table['amount'] as String,
                  features: table['features'] as List<String>,
                  hasBestValue: table['hasBestValue'] as bool,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        // Pagination indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            tables.length,
            (index) => Container(
              width: index == currentTableIndex ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: index == currentTableIndex
                    ? const Color(0xFF7464E4)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Ticket Pass Card Widget
class TicketPassCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final int bookingAmount;
  final int mrp;
  final int offerPrice;

  const TicketPassCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.bookingAmount,
    required this.mrp,
    required this.offerPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=2070',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF2C3E50),
                  child: const Center(
                    child: Icon(Icons.event, size: 100, color: Colors.white54),
                  ),
                );
              },
            ),
          ),

          // Ticket overlay with perforated edge
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: CustomPaint(
                  painter: PerforatedEdgePainter(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          title,
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4F4F4F),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Pricing Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Booking Amount',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF4F4F4F),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹$bookingAmount/Person',
                              style: GoogleFonts.lexend(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3CBD53), // Green
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'MRP-₹$mrp',
                                  style: GoogleFonts.lexend(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '₹$offerPrice/Person',
                                  style: GoogleFonts.lexend(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF4F4F4F),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Inclusions',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF4F4F4F),
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Barcode
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: CustomPaint(
                            painter: BarcodePainter(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Date and Time on right edge (vertically)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 20,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: RotatedBox(
                quarterTurns: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      date,
                      style: GoogleFonts.lexend(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: GoogleFonts.lexend(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
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
    );
  }
}

// Perforated Edge Painter
class PerforatedEdgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    final spacing = 8.0;
    final radius = 3.0;

    for (double y = spacing; y < size.height - spacing; y += spacing * 2) {
      path.addOval(Rect.fromCircle(
        center: Offset(size.width, y),
        radius: radius,
      ));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Barcode Painter
class BarcodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final barWidth = 2.0;
    final spacing = 2.0;
    double x = spacing;

    while (x < size.width - spacing) {
      final barHeight = size.height * 0.8;
      final top = (size.height - barHeight) / 2;
      canvas.drawRect(
        Rect.fromLTWH(x, top, barWidth, barHeight),
        paint,
      );
      x += barWidth + spacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Table Booking Card Widget
class TableBookingCard extends StatelessWidget {
  final String title;
  final String zone;
  final String price;
  final String perPerson;
  final String amount;
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
    this.hasBestValue = false,
  });

  @override
  Widget build(BuildContext context) {
    final tableNumber = title.split(' ').last;

    return Container(
      width: 282,
      height: 351,
      decoration: BoxDecoration(
        color: const Color(0x80FFFFFF), // #FFFFFF4D
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Section - Image Background with Overlay (height: 88)
              SizedBox(
                height: 88,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Background Image
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/table_bg.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF2C3E50),
                            child: const Center(
                              child: Icon(Icons.restaurant, size: 30, color: Colors.white54),
                            ),
                          );
                        },
                      ),
                    ),
                    // Dark Overlay
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color(0x96000000), // #00000096
                      ),
                      child: Row(
                        children: [
                          // Icon (48x48)
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/icons/user.svg',
                              width: 28,
                              height: 28,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person_add_alt_1_outlined,
                                  color: Colors.white,
                                  size: 28,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Title and Zone
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  title,
                                  style: GoogleFonts.lexend(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    height: 1.0,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  zone,
                                  style: GoogleFonts.lexend(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Best Value Tag
                          if (hasBestValue)
                            Container(
                              padding: const EdgeInsets.only(
                                top: 5,
                                right: 10,
                                bottom: 5,
                                left: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0x1A3CBD53), // #3CBD531A
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                                child: Text(
                                  'Best Value',
                                  style: GoogleFonts.lexend(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF3CBD53),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Middle Section - Pricing and Features (height: 183)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 0,
                    right: 15,
                    bottom: 0,
                    left: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 19),
                      // Pricing Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Minimum Spend Column
                          SizedBox(
                            width: 96,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Minimum Spend',
                                  style: GoogleFonts.lexend(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF4F4F4F),
                                    height: 1.0,
                                  ),
                                ),
                                const SizedBox(height: 0),
                                Text(
                                  '₹$price',
                                  style: GoogleFonts.lexend(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF4F4F4F),
                                    height: 1.0,
                                  ),
                                ),
                                const SizedBox(height: 0),
                                Text(
                                  '₹$perPerson/Person',
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF4F4F4F),
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Book For Button
                          Container(
                            width: 85,
                            height: 31,
                            padding: const EdgeInsets.only(
                              top: 8,
                              right: 10,
                              bottom: 8,
                              left: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0x80FFFFFF), // #FFFFFF4D
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                              child: Center(
                                child: Text(
                                  'Book for $tableNumber',
                                  style: GoogleFonts.lexend(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF4F4F4F),
                                    height: 1.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 19),
                      // Standard Seating Title
                      Text(
                        zone.contains('Standard')
                            ? 'Standard Seating'
                            : zone.contains('VIP')
                                ? 'VIP Seating'
                                : 'Elite Seating',
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4F4F4F),
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Features List
                      ...features.map((feature) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              feature,
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF4F4F4F),
                                height: 1.0,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),

              // Bottom Section - Booking Amount (height: 40)
              Container(
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 13,
                  bottom: 10,
                  left: 13,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x1A3CBD53), // #3CBD531A
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'BOOKING AMOUNT',
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF3CBD53),
                          height: 1.0,
                        ),
                      ),
                      Text(
                        '₹$amount',
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF3CBD53),
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

