import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/booking/booking_bloc.dart';
import '../bloc/booking/booking_event.dart';
import '../bloc/booking/booking_state.dart';
import '../widgets/app_header.dart';
import '../widgets/booking_tabs.dart';
import '../widgets/unified_event_card.dart';
import '../../domain/models/user_activity_model.dart';
import '../../domain/models/booking_history_model.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../../data/mappers/booking_mapper.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
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
      create: (context) => BookingBloc(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              const AppHeader(),
              // Active Booking title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Text(
                      'Active Booking',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff070707),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Tabs
              const BookingTabs(),
              // Content
              Expanded(
                child: BlocBuilder<BookingBloc, BookingState>(
                  builder: (context, state) {
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
                                    type: 'upcoming',
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

                    // Get selected tab from state
                    String selectedTab = 'Carnival';
                    if (state is BookingTabSelected) {
                      selectedTab = state.selectedTab;
                    } else if (state is BookingHistoryLoaded) {
                      selectedTab = state.selectedTab;
                    } else if (state is BookingHistoryError) {
                      selectedTab = state.selectedTab;
                    } else if (state is BookingHistoryLoading) {
                      selectedTab = state.selectedTab;
                    }

                    // Only show content for Carnival tab
                    if (selectedTab != 'Carnival') {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text('Select Carnival tab to view bookings'),
                        ),
                      );
                    }

                    // Show multiple carnival cards for all bookings
                    if (state is BookingHistoryLoaded &&
                        state.bookings.isNotEmpty) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            // Show a card for each booking
                            ...state.bookings.asMap().entries.map((entry) {
                              final index = entry.key;
                              final bookingData = entry.value;
                              final booking =
                                  bookingData as BookingHistoryModel;
                              final featuredEvent =
                                  BookingMapper.toFeaturedEventModelWithDefaults(
                                    booking,
                                    _defaultFeaturedEvent,
                                  );
                              final eventDetails =
                                  BookingMapper.toEventDetailsModelWithDefaults(
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
                                    showPaymentDetails: true,
                                    showOfferButton: true,
                                  ),
                                  // Add spacing between cards (except for last card)
                                  if (index < state.bookings.length - 1)
                                    const SizedBox(height: 12),
                                ],
                              );
                            }).toList(),
                            // Show "Check your past bookings" only after all cards
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 13.0,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: _buildPastBookingsLink(),
                              ),
                            ),
                            const SizedBox(height: 85),
                          ],
                        ),
                      );
                    }

                    // Default/empty state - show default data
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          UnifiedEventCard(
                            users: _defaultUserActivities,
                            featuredEvent: _defaultFeaturedEvent,
                            eventDetails: _defaultEventDetails,
                            artist: _defaultArtist,
                            showUserActivity: true,
                            showInclusions: true,
                            showPaymentDetails: true,
                            showOfferButton: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 13.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: _buildPastBookingsLink(),
                            ),
                          ),
                          const SizedBox(height: 85),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildPastBookingsLink() {
  return Text(
    'Check your past bookings',
    style: GoogleFonts.lexend(
      color: Color(0xff7464E4),
      fontSize: 14,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.underline,
    ),
  );
}
