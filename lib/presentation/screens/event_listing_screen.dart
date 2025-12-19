import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/app_header.dart';
import '../widgets/event_listing_card.dart';
import '../widgets/filter_modal.dart';
import '../widgets/sort_modal.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../../domain/models/user_activity_model.dart';

class EventListingScreen extends StatefulWidget {
  const EventListingScreen({super.key});

  @override
  State<EventListingScreen> createState() => _EventListingScreenState();
}

class _EventListingScreenState extends State<EventListingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  String selectedFilter = 'Events';

  // Sample data - replace with actual data from your backend
  late final List<EventModel> carnivalEvents;
  late final List<EventModel> myBidsEvents;
  late final ArtistModel artist;
  late final List<UserActivityModel> userActivities;

  @override
  void initState() {
    super.initState();
    _initializeSampleData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _initializeSampleData() {
    artist = ArtistModel(
      id: '1',
      name: 'Malvika Khanna',
      imageUrl: '',
      role: 'Artist',
    );

    userActivities = [
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
    ];

    carnivalEvents = List.generate(
      3,
      (index) => EventModel(
        id: '${index + 1}',
        title: 'Sitar Magic by Rishabh Rikhiram Sharma...',
        venue: 'F-Bar',
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
      ),
    );

    myBidsEvents = List.generate(
      6,
      (index) => EventModel(
        id: '${index + 10}',
        title: 'Sitar Magic by Rishabh Rikhiram Sharma...',
        venue: 'F-Bar',
        location: 'DLP Phase 3, Gurugram',
        imageUrl: '',
        date: 'Today',
        time: '10:00 PM Onwards',
        type: index.isEven ? 'Carnival' : 'Event',
        rating: 4.1,
        reviewCount: 3,
        eventCategory: 'Stand-up Comedy',
        inclusions: ['3 Starters', '2 Main Course'],
        advancePaid: 1800,
        balanceAmount: 3800,
        distance: 1.2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Collapsible AppBar - same as BookingScreen
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
                      color: const Color(0xffF1F4E0).withOpacity(0.90),
                    ),
                    child: const AppHeader(),
                  ),
                ),
              ),
            ),

            // Sticky Event Listing title and filter buttons
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF1F4E0).withOpacity(0.90),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Event Listing title
                            const Text(
                              'Event Listing',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff070707),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Filter buttons and icons row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left side - filter chips
                                Row(
                                  children: [
                                    _buildFilterChip('Events', true),
                                    const SizedBox(width: 10),
                                    _buildFilterChip('Carnival Events', false),
                                  ],
                                ),

                                // Right side - sort and filter icons
                                Row(
                                  children: [
                                    _buildIconButton(
                                      icon: Icons.sort,
                                      onTap: () => _showSortModal(),
                                    ),
                                    const SizedBox(width: 10),
                                    _buildIconButton(
                                      icon: Icons.filter_alt,
                                      onTap: () => _showFilterModal(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Carousel with page indicator
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 780,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: carnivalEvents.length,
                      itemBuilder: (context, index) {
                        return EventListingCard(
                          users: userActivities,
                          event: carnivalEvents[index],
                          artist: artist,
                          cardType: CardType.carnival,
                          onBuyTickets: () {
                            // Handle buy tickets
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 11),

                  // Page indicators
                  _buildPageIndicator(),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // My Bids section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'My Bids (500)',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff070707),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // List of bid cards - each with different card type based on Figma
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                // Assign different card types based on index to match Figma
                final cardTypes = [
                  CardType.carnival,
                  CardType.carnivalWithPass,
                  CardType.event,
                  CardType.venueListing,
                  CardType.packageBidding,
                  CardType.packageCompact,
                ];

                return EventListingCard(
                  users: index == 0 ? userActivities : null,
                  event: myBidsEvents[index],
                  artist: artist,
                  cardType: cardTypes[index % cardTypes.length],
                  onBuyTickets: () {
                    // Handle buy tickets
                  },
                );
              }, childCount: myBidsEvents.length),
            ),

            // Bottom padding to prevent content from being hidden behind bottom navigation
            const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xff7464E4)
              : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isSelected ? Colors.white : const Color(0xff070707),
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 5),
              const Icon(Icons.close, size: 14, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xff7464E4),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(child: Icon(icon, size: 24, color: Colors.white)),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.19)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(carnivalEvents.length, (index) {
          final isActive = index == _currentPage;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.5),
            width: isActive ? 20 : 5,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xff7464E4),
              borderRadius: BorderRadius.circular(2.5),
            ),
          );
        }),
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterModal(),
    );
  }

  void _showSortModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const SortModal(),
    );
  }
}

// Custom delegate for sticky header - same as BookingScreen
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 100.0;

  @override
  double get maxExtent => 100.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
