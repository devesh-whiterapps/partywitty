import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/models/event_model.dart';

/// Reusable location section with distance badge
class CardLocationSection extends StatelessWidget {
  final EventModel event;
  final bool showDistanceBadge;

  const CardLocationSection({
    super.key,
    required this.event,
    this.showDistanceBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/location.svg',
          width: 18,
          height: 18,
          colorFilter: const ColorFilter.mode(
            Color(0xff4F4F4F),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            event.location,
            style: GoogleFonts.lexend(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xff4F4F4F),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (showDistanceBadge) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xff7464E4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/distance.svg',
                  width: 10,
                  height: 10,
                  colorFilter: const ColorFilter.mode(
                    Color(0xff7464E4),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '${event.distance.toStringAsFixed(1)} Kms',
                  style: GoogleFonts.lexend(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff7464E4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
