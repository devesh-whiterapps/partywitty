import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'event_booking_toggle.dart';

class EventOptionsSwitcher extends StatefulWidget {
  const EventOptionsSwitcher({super.key});

  @override
  State<EventOptionsSwitcher> createState() => _EventOptionsSwitcherState();
}

class _EventOptionsSwitcherState extends State<EventOptionsSwitcher> {
  // Toggle state: false = Ticket Pass, true = Table Options
  bool _showTableOptions = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- HEADER SECTION ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _showTableOptions ? 'Table Options' : 'Ticket Options',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _showTableOptions = !_showTableOptions;
                });
              },
              child: Text(
                _showTableOptions ? 'View Tickets Options' : 'View Table Options',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  color: const Color(0xFF7464E4), // Purple color from screenshot
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // --- CONTENT SECTION ---
        // We use AnimatedSwitcher for a smooth fade transition between views
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _showTableOptions 
              ? _buildTableOptionsList() 
              : _buildTicketPassList(),
        ),

        const SizedBox(height: 15),

        // --- PAGINATION DOTS ---
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                width: index == 0 ? 20 : 8, // Makes the first dot a capsule
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == 0 ? const Color(0xFF7464E4) : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // View 1: The Event Pass Images
  Widget _buildTicketPassList() {
    return SizedBox(
      key: const ValueKey('tickets'),
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/event_pass.png', // Replace with your image
                height: 220,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 220,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  // View 2: The Table Booking Cards
  Widget _buildTableOptionsList() {
    return SizedBox(
      key: const ValueKey('tables'),
      height: 500, // Sufficient height for the TableBookingCard
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          // Table For 4 - Standard Zone
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 320,
              child: TableBookingCard(
                title: 'Table For 4',
                zone: 'Standard Zone',
                price: '15,000',
                perPerson: '2400',
                amount: '3000',
                features: [
                  'Comfortable sofa seating',
                  'Basic snacks included',
                  'Standard entry',
                ],
                hasBestValue: true,
              ),
            ),
          ),
          // Table For 8 - VIP Zone
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 320,
              child: TableBookingCard(
                title: 'Table For 8',
                zone: 'VIP Zone',
                price: '28,000',
                perPerson: '3500',
                amount: '4453',
                features: [
                  'Premium bottle service',
                  'Priority entry access',
                  'Dedicated server',
                ],
                hasBestValue: true,
              ),
            ),
          ),
          // Table For 10 - Elite Zone
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 320,
              child: TableBookingCard(
                title: 'Table For 10',
                zone: 'Elite Zone',
                price: '40,000',
                perPerson: '4000',
                amount: '3000',
                features: [
                  'Front stage positioning',
                  'Dedicated steward service',
                  'Premium cocktails included',
                ],
                hasBestValue: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

