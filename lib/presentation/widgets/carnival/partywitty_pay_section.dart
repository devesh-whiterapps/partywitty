import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'offer_card_widget.dart';

class PartywittyPaySection extends StatelessWidget {
  const PartywittyPaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'Partywitty Pay',
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Get Instant Discount On F&B',
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 15),

        // Offer Cards Horizontal Scroll
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              OfferCardWidget(
                title: 'Use tulips to make payment',
                subtitle: 'Earn 25 tulips',
                buttonText: 'Watch & Earn',
                icon: Icons.play_circle_outline,
              ),
              SizedBox(width: 10),
              OfferCardWidget(
                title: 'Upto 50% Off',
                subtitle: 'On Food & Beverages Bill',
                buttonText: 'Pre-Booking',
                icon: Icons.event_available,
              ),
              SizedBox(width: 10),
              OfferCardWidget(
                title: 'Flat 25% OFF',
                subtitle: 'For Total bill',
                buttonText: 'Pay Bill',
                icon: Icons.payment,
              ),
              SizedBox(width: 10),
              OfferCardWidget(
                title: 'Earn Up To ₹200',
                subtitle: 'Pay Using Partywitty Pay',
                buttonText: 'Earn Now',
                icon: Icons.account_balance_wallet,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Indicator Dots
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
                  (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == 0
                      ? const Color(0xFF7464E4)
                      : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}