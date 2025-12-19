import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/carnival/event_pass_card.dart';
import '../widgets/carnival/partywitty_pay_section.dart';
import '../widgets/carnival/menu_section.dart';
import '../widgets/carnival/gallery_section.dart';
import '../widgets/carnival/artist_card.dart';
import '../widgets/carnival/teaser_section.dart';
import '../widgets/carnival/event_info_card.dart';
import '../widgets/event_booking_toggle.dart';
import '../widgets/event_options_switcher.dart';
import '../widgets/unified_event_card.dart';
import '../widgets/sections/card_buttons_section.dart';
import '../widgets/gradient_background.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';

class CarnivalDetailScreen extends StatefulWidget {
  const CarnivalDetailScreen({super.key});

  @override
  State<CarnivalDetailScreen> createState() => _CarnivalDetailScreenState();
}

class _CarnivalDetailScreenState extends State<CarnivalDetailScreen> {
  // Add this state variable at the top of the State class
  bool _showTableOptions = false;
  bool _isFavorite = false;
  static const double _headerReservedSpace = 72;

  // Timer state
  Duration _timerDuration = const Duration(hours: 6, minutes: 40, seconds: 59);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerDuration.inSeconds > 0) {
        setState(() {
          _timerDuration = Duration(seconds: _timerDuration.inSeconds - 1);
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours : $minutes : $seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: Stack(
          children: [
            // Main Content
            Padding(
            padding: EdgeInsets.only(
              top: _headerReservedSpace,
              bottom:
                  80, // Space for bottom button and navigation bar (44px button + 10px top padding + 10px bottom padding + 16px extra for nav bar)
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 20), // Two lines from top
                      // Horizontal divider line above F-Bar
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: const Color(0xFFE6E6E6),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                      ),
                      const SizedBox(height: 15),
                      // White Background Card
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          width: double.infinity,
                          // height: 608.3157958984375, // Height will be determined by child
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: _buildVenueBidCard(), // Place the card here
                        ),
                      ),
                      // Main Content Container
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),

                            // Event Banner (after F-Bar card)
                            _buildEventBanner(),

                            const SizedBox(height: 15),

                            // Event Info Card
                            const EventInfoCard(),

                            const SizedBox(height: 15),

                            // Ticket Options
                            // _buildTicketOptions(),

                            // const SizedBox(height: 20),

                            // // Partywitty Pay Section
                            // const PartywittyPaySection(),

                            // const SizedBox(height: 20),

                            // // Event Banner 2
                            // _buildEventBannerSection(),

                            // const SizedBox(height: 20),

                            // // Event Details Card
                            // _buildEventDetailsCard(),

                            // const SizedBox(height: 20),

                            // Ticket Options with Passes
                            const EventOptionsSwitcher(),

                            const SizedBox(height: 20),

                            // Menu Section
                            const MenuSection(),

                            const SizedBox(height: 20),

                            // Gallery Section
                            const GallerySection(),

                            const SizedBox(height: 20),

                            // Teaser Section
                            const TeaserSection(),

                            // Offer Cards Section
                            _buildOfferCardsSection(),

                            // Partywitty Pay (repeated)
                            // const PartywittyPaySection(),

                            // Artists Section
                            _buildArtistsSection(),

                            const SizedBox(height: 20),

                            // You May Also Like Section
                            _buildYouMayAlsoLike(),

                            const SizedBox(height: 20), // Extra space before bottom button
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Sticky Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                    ),
                    padding: const EdgeInsets.only(
                      top: 11,
                      left: 7,
                      right: 23,
                      bottom: 11,
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        width: 71,
                        height: 23,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 45,
                              height: 23,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/icons/arrow_back.png',
                                width: 16,
                                height: 12,
                                color: const Color(0xFF070707),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Back',
                              style: GoogleFonts.lexend(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF070707),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Sticky Bottom Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(top: false, child: _buildStickyBottomButton()),
          ),
        ],
      ),
    )
    );
  }

  Widget _buildVenueBidCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header Section
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: const Color(0xFF1E69DE),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              alignment: Alignment.center,
              child: Image.asset('assets/icons/f_bar_logo.png'),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 50,
              height: 23,
              child: Text(
                'F-Bar',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1.0, // line-height: 100%
                  letterSpacing: 0,
                  color: const Color(0xFF4F4F4F),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Image.asset('assets/icons/star.png', width: 20, height: 20),
            const SizedBox(width: 4),
            Text('4.1', style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
            const SizedBox(width: 8),
            Text(
              'Review (03)',
              style: GoogleFonts.outfit(
                color: const Color(0xFF555555),
                decoration: TextDecoration.underline,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Info Rows
        Row(
          children: [
            const SizedBox(width: 4),
            Image.asset(
              'assets/icons/location_r.png',
              width: 18,
              height: 18,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Color(0xFF555555),
                );
              },
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 21,
              child: Text(
                'DLP Phase 3, Gurugram',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 20.84 / 14, // line-height: 20.84px
                  color: const Color(0xFF4F4F4F),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF7464E4),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Row(
                children: [
                  const Icon(Icons.undo, size: 14, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    '1.2 Kms',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const SizedBox(width: 4),
            Image.asset('assets/icons/buffet.png', width: 20, height: 20),
            const SizedBox(width: 8),
            SizedBox(
              width: 136,
              height: 21,
              child: Text(
                'IMFL Drinks +FOOD',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 20.84 / 14, // line-height: 20.84px
                  letterSpacing: 0,
                  color: const Color(0xFF4F4F4F),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Cyan Gradient Banner
        Container(
          width: double.infinity,
          height: 34,
          padding: const EdgeInsets.only(
            top: 10,
            right: 15,
            bottom: 10,
            left: 15,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
            ),
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
            child: SizedBox(
            width: double.infinity,
            child: Text(
              'Make your counter bid and grab the best deal for your party!',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                height: 1.0, // line-height: 100%
                letterSpacing: 0,
                color: const Color(0xFF070707),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Price Row
        Row(
          children: [
            Container(
              width: 95,
              height: 30,
              padding: const EdgeInsets.only(
                top: 9,
                right: 10,
                bottom: 9,
                left: 10,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF7464E4), Color(0xFF1A00D2)],
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Center(
                child: Text(
                  '₹1500/Pax',
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.0,
                    letterSpacing: 0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              height: 30,
              padding: const EdgeInsets.only(
                top: 3,
                right: 7,
                bottom: 3,
                left: 7,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF), // #FFFFFF
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: const Color(0xFFE6E6E6),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Kids Price',
                  style: GoogleFonts.lexend(
                    color: const Color(0xFF7C3AED),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                _showCounterBidModal(context);
              },
              child: Container(
                height: 30,
                padding: const EdgeInsets.only(
                  top: 2,
                  right: 15,
                  bottom: 2,
                  left: 15,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Center(
                  child: Text(
                    'Counter Bid',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: 0,
                      color: const Color(0xFF070707),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Details Bar
        Container(
          width: double.infinity,
          height: 38,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF4338CA),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem(Icons.calendar_today, '11-4-25'),
              _buildDetailItem(Icons.access_time, '10 PM'),
              _buildDetailItem(Icons.wine_bar, '10 PM'),
              _buildDetailItem(Icons.group, '10'),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Green Gradient Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF22D3EE), Color(0xFF86EFAC)],
            ),
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Great Choice! ₹290 would be Saved Instantly on This Booking!',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Feature Chips Section
        SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 8,
            runSpacing: 10,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildFeatureChip(Icons.local_bar, 'Alcoholic'),
              _buildFeatureChip(null, 'Pure Veg'),
              _buildFeatureChip(
                Icons.restaurant_menu,
                '3 Starters + 2 Main Course',
              ),
              _buildFeatureChip(
                Icons.local_drink,
                '2 Mocktails + 2 Soft drinks',
              ),
              _buildFeatureChip(Icons.timer_outlined, '3 Hours'),
              _buildFeatureChip(Icons.music_note, 'Live Music'),
              _buildFeatureChip(Icons.dinner_dining_outlined, 'Food – 3h'),
              _buildFeatureChip(Icons.wine_bar_outlined, 'Drinks – 1.5h'),
            ],
          ),
        ),
        const SizedBox(height: 6),

        // Confirmation Texts and Final Price Container
        SizedBox(
          width: double.infinity,
          height: 97,
          child: Column(
            children: [
              // Confirmation Texts Section
              Container(
                width: double.infinity,
                height: 30,
                padding: const EdgeInsets.only(
                  top: 8,
                  right: 15,
                  bottom: 8,
                  left: 15,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x99FFFFFF), // #FFFFFF99
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 123,
                          height: 15,
                          child: Text(
                            'Instant Confirmation',
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.0,
                              letterSpacing: 0,
                              color: const Color(0xFF4F4F4F),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 93,
                          height: 15,
                          child: Text(
                            'No Hidden Fees',
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.0,
                              letterSpacing: 0,
                              color: const Color(0xFF4F4F4F),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 95,
                          height: 15,
                          child: Text(
                            'Secure Payment',
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.0,
                              letterSpacing: 0,
                              color: const Color(0xFF4F4F4F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Final Price and Timer Footer
              Container(
                width: double.infinity,
                height: 67,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0), // Square corners
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF7464E4), Color(0xFF1A00D2)],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'MRP–₹2000',
                            style: GoogleFonts.lexend(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              height: 1.0,
                              letterSpacing: 0,
                              color: const Color(0xFF3CBD53),
                              decoration: TextDecoration.lineThrough,
                              decorationColor: const Color(0xFF3CBD53),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Offer Price ₹1500',
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 1.0,
                                  letterSpacing: 0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Kid\'s Price',
                                style: GoogleFonts.lexend(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.0,
                                  letterSpacing: 0,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        _formatDuration(_timerDuration).toLowerCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.0,
                          letterSpacing: 0,
                          color: const Color(0xFF070707),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 15, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.outfit(fontSize: 13, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildFeatureChip(IconData? icon, String label) {
    final isVeg = label == 'Pure Veg';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Light grey background
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon - no border container, just the icon
          isVeg
              ? Image.asset(
                  'assets/icons/veg_indicator.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                )
              : icon != null
              ? Icon(
                  icon,
                  size: 20,
                  color: const Color(0xFF444444), // Dark grey icon
                )
              : const SizedBox(width: 20),
          const SizedBox(width: 6), // gap between icon and text
          // Text
          Flexible(
            child: Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF444444), // Dark grey text
                height: 1.43, // line-height: 20px
                letterSpacing: 0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventBanner() {
    const double bannerHeight = 236;
    const double foregroundWidth = 125;
    const double foregroundHeight = 205;
    const double iconSize = 35;
    return SizedBox(
      height: bannerHeight,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Blurred backdrop using the same hero image
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Image.asset(
                'assets/images/imageOne.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          // Dark overlay to make the foreground pop
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),
          // Foreground image card
          Align(
            alignment: Alignment.center,
            child: Container(
              height: foregroundHeight,
              width: foregroundWidth,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 22,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/imageOne.png',
                fit: BoxFit.cover,
                width: foregroundWidth,
                height: foregroundHeight,
              ),
            ),
          ),
          // Action icons
          Positioned(
            top: 16,
            right: 16,
            child: Row(
              children: [
                _buildCircleIconButton(
                  assetPath: 'assets/icons/heartvector.png',
                  size: iconSize,
                  isActive: _isFavorite,
                  onTap: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                ),
                const SizedBox(width: 10),
                _buildCircleIconButton(
                  assetPath: 'assets/icons/sharevector.png',
                  size: iconSize,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIconButton({
    required String assetPath,
    required double size,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFFEAEAEA),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        overlayColor: MaterialStateProperty.all(
          const Color(0xFF4F4F4F).withOpacity(0.12),
        ),
        child: SizedBox(
          height: size,
          width: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (isActive)
                Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.16),
                    shape: BoxShape.circle,
                  ),
                ),
              Center(
                child: Image.asset(
                  assetPath,
                  width: size * 0.5,
                  height: size * 0.5,
                  fit: BoxFit.contain,
                  color: isActive ? Colors.red : null,
                  colorBlendMode: isActive ? BlendMode.srcIn : null,
                ),
              ),
            ],
          ),
        ),
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

  Widget _buildOfferBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF7464E4), Color(0xFF1A00D2)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Get Flat 25% Off On Food & Bever.',
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
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

  // Widget _buildTicketPassOptions() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'Ticket Options',
  //             style: GoogleFonts.lexend(
  //               fontSize: 18,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               // Show the EventBookingToggle in a bottom sheet
  //               showModalBottomSheet(
  //                 context: context,
  //                 isScrollControlled: true,
  //                 backgroundColor: Colors.transparent,
  //                 builder: (BuildContext context) {
  //                   return Container(
  //                     height: MediaQuery.of(context).size.height * 0.9,
  //                     decoration: const BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //                     ),
  //                     child: const EventBookingToggle(),
  //                   );
  //                 },
  //               );
  //             },
  //             child: Text(
  //               'View Table Options',
  //               style: GoogleFonts.lexend(
  //                 fontSize: 14,
  //                 color: const Color(0xFF7464E4),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 10),
  //       SizedBox(
  //         height: 220,
  //         child: ListView.builder(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: 2, // Assuming you still want two images
  //           itemBuilder: (context, index) {
  //             return Padding(
  //               padding: const EdgeInsets.only(right: 15),
  //               // Replace the EventPassCard with a static image from your assets
  //               child: Image.asset(
  //                 'assets/images/event_pass.png', // <<< Your static image path here
  //                 height: 220, // Match the container height
  //                 fit: BoxFit.contain, // Adjust fit as needed (e.g., BoxFit.cover)
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //       const SizedBox(height: 10),
  //       Center(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: List.generate(
  //             3,
  //                 (index) => Container(
  //               width: 8,
  //               height: 8,
  //               margin: const EdgeInsets.symmetric(horizontal: 4),
  //               decoration: BoxDecoration(
  //                 color: index == 0
  //                     ? const Color(0xFF7464E4)
  //                     : Colors.grey.shade300,
  //                 shape: BoxShape.circle,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildOfferCardsSection() {
    final cards = [
      PromoCardData(
        title: 'Get Flat 35% Off',
        subtitle: 'On Food & Beverages',
        buttonText: 'Book Now',
        imagePath: 'assets/icons/celebration.svg',
        backgroundColor: const Color(0xffFFF9C4),
      ),
      PromoCardData(
        title: 'Use Tulips To Make Payment',
        subtitle: 'Earn 25 Tulips',
        buttonText: 'Watch & Earn',
        imagePath: 'assets/icons/celebration.svg',
        backgroundColor: const Color(0xffFFF9C4),
      ),
      PromoCardData(
        title: 'Upto 50% Off',
        subtitle: 'On Food & Beverages Bill',
        buttonText: 'Pre-Booking',
        imagePath: 'assets/images/group_celeb.svg',
        backgroundColor: const Color(0xffFFF9C4),
      ),
      PromoCardData(
        title: 'Use Tulips To Make Payment',
        subtitle: 'Earn 25 Tulips',
        buttonText: 'Watch & Earn',
        imagePath: 'assets/images/card3.svg',
        backgroundColor: const Color(0xffFFF9C4),
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PromoCarousel(cards: cards, borderColor: Colors.black),
        Center(
          child: SizedBox(
            width: double.infinity,
            height: 11,
            child: Image.asset(
              'assets/images/indicators.png',
              width: double.infinity,
              height: 11,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 20),

      ],
    );
  }

  Widget _buildArtistsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Artists',
          style: GoogleFonts.lexend(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Image.asset(
          'assets/images/sarah_singer.png',
          width: double.infinity,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 10),
        Center(
          child: _buildIndicators(3, 0),
        ),
      ],
    );
  }

  Widget _buildIndicators(int count, int currentIndex) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.19),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              count,
              (index) => Padding(
                padding: EdgeInsets.only(
                  right: index < count - 1 ? 5 : 0,
                ),
                child: Image.asset(
                  'assets/images/indicator.png',
                  width: index == currentIndex ? 20 : 5,
                  height: 5,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to colored container if image not found
                    return Container(
                      width: index == currentIndex ? 20 : 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7464E4),
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildYouMayAlsoLike() {
    // Sample event data - only 1 card
    final event = EventModel(
      id: '1',
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'You May Also Like This',
            style: GoogleFonts.lexend(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 5),
        // Person attended image
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Image.asset(
            'assets/images/person_attended_image.png',
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
        // UnifiedEventCard (removed extra spacing)
        UnifiedEventCard(
          featuredEvent: event,
          eventDetails: event,
          artist: artist,
          showUserActivity: false,
          showOfferButton: false,
          showPaymentDetails: false,
          showPassDetails: true,
        ),
      ],
    );
  }

  Widget _buildStickyBottomButton() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 1),
      child: GestureDetector(
        onTap: () {
          // Handle book tickets action
        },
        child: Container(
          width: double.infinity,
          height: 44,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color(0xE5FFFFFF), // #FFFFFFE5
            borderRadius: BorderRadius.circular(2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                width: double.infinity,
                height: 36,
                padding: const EdgeInsets.only(
                  top: 8,
                  right: 16,
                  bottom: 8,
                  left: 14,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(-0.47, 0.0), // 84.28deg approximation
                    end: Alignment(1.05, 0.0),
                    colors: [Color(0xFF7464E4), Color(0xFF3354F4)],
                  ),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 0,
                      offset: Offset.zero,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Book Tickets',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 1.0, // line-height: 100%
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCounterBidModal(BuildContext context) {
    final TextEditingController bidController = TextEditingController();
    String? selectedReason;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext modalContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 1,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE6E6E6), // Light gray background
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag Handle - centered
                  Center(
                    child: Container(
                      width: 50,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4F4F4F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Title - left aligned
                  Text(
                    'Counter Bid',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                      letterSpacing: 0,
                      color: const Color(0xFF070707),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Club Offer - left aligned
                  Text(
                    'Club Offer  ₹1500',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                      letterSpacing: 0,
                      color: const Color(0xFF4F4F4F),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Counter Bid Input Field
                  GestureDetector(
                    onTap: () {
                      if (bidController.text.isEmpty) {
                        bidController.text = '1100';
                        setModalState(() {});
                      }
                      // Dismiss keyboard if it's open
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 49,
                      padding: const EdgeInsets.only(
                        top: 12,
                        right: 15,
                        bottom: 12,
                        left: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white, // Solid white
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '₹',
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF4F4F4F),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: bidController,
                              readOnly: true,
                              showCursor: false,
                              enableInteractiveSelection: false,
                              style: GoogleFonts.lexend(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.0,
                                letterSpacing: 0,
                                color: const Color(0xFF4F4F4F),
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter Counter Bid',
                                hintStyle: GoogleFonts.lexend(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.0,
                                  letterSpacing: 0,
                                  color: const Color(
                                    0xFF4F4F4F,
                                  ).withOpacity(0.5),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Reason Section
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Reason Label
                        Text(
                          'Reason',
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.0,
                            letterSpacing: 0,
                            color: const Color(0xFF4F4F4F),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Reason Dropdown
                        Container(
                          width: double.infinity,
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 13,
                            right: 15,
                            bottom: 13,
                            left: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white, // Solid white
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              _showReasonModal(context, (reason) {
                                setModalState(() {
                                  selectedReason = reason;
                                });
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    selectedReason ?? 'Select Reason',
                                    style: GoogleFonts.lexend(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: selectedReason != null
                                          ? const Color(0xFF4F4F4F)
                                          : const Color(
                                              0xFF4F4F4F,
                                            ).withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xFF4F4F4F),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showReasonModal(
    BuildContext context,
    Function(String) onReasonSelected,
  ) {
    final List<String> reasons = [
      'Seeking packages with a few more inclusions',
      'Received tempting offers from other venues',
      'Looking for a venue with a specific feature',
      'Reviews made me reconsider my choice',
      'Considering venues in a different location',
      'Found another venue that suits my needs better',
      'Unexpected change in plans; need a different vibe.',
      'Concerned about the venue\'s capacity for my guest list',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Reason',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF070707),
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Reasons List
                    ...reasons.map(
                      (reason) => GestureDetector(
                        onTap: () {
                          onReasonSelected(reason);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 0,
                          ),
                          height: 24,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            reason,
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 24 / 12, // line-height: 24px
                              letterSpacing: 0,
                              color: const Color(0xFF4F4F4F),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Model for card data
class PromoCardData {
  final String title;
  final String subtitle;
  final String buttonText;
  final String imagePath;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  PromoCardData({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imagePath,
    this.backgroundColor = const Color(0xffFFF9C4),
    this.onPressed,
  });
}

// Reusable Single Card Widget
class PromoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String imagePath;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const PromoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imagePath,
    this.backgroundColor = const Color(0xffFFF9C4),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 120,
      child: CustomPaint(
        painter: _PromoCardDottedBorderPainter(),
        child: Opacity(
          opacity: 1,
          child: Container(
            padding: const EdgeInsets.only(
              left: 8,
              right: 0,
              top: 8,
              bottom: 0,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffF0CF66).withValues(alpha: 0.0),
                  Color(0xffCCED29).withValues(alpha: 0.3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 3.0,
                right: 0.0,
                top: 9.0,
                bottom: 0.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff070707),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff070707),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Transform.translate(
                          offset: const Offset(0, -6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff000000).withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(
                                color: Color(
                                  0xff000000,
                                ).withValues(alpha: 0.06),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              buttonText,
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff070707),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 0),
                      SvgPicture.asset(
                        imagePath,
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Carousel Widget with Multiple Cards
class PromoCarousel extends StatefulWidget {
  final List<PromoCardData> cards;
  final Color borderColor;
  final int cardsPerView;

  const PromoCarousel({
    super.key,
    required this.cards,
    this.borderColor = Colors.black,
    this.cardsPerView = 2,
  });

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardSpacing = 8.0; // Space between cards
    final cardHeight = 109.0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: cardHeight,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.cards.length,
          itemBuilder: (context, index) {
            final card = widget.cards[index];
            return Container(
              width: 200,
              margin: EdgeInsets.only(
                right: index < widget.cards.length - 1 ? cardSpacing : 0,
              ),
              child: PromoCard(
                title: card.title,
                subtitle: card.subtitle,
                buttonText: card.buttonText,
                imagePath: card.imagePath,
                backgroundColor: card.backgroundColor,
                onPressed: card.onPressed,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Custom painter for dotted border on promo cards
class _PromoCardDottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xff020202).withValues(alpha: 0.92)
      ..strokeWidth = 0.3
      ..style = PaintingStyle.stroke;

    const dashWidth = 3.0;
    const dashSpace = 2.0;
    const radius = 2.0;

    // Draw dotted border around the container
    _drawDottedRect(
      canvas,
      paint,
      Offset(0, 0),
      size,
      radius,
      dashWidth,
      dashSpace,
    );
  }

  void _drawDottedRect(
    Canvas canvas,
    Paint paint,
    Offset offset,
    Size size,
    double radius,
    double dashWidth,
    double dashSpace,
  ) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    final dashPath = _dashPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _dashPath(Path path, double dashWidth, double dashSpace) {
    final dashPath = Path();
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    return dashPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
