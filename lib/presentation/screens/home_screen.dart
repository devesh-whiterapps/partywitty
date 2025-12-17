import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partywitty/presentation/widgets/home_card.dart';
import '../widgets/filter_modal.dart';
import '../widgets/sort_modal.dart';
import '../../domain/models/user_activity_model.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Default/hardcoded data for home screen
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
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
                    child: _buildSimpleHeader(),
                  ),
                ),
              ),
            ),

            // Sticky Header with Event Listing Title and Filters
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF1F4E0).withOpacity(0.90),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Event Listing title
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              12.0,
                              16.0,
                              12.0,
                            ),
                            child: Text(
                              'Event Listing',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff070707),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // Filter tabs and buttons
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              0,
                              16.0,
                              12.0,
                            ),
                            child: Row(
                              children: [
                                // Scrollable tabs section
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        // Events tab (selected)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0,
                                            vertical: 8.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color(0xff7464E4),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Events',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Icon(
                                                Icons.close,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        // Carnival Events tab
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0,
                                            vertical: 8.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: Color(0xffE0E0E0),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            'Carnival Events',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff070707),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        // Add more dummy tabs to show scrolling
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0,
                                            vertical: 8.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: Color(0xffE0E0E0),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            'Music Events',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff070707),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Fixed action buttons
                                // Sort button
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) => SortModal(),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xff7464E4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/sorting.svg',
                                      width: 20,
                                      height: 20,
                                      colorFilter: ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Filter button
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) => FilterModal(),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xff7464E4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/filter.svg',
                                      width: 20,
                                      height: 20,
                                      colorFilter: ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Content - Multiple Event Cards
            SliverList(
              delegate: SliverChildListDelegate([
                // First Event Card with user activity
                HomeCard(
                  users: _defaultUserActivities,
                  featuredEvent: _defaultFeaturedEvent,
                  eventDetails: _defaultEventDetails,
                  artist: _defaultArtist,
                  showUserActivity: true,
                  showInclusions: true,
                  showPaymentDetails: true,
                  showOfferButton: true,
                ),
              ]),
            ),

            // Bottom padding to prevent content from being hidden behind bottom navigation bar
            SliverPadding(padding: const EdgeInsets.only(bottom: 120)),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // Logo placeholder
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.party_mode, color: Color(0xff070707), size: 24),
          ),
          const SizedBox(width: 12),
          // Location selector
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffffffff).withOpacity(0.55),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: Color(0xff4f4f4f),
                    ),
                    const Text(
                      'Vasant Kunj',
                      style: TextStyle(fontSize: 13, color: Color(0xff4f4f4f)),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Color(0xff4f4f4f),
                    ),
                  ],
                ),
              ),
              const Text(
                'Vasant Kunj Comes Under ..',
                style: TextStyle(fontSize: 11.5, color: Colors.grey),
              ),
            ],
          ),
          Spacer(),
          // Notification icon
          Container(
            width: 44,
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.notifications_outlined,
              size: 24,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          const SizedBox(width: 10),
          // Scanner icon
          // Container(
          //   width: 44,
          //   height: 45,
          //   padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
          //   decoration: BoxDecoration(
          //     color: Colors.white.withOpacity(0.5),
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: Icon(
          //     Icons.qr_code_scanner,
          //     size: 24,
          //     color: Colors.black.withOpacity(0.8),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// Custom delegate for sticky header
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 120.0; // Minimum height when collapsed

  @override
  double get maxExtent => 120.0; // Maximum height when expanded

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(height: maxExtent, child: child);
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
