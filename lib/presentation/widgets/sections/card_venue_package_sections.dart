import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

/// Live Events section with date chip
class CardLiveEventsSection extends StatelessWidget {
  final String date;
  final int moreCount;
  final VoidCallback? onMoreTap;

  const CardLiveEventsSection({
    super.key,
    this.date = "17 Sep '25 7 PM Onwards",
    this.moreCount = 3,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Live Events',
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xff070707),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Background SVG
                SvgPicture.asset(
                  'assets/images/Rectangle-live.svg',
                  width: 200,
                  height: 36,
                  fit: BoxFit.fill,
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                  ),
                  child: Text(
                    date,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Builder(
              builder: (context) => GestureDetector(
                onTap: () {
                  onMoreTap?.call();
                  // Show bottom sheet
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) => _buildLiveEventsBottomSheet(context),
                  );
                },
                child: Text(
                  '+ $moreCount More',
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff7464E4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Features section with bullet list
class CardFeaturesSection extends StatelessWidget {
  final List<String> features;
  final int moreCount;
  final VoidCallback? onMoreTap;

  const CardFeaturesSection({
    super.key,
    this.features = const [
      'Stage Setup',
      'Led Screens',
      'Lawn + Indoor Halls',
      'Custom Decor',
    ],
    this.moreCount = 8,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Features',
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xff070707),
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            ...features.map(
              (feature) => Text(
                '• $feature',
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff4F4F4F),
                ),
              ),
            ),
            if (moreCount > 0)
              Builder(
                builder: (context) => GestureDetector(
                  onTap: () {
                    onMoreTap?.call();
                    // Show bottom sheet
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => _buildFeaturesBottomSheet(context),
                    );
                  },
                  child: Text(
                    '$moreCount+ More',
                    style: GoogleFonts.lexend(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff7464E4),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Offer price section for package bidding
class CardOfferPriceSection extends StatelessWidget {
  final String mrpPrice;
  final String offerPrice;
  final String kidsPriceLabel;
  final String countdownTime;

  const CardOfferPriceSection({
    super.key,
    this.mrpPrice = 'MRP-₹2000',
    this.offerPrice = '₹1500',
    this.kidsPriceLabel = "Kid's Price",
    this.countdownTime = '06 Hr 50 Min',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mrpPrice,
                style: GoogleFonts.lexend(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff7464E4),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Offer Price ',
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff070707),
                    ),
                  ),
                  Text(
                    offerPrice,
                    style: GoogleFonts.lexend(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff7464E4),
                    ),
                  ),
                ],
              ),
              Text(
                kidsPriceLabel,
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff7464E4),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Offer Ends In',
              style: GoogleFonts.lexend(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: const Color(0xff4F4F4F),
              ),
            ),
            Text(
              countdownTime,
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xff7464E4),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// User attended row for package bidding
class CardUserAttendedRow extends StatelessWidget {
  final String userName;
  final String activityText;

  const CardUserAttendedRow({
    super.key,
    this.userName = 'Rohit Sharma',
    this.activityText = 'Attended a party here l..',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/Ellipse 4.png',
            width: 24,
            height: 24,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 24,
              height: 24,
              color: Colors.grey[300],
              child: const Icon(Icons.person, size: 14),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            '$userName $activityText',
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xff4F4F4F),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Drinks and food row
class CardDrinksAndFood extends StatelessWidget {
  final String text;

  const CardDrinksAndFood({super.key, this.text = 'IMFL Drinks +FOOD'});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.local_bar, size: 18, color: Color(0xff4F4F4F)),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.lexend(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xff4F4F4F),
            ),
          ),
        ),
      ],
    );
  }
}

/// Service time row with icons
class CardServiceTime extends StatelessWidget {
  final String label;
  final String closeTime;
  final String barTime;

  const CardServiceTime({
    super.key,
    this.label = 'Service Time',
    this.closeTime = '3h',
    this.barTime = '1.5h',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xff4F4F4F),
          ),
        ),
        const SizedBox(width: 12),
        _buildTimeChip(Icons.close, closeTime),
        const SizedBox(width: 8),
        _buildTimeChip(Icons.local_bar, barTime),
      ],
    );
  }

  Widget _buildTimeChip(IconData icon, String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffE5E5E5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xff4F4F4F)),
          const SizedBox(width: 4),
          Text(
            time,
            style: GoogleFonts.lexend(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xff4F4F4F),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureSection extends StatefulWidget {
  final String title;
  final List<String> items;
  final bool isWhiteBackground;

  const _FeatureSection({
    required this.title,
    required this.items,
    required this.isWhiteBackground,
  });

  @override
  State<_FeatureSection> createState() => _FeatureSectionState();
}

class _FeatureSectionState extends State<_FeatureSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isWhiteBackground
            ? Colors.white
            : const Color(0xFFF9F9F9CC),
        border: const Border(
          bottom: BorderSide(color: Color(0xFFEBEBEB), width: 1),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4F4F4F),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xFF4F4F4F),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.only(top: 8, right: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF4F4F4F),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item,
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF4F4F4F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class CardDateTimePaxRow extends StatelessWidget {
  final String date;
  final String time;
  final String pax;

  const CardDateTimePaxRow({
    super.key,
    this.date = 'Apr 14, 2025 Mon',
    this.time = '10:00 PM Onwards',
    this.pax = '50',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildColumn(Icons.calendar_today, 'Date', date)),
        Expanded(child: _buildColumn(Icons.access_time, 'Time', time)),
        _buildColumn(Icons.people, 'Pax', pax),
      ],
    );
  }

  Widget _buildColumn(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xff4F4F4F)),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: const Color(0xff4F4F4F),
              ),
            ),
          ],
        ),
        Text(
          value,
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xff070707),
          ),
        ),
      ],
    );
  }
}

/// Helper function to build Features bottom sheet
Widget _buildFeaturesBottomSheet(BuildContext context) {
  final features = [
    'Stage Setup',
    'Lighting Design',
    'Sound Engineering',
    'Rehearsal Schedule',
    'Rehearsal Schedule',
    'Lighting Design',
    'Rehearsal Schedule',
    'Rehearsal Schedule',
  ];

  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 50,
                    height: 6,
                    decoration: BoxDecoration(
                      color: const Color(0xff4F4F4F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Title
                Text(
                  'Features',
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff000000),
                  ),
                ),
                const SizedBox(height: 16),
                // Features as white cards
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: features.map((feature) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        feature,
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff4F4F4F),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

/// Helper function to build Live Events bottom sheet
Widget _buildLiveEventsBottomSheet(BuildContext context) {
  final events = [
    "17 Sep '25\n7 PM Onwards",
    "17 Sep '25\n7 PM Onwards",
    "17 Sep '25\n7 PM Onwards",
    "17 Sep '25\n7 PM Onwards",
  ];

  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 50,
                    height: 6,
                    decoration: BoxDecoration(
                      color: const Color(0xff4F4F4F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Title
                Text(
                  'Live Events',
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff000000),
                  ),
                ),
                const SizedBox(height: 16),
                // Events list
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: events.map((event) {
                    return Stack(
                      children: [
                        SvgPicture.asset(
                          'assets/images/Rectangle.svg',
                          width: 160,
                          height: 80,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          width: 160,
                          height: 80,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Center(
                            child: Text(
                              event,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
