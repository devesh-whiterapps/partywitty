import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/models/event_model.dart';

/// Reusable venue and rating section
class CardVenueRatingSection extends StatelessWidget {
  final EventModel event;
  final bool showReviewLink;
  final VoidCallback? onReviewTap;

  const CardVenueRatingSection({
    super.key,
    required this.event,
    this.showReviewLink = true,
    this.onReviewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/f_bar.png',
          width: 22,
          height: 22,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.location_city,
            size: 22,
            color: Color(0xff7464E4),
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            event.venue,
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xff111827),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 6),
        Icon(Icons.star, color: Colors.amber[700], size: 18),
        const SizedBox(width: 2),
        Text(
          '${event.rating}',
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xff070707),
          ),
        ),
        if (showReviewLink) ...[
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onReviewTap,
            child: Flexible(
              child: Text(
                'Review (${event.reviewCount.toString().padLeft(2, '0')})',
                style: GoogleFonts.lexend(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  color: const Color(0xff070707),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
