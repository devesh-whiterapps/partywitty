import 'package:flutter/material.dart';
import 'package:partywitty/presentation/widgets/gradient_background.dart';
import 'package:partywitty/presentation/widgets/unified_event_card.dart';
import 'package:partywitty/presentation/widgets/inclusions_dialog.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../../domain/models/ticket_model.dart';

/// Event details screen with payment QR and ticket options
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

    final tickets = [
      TicketModel(
        id: '1',
        title: 'General Pass (Domestic Liquor & Food)',
        type: 'Single',
        category: 'Domestic',
        price: 1800,
        quantity: 1,
        inclusions: ['3 Starters', '2 Main Course'],
      ),
      TicketModel(
        id: '2',
        title: 'General Pass (Domestic Liquor & Food)',
        type: 'Couple',
        category: 'Domestic',
        price: 1800,
        quantity: 2,
        inclusions: ['3 Starters', '2 Main Course'],
      ),
      TicketModel(
        id: '3',
        title: 'General Pass (Imported Liquor & Food)',
        type: 'Single',
        category: 'Imported',
        price: 1800,
        quantity: 1,
        inclusions: ['3 Starters', '2 Main Course'],
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
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  'Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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

                        // Unified event card - in event details screen:
                        // - No user activity section
                        // - No inclusions, payment details, or offer button (those are shown separately in payment section)
                        UnifiedEventCard(
                          users:
                              null, // Don't show user activity in event details
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 13.0),
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
                      // color: Colors.grey[300],
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                //borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Advance Amount',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '₹${advancePaid.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Balance Amount
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                // borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Balance Amount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        '₹${balanceAmount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildTicketsSection(BuildContext context, List<TicketModel> tickets) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tickets Pass',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            ...tickets.map((ticket) => _buildTicketCard(context, ticket)),
          ],
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${ticket.title} || ${ticket.type}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
                      style: TextStyle(
                        color: Color(0xff7464E4),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
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
                      style: TextStyle(
                        color: Color(0xff7464E4),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
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
