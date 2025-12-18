import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// Gradient offer text with animation
class CardOfferText extends StatefulWidget {
  final String text;
  final List<Color> gradientColors;
  final List<String>? offers;

  const CardOfferText({
    super.key,
    this.text = 'Get Flat 25% Off On Food & Bever.',
    this.gradientColors = const [Color(0xff7464E4), Color(0xff3354F4)],
    this.offers,
  });

  @override
  State<CardOfferText> createState() => _CardOfferTextState();
}

class _CardOfferTextState extends State<CardOfferText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  int _currentIndex = 0;
  late List<String> _displayOffers;

  @override
  void initState() {
    super.initState();
    _displayOffers = widget.offers ??
        [
          'Get Flat 25% Off On Food & Bever.',
          'Get Flat 40% Off On Beverages.',
          'Early bird offer 30% discount.',
          'Weekend Special: 50% Off.',
        ];

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    if (_displayOffers.length > 1) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _controller.forward(from: 0.0).then((_) {
          if (mounted) {
            setState(() {
              _currentIndex = (_currentIndex + 1) % _displayOffers.length;
            });
            _startAnimation();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _displayOffers.length > 1 ? _fadeAnimation.value : 1.0,
          child: ShaderMask(
            shaderCallback: (bounds) =>
                LinearGradient(colors: widget.gradientColors)
                    .createShader(bounds),
            child: Text(
              _displayOffers[_currentIndex],
              style: GoogleFonts.lexend(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// General Pass section with "More" link
class CardGeneralPassSection extends StatelessWidget {
  final String passName;
  final int moreCount;
  final VoidCallback? onMoreTap;

  const CardGeneralPassSection({
    super.key,
    this.passName = 'General Pass (Imported Liquor)',
    this.moreCount = 3,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      children: [
        Text(
          passName,
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xff4F4F4F),
          ),
        ),
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            color: Color(0xff4F4F4F),
            shape: BoxShape.circle,
          ),
        ),
        GestureDetector(
          onTap: onMoreTap,
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xff7464E4), Color(0xff1A00D2)],
            ).createShader(bounds),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '+$moreCount More',
                  style: GoogleFonts.lexend(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 10,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Price row with MRP strikethrough
class CardPriceRow extends StatelessWidget {
  final String mrpPrice;
  final String discountedPrice;
  final String passType;

  const CardPriceRow({
    super.key,
    this.mrpPrice = 'MRP-₹10000',
    this.discountedPrice = '₹8000/Person',
    this.passType = 'General Pass',
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      children: [
        Text(
          mrpPrice,
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xff3CBD53),
            decoration: TextDecoration.lineThrough,
          ),
        ),
        Text(
          discountedPrice,
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xff4F4F4F),
          ),
        ),
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            color: Color(0xff4F4F4F),
            shape: BoxShape.circle,
          ),
        ),
        Text(
          passType,
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xff4F4F4F),
          ),
        ),
      ],
    );
  }
}

/// Discount offer section for venue listing
class CardDiscountOfferSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Map<String, dynamic>> discounts;

  const CardDiscountOfferSection({
    super.key,
    this.title = 'Discount Offer',
    this.subtitle = 'Offer ends in - 03:20',
    this.discounts = const [
      {'text': '25% OFF', 'opacity': 1.0},
      {'text': '40% off', 'opacity': 0.8},
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff070707),
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff4F4F4F),
                ),
              ),
            ],
          ),
        ),
        ...discounts.map(
          (discount) => Padding(
            padding: const EdgeInsets.only(left: 8),
            child: _buildDiscountChip(
              discount['text'] as String,
              const Color(
                0xff7464E4,
              ).withOpacity(discount['opacity'] as double),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDiscountChip(String text, Color color) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background SVG
        SvgPicture.asset(
          'assets/images/Rectangle 34624280.svg',
          width: 90,
          height: 32,
          fit: BoxFit.fill,
        ),
        // Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.local_offer, size: 14, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                text,
                style: GoogleFonts.lexend(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Book for X pricing section
class CardBookForPricing extends StatelessWidget {
  final int bookForCount;
  final String minSpend;
  final String perPerson;

  const CardBookForPricing({
    super.key,
    this.bookForCount = 8,
    this.minSpend = '₹28,000',
    this.perPerson = '₹3500/Person',
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'Book For $bookForCount',
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xff4F4F4F),
          ),
        ),
        _buildDot(),
        Text(
          'Minimum Spend $minSpend',
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xff4F4F4F),
          ),
        ),
        _buildDot(),
        Text(
          perPerson,
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xff4F4F4F),
          ),
        ),
      ],
    );
  }

  Widget _buildDot() {
    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: Color(0xff4F4F4F),
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Partywitty Pay offer text
class CardPartywittyPayOffer extends StatelessWidget {
  final int discountPercent;

  const CardPartywittyPayOffer({super.key, this.discountPercent = 25});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: [
        Text(
          'Get Flat',
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xff070707),
          ),
        ),
        Text(
          '$discountPercent%',
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xff7464E4),
          ),
        ),
        Text(
          'Off On FnB  Pay Through Partywitty Pay',
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xff070707),
          ),
        ),
      ],
    );
  }
}
