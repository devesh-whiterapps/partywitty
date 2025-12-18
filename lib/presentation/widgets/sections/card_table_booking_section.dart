import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Reusable table booking card widget
class CardTableBookingSection extends StatelessWidget {
  final bool isVIP;
  final String tableName;
  final String zone;
  final String minSpend;
  final String perPerson;
  final String seatingType;
  final List<String> features;
  final String bookingAmount;
  final String? imagePath;
  final VoidCallback? onBookTap;

  const CardTableBookingSection({
    super.key,
    this.isVIP = false,
    this.tableName = 'Table For 4',
    this.zone = 'Standard Zone',
    this.minSpend = '₹15,000',
    this.perPerson = '₹2400/Person',
    this.seatingType = 'Standard Seating',
    this.features = const [
      'Comfortable sofa seating',
      'Basic snacks included',
      'Standard entry',
    ],
    this.bookingAmount = '₹3000',
    this.imagePath = 'assets/images/view.png',
    this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header image with overlay
          _buildHeaderImage(),
          // Content section
          _buildContentSection(),
          const Spacer(),
          // Bottom booking amount bar
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Image.asset(
            imagePath ?? 'assets/images/view.png',
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(height: 100, color: const Color(0xFF1A1A2E));
            },
          ),
        ),
        // Dark gradient overlay
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        // Best Value badge (for non-VIP cards)
        if (!isVIP)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFDBF658),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Best Value',
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff070707),
                ),
              ),
            ),
          ),
        // Table icon and info
        Positioned(
          left: 12,
          bottom: 12,
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.groups_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tableName,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    zone,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Minimum Spend row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Minimum Spend',
                    style: GoogleFonts.lexend(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff4F4F4F),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        minSpend,
                        style: GoogleFonts.lexend(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff070707),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    perPerson,
                    style: GoogleFonts.lexend(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff4F4F4F),
                    ),
                  ),
                ],
              ),
              // Book For X button
              GestureDetector(
                onTap: onBookTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff070707)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Book For 4',
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff070707),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Seating type
          Text(
            seatingType,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xff070707),
            ),
          ),
          const SizedBox(height: 8),
          // Features list
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xff4F4F4F),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    feature,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff4F4F4F),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'BOOKING AMOUNT  ',
            style: GoogleFonts.lexend(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xff3CBD53),
              letterSpacing: 1,
            ),
          ),
          Text(
            bookingAmount,
            style: GoogleFonts.lexend(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xff3CBD53),
            ),
          ),
        ],
      ),
    );
  }
}

/// Paginated table booking cards with page indicator
class CardTableBookingListSection extends StatefulWidget {
  final int tableCount;
  final double height;

  const CardTableBookingListSection({
    super.key,
    this.tableCount = 2,
    this.height = 360,
  });

  @override
  State<CardTableBookingListSection> createState() =>
      _CardTableBookingListSectionState();
}

class _CardTableBookingListSectionState
    extends State<CardTableBookingListSection> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemCount: widget.tableCount,
            itemBuilder: (context, index) {
              final isVIP = index == 1;
              return CardTableBookingSection(
                isVIP: isVIP,
                tableName: 'Table For 4',
                zone: isVIP ? 'VIP Zone' : 'Standard Zone',
                minSpend: isVIP ? '₹28,000' : '₹15,000',
                perPerson: isVIP ? '₹3500/Person' : '₹2400/Person',
                seatingType: isVIP ? 'VIP Lounge Seating' : 'Standard Seating',
                features: isVIP
                    ? ['Premium booths', 'Priority entry', 'Dedicated server']
                    : [
                        'Comfortable sofa seating',
                        'Basic snacks included',
                        'Standard entry',
                      ],
                bookingAmount: isVIP ? '₹5000' : '₹3000',
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Page indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.tableCount,
            (index) => Container(
              width: index == _currentIndex ? 20 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: index == _currentIndex
                    ? const Color(0xFF7464E4)
                    : const Color(0xFFE5E5E5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
