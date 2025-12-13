import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partywitty/presentation/screens/past_booking_screen.dart';
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
          child: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              final contentSlivers = _buildContentSlivers(context, state);
              final slivers = <Widget>[
                // Collapsible AppBar
                SliverAppBar(
                  floating: true,
                  snap: true,
                  pinned: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  expandedHeight: 0,
                  toolbarHeight: 57,
                  flexibleSpace: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF1F4E0).withOpacity(0.90),
                        ),
                        child: const AppHeader(),
                      ),
                    ),
                  ),
                ),

                // Sticky Active Booking title and Tabs
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyHeaderDelegate(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          //color: Colors.white.withOpacity(0.01),
                          decoration: BoxDecoration(
                            color: Color(0xffF1F4E0).withOpacity(0.90),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Active Booking title
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
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
                              // Tabs
                              const BookingTabs(),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
              slivers.addAll(contentSlivers);

              // Add bottom padding to prevent content from being hidden behind bottom navigation bar
              slivers.add(
                SliverPadding(padding: const EdgeInsets.only(bottom: 120)),
              );

              return CustomScrollView(slivers: slivers);
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContentSlivers(BuildContext context, BookingState state) {
    if (state is BookingHistoryLoading) {
      return [
        const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    if (state is BookingHistoryError) {
      return [
        SliverFillRemaining(
          child: Center(
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
          ),
        ),
      ];
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
      return [
        const SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text('Select Carnival tab to view bookings'),
            ),
          ),
        ),
      ];
    }

    // Show multiple carnival cards for all bookings
    if (state is BookingHistoryLoaded && state.bookings.isNotEmpty) {
      return [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index == state.bookings.length) {
              // Past bookings link
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 13.0,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _buildPastBookingsLink(context),
                ),
              );
            }

            final bookingData = state.bookings[index];
            final booking = bookingData as BookingHistoryModel;
            final featuredEvent =
                BookingMapper.toFeaturedEventModelWithDefaults(
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
                  showPaymentDetails: true,
                  showOfferButton: true,
                ),
                // Add spacing between cards (except for last card)
                if (index < state.bookings.length - 1)
                  const SizedBox(height: 12),
              ],
            );
          }, childCount: state.bookings.length + 1),
        ),
      ];
    }

    // Default/empty state - show default data
    return [
      SliverList(
        delegate: SliverChildListDelegate([
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
              child: _buildPastBookingsLink(context),
            ),
          ),
          const SizedBox(height: 220),
        ]),
      ),
    ];
  }
}

Widget _buildPastBookingsLink(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PastBookingsScreen()),
      );
    },
    child: Text(
      'Check your past bookings',
      style: GoogleFonts.lexend(
        color: Color(0xff7464E4),
        fontSize: 14,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
      ),
    ),
  );
}

// Custom delegate for sticky header
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 84.0; // Minimum height when collapsed (8 padding + 26 text + 8 padding + 38 tabs + 4 spacing)

  @override
  double get maxExtent => 84.0; // Maximum height when expanded

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
    //Container(
    // return Container(
    //   margin: const EdgeInsets.only(top: -1.0),
    //   child: ClipRect(
    //     child: BackdropFilter(
    //       filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
    //       child: Container(color: Colors.white.withOpacity(0.1), child: child),
    //     ),
    //   ),
    // );
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
