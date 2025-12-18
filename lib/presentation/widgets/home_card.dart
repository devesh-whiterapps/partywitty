import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partywitty/presentation/widgets/ticket_inclusion_modal.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../../domain/models/user_activity_model.dart';
import '../screens/event_details_screen.dart';
import '../screens/payment_screen.dart';
import '../screens/general_pass_options_screen.dart';
import 'inclusions_dialog.dart';

class HomeCard extends StatelessWidget {
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

  const HomeCard({
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.71),
        borderRadius: BorderRadius.circular(4),
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
                _buildUserActivitySection(),
              // Featured event image section
              _buildFeaturedEventImageSection(context),
              // Event details section
              _buildEventDetailsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  // User Activity Section
  Widget _buildUserActivitySection() {
    return Container(
      padding: const EdgeInsets.only(
        top: 12.0,
        bottom: 0.0,
        left: 12.0,
        right: 12.0,
      ),
      child: Row(
        children: [
          // Stacked user avatars
          _buildStackedAvatars(),
          const SizedBox(width: 12),
          // Activity text
          Expanded(
            child: Text(
              '${users!.first.name} +${users!.length - 1} more Attended a party here last m...',
              style: const TextStyle(fontSize: 13, color: Colors.black87),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackedAvatars() {
    final displayCount = 3;
    final avatarSize = 24.0;
    final overlap = 10.0;
    final totalWidth = (displayCount * overlap) + (avatarSize - overlap);

    return SizedBox(
      height: avatarSize,
      width: totalWidth,
      child: Stack(
        children: [
          ...List.generate(
            displayCount,
            (index) => Positioned(
              left: index * overlap,
              child: _buildCircularAvatarWithBorder(avatarSize),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularAvatarWithBorder(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[200]!, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/Ellipse 4.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Icon(Icons.person, size: 12, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }

  // Featured Event Image Section
  Widget _buildFeaturedEventImageSection(BuildContext context) {
    return SizedBox(
      height: 370,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Event image
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 0),
            width: double.infinity,
            height: double.maxFinite,
            child: Image.asset('assets/images/carnival_image.png'),
          ),
          // Top icons
          Positioned(
            top: 25,
            right: 12,
            child: Row(
              children: [
                Image.asset('assets/icons/bookmark.png', width: 26, height: 26),
                const SizedBox(width: 8),
                Image.asset('assets/icons/share.png', width: 26, height: 26),
                const SizedBox(width: 8),
              ],
            ),
          ),
          // Bottom banner with date/time
          Positioned(
            bottom: -28,
            left: (MediaQuery.of(context).size.width - 330) / 2,
            child: Container(
              padding: const EdgeInsets.only(bottom: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        'assets/images/tilted_container.png',
                        width: 200,
                        height: 90,
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Text(
                              '${featuredEvent.date} | ${featuredEvent.time}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        'assets/icons/carnival_container.png',
                        width: 100,
                        height: 70,
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/celebration.png',
                                  width: 13,
                                  height: 13,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Carnival',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Event Details Section
  Widget _buildEventDetailsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event title
          Text(
            eventDetails.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff070707),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          // Artist info
          _buildArtistInfo(),
          const SizedBox(height: 12),
          // Venue and rating
          _buildVenueAndRating(),
          const SizedBox(height: 12),
          // Location
          _buildLocation(),
          const SizedBox(height: 12),
          // Event type
          _buildEventType(),
          if (showInclusions) ...[
            const SizedBox(height: 12),
            // Inclusions
            _buildInclusions(context),
          ],
          // Event Pass Card
          const SizedBox(height: 12),
          EventPassCard(
            passTitle: 'General Pass (Domestic Liquor & Food) || Single',
            bookingAmount: '₹3000',
            mrpPrice: 'MRP-₹20000',
            totalPrice: '₹18000/Person',
            date: '26 Dec 25',
            time: '10:00 PM Onwards',
            onInclusionsTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => TicketInclusionModal(),
              );
            },
          ),
          //
          if (showPaymentDetails) ...[
            const SizedBox(height: 16),
            // Payment details
            _buildPaymentDetails(context),
          ],
          if (showOfferButton) ...[
            const SizedBox(height: 12),
            // Offer button
            _buildOfferButton(),
          ],
          if (showWriteReviewButton) ...[
            const SizedBox(height: 12),
            // Write Review button
            _buildWriteReviewButton(),
          ],
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildArtistInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          child: Image.asset(
            'assets/images/user_img.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    artist.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff070707),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.favorite, size: 14, color: Colors.black),
                ],
              ),
              Text(
                artist.role,
                style: TextStyle(fontSize: 12, color: Color(0xff4f4f4f)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVenueAndRating() {
    return Row(
      children: [
        Image.asset('assets/icons/f_bar.png', width: 24, height: 24),
        const SizedBox(width: 6),
        Text(
          eventDetails.venue,
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xff070707),
          ),
        ),
        const SizedBox(width: 4),
        Icon(Icons.star, color: Colors.amber[700], size: 18),
        const SizedBox(width: 4),
        Text(
          '${eventDetails.rating}',
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff070707),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          'Review ',
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            color: Color(0xff070707),
          ),
        ),
        Text(
          '(${eventDetails.reviewCount.toString().padLeft(2, '0')})',
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff070707),
          ),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/icons/location.svg', width: 20, height: 20),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            eventDetails.location,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff4F4F4F),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xff7464E4).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/distance.svg',
                width: 12,
                height: 12,
              ),
              const SizedBox(width: 4),
              Text(
                '${eventDetails.distance.toStringAsFixed(1)} Kms',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff7464E4),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventType() {
    return Row(
      children: [
        Icon(Icons.theater_comedy_outlined, color: Colors.grey[900], size: 20),
        const SizedBox(width: 6),
        Text(
          eventDetails.eventCategory,
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff4F4F4F),
          ),
        ),
      ],
    );
  }

  Widget _buildInclusions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Inclusion:',
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff070707),
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            ...eventDetails.inclusions
                .take(2)
                .map(
                  (item) => Text(
                    "• ${item}",
                    style: GoogleFonts.lexend(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff4F4F4F),
                    ),
                  ),
                ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => TicketInclusionModal(),
                );
              },
              child: Text(
                '10+ More',
                style: GoogleFonts.lexend(
                  decoration: TextDecoration.underline,
                  fontSize: 13,
                  color: Color(0xff7464E4),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGeneralPassSection() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GeneralPassOptionsScreen(
              eventName: event?.title ?? 'Event',
              eventDate: event?.date ?? '',
              eventTime: event?.time ?? '',
            ),
          ),
        );
      },
      child: Row(
        children: [
          Flexible(
            child: Text(
              'General Pass (Imported Liquor',
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff070707),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Color(0xff070707),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '+3 More',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff7464E4),
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.arrow_forward, size: 16, color: Color(0xff7464E4)),
        ],
      ),
    );
  }

  Widget _buildPromotionalOffer() {
    return Text(
      'Get Flat 25% Off On Food & Bever.',
      style: GoogleFonts.lexend(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xff7464E4),
      ),
    );
  }

  Widget _buildPricingCardsSection(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildGeneralPassCard(context),
          const SizedBox(width: 12),
          _buildMinimumSpendCard(context),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _buildGeneralPassCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xff7464E4), Color(0xff5B4BC9)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'MRP-₹10000',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff90EE90),
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Color(0xff90EE90),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '₹8000/Person',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'General Pass',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff5B4BC9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking Amount',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹3000',
                        style: GoogleFonts.lexend(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '/Person',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withOpacity(0.3),
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xff7464E4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Buy Tickets',
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMinimumSpendCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xffE8F44D), Color(0xffD4E84D)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Minimum Spend-₹15000',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff008000),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '₹3700/Person',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff070707),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffD4E84D),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking Amount',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff070707).withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹2385',
                        style: GoogleFonts.lexend(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff070707),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Color(0xff070707).withOpacity(0.2),
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff070707),
                    foregroundColor: Color(0xffE8F44D),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Book Table',
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advance Paid',
              style: GoogleFonts.lexend(
                fontSize: 14,
                color: Color(0xff070707),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              '₹${eventDetails.advancePaid.toStringAsFixed(0)}',
              style: GoogleFonts.lexend(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xff008000),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
        Spacer(),
        Row(
          children: [
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        event: eventDetails,
                        artist: artist,
                        balanceAmount: eventDetails.balanceAmount,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff7464E4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Use Partywitty Pay',
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Balance Amount - ₹${eventDetails.balanceAmount.toStringAsFixed(0)}',
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 7),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EventDetailsScreen(
                      event: eventDetails,
                      artist: artist,
                      advancePaid: eventDetails.advancePaid,
                      balanceAmount: eventDetails.balanceAmount,
                    ),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Color(0xff7464E4).withValues(alpha: 0.11),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SvgPicture.asset(
                  'assets/icons/qr-code.svg',
                  width: 22.5,
                  height: 22.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOfferButton() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xff7464E4), Color(0xff1A00D2)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          child: Center(
            child: Text(
              'Get Flat 25% Off On Food & Bever.',
              style: GoogleFonts.lexend(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWriteReviewButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onWriteReview,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff7464E4),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Text(
          'Write Review',
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Event Pass Card Widget with background image
class EventPassCard extends StatelessWidget {
  final String passTitle;
  final String bookingAmount;
  final String mrpPrice;
  final String totalPrice;
  final String date;
  final String time;
  final VoidCallback? onTap;
  final VoidCallback? onInclusionsTap;

  const EventPassCard({
    super.key,
    this.passTitle = 'General Pass (Domestic Liquor & Food) || Single',
    this.bookingAmount = '₹3000',
    this.mrpPrice = 'MRP-₹20000',
    this.totalPrice = '₹18000/Person',
    this.date = '26 Dec 25',
    this.time = '10:00 PM Onwards',
    this.onTap,
    this.onInclusionsTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 189,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'assets/images/Event Pass.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // Content overlay
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Pass title
                          Text(
                            passTitle,
                            style: GoogleFonts.lexend(
                              fontSize: 11.814,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          // Booking Amount label
                          Text(
                            'Booking Amount',
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff070707),
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Price
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: bookingAmount,
                                  style: GoogleFonts.lexend(
                                    fontSize: 20.153,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff3CBD53),
                                  ),
                                ),
                                TextSpan(
                                  text: '/Person',
                                  style: GoogleFonts.lexend(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff3CBD53),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          // Barcode
                          SizedBox(
                            height: 21,
                            child: Row(
                              children: List.generate(
                                45,
                                (i) => Container(
                                  width: i % 3 == 0 ? 3 : 2,
                                  height: i % 4 == 0
                                      ? 21
                                      : (i % 3 == 0 ? 15 : 18),
                                  margin: const EdgeInsets.only(right: 1.5),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Right side content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // MRP
                        Text(
                          mrpPrice,
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffFF5C5C),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Total price
                        Text(
                          totalPrice,
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff070707),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Inclusions link
                        GestureDetector(
                          onTap: onInclusionsTap,
                          child: Text(
                            'Inclusions',
                            style: GoogleFonts.lexend(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Date and time (rotated)
                        SizedBox(
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  '$date  •  $time',
                                  style: GoogleFonts.lexend(
                                    fontSize: 8.339,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
