import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/booking/booking_bloc.dart';
import '../widgets/app_header.dart';
import '../widgets/booking_tabs.dart';
import '../widgets/unified_event_card.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../../domain/models/user_activity_model.dart';

/// Main booking screen matching the UI design
class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data - in real app, this would come from a repository
    final featuredEvent = EventModel(
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

    final eventDetails = EventModel(
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

    final artist = ArtistModel(
      id: '1',
      name: 'Malvika Khanna',
      imageUrl: '',
      role: 'Artist',
    );

    final userActivities = [
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
              //  const SizedBox(height: 1),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Unified event card combining all sections
                      // In booking screen, show all sections including user activity
                      UnifiedEventCard(
                        users: userActivities,
                        featuredEvent: featuredEvent,
                        eventDetails: eventDetails,
                        artist: artist,
                        showUserActivity: true,
                        showInclusions: true,
                        showPaymentDetails: true,
                        showOfferButton: true,
                      ),
                      // const SizedBox(height: 20),
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
    style: TextStyle(
      color: Color(0xff7464E4),
      fontSize: 14,
      decoration: TextDecoration.underline,
    ),
  );
}
