import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/sections/card_ticket_section.dart';
import '../widgets/sections/card_table_booking_section.dart';

/// Function to show General Pass Options as a popup modal
void showGeneralPassOptionsModal(
  BuildContext context, {
  String eventName = 'Sitar Night - Music x Vibes',
  String eventDate = '26 DEC 25',
  String eventTime = '07:30 PM',
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => GeneralPassOptionsModal(
      eventName: eventName,
      eventDate: eventDate,
      eventTime: eventTime,
    ),
  );
}

/// Modal widget to display all General Pass options
class GeneralPassOptionsModal extends StatefulWidget {
  final String eventName;
  final String eventDate;
  final String eventTime;

  const GeneralPassOptionsModal({
    super.key,
    this.eventName = 'Sitar Night - Music x Vibes',
    this.eventDate = '26 DEC 25',
    this.eventTime = '07:30 PM',
  });

  @override
  State<GeneralPassOptionsModal> createState() =>
      _GeneralPassOptionsModalState();
}

class _GeneralPassOptionsModalState extends State<GeneralPassOptionsModal> {
  int _selectedTabIndex = 0;

  // Pass options data
  final List<Map<String, dynamic>> passOptions = [
    {
      'title': 'General Pass (Domestic Liquor & Food) || Single',
      'bookingAmount': '₹3000',
      'mrpPrice': 'MRP-₹20000',
      'totalPrice': '₹18000/Person',
      'dateTime': '26 DEC 25 - 10:00 PM ONWARDS',
    },
    {
      'title': 'General Pass (Imported Liquor & Food) || Single',
      'bookingAmount': '₹5000',
      'mrpPrice': 'MRP-₹25000',
      'totalPrice': '₹22000/Person',
      'dateTime': '26 DEC 25 - 10:00 PM ONWARDS',
    },
    {
      'title': 'General Pass (Premium Liquor & Food) || Couple',
      'bookingAmount': '₹8000',
      'mrpPrice': 'MRP-₹35000',
      'totalPrice': '₹30000/Couple',
      'dateTime': '26 DEC 25 - 10:00 PM ONWARDS',
    },
    {
      'title': 'General Pass (VVIP Liquor & Food) || Single',
      'bookingAmount': '₹12000',
      'mrpPrice': 'MRP-₹45000',
      'totalPrice': '₹40000/Person',
      'dateTime': '26 DEC 25 - 10:00 PM ONWARDS',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Color(0xFFC3C3C3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xff4F4F4F),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            // Event Header with background
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(color: Color(0xFFD6D6D6)),
              child: Row(
                children: [
                  // Calendar Icon
                  SvgPicture.asset(
                    'assets/icons/inventory.svg',
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF4F4F4F),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Event Name
                  Expanded(
                    child: Text(
                      widget.eventName,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF070707),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Timer Icon
                  SvgPicture.asset(
                    'assets/icons/timer.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF4F4F4F),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Time
                  Text(
                    widget.eventTime,
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF070707),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Tab Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildTabButton('Unlimited F&B Pass', 0),
                  const SizedBox(width: 12),
                  _buildTabButton('View Table Booking', 1),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Content based on selected tab
            Expanded(
              child: _selectedTabIndex == 0
                  ? _buildUnlimitedFBContent()
                  : _buildTableBookingContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF7464E4) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF7464E4)
                  : const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF4F4F4F),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnlimitedFBContent() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      itemCount: passOptions.length,
      itemBuilder: (context, index) {
        final pass = passOptions[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CardTicketSection(
            passTitle: pass['title'],
            bookingAmount: pass['bookingAmount'],
            pricePerPerson: '/Person',
            mrpPrice: pass['mrpPrice'],
            totalPrice: pass['totalPrice'],
            dateTime: pass['dateTime'],
            onTap: () {
              // Handle ticket selection
              Navigator.pop(context);
              _showTicketConfirmation(context, pass);
            },
            onInclusionsTap: () {
              // Show inclusions modal
              _showInclusionsModal(context, pass);
            },
          ),
        );
      },
    );
  }

  Widget _buildTableBookingContent() {
    return const CardTableBookingListSection(tableCount: 2, height: 360);
  }

  void _showTicketConfirmation(
    BuildContext context,
    Map<String, dynamic> pass,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: ${pass['title']}'),
        backgroundColor: const Color(0xFF7464E4),
      ),
    );
  }

  void _showInclusionsModal(BuildContext context, Map<String, dynamic> pass) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xff4F4F4F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        'Inclusions',
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Inclusions List
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      _buildInclusionItem(
                        'assets/icons/inventory.svg',
                        '3 Starters',
                      ),
                      _buildInclusionItem(
                        'assets/icons/inventory.svg',
                        '2 Main Course',
                      ),
                      _buildInclusionItem(
                        'assets/icons/inventory.svg',
                        'Unlimited Beverages',
                      ),
                      _buildInclusionItem(
                        'assets/icons/timer.svg',
                        'Entry from 10:00 PM Onwards',
                      ),
                      _buildInclusionItem(
                        'assets/icons/inventory.svg',
                        'Complimentary Dessert',
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

  Widget _buildInclusionItem(String iconPath, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: const ColorFilter.mode(
                Color(0xFF7464E4),
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Screen to display all General Pass options (kept for backward compatibility)
class GeneralPassOptionsScreen extends StatefulWidget {
  final String eventName;
  final String eventDate;
  final String eventTime;

  const GeneralPassOptionsScreen({
    super.key,
    this.eventName = 'Sitar Night - Music x Vibes',
    this.eventDate = '26 DEC 25',
    this.eventTime = '07:30 PM',
  });

  @override
  State<GeneralPassOptionsScreen> createState() =>
      _GeneralPassOptionsScreenState();
}

class _GeneralPassOptionsScreenState extends State<GeneralPassOptionsScreen> {
  @override
  void initState() {
    super.initState();
    // Show the modal immediately when this screen is pushed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context); // Pop this screen
      showGeneralPassOptionsModal(
        context,
        eventName: widget.eventName,
        eventDate: widget.eventDate,
        eventTime: widget.eventTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.shrink(),
    );
  }
}
