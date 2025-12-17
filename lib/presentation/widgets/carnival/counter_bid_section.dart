import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CounterBidSection extends StatelessWidget {
  final int pricePerPax;
  final int savings;

  const CounterBidSection({
    super.key,
    required this.pricePerPax,
    required this.savings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Counter Bid Banner
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                'Make your counter bid and grab the best deal for your party!',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                // Price and Actions Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7464E4), Color(0xFF1A00D1)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '₹$pricePerPax/Pax',
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Kids Price',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF7464E4),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Counter Bid',
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Savings Banner
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Great Choice! ₹$savings would be Saved Instantly on This Booking!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexend(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}