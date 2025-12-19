import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TableBookingCard extends StatelessWidget {
  const TableBookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrapped with a Material widget to provide text direction and theming
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 380,
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0), // Light grey background
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- TOP IMAGE SECTION ---
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=2070&auto=format&fit=crop', // Replace with your asset
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.4),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                  // "Best Value" Badge
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF5D7A5D), // Dark olive green
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                      ),
                      child: Text(
                        'Best Value',
                        style: GoogleFonts.lexend(color: const Color(0xFF90EE90), fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  // User Icon and Title
                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white70,
                          child: Icon(Icons.person_add_alt_1_outlined, size: 40, color: Color(0xFF4F4F4F)),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Table For 4',
                              style: GoogleFonts.lexend(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Standard Zone',
                              style: GoogleFonts.lexend(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // --- PRICING SECTION ---
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Minimum Spend', style: GoogleFonts.lexend(fontSize: 18, color: const Color(0xFF616161), fontWeight: FontWeight.w600)),
                        Text('₹15,000', style: GoogleFonts.lexend(fontSize: 36, fontWeight: FontWeight.bold, color: const Color(0xFF424242))),
                        Text(
                          '₹2400/Person',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            color: const Color(0xFF616161),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        _bookButton('Book For 4', Colors.white, Colors.black87),
                        const SizedBox(height: 8),
                        _bookButton('Book For 4', Colors.black, Colors.white),
                      ],
                    )
                  ],
                ),
              ),

              // --- FEATURES SECTION ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Standard Seating', style: GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFF616161))),
                    const SizedBox(height: 10),
                    _bulletPoint('Comfortable sofa seating'),
                    _bulletPoint('Basic snacks included'),
                    _bulletPoint('Standard entry'),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // --- FOOTER SECTION ---
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: const BoxDecoration(
                  color: Color(0xFFC8D9C8), // Light green footer
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BOOKING AMOUNT',
                      style: GoogleFonts.lexend(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF388E3C)),
                    ),
                    Text(
                      '₹3000',
                      style: GoogleFonts.lexend(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF388E3C)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bookButton(String text, Color bgColor, Color textColor) {
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(4)),
      child: Text(text, style: GoogleFonts.lexend(color: textColor, fontWeight: FontWeight.w600, fontSize: 14)),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Icon(Icons.circle, size: 8, color: Color(0xFF616161)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.lexend(fontSize: 18, color: const Color(0xFF616161), fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}