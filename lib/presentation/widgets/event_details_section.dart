import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../screens/event_details_screen.dart';

class EventDetailsSection extends StatelessWidget {
  final EventModel eventDetails;
  final ArtistModel artist;
  final bool showInclusions;
  final bool showPaymentDetails;
  final bool showOfferButton;

  const EventDetailsSection({
    super.key,
    required this.eventDetails,
    required this.artist,
    this.showInclusions = true,
    this.showPaymentDetails = true,
    this.showOfferButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      decoration: const BoxDecoration(
        // color: Colors.white,
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
          buildVenueAndRating(),
          const SizedBox(height: 12),
          // Location
          buildLocation(),
          const SizedBox(height: 12),
          // Event type
          _buildEventType(),
          if (showInclusions) ...[
            const SizedBox(height: 12),
            // Inclusions
            _buildInclusions(),
          ],
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

  Widget buildVenueAndRating() {
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

  Widget buildLocation() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.location_on_outlined, color: Colors.grey[700], size: 20),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            eventDetails.location,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff4F4F4F),
            ),
            maxLines: 2,
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
              Image.asset('assets/icons/distance.png', width: 12, height: 12),
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

  Widget _buildInclusions() {
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
            Text(
              '10+ More',
              style: GoogleFonts.lexend(
                decoration: TextDecoration.underline,
                fontSize: 13,
                color: Color(0xff7464E4),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
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
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff7464E4),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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
            const SizedBox(width: 5),
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
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.asset(
                  'assets/icons/qr.png',
                  width: 50,
                  height: 50,
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
}
