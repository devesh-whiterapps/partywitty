import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Reusable Event Ticket Card Widget with responsive dimensions
class EventTicketCard extends StatelessWidget {
  final String passTitle;
  final String bookingAmount;
  final String pricePerPerson;
  final String mrpPrice;
  final String totalPrice;
  final String dateTime;
  final String imagePath;
  final VoidCallback? onTap;
  final VoidCallback? onInclusionsTap;

  const EventTicketCard({
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
    // Get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth - 60;

    // Calculate responsive dimensions based on card width
    // Base width is 315 (screen width 375 - 60)
    final scale = cardWidth / 315;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 189 * scale,
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14 * scale),
        ),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14 * scale),
                child: Image.asset(imagePath, fit: BoxFit.fill),
              ),
            ),
            // Content overlay
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 35 * scale,
                  right: 12 * scale,
                  top: 32 * scale,
                  bottom: 18 * scale,
                ),
                child: Stack(
                  children: [
                    // Left side content (white rectangle area)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: 210 * scale,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Pass title
                          Padding(
                            padding: EdgeInsets.only(right: 10 * scale),
                            child: Text(
                              passTitle,
                              style: GoogleFonts.lexend(
                                fontSize: 12 * scale,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 10 * scale),
                          // Booking Amount label
                          Text(
                            'Booking Amount',
                            style: GoogleFonts.lexend(
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff070707),
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          // Price
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: bookingAmount,
                                  style: GoogleFonts.lexend(
                                    fontSize: 18 * scale,
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
                                    fontSize: 11 * scale,
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
                      top: 40 * scale,
                      left: 110 * scale,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // MRP
                          Text(
                            mrpPrice,
                            style: GoogleFonts.lexend(
                              fontSize: 10 * scale,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 205, 72, 72),
                            ),
                          ),
                          SizedBox(height: 2 * scale),
                          // Total price
                          Text(
                            totalPrice,
                            style: GoogleFonts.lexend(
                              fontSize: 10 * scale,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff070707),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Inclusions at bottom left of right side
                    Positioned(
                      bottom: 45 * scale,
                      left: 110 * scale,
                      child: GestureDetector(
                        onTap: onInclusionsTap,
                        child: Text(
                          'Inclusions',
                          style: GoogleFonts.lexend(
                            fontSize: 10 * scale,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff070707),
                          ),
                        ),
                      ),
                    ),
                    // Vertical date/time text on the far right edge
                    Positioned(
                      left: 195 * scale,
                      top: 8 * scale,
                      bottom: 10 * scale,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Center(
                          child: Text(
                            dateTime,
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.lexend(
                              fontSize: 8 * scale,
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
