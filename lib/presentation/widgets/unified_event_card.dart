import 'dart:ui';
import 'package:flutter/material.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../../domain/models/user_activity_model.dart';
import 'user_activity_section.dart';
import 'featured_event_image_section.dart';
import 'event_details_section.dart';

class UnifiedEventCard extends StatelessWidget {
  final List<UserActivityModel>? users;
  final EventModel featuredEvent;
  final EventModel eventDetails;
  final ArtistModel artist;
  final bool showUserActivity;
  final bool showInclusions;
  final bool showPaymentDetails;
  final bool showOfferButton;

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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.71),
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
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // User activity section (optional)
              if (showUserActivity && users != null && users!.isNotEmpty)
                UserActivitySection(users: users!),
              // Featured event image section
              FeaturedEventImageSection(featuredEvent: featuredEvent),
              // Event details section (with optional inclusions, payment, offer)
              EventDetailsSection(
                eventDetails: eventDetails,
                artist: artist,
                showInclusions: showInclusions,
                showPaymentDetails: showPaymentDetails,
                showOfferButton: showOfferButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
