import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partywitty/presentation/widgets/gradient_background.dart';
import 'package:partywitty/presentation/widgets/unified_event_card.dart';
import '../bloc/booking/booking_bloc.dart';
import '../bloc/booking/booking_event.dart';
import '../bloc/booking/booking_state.dart';
import '../../domain/models/user_activity_model.dart';
import '../../domain/models/booking_history_model.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../../data/mappers/booking_mapper.dart';

class PastBookingsScreen extends StatefulWidget {
  const PastBookingsScreen({super.key});

  @override
  State<PastBookingsScreen> createState() => _PastBookingsScreenState();
}

class _PastBookingsScreenState extends State<PastBookingsScreen> {
  // Default/hardcoded data that will be used as fallback
  late final EventModel _defaultFeaturedEvent;
  late final EventModel _defaultEventDetails;
  late final ArtistModel _defaultArtist;
  late final List<UserActivityModel> _defaultUserActivities;

  @override
  void initState() {
    super.initState();
    // Initialize default data
    _defaultFeaturedEvent = EventModel(
      id: '1',
      title: 'Desi Techno Tuesdays',
      venue: 'FLOAT BY DUTY FREE',
      location: 'DLP Phase 3, Gurugram',
      imageUrl: '',
      date: 'Today',
      time: '10:00 PM Onwards',
      type: 'Carnival',
      rating: 4.1,
      reviewCount: 3,
      eventCategory: 'Stand-up Comedy',
      inclusions: ['3 Starters', '2 Main Course'],
      advancePaid: 1800,
      balanceAmount: 3800,
      distance: 1.2,
    );

    _defaultEventDetails = EventModel(
      id: '2',
      title: 'Sitar Magic by Rishabh Rikhiram Sharma',
      venue: 'F-Bar',
      location: 'DLP Phase 3, Gurugram',
      imageUrl: '',
      date: 'Today',
      time: '10:00 PM Onwards',
      type: 'Event',
      rating: 4.1,
      reviewCount: 3,
      eventCategory: 'Stand-up Comedy',
      inclusions: ['3 Starters', '2 Main Course'],
      advancePaid: 1800,
      balanceAmount: 3800,
      distance: 1.2,
    );

    _defaultArtist = ArtistModel(
      id: '1',
      name: 'Malvika Khanna',
      imageUrl: '',
      role: 'Artist',
    );

    _defaultUserActivities = [
      UserActivityModel(
        id: '1',
        name: 'Rohit Sharma',
        imageUrl: '',
        activityText: 'Attended a party here last m...',
      ),
      UserActivityModel(
        id: '2',
        name: 'User 2',
        imageUrl: '',
        activityText: '',
      ),
      UserActivityModel(
        id: '3',
        name: 'User 3',
        imageUrl: '',
        activityText: '',
      ),
      UserActivityModel(
        id: '4',
        name: 'User 4',
        imageUrl: '',
        activityText: '',
      ),
      UserActivityModel(
        id: '5',
        name: 'User 5',
        imageUrl: '',
        activityText: '',
      ),
      UserActivityModel(
        id: '6',
        name: 'User 6',
        imageUrl: '',
        activityText: '',
      ),
      UserActivityModel(
        id: '7',
        name: 'User 7',
        imageUrl: '',
        activityText: '',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc()
        ..add(
          const FetchBookingHistoryEvent(
            userId: '14393',
            longitude: '77.0801664',
            latitude: '28.6294016',
            type: 'completed',
            sessionCookie: 'ci_session=r635a1dspb8t0mbodajeho1bjttliuv4',
          ),
        ),
      child: Scaffold(
        body: GradientBackground(
          child: SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Image.asset(
                      'assets/icons/arrow_back.png',
                      width: 16,
                      height: 13,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  titleSpacing: -10,
                  title: Text(
                    'Transaction History',
                    style: GoogleFonts.lexend(
                      color: Color(0xff070707),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  centerTitle: false,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Container(
                        width: 38,
                        height: 38,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffECECE9),
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xffFFFFFF).withOpacity(0.5),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: 24,
                          height: 24,
                          color: Color(0xff4F4F4F),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<BookingBloc, BookingState>(
                    builder: (context, state) {
                      return _buildContent(context, state);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, BookingState state) {
    if (state is BookingHistoryLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is BookingHistoryError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<BookingBloc>().add(
                  const FetchBookingHistoryEvent(
                    userId: '14393',
                    longitude: '77.0801664',
                    latitude: '28.6294016',
                    type: 'completed',
                    sessionCookie:
                        'ci_session=r635a1dspb8t0mbodajeho1bjttliuv4',
                  ),
                );
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // Show past bookings
    if (state is BookingHistoryLoaded && state.bookings.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 120),
        itemCount: state.bookings.length,
        itemBuilder: (context, index) {
          final bookingData = state.bookings[index];
          final booking = bookingData as BookingHistoryModel;
          final featuredEvent = BookingMapper.toFeaturedEventModelWithDefaults(
            booking,
            _defaultFeaturedEvent,
          );
          final eventDetails = BookingMapper.toEventDetailsModelWithDefaults(
            booking,
            _defaultEventDetails,
          );

          return Column(
            children: [
              UnifiedEventCard(
                users: _defaultUserActivities,
                featuredEvent: featuredEvent,
                eventDetails: eventDetails,
                artist: _defaultArtist,
                showUserActivity: true,
                showInclusions: true,
                showPaymentDetails: false,
                showOfferButton: false,
                showWriteReviewButton: true,
                onWriteReview: () {
                  // Handle write review for this specific booking
                  _handleWriteReview(booking);
                },
              ),
              // Add spacing between cards (except for last card)
              if (index < state.bookings.length - 1) const SizedBox(height: 12),
            ],
          );
        },
      );
    }

    // Empty state - show default data or empty message
    return ListView(
      padding: const EdgeInsets.only(bottom: 120),
      children: [
        UnifiedEventCard(
          users: _defaultUserActivities,
          featuredEvent: _defaultFeaturedEvent,
          eventDetails: _defaultEventDetails,
          artist: _defaultArtist,
          showUserActivity: true,
          showInclusions: true,
          showPaymentDetails: false,
          showOfferButton: false,
          showWriteReviewButton: true,
          onWriteReview: () {
            // Handle write review for default event
            _handleWriteReview(null);
          },
        ),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () {}, child: Text('View All')),
      ],
    );
  }

  void _handleWriteReview(BookingHistoryModel? booking) {
    // TODO: Navigate to write review screen or show review dialog
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          booking != null
              ? 'Write review for ${booking.carnivalName}'
              : 'Write review',
        ),
      ),
    );
  }
}
