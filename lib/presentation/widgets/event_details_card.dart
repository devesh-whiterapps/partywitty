import 'package:flutter/material.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../screens/event_details_screen.dart';


class EventDetailsCard extends StatelessWidget {
  final EventModel event;
  final ArtistModel artist;

  const EventDetailsCard({
    super.key,
    required this.event,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event title
          Text(
            event.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
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
          const SizedBox(height: 12),
          // Inclusions
          _buildInclusions(),
          const SizedBox(height: 16),
          // Payment details
          _buildPaymentDetails(context),
          const SizedBox(height: 12),
          // Offer button
          _buildOfferButton(),
          const SizedBox(height: 12),
          // Past bookings link
          _buildPastBookingsLink(),
        ],
      ),
    );
  }

  Widget _buildArtistInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[300],
          child: Text(
            artist.name[0].toUpperCase(),
            style: const TextStyle(fontSize: 14),
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
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.favorite, size: 14, color: Colors.black),
                ],
              ),
              Text(
                artist.role,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
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
        Icon(Icons.diamond, color: Colors.blue[700], size: 18),
        const SizedBox(width: 6),
        Text(
          event.venue,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 16),
        Icon(Icons.star, color: Colors.amber[700], size: 18),
        const SizedBox(width: 4),
        Text(
          '${event.rating}',
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(width: 4),
        Text(
          'Review (${event.reviewCount.toString().padLeft(2, '0')})',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(Icons.location_on, color: Colors.grey[700], size: 18),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            event.location,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.purple[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.diamond, color: Colors.purple[700], size: 12),
              const SizedBox(width: 4),
              Text(
                '${event.distance.toStringAsFixed(1)} Kms',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.purple[700],
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
        Icon(Icons.theater_comedy, color: Colors.grey[700], size: 18),
        const SizedBox(width: 6),
        Text(
          event.eventCategory,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildInclusions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Inclusion:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            ...event.inclusions.take(2).map((item) => Text(
                  item,
                  style: const TextStyle(fontSize: 13),
                )),
            Text(
              '10+ More',
              style: TextStyle(
                fontSize: 13,
                color: Colors.blue[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Advance Paid',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '₹${event.advancePaid.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Use Partywitty Pay Balance Amount - ₹3800',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EventDetailsScreen(
                      event: event,
                      artist: artist,
                      advancePaid: event.advancePaid,
                      balanceAmount: event.balanceAmount,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.qr_code, color: Colors.grey[700]),
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
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple[700],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Get Flat 25% Off On Food & Bever.',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildPastBookingsLink() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Check your past bookings',
          style: TextStyle(
            color: Colors.blue[700],
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

