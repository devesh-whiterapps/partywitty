import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/carnival/venue_details_card.dart';
import '../widgets/carnival/counter_bid_section.dart';
import '../widgets/carnival/event_pass_card.dart';
import '../widgets/carnival/partywitty_pay_section.dart';
import '../widgets/carnival/menu_section.dart';
import '../widgets/carnival/gallery_section.dart';
import '../widgets/carnival/artist_card.dart';
import '../widgets/carnival/teaser_section.dart';

class CarnivalDetailScreen extends StatefulWidget {
  const CarnivalDetailScreen({super.key});

  @override
  State<CarnivalDetailScreen> createState() => _CarnivalDetailScreenState();
}

class _CarnivalDetailScreenState extends State<CarnivalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Gradient Background with Ellipses
          _buildGradientBackground(),

          // Main Content
          CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  'Event Details',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Event Banner
                    _buildEventBanner(),

                    const SizedBox(height: 15),

                    // Main Content Container
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Venue Details Card
                          const VenueDetailsCard(
                            venueName: 'F-bar',
                            rating: 4.1,
                            reviewCount: 3,
                            location: 'DLP Phase 3, Gurugram',
                            distance: '1.2 Kms',
                            serviceType: 'IMFL Drinks +FOOD',
                          ),

                          const SizedBox(height: 15),

                          // Counter Bid Section
                          const CounterBidSection(
                            pricePerPax: 1500,
                            savings: 290,
                          ),

                          const SizedBox(height: 15),

                          // Ticket Options
                          _buildTicketOptions(),

                          const SizedBox(height: 20),

                          // Partywitty Pay Section
                          const PartywittyPaySection(),

                          const SizedBox(height: 20),

                          // Event Banner 2
                          _buildEventBannerSection(),

                          const SizedBox(height: 20),

                          // Event Details Card
                          _buildEventDetailsCard(),

                          const SizedBox(height: 20),

                          // Ticket Options with Passes
                          _buildTicketPassOptions(),

                          const SizedBox(height: 20),

                          // Menu Section
                          const MenuSection(),

                          const SizedBox(height: 20),

                          // Gallery Section
                          const GallerySection(),

                          const SizedBox(height: 20),

                          // Teaser Section
                          const TeaserSection(),

                          const SizedBox(height: 20),

                          // Partywitty Pay (repeated)
                          const PartywittyPaySection(),

                          const SizedBox(height: 20),

                          // Artists Section
                          _buildArtistsSection(),

                          const SizedBox(height: 20),

                          // You May Also Like Section
                          _buildYouMayAlsoLike(),

                          const SizedBox(height: 80), // Space for bottom button
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Sticky Bottom Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildStickyBottomButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Positioned.fill(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE4E4E4),
                  Colors.white,
                ],
              ),
            ),
          ),
          // Yellow Ellipse
          Positioned(
            top: 50,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF6C656).withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF6C656).withOpacity(0.3),
                    blurRadius: 450,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          // Purple Ellipse
          Positioned(
            top: 200,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF7464E4).withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7464E4).withOpacity(0.3),
                    blurRadius: 450,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          // Green-Yellow Ellipse
          Positioned(
            bottom: 100,
            left: 50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFDBF657).withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFDBF657).withOpacity(0.3),
                    blurRadius: 450,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventBanner() {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/400/250'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          // Buttons
          Positioned(
            top: 10,
            right: 10,
            child: Row(
              children: [
                _buildIconButton(Icons.favorite_border, () {}),
                const SizedBox(width: 10),
                _buildIconButton(Icons.share, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }

  Widget _buildTicketOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ticket Options',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View Table Options',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF7464E4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(right: 15),
                child: EventPassCard(
                  title: 'General Pass (Domestic Liquor & Food)',
                  bookingAmount: 3000,
                  mrp: 20000,
                  offerPrice: 18000,
                  date: '26 Dec 25',
                  time: '10:00 PM Onwards',
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventBannerSection() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/400/200'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildEventDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '29 Dec 25',
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '10:00 PM Onwards',
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF7464E4),
                  side: const BorderSide(color: Color(0xFF7464E4)),
                ),
                child: Text(
                  'View Table Options',
                  style: GoogleFonts.lexend(fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Tuesday Tunes @connaught club house@01 July 2025 ( DJ Night)',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketPassOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ticket Options',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View Table Options',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  color: const Color(0xFF7464E4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(right: 15),
                child: EventPassCard(
                  title: 'General Pass (Domestic Liquor & Food)',
                  bookingAmount: 3000,
                  mrp: 20000,
                  offerPrice: 18000,
                  date: '26 Dec 25',
                  time: '10:00 PM Onwards',
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
                  (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == 0
                      ? const Color(0xFF7464E4)
                      : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildArtistsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Artists',
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 420,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(right: 15),
                child: ArtistCard(
                  artistName: 'Sarah Martinez',
                  artistType: 'Singer',
                  rating: 4.8,
                  eventDate: '20 Sep 25',
                  eventTime: '07:00 AM',
                  eventEndTime: '10:00 AM',
                  genres: ['POP', 'Popular', 'Rock'],
                  followers: 500,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
                  (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == 0
                      ? const Color(0xFF7464E4)
                      : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildYouMayAlsoLike() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You May Also Like This',
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 500,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: _buildEventCard(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard() {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image
          Container(
            height: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/320/150'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sitar Magic by Rishabh Rikhiram Sharma...',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage('https://picsum.photos/30/30'),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Malvika Khanna',
                              style: GoogleFonts.lexend(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Icon(Icons.verified, size: 14, color: Colors.blue),
                          ],
                        ),
                        Text(
                          'Artist',
                          style: GoogleFonts.lexend(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7464E4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Carnival',
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyBottomButton() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF7464E4),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7464E4),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                'Book Tickets',
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}