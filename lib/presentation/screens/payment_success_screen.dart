import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partywitty/presentation/widgets/event_details_section.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../widgets/gradient_background.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final EventModel event;
  final ArtistModel artist;
  final double paidAmount;
  final String orderId;
  final int carrotsEarned;

  const PaymentSuccessScreen({
    super.key,
    required this.event,
    required this.artist,
    required this.paidAmount,
    required this.orderId,
    this.carrotsEarned = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: false,
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // AppBar
                _buildAppBar(context),
                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Payment Success Section (Light Green)
                          _buildSuccessSection(),
                          const SizedBox(height: 12),
                          // Transaction Details Section (White)
                          _buildTransactionDetailsSection(),
                          const SizedBox(height: 16),
                          // Carrots Earned Section (Yellow)
                          _buildCarrotsSection(),
                          const SizedBox(height: 16),
                          // Refer & Earn Section (White)
                          _buildReferAndEarnSection(),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    // return AppBar(
    //   backgroundColor: Colors.transparent,
    //   elevation: 0,
    //   leading: Row(
    //     children: [
    //       IconButton(
    //         icon: Image.asset(
    //           'assets/icons/arrow_back.png',
    //           width: 16,
    //           height: 13,
    //         ),
    //         onPressed: () => Navigator.of(context).pop(),
    //       ),
    //       Text(
    //         'Back',
    //         style: GoogleFonts.lexend(
    //           color: Color(0xff070707),
    //           fontSize: 16,
    //           fontWeight: FontWeight.w500,
    //         ),
    //       ),
    //     ],
    //   ),
    //   actions: [
    //     Padding(
    //       padding: const EdgeInsets.only(right: 16.0),
    //       child: Container(
    //         width: 24,
    //         height: 24,
    //         decoration: BoxDecoration(
    //           border: Border.all(color: Colors.grey[300]!, width: 1),
    //         ),
    //         child: Image.asset(
    //           'assets/logo/Vector.png',
    //           width: 20,
    //           height: 20,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset('assets/icons/arrow_back.png', width: 16, height: 13),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: -10,
      title: Text(
        'Back',
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
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: Image.asset('assets/logo/Vector.png', width: 40, height: 40),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color(0xffffffff).withValues(alpha: 0.7), // Light green
      ),
      child: Column(
        children: [
          // Success Checkmark Icon
          Container(
            padding: const EdgeInsets.all(10),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xff22C55E).withValues(alpha: 0.1),
              // border: Border.all(
              //   color: Color(0xff22C55E).withValues(alpha: 0.1),
              // ),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/check.svg',
              width: 36,
              height: 36,
            ),
          ),
          const SizedBox(height: 12),
          // Success Message
          Text(
            'Thank You! Payment Successful with PartyWitty"',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xff070707),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Subtitle
          Text(
            'Your bill has been paid securely using PartyWitty Wallet. Enjoy your meal and have a great time!',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff4F4F4F),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetailsSection() {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xffffffff).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xffECECE9), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Venue and Rating5
          // Row(
          //   children: [
          //     Container(
          //       width: 24,
          //       height: 24,
          //       decoration: BoxDecoration(
          //         color: Colors.blue,
          //         borderRadius: BorderRadius.circular(4),
          //       ),
          //       child: Center(
          //         child: Text(
          //           'F',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 14,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 8),
          //     Text(
          //       event.venue,
          //       style: GoogleFonts.lexend(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w500,
          //         color: Color(0xff070707),
          //       ),
          //     ),
          //     const SizedBox(width: 8),
          //     Icon(Icons.star, color: Colors.amber[700], size: 18),
          //     const SizedBox(width: 4),
          //     Text(
          //       '${event.rating}',
          //       style: GoogleFonts.lexend(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Color(0xff070707),
          //       ),
          //     ),
          //     const SizedBox(width: 4),
          //     Text(
          //       'Review ',
          //       style: GoogleFonts.lexend(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         decoration: TextDecoration.underline,
          //         color: Color(0xff7464E4),
          //       ),
          //     ),
          //     Text(
          //       '(${event.reviewCount.toString().padLeft(2, '0')})',
          //       style: GoogleFonts.lexend(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Color(0xff070707),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 12),
          // // Location
          // Row(
          //   children: [
          //     Icon(
          //       Icons.location_on_outlined,
          //       color: Colors.grey[700],
          //       size: 20,
          //     ),
          //     const SizedBox(width: 6),
          //     Text(
          //       event.location,
          //       style: GoogleFonts.lexend(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w400,
          //         color: Color(0xff4F4F4F),
          //       ),
          //     ),
          //   ],
          // ),
          EventDetailsSection(
            eventDetails: event,
            artist: artist,
          ).buildVenueAndRating(),
          const SizedBox(height: 12),
          // Location
          EventDetailsSection(
            eventDetails: event,
            artist: artist,
          ).buildLocation(),
          const SizedBox(height: 12),
          // const SizedBox(height: 24),
          // Paid Amount and Order ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Paid Amount',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff070707),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${paidAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff16A34A),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Order ID',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff070707),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    orderId,
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCarrotsSection() {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 23),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 23),
      decoration: BoxDecoration(
        color: Color(0xffF1C943).withValues(alpha: 0.9), // Light yellow
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bunny Illustration (using icon as placeholder)
          Container(
            width: 71,
            height: 109,
            alignment: Alignment.center,
            // child: SvgPicture.asset(
            //   'assets/images/rabbit.svg',
            //   width: 71,
            //   height: 109,
            //   fit: BoxFit.contain,
            // ),
            child: Image.asset(
              'assets/images/Rectangle.png',
              width: 71,
              height: 109,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 20),
          // Carrots Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Congratulations !!!',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff070707),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'You Have Earned Partywitty Carrots',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff070707),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$carrotsEarned Carrots',
                style: GoogleFonts.lexend(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff0000000),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Navigate to carrots view
                },
                child: Text(
                  'View Carrots',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReferAndEarnSection() {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          // margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.67),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Refer & Earn',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff070707),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Share the party vibes with your friends and collect carrots every time they join in. More carrots = more savings on your next night out!',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4F4F4F),
                ),
              ),
              // const SizedBox(height: 20),
              const SizedBox(height: 12),
              Row(
                children: [
                  // Invite Friends Button
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff614BFF),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Color(0xff7464E4), width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/invite.svg',
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Invite Friends',
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  // // Social Icons Illustration (placeholder)
                  // Row(
                  //   children: [
                  //     _buildSocialIcon(Icons.card_giftcard, Color(0xffE8F5E9)),
                  //     const SizedBox(width: 8),
                  //     _buildSocialIcon(
                  //       Icons.chat_bubble_outline,
                  //       Color(0xff7464E4).withValues(alpha: 0.2),
                  //     ),
                  //     const SizedBox(width: 8),
                  //     _buildSocialIcon(Icons.phone, Color(0xffFFF9C4)),
                  //     const SizedBox(width: 8),
                  //     _buildSocialIcon(Icons.camera_alt, Color(0xffFFE0B2)),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ),
        // SVG at 50 pixels from left with 8% opacity
        Positioned(
          left: 80,
          bottom: 0,
          child: Transform.rotate(
            angle: -2.11 * 3.14159 / 180, // Convert degrees to radians
            child: Opacity(
              opacity: 0.01,
              child: SvgPicture.asset(
                'assets/images/rotated_invite_vector.svg',
                width: 157,
                height: 157,
              ),
            ),
          ),
        ),
        // SVG at rightmost end with 32.11 degree rotation and 20% opacity
        Positioned(
          right: 0,
          bottom: 0,
          child: Transform.rotate(
            angle: -2.11 * 3.14159 / 180, // Convert degrees to radians
            child: Opacity(
              opacity: 1,
              child: SvgPicture.asset(
                'assets/images/rotated_invite_vector.svg',
                width: 157,
                height: 157,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 0,
          child: Opacity(
            opacity: 1,
            child: SvgPicture.asset('assets/images/invite_grp.svg'),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, size: 18, color: Colors.grey[700]),
    );
  }
}
