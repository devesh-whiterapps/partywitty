import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Sliding booking section that swipes between Buy Tickets (purple) and Book Table (yellow-green)
class CardSlidingBookingSection extends StatefulWidget {
  final VoidCallback? onBuyTickets;
  final VoidCallback? onBookTable;

  const CardSlidingBookingSection({
    super.key,
    this.onBuyTickets,
    this.onBookTable,
  });

  @override
  State<CardSlidingBookingSection> createState() =>
      _CardSlidingBookingSectionState();
}

class _CardSlidingBookingSectionState extends State<CardSlidingBookingSection> {
  int _currentPage = 0;
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
          height: 60,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              // Option 1: Purple - Buy Tickets
              _buildPurpleBookingRow(),
              // Option 2: Yellow-green - Book Table
              _buildYellowBookingRow(),
            ],
          ),
        ),
        const SizedBox(height: 6),
        // Page indicator
        _buildPageIndicator(),
      ],
    );
  }

  Widget _buildPurpleBookingRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xff7464E4), Color(0xff1A00D2)],
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Booking',
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                'Amount',
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '₹3000',
                  style: GoogleFonts.lexend(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: '/Person',
                  style: GoogleFonts.lexend(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(width: 1, height: 30, color: Colors.white.withOpacity(0.3)),
          const Spacer(),
          GestureDetector(
            onTap: widget.onBuyTickets,
            child: Row(
              children: [
                Text(
                  'Buy Tickets',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward, size: 14, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYellowBookingRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xffF0CF66), Color(0xffC9EE25)],
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Booking',
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff070707).withOpacity(0.8),
                ),
              ),
              Text(
                'Amount',
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff070707).withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
          Text(
            '₹2385',
            style: GoogleFonts.lexend(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color(0xff070707),
            ),
          ),
          const Spacer(),
          Container(
            width: 1,
            height: 30,
            color: Color(0xff070707).withOpacity(0.2),
          ),
          const Spacer(),
          GestureDetector(
            onTap: widget.onBookTable,
            child: Row(
              children: [
                Text(
                  'Book Table',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff070707),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 14, color: Color(0xff070707)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _currentPage == 0 ? 16 : 4,
            height: 4,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: _currentPage == 0
                  ? const Color(0xff7464E4)
                  : const Color(0xff7464E4).withOpacity(0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            width: _currentPage == 1 ? 16 : 4,
            height: 4,
            decoration: BoxDecoration(
              color: _currentPage == 1
                  ? const Color(0xff7464E4)
                  : const Color(0xff7464E4).withOpacity(0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

/// Gradient button with configurable colors
class CardGradientButton extends StatelessWidget {
  final String text;
  final List<Color> gradientColors;
  final Color textColor;
  final VoidCallback? onPressed;
  final IconData? trailingIcon;
  final Widget? child;

  const CardGradientButton({
    super.key,
    required this.text,
    this.gradientColors = const [Color(0xff7464E4), Color(0xff1A00D2)],
    this.textColor = Colors.white,
    this.onPressed,
    this.trailingIcon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child:
            child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (trailingIcon != null) ...[
                  const SizedBox(width: 4),
                  Icon(trailingIcon, size: 14),
                ],
              ],
            ),
      ),
    );
  }
}

/// Buy Tickets button with price info
class CardBuyTicketsButton extends StatelessWidget {
  final String bookingAmount;
  final String perPerson;
  final String buttonText;
  final VoidCallback? onPressed;

  const CardBuyTicketsButton({
    super.key,
    this.bookingAmount = '₹3000',
    this.perPerson = '/Person',
    this.buttonText = 'Buy Tickets',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xff7464E4), Color(0xff1A00D2)],
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking',
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                'Amount',
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: bookingAmount,
                  style: GoogleFonts.lexend(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: perPerson,
                  style: GoogleFonts.lexend(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(width: 1, height: 24, color: Colors.white.withOpacity(0.3)),
          const Spacer(),
          GestureDetector(
            onTap: onPressed,
            child: Row(
              children: [
                Text(
                  buttonText,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward, size: 14, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Yellow/Green or Purple View Details button
class CardViewDetailsButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPurple; // true for purple gradient, false for yellow-green

  const CardViewDetailsButton({
    super.key,
    this.text = 'View Details',
    this.onPressed,
    this.isPurple = false, // Default to yellow-green
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4),
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: isPurple
                  ? [
                      const Color(0xFF7464E4), // Purple
                      const Color(0xFF1A00D2), // Dark purple
                    ]
                  : [
                      const Color(0xFFF4E04D), // Yellow
                      const Color(0xFFDBF658), // Yellow-green
                    ],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: Text(
              text,
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isPurple ? Colors.white : const Color(0xff000000),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Page indicator dots
class CardPageIndicator extends StatelessWidget {
  final int totalPages;
  final int currentPage;

  const CardPageIndicator({
    super.key,
    this.totalPages = 2,
    this.currentPage = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            totalPages,
            (index) => Container(
              width: index == currentPage ? 16 : 4,
              height: 4,
              margin: EdgeInsets.only(right: index < totalPages - 1 ? 4 : 0),
              decoration: BoxDecoration(
                color: index == currentPage
                    ? const Color(0xff7464E4)
                    : const Color(0xff7464E4).withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Complete sliding price and booking section
class CardSlidingPriceBookingSection extends StatefulWidget {
  final List<PriceBookingOption> options;

  const CardSlidingPriceBookingSection({super.key, required this.options});

  @override
  State<CardSlidingPriceBookingSection> createState() =>
      _CardSlidingPriceBookingSectionState();
}

class _CardSlidingPriceBookingSectionState
    extends State<CardSlidingPriceBookingSection> {
  int _currentPage = 0;
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
          height: 88,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              final option = widget.options[index];
              return _buildPriceBookingCard(option);
            },
          ),
        ),
        const SizedBox(height: 6),
        CardPageIndicator(
          totalPages: widget.options.length,
          currentPage: _currentPage,
        ),
      ],
    );
  }

  Widget _buildPriceBookingCard(PriceBookingOption option) {
    return Column(
      children: [
        // Price header
        _buildPriceHeader(option),
        const SizedBox(height: 8),
        // Booking button
        _buildBookingButton(option),
      ],
    );
  }

  Widget _buildPriceHeader(PriceBookingOption option) {
    return Row(
      children: [
        if (option.mrpPrice != null) ...[
          Text(
            option.mrpPrice!,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: option.isPurple
                  ? const Color(0xff7464E4)
                  : const Color(0xff4CAF50),
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 6),
        ],
        Text(
          option.currentPrice,
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xff070707),
          ),
        ),
        if (option.passType != null) ...[
          const SizedBox(width: 8),
          Text(
            '•',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xff070707),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            option.passType!,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xff070707),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildBookingButton(PriceBookingOption option) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: option.isPurple
              ? [const Color(0xff7464E4), const Color(0xff1A00D2)]
              : [const Color(0xffF0CF66), const Color(0xffC9EE25)],
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Booking',
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: option.isPurple
                      ? Colors.white
                      : const Color(0xff070707).withOpacity(0.8),
                ),
              ),
              Text(
                'Amount',
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: option.isPurple
                      ? Colors.white
                      : const Color(0xff070707).withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: option.bookingAmount,
                  style: GoogleFonts.lexend(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: option.isPurple
                        ? Colors.white
                        : const Color(0xff070707),
                  ),
                ),
                if (option.perPerson != null)
                  TextSpan(
                    text: option.perPerson,
                    style: GoogleFonts.lexend(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: option.isPurple
                          ? Colors.white
                          : const Color(0xff070707),
                    ),
                  ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: 1,
            height: 30,
            color: option.isPurple
                ? Colors.white.withOpacity(0.3)
                : const Color(0xff070707).withOpacity(0.2),
          ),
          const Spacer(),
          GestureDetector(
            onTap: option.onPressed,
            child: Row(
              children: [
                Text(
                  option.buttonText,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: option.isPurple
                        ? Colors.white
                        : const Color(0xff070707),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward,
                  size: 14,
                  color: option.isPurple
                      ? Colors.white
                      : const Color(0xff070707),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Data model for price booking options
class PriceBookingOption {
  final String? mrpPrice; // e.g., "MRP ₹10000"
  final String currentPrice; // e.g., "₹8000/Person"
  final String? passType; // e.g., "General Pass"
  final String bookingAmount; // e.g., "₹3000"
  final String? perPerson; // e.g., "/Person"
  final String buttonText; // e.g., "Buy Tickets" or "Book Table"
  final bool isPurple; // true for purple gradient, false for yellow-green
  final VoidCallback? onPressed;

  const PriceBookingOption({
    this.mrpPrice,
    required this.currentPrice,
    this.passType,
    required this.bookingAmount,
    this.perPerson,
    required this.buttonText,
    this.isPurple = true,
    this.onPressed,
  });
}
