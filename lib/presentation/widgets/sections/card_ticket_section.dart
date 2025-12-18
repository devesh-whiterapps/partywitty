import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom painter for dashed line in ticket cards
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7464E4)
      ..strokeWidth = 1;

    const dashHeight = 5.0;
    const dashSpace = 3.0;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Reusable ticket card for F&B Pass section
class CardTicketSection extends StatelessWidget {
  final String passTitle;
  final String bookingAmount;
  final String pricePerPerson;
  final String mrpPrice;
  final String totalPrice;
  final String dateTime;
  final String imagePath;
  final VoidCallback? onTap;

  const CardTicketSection({
    super.key,
    this.passTitle = 'General Pass (Domestic Liquor & Food) || Single',
    this.bookingAmount = '₹3000',
    this.pricePerPerson = '/Person',
    this.mrpPrice = 'MRP-₹20000',
    this.totalPrice = '₹18000/Person',
    this.dateTime = '26 DEC 25 - 10:00 PM ONWARDS',
    this.imagePath = 'assets/images/unlimited.png',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF7464E4), width: 2),
        ),
        child: Row(
          children: [
            // Left side - Pass details
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pass title
                    Text(
                      passTitle,
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff070707),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    // Booking Amount label
                    Text(
                      'Booking Amount',
                      style: GoogleFonts.lexend(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff4F4F4F),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Price row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          bookingAmount,
                          style: GoogleFonts.lexend(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff3CBD53), // Green price
                          ),
                        ),
                        Text(
                          pricePerPerson,
                          style: GoogleFonts.lexend(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff4F4F4F),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Barcode
                    SizedBox(
                      height: 30,
                      child: Row(
                        children: List.generate(
                          30,
                          (i) => Container(
                            width: 2,
                            height: i % 3 == 0 ? 30 : (i % 2 == 0 ? 20 : 25),
                            margin: const EdgeInsets.only(right: 2),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Dashed divider with notches
            SizedBox(
              width: 20,
              child: Column(
                children: [
                  // Top notch
                  Container(
                    width: 20,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomPaint(
                      painter: DashedLinePainter(),
                      size: const Size(1, double.infinity),
                    ),
                  ),
                  // Bottom notch
                  Container(
                    width: 20,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Right side - Image and info
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: Stack(
                  children: [
                    // Background image
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF1A1A2E),
                            child: const Center(
                              child: Icon(Icons.image, color: Colors.white54),
                            ),
                          );
                        },
                      ),
                    ),
                    // Overlay with text
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dateTime,
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
                    // MRP and Inclusions
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            mrpPrice,
                            style: GoogleFonts.lexend(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff3CBD53),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            totalPrice,
                            style: GoogleFonts.lexend(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Inclusions',
                            style: GoogleFonts.lexend(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFDBF658),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal scrollable list of ticket cards
class CardTicketListSection extends StatelessWidget {
  final int ticketCount;
  final double height;

  const CardTicketListSection({
    super.key,
    this.ticketCount = 2,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ticketCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: index < ticketCount - 1 ? 12 : 0),
            child: const CardTicketSection(),
          );
        },
      ),
    );
  }
}
