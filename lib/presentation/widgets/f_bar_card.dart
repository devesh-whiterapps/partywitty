import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FBarCard extends StatelessWidget {
  const FBarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF9F9F4,
      ), // Light cream background from image
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _HeaderSection(),
                const SizedBox(height: 12),
                const _BookingDetailsSection(),
                const SizedBox(height: 12),
                const _SavingsBanner(),
                const SizedBox(height: 16),
                const _FeaturesGrid(),
                const SizedBox(height: 20),
                const _FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Header & Pricing Section ---
class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Row 1: Title and Rating (REVISED) ---
        SizedBox(
          width: 400, // Overall width of the card content area
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Pushes rating to the right
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side: F-bar title
              SizedBox(
                width: 229, // As per spec
                height: 24, // As per spec
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Placeholder for line icon
                    const Icon(
                      Icons.horizontal_rule,
                      size: 24,
                      color: Color(0xFF4F4F4F),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'F-bar',
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w500, // Medium weight
                        fontSize: 18,
                        color: const Color(0xFF4F4F4F),
                        height: 1.0, // 100% line-height
                      ),
                    ),
                  ],
                ),
              ),
              // Right side: Rating and Review
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Star Icon
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  // 4.1 Rating Text
                  Text(
                    '4.1',
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: const Color(0xFF4F4F4F),
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Review Link with new styling
                  Container(
                    width: 81,
                    height: 18,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                    ), // Added padding for aesthetics
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        100,
                      ), // Fully rounded corners
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        'Review (03)',
                        style: GoogleFonts.lexend(
                          fontSize: 12, // Adjusted for better fit
                          decoration: TextDecoration.underline,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          width: 277, // New width constraint
          height: 21, // Explicit height for the row
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Location Icon from asset
              Image.asset('asset/icons/r.png', width: 20, height: 20),
              const SizedBox(width: 4),
              // DLP Phase 3 Text with specific styling
              Expanded(
                // Use Expanded to fill available space
                child: Text(
                  'DLP Phase 3, Gurugram',
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w400, // font-style: Regular
                    fontSize: 14,
                    color: const Color(0xFF4F4F4F),
                    height: 1.48, // 20.84px line-height for 14px font
                  ),
                  overflow: TextOverflow
                      .ellipsis, // Prevents overflow if text is too long
                ),
              ),
              const SizedBox(width: 8), // Gap between text and icon
              // Distance with location icon
              Row(
                children: [
                  Image.asset(
                    'assets/icons/Vector (1).png',
                    width: 45,
                    height: 21,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '1.2 Kms',
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF7464E4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.restaurant_menu, size: 18),
            const SizedBox(width: 8),
            Text(
              'IMFL Drinks +FOOD',
              style: GoogleFonts.lexend(fontWeight: FontWeight.w400),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
              colors: [Color(0xFF00E5FF), Color(0xFF96FFAD)],
            ),
          ),
          child: Text(
            'Make your counter bid and grab the best deal for your party!',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _actionButton('₹1500/Pax', isPrimary: true),
                const SizedBox(width: 8),
                _actionButton('Kids Price', isPrimary: false),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xFF00E5FF),
              ),
              child: Text(
                'Counter Bid',
                style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _actionButton(String label, {required bool isPrimary}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: isPrimary
            ? const LinearGradient(
                colors: [Color(0xFF7464E4), Color(0xFF1A00D2)],
              )
            : null,
        color: isPrimary ? null : Colors.white,
        border: isPrimary ? null : Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: GoogleFonts.lexend(
          color: isPrimary ? Colors.white : const Color(0xFF7464E4),
          fontSize: isPrimary ? 13 : 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// --- Date/Time Info Row ---
class _BookingDetailsSection extends StatelessWidget {
  const _BookingDetailsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF7464E4), Color(0xFF1A00D2)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _iconText(Icons.calendar_today, '11-4-25'),
          _iconText(Icons.access_time, '10 PM'),
          _iconText(Icons.wine_bar, '10 PM'),
          _iconText(Icons.people_outline, '10'),
        ],
      ),
    );
  }

  Widget _iconText(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

class _SavingsBanner extends StatelessWidget {
  const _SavingsBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: const LinearGradient(
          colors: [Color(0xFF00E5FF), Color(0xFF96FFAD)],
        ),
      ),
      child: Text(
        'Great Choice! ₹290 would be Saved Instantly on This Booking!',
        textAlign: TextAlign.center,
        style: GoogleFonts.lexend(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// --- Features Grid (Tags) ---
class _FeaturesGrid extends StatelessWidget {
  const _FeaturesGrid();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const [
        _FeatureTag(Icons.local_bar, 'Alcoholic'),
        _FeatureTag(Icons.eco_outlined, 'Pure Veg', isVeg: true),
        _FeatureTag(Icons.restaurant, '3 Starters + 2 Main Course'),
        _FeatureTag(Icons.local_drink, '2 Mocktails + 2 Soft drinks'),
        _FeatureTag(Icons.access_time, '3 Hours'),
        _FeatureTag(Icons.music_note, 'Live Music'),
        _FeatureTag(Icons.flatware, 'Food - 3h'),
        _FeatureTag(Icons.wine_bar, 'Drinks - 1.5h'),
      ],
    );
  }
}

class _FeatureTag extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isVeg;

  const _FeatureTag(this.icon, this.label, {this.isVeg = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: isVeg ? Colors.green : Colors.black87),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.lexend(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// --- Final Bottom Section ---
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Instant Confirmation',
              style: TextStyle(fontSize: 11, color: Colors.black54),
            ),
            const Text(
              'No Hidden Fees',
              style: TextStyle(fontSize: 11, color: Colors.black54),
            ),
            const Text(
              'Secure Payment',
              style: TextStyle(fontSize: 11, color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF3B28CC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MRP ₹2000',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        'Offer Price ₹1500',
                        style: GoogleFonts.lexend(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Kid's Price",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '06 : 40 : 59',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
