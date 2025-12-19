import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/sections/card_ticket_section.dart';

/// Function to show General Pass Options as a popup modal
void showGeneralPassOptionsModal(
  BuildContext context, {
  String eventName = 'Sitar Night –  Music x Vibes',
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
    this.eventName = 'Sitar Night –  Music x Vibes',
    this.eventDate = '26 DEC 25',
    this.eventTime = '07:30 PM',
  });

  @override
  State<GeneralPassOptionsModal> createState() =>
      _GeneralPassOptionsModalState();
}

class _GeneralPassOptionsModalState extends State<GeneralPassOptionsModal> {
  int _selectedTabIndex = 0; // Default to "Unlimited F&B Pass"

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
        topLeft: Radius.circular(4),
        topRight: Radius.circular(4),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.60,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F1).withOpacity(0.68),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                // Drag handle
                Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xff4F4F4F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 14),
                // Event Header Row
                Row(
                  children: [
                    // Event name with icon
                    SvgPicture.asset(
                      'assets/icons/inventory.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF4F4F4F),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 6.95),
                    Expanded(
                      child: Text(
                        widget.eventName,
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF4F4F4F),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Timer with icon
                    SvgPicture.asset(
                      'assets/icons/timer.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF4F4F4F),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 6.95),
                    Text(
                      widget.eventTime,
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4F4F4F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Tab Selection
                Row(
                  children: [
                    _buildTabButton('Unlimited F&B Pass', 0),
                    const SizedBox(width: 10),
                    _buildTabButton('View Table Booking', 1),
                  ],
                ),
                const SizedBox(height: 14),
                // Content based on selected tab
                Expanded(
                  child: _selectedTabIndex == 0
                      ? _buildUnlimitedFBContent()
                      : _buildTableBookingContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF7464E4)
                  : Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isSelected ? Colors.white : const Color(0xFF1C1B1D),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnlimitedFBContent() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
    return const TableBookingHorizontalList();
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

/// Horizontal scrolling table booking cards with indicators
class TableBookingHorizontalList extends StatefulWidget {
  const TableBookingHorizontalList({super.key});

  @override
  State<TableBookingHorizontalList> createState() =>
      _TableBookingHorizontalListState();
}

class _TableBookingHorizontalListState
    extends State<TableBookingHorizontalList> {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> tableOptions = [
    {
      'tableName': 'Table For 3',
      'zone': 'Standard Zone',
      'minSpend': '₹15,000',
      'perPerson': '₹2400/Person',
      'seatingType': 'Standard Seating',
      'features': [
        'Comfortable sofa seating',
        'Basic snacks included',
        'Standard entry',
      ],
      'bookingAmount': '₹3000',
      'bookFor': 'Book for 4',
      'bookingColor': const Color(0xFF3CBD53),
      'bookingBgColor': const Color(0xFF3CBD53).withOpacity(0.1),
    },
    {
      'tableName': 'Table for 8',
      'zone': 'VIP Zone',
      'minSpend': '₹28,000',
      'perPerson': '₹3500/Person',
      'seatingType': 'VIP Lounge Zone',
      'features': [
        'Premium bottle service',
        'Priority entry access',
        'Dedicated server',
      ],
      'bookingAmount': '₹4453',
      'bookFor': 'Book for 8',
      'bookingColor': const Color(0xFFA89D28),
      'bookingBgColor': const Color(0xFFA89D28).withOpacity(0.1),
    },
    {
      'tableName': 'Table For 10',
      'zone': 'Elite Zone',
      'minSpend': '40,000',
      'perPerson': '₹4000/Person',
      'seatingType': 'Elite Stage View',
      'features': [
        'Front stage positioning',
        'Dedicated steward service',
        'Premium cocktails included',
      ],
      'bookingAmount': '₹3000',
      'bookFor': 'Book for 10',
      'bookingColor': const Color(0xFFD4AF37),
      'bookingBgColor': const Color(0xFFD4AF37).withOpacity(0.1),
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                final cardWidth = 282.0 + 10.0; // card width + gap
                final newIndex = (_scrollController.offset / cardWidth).round();
                if (newIndex != _currentIndex &&
                    newIndex >= 0 &&
                    newIndex < tableOptions.length) {
                  setState(() => _currentIndex = newIndex);
                }
              }
              return false;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                children: List.generate(
                  tableOptions.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      right: index < tableOptions.length - 1 ? 10 : 0,
                    ),
                    child: _buildTableCard(tableOptions[index]),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Page indicators
        _buildIndicators(),
      ],
    );
  }

  Widget _buildIndicators() {
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
              tableOptions.length,
              (index) => Container(
                width: index == _currentIndex ? 20 : 5,
                height: 5,
                margin: EdgeInsets.only(
                  right: index < tableOptions.length - 1 ? 5 : 0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF7464E4),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableCard(Map<String, dynamic> data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          width: 282,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Header with image background
              Stack(
                children: [
                  // Background image
                  Container(
                    height: 90,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/view.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Dark overlay (reduced opacity)
                  Container(
                    height: 90,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  // Best Value badge
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3CBD53).withOpacity(0.1),
                          ),
                          child: Text(
                            'Best Value',
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF3CBD53),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Table info with icon
                  Positioned(
                    left: 20,
                    top: 0,
                    bottom: 0,
                    child: Row(
                      children: [
                        // User icon in circle
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/fi-rr-user-add.svg',
                            width: 28,
                            height: 28,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF4F4F4F),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Table name and zone
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data['tableName'],
                              style: GoogleFonts.lexend(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              data['zone'],
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Content section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Minimum Spend row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left - Price info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Minimum Spend',
                                style: GoogleFonts.lexend(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                              Text(
                                data['minSpend'],
                                style: GoogleFonts.lexend(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                              Text(
                                data['perPerson'],
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                            ],
                          ),
                          // Right - Quantity selector
                          _TableQuantitySelector(),
                        ],
                      ),
                      const SizedBox(height: 19),
                      // Seating type
                      Text(
                        data['seatingType'],
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4F4F4F),
                        ),
                      ),
                      const SizedBox(height: 9),
                      // Features list
                      ...List.generate(
                        (data['features'] as List<String>).length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '•  ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF4F4F4F),
                                  height: 1.7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  (data['features'] as List<String>)[index],
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF4F4F4F),
                                    height: 1.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom booking amount bar
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(color: data['bookingBgColor']),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BOOKING AMOUNT',
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: data['bookingColor'],
                          ),
                        ),
                        const SizedBox(width: 11),
                        Text(
                          data['bookingAmount'],
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: data['bookingColor'],
                          ),
                        ),
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
}

/// Screen to display all General Pass options (kept for backward compatibility)
class GeneralPassOptionsScreen extends StatefulWidget {
  final String eventName;
  final String eventDate;
  final String eventTime;

  const GeneralPassOptionsScreen({
    super.key,
    this.eventName = 'Sitar Night –  Music x Vibes',
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

/// Quantity selector widget for table bookings (- 01 +)
class _TableQuantitySelector extends StatefulWidget {
  const _TableQuantitySelector();

  @override
  State<_TableQuantitySelector> createState() => _TableQuantitySelectorState();
}

class _TableQuantitySelectorState extends State<_TableQuantitySelector> {
  int _quantity = 1;

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Minus button (circular)
        GestureDetector(
          onTap: _decrement,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
            ),
            alignment: Alignment.center,
            child: Text(
              '−',
              style: GoogleFonts.lexend(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: const Color(0xff4F4F4F),
              ),
            ),
          ),
        ),
        // Quantity display
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            _quantity.toString().padLeft(2, '0'),
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xff4F4F4F),
            ),
          ),
        ),
        // Plus button (circular)
        GestureDetector(
          onTap: _increment,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
            ),
            alignment: Alignment.center,
            child: Text(
              '+',
              style: GoogleFonts.lexend(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: const Color(0xff4F4F4F),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
