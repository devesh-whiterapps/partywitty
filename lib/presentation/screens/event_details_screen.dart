import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partywitty/presentation/widgets/gradient_background.dart';
import 'package:partywitty/presentation/widgets/unified_event_card.dart';
import 'package:partywitty/presentation/widgets/inclusions_dialog.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../../domain/models/ticket_model.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  final ArtistModel artist;
  final double advancePaid;
  final double balanceAmount;

  const EventDetailsScreen({
    super.key,
    required this.event,
    required this.artist,
    required this.advancePaid,
    required this.balanceAmount,
  });

  @override
  Widget build(BuildContext context) {
    // Use the passed event data
    final featuredEvent = event;
    final eventDetails = event;

    // Default tickets - in a real app, these would come from the booking data
    // For now, using sample data based on the event
    final tickets = [
      TicketModel(
        id: '1',
        title: 'General Pass (Domestic Liquor & Food)',
        type: 'Single',
        category: 'Domestic',
        price: 1800,
        // price: event.advancePaid,
        quantity: 1,
        inclusions: event.inclusions,
      ),
      TicketModel(
        id: '2',
        title: 'General Pass (Domestic Liquor & Food)',
        type: 'Couple',
        category: 'Domestic',
        price: event.advancePaid,
        quantity: 2,
        inclusions: event.inclusions,
      ),

      TicketModel(
        id: '1',
        title: 'General Pass (Domestic Liquor & Food)',
        type: 'Single',
        category: 'Domestic',
        price: 1800,
        // price: event.advancePaid,
        quantity: 1,
        inclusions: event.inclusions,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: false,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // AppBar
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
                  'Details',
                  style: GoogleFonts.lexend(
                    color: Color(0xff070707),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: false,
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Payment Section
                        _buildPaymentSection(),
                        const SizedBox(height: 0),

                        UnifiedEventCard(
                          users: null,
                          featuredEvent: featuredEvent,
                          eventDetails: eventDetails,
                          artist: artist,
                          showUserActivity: false,
                          showInclusions: false,
                          showPaymentDetails: false,
                          showOfferButton: false,
                        ),
                        SizedBox(height: 12),
                        // Tickets Pass Section
                        _buildTicketsSection(context, tickets),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.71),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xffF3F4F6), width: 1),
      ),
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(2),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 13.0,
              vertical: 13.0,
            ),
            child: Column(
              children: [
                // QR Code
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color(0xffF8F9FA),
                          borderRadius: BorderRadius.circular(4),
                          // border: Border.all(color: Colors.grey[400]!),
                        ),
                        child: ClipRRect(
                          //  borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            "assets/images/generated_qr.png",
                            width: 176,
                            height: 176,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Generated payment QR',
                        style: TextStyle(
                          color: Color(0xff7464E4),
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Advance Amount
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffECECE9).withValues(alpha: 0.71),
                    //borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Advance Amount',
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff070707),
                        ),
                      ),
                      Spacer(),
                      Text(
                        '₹${advancePaid.toStringAsFixed(0)}',
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff16A34A),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Balance Amount
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffECECE9).withValues(alpha: 0.71),
                    // borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Balance Amount',
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff070707),
                            ),
                          ),
                          Text(
                            '₹${balanceAmount.toStringAsFixed(0)}',
                            style: GoogleFonts.lexend(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff070707),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Row(
                        children: [
                          const SizedBox(width: 12),

                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [Color(0xff7464E4), Color(0xff1A00D2)],
                              ),
                              // borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 8,
                              ),
                              child: Center(
                                child: Text(
                                  'Pay Now',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketsSection(BuildContext context, List<TicketModel> tickets) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tickets Pass',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                ...tickets.map((ticket) => _buildTicketCard(context, ticket)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context, TicketModel ticket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withValues(alpha: 0.1),
        //     blurRadius: 4,
        //     offset: const Offset(0, 2),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${ticket.title} || ${ticket.type}',
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xff4f4f4f),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          // Text(
          //   '₹${ticket.price.toStringAsFixed(0)}',
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.blue[700],
          //   ),
          // ),
          SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '₹${ticket.price.toStringAsFixed(0)}',
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff7464E4),
                    ),
                  ),
                  Text(
                    ' • ',
                    style: TextStyle(fontSize: 25, color: Colors.grey[700]),
                  ),

                  Image.asset(
                    'assets/icons/chair.png',
                    width: 16,
                    height: 16,
                    color: Colors.black.withValues(alpha: 0.9),
                  ),
                  //Icon(Icons.person_outline, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    ticket.quantity.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Row(
              //   children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _showInclusionsDialog(context, ticket);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Inclusions',
                      style: GoogleFonts.lexend(
                        color: Color(0xff7464E4),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text(
                    ' • ',
                    style: TextStyle(fontSize: 25, color: Colors.grey[700]),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'T&C',
                      style: GoogleFonts.lexend(
                        color: Color(0xff7464E4),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
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

  void _showInclusionsDialog(BuildContext context, TicketModel ticket) {
    // Organize inclusions by category
    // In a real app, this would come from the ticket model or API
    // For now, we'll create sample data based on common categories
    final inclusionsByCategory = <String, List<String>>{
      'Starters': ['Paneer Tikka', 'Chicken Wings', 'Spring Rolls'],
      'Main Course': ['Butter Chicken', 'Biryani', 'Dal Makhani', 'Naan'],
      'Desserts': ['Gulab Jamun', 'Ice Cream', 'Brownie'],
      'Drinks': ['Soft Drinks', 'Mocktails', 'Water'],
    };

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          InclusionsDialog(inclusionsByCategory: inclusionsByCategory),
    );
  }
}
