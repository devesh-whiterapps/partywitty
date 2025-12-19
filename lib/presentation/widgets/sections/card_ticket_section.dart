import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';

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

/// Reusable ticket card for F&B Pass section with Event Pass background
class CardTicketSection extends StatelessWidget {
  final String passTitle;
  final String bookingAmount;
  final String pricePerPerson;
  final String mrpPrice;
  final String totalPrice;
  final String dateTime;
  final String imagePath;
  final VoidCallback? onTap;
  final VoidCallback? onInclusionsTap;

  const CardTicketSection({
    super.key,
    this.passTitle = 'General Pass (Domestic Liquor & Food) || Single',
    this.bookingAmount = '₹3000',
    this.pricePerPerson = '/Person',
    this.mrpPrice = 'MRP-₹20000',
    this.totalPrice = '₹18000/Person',
    this.dateTime = '26 DEC 25 - 10:00 PM',
    this.imagePath = 'assets/images/Event Pass.png',
    this.onTap,
    this.onInclusionsTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 189,
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(imagePath),
              ),
            ),
            // Content overlay
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 35,
                  right: 12,
                  top: 32,
                  bottom: 18,
                ),
                child: Stack(
                  children: [
                    // Left side content (white rectangle area)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: 210,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Pass title
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              passTitle,
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Booking Amount label
                          Text(
                            'Booking Amount',
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff070707),
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Price
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: bookingAmount,
                                  style: GoogleFonts.lexend(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: const Color.fromARGB(
                                      255,
                                      41,
                                      134,
                                      58,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: pricePerPerson,
                                  style: GoogleFonts.lexend(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromARGB(
                                      255,
                                      41,
                                      134,
                                      58,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    // MRP and Total Price - positioned to the right of ₹3000
                    Positioned(
                      top: 40,
                      left: 110,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // MRP
                          Text(
                            mrpPrice,
                            style: GoogleFonts.lexend(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 205, 72, 72),
                            ),
                          ),
                          const SizedBox(height: 2),
                          // Total price
                          Text(
                            totalPrice,
                            style: GoogleFonts.lexend(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff070707),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Inclusions at bottom left of right side
                    Positioned(
                      bottom: 45,
                      left: 110,
                      child: Text(
                        'Inclusions',
                        style: GoogleFonts.lexend(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff070707),
                        ),
                      ),
                    ),
                    // Vertical date/time text on the far right edge
                    Positioned(
                      left: 195,
                      top: 8,
                      bottom: 10,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Center(
                          child: Text(
                            dateTime,
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.lexend(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff070707),
                            ),
                          ),
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
