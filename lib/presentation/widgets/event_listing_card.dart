import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../../domain/models/user_activity_model.dart';
import 'sections/sections.dart';

/// Card type enum for different card styles matching Figma
enum CardType {
  carnival, // Carnival card with Buy Tickets (main carousel)
  carnivalWithPass, // Carnival with horizontal pass selector
  carnivalBookFor, // Carnival with Book for X pricing
  event, // Simple event card with Buy Now
  venueListing, // Venue with discount offers & View Details
  packageBidding, // Package bidding with offer price
  packageCompact, // Compact package with date/time/pax
}

/// Event Listing Card matching Figma design exactly
/// Now uses modular section widgets for reduced code and maintainability
class EventListingCard extends StatefulWidget {
  final List<UserActivityModel>? users;
  final EventModel event;
  final ArtistModel? artist;
  final VoidCallback? onBuyTickets;
  final VoidCallback? onBookTable;
  final VoidCallback? onViewDetails;
  final CardType cardType;

  const EventListingCard({
    super.key,
    this.users,
    required this.event,
    this.artist,
    this.onBuyTickets,
    this.onBookTable,
    this.onViewDetails,
    this.cardType = CardType.carnival,
  });

  @override
  State<EventListingCard> createState() => _EventListingCardState();
}

class _EventListingCardState extends State<EventListingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // User activity section
              if (widget.users != null && widget.users!.isNotEmpty)
                CardUserActivitySection(users: widget.users!),

              // Image section
              _buildImageSection(),

              const SizedBox(height: 20),

              // Details section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event title
                    Text(
                      widget.event.title,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff070707),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Build sections based on card type
                    ..._buildCardContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    final bool isCarnival =
        widget.cardType == CardType.carnival ||
        widget.cardType == CardType.carnivalWithPass ||
        widget.cardType == CardType.carnivalBookFor ||
        widget.cardType == CardType.event;

    BannerType bannerType;
    bool showFilterBadge = false;

    switch (widget.cardType) {
      case CardType.carnival:
      case CardType.carnivalWithPass:
      case CardType.carnivalBookFor:
        bannerType = BannerType.dateTimeWithType;
        break;
      case CardType.event:
        bannerType = BannerType.dateTimeOnly;
        showFilterBadge = true;
        break;
      case CardType.venueListing:
        bannerType = BannerType.venueType;
        showFilterBadge = true;
        break;
      case CardType.packageBidding:
      case CardType.packageCompact:
        bannerType = BannerType.package;
        showFilterBadge = widget.cardType == CardType.packageBidding;
        break;
    }

    return CardImageSection(
      event: widget.event,
      imagePath: isCarnival
          ? 'assets/images/sitar.jpg'
          : 'assets/images/discount.png',
      showFilterBadge: showFilterBadge,
      bannerType: bannerType,
    );
  }

  List<Widget> _buildCardContent() {
    switch (widget.cardType) {
      case CardType.carnival:
        return _buildCarnivalContent();
      case CardType.carnivalWithPass:
        return _buildCarnivalWithPassContent();
      case CardType.carnivalBookFor:
        return _buildCarnivalBookForContent();
      case CardType.event:
        return _buildEventContent();
      case CardType.venueListing:
        return _buildVenueListingContent();
      case CardType.packageBidding:
        return _buildPackageBiddingContent();
      case CardType.packageCompact:
        return _buildPackageCompactContent();
    }
  }

  // ========== CARNIVAL CARD CONTENT ==========
  List<Widget> _buildCarnivalContent() {
    return [
      if (widget.artist != null) CardArtistSection(artist: widget.artist!),
      if (widget.artist != null) const SizedBox(height: 12),
      CardVenueRatingSection(event: widget.event),
      const SizedBox(height: 8),
      CardLocationSection(event: widget.event),
      const SizedBox(height: 12),
      CardEventTypeSection(category: widget.event.eventCategory),
      const SizedBox(height: 12),
      CardInclusionsSection(inclusions: widget.event.inclusions),
      const SizedBox(height: 8),
      const CardGeneralPassSection(),
      const SizedBox(height: 6),
      const CardOfferText(),
      const SizedBox(height: 10),
      CardSlidingPriceBookingSection(
        options: [
          PriceBookingOption(
            mrpPrice: 'MRP ₹10000',
            currentPrice: '₹8000/Person',
            passType: 'General Pass',
            bookingAmount: '₹3000',
            perPerson: '/Person',
            buttonText: 'Buy Tickets',
            isPurple: true,
            onPressed: widget.onBuyTickets,
          ),
          PriceBookingOption(
            mrpPrice: 'Minimum Spend-₹15000',
            currentPrice: '₹3700/Person',
            bookingAmount: '₹2385',
            buttonText: 'Book Table',
            isPurple: false,
            onPressed: widget.onBookTable,
          ),
        ],
      ),
      const SizedBox(height: 12),
    ];
  }

  // ========== CARNIVAL WITH PASS CONTENT ==========
  List<Widget> _buildCarnivalWithPassContent() {
    return [
      if (widget.artist != null) CardArtistSection(artist: widget.artist!),
      if (widget.artist != null) const SizedBox(height: 12),
      CardVenueRatingSection(event: widget.event),
      const SizedBox(height: 8),
      CardLocationSection(event: widget.event),
      const SizedBox(height: 12),
      CardEventTypeSection(category: widget.event.eventCategory),
      const SizedBox(height: 12),
      CardInclusionsSection(inclusions: widget.event.inclusions),
      const SizedBox(height: 8),
      const CardOfferText(),
      const SizedBox(height: 10),
      // Simple ticket cards without tabs
      const CardTicketListSection(),
      const SizedBox(height: 12),
    ];
  }

  // ========== CARNIVAL BOOK FOR CONTENT ==========
  List<Widget> _buildCarnivalBookForContent() {
    return [
      if (widget.artist != null) CardArtistSection(artist: widget.artist!),
      if (widget.artist != null) const SizedBox(height: 12),
      CardVenueRatingSection(event: widget.event),
      const SizedBox(height: 8),
      CardLocationSection(event: widget.event),
      const SizedBox(height: 12),
      CardEventTypeSection(category: widget.event.eventCategory),
      const SizedBox(height: 12),
      CardInclusionsSection(inclusions: widget.event.inclusions),
      const SizedBox(height: 8),
      const CardOfferText(),
      const SizedBox(height: 10),
      const CardBookForPricing(),
      const SizedBox(height: 12),
    ];
  }

  // ========== EVENT CARD CONTENT ==========
  List<Widget> _buildEventContent() {
    return [
      if (widget.artist != null) CardArtistSection(artist: widget.artist!),
      if (widget.artist != null) const SizedBox(height: 12),
      CardVenueRatingSection(event: widget.event),
      const SizedBox(height: 8),
      CardLocationSection(event: widget.event),
      const SizedBox(height: 12),
      CardEventTypeSection(category: widget.event.eventCategory),
      const SizedBox(height: 12),
      CardInclusionsSection(inclusions: widget.event.inclusions),
      const SizedBox(height: 8),
      const CardOfferText(),
      const SizedBox(height: 10),
      CardGradientButton(text: 'Buy Now', onPressed: widget.onBuyTickets),
      const SizedBox(height: 12),
    ];
  }

  // ========== VENUE LISTING CONTENT ==========
  List<Widget> _buildVenueListingContent() {
    return [
      const CardDiscountOfferSection(),
      const SizedBox(height: 10),
      CardVenueRatingSection(event: widget.event),
      const SizedBox(height: 8),
      CardLocationSection(event: widget.event),
      const SizedBox(height: 12),
      CardLiveEventsSection(
        onMoreTap: () {
          // TODO: Navigate to live events page
        },
      ),
      const SizedBox(height: 12),
      CardFeaturesSection(
        onMoreTap: () {
          // TODO: Navigate to features page
        },
      ),
      const SizedBox(height: 8),
      const CardOfferText(),
      const SizedBox(height: 10),
      const CardPartywittyPayOffer(),
      const SizedBox(height: 10),
      CardViewDetailsButton(onPressed: widget.onViewDetails),
      const SizedBox(height: 12),
    ];
  }

  // ========== PACKAGE BIDDING CONTENT ==========
  List<Widget> _buildPackageBiddingContent() {
    return [
      const CardOfferPriceSection(),
      const SizedBox(height: 10),
      const CardUserAttendedRow(),
      const SizedBox(height: 10),
      CardVenueRatingSection(event: widget.event),
      const SizedBox(height: 8),
      CardLocationSection(event: widget.event),
      const SizedBox(height: 12),
      const CardDrinksAndFood(),
      const SizedBox(height: 8),
      const CardServiceTime(),
      const SizedBox(height: 8),
      const CardOfferText(),
      const SizedBox(height: 10),
      const CardPartywittyPayOffer(),
      const SizedBox(height: 10),
      CardViewDetailsButton(onPressed: widget.onViewDetails),
      const SizedBox(height: 12),
    ];
  }

  // ========== PACKAGE COMPACT CONTENT ==========
  List<Widget> _buildPackageCompactContent() {
    return [
      CardVenueRatingSection(event: widget.event),
      const SizedBox(height: 8),
      CardLocationSection(event: widget.event),
      const SizedBox(height: 12),
      const CardDrinksAndFood(),
      const SizedBox(height: 8),
      const CardOfferText(),
      const SizedBox(height: 10),
      const CardDateTimePaxRow(),
      const SizedBox(height: 8),
      const CardServiceTime(),
      const SizedBox(height: 12),
    ];
  }
}
