import 'package:flutter/material.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../../domain/models/user_activity_model.dart';
import 'user_activity_section.dart';
import 'featured_event_image_section.dart';
import 'event_details_section.dart';
import 'sections/card_buttons_section.dart';
import 'sections/card_pricing_sections.dart';

class UnifiedEventCard extends StatelessWidget {
  final List<UserActivityModel>? users;
  final EventModel featuredEvent;
  final EventModel eventDetails;
  final ArtistModel artist;
  final bool showUserActivity;
  final bool showInclusions;
  final bool showPaymentDetails;
  final bool showOfferButton;
  final bool showWriteReviewButton;
  final VoidCallback? onWriteReview;
  final VoidCallback? onBuyTickets;
  final VoidCallback? onBookTable;
  final bool showPassDetails;

  const UnifiedEventCard({
    super.key,
    this.users,
    required this.featuredEvent,
    required this.eventDetails,
    required this.artist,
    this.showUserActivity = true,
    this.showInclusions = true,
    this.showPaymentDetails = true,
    this.showOfferButton = true,
    this.showWriteReviewButton = false,
    this.onWriteReview,
    this.onBuyTickets,
    this.onBookTable,
    this.showPassDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),


        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withValues(alpha: 0.1),
        //     blurRadius: 8,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User activity section (optional)
            if (showUserActivity && users != null && users!.isNotEmpty)
              UserActivitySection(users: users!),
            // Featured event image section
            FeaturedEventImageSection(featuredEvent: featuredEvent),
            // Event details section (with optional inclusions, payment, offer)
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: EventDetailsSection(
                eventDetails: eventDetails,
                artist: artist,
                showInclusions: showInclusions,
                showPaymentDetails: showPaymentDetails,
                showOfferButton: showOfferButton,
                showWriteReviewButton: showWriteReviewButton,
                onWriteReview: onWriteReview,
              ),
            ),
            // General Pass, Offer, and Price sections (only for carnival detail page)
            if (showPassDetails) ...[
              // General Pass section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: const CardGeneralPassSection(
                  passName: 'General Pass (Imported Liquor)',
                  moreCount: 3,
                ),
              ),
              const SizedBox(height: 6),
              // Offer text section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: const CardOfferText(
                  text: 'Get Flat 25% Off on Food & Bever.',
                ),
              ),
              const SizedBox(height: 6),
              // Price row section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: const CardPriceRow(
                  mrpPrice: 'MRP-₹10000',
                  discountedPrice: '₹8000/Person',
                  passType: 'General Pass',
                ),
              ),
              const SizedBox(height: 8),
            ],
            // Booking section with Buy Tickets and Book Table
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: CardSlidingBookingSection(
                onBuyTickets: onBuyTickets,
                onBookTable: onBookTable,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
