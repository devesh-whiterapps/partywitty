import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/models/event_model.dart';

/// Banner type for the image section
enum BannerType {
  dateTimeWithType, // Date + Time + Type badge (carnival cards)
  dateTimeOnly, // Date + Time only (event cards)
  venueType, // "Lowest Price | Recommended" (venue listing)
  package, // "Highest Price | Recommended" (package cards)
  none, // No banner
}

/// Reusable image section with configurable banner overlays
class CardImageSection extends StatefulWidget {
  final EventModel event;
  final String imagePath;
  final bool showFilterBadge;
  final BannerType bannerType;
  final String? typeBadgeText;
  final VoidCallback? onBookmark;
  final VoidCallback? onShare;

  const CardImageSection({
    super.key,
    required this.event,
    required this.imagePath,
    this.showFilterBadge = false,
    this.bannerType = BannerType.dateTimeWithType,
    this.typeBadgeText,
    this.onBookmark,
    this.onShare,
  });

  @override
  State<CardImageSection> createState() => _CardImageSectionState();
}

class _CardImageSectionState extends State<CardImageSection> {
  bool _isHeartFilled = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main image
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                widget.imagePath,
                width: double.infinity,
                height: 306,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 306,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.image, size: 48)),
                ),
              ),
            ),
          ),

          // Filter badge (top left)
          if (widget.showFilterBadge)
            Positioned(top: 16, left: 18, child: _buildFilterBadge()),

          // Bookmark & Share icons (top right)
          Positioned(
            top: 16,
            right: 18,
            child: Row(
              children: [
                _buildIconButton(
                  child: _isHeartFilled
                      ? const Icon(
                          Icons.favorite,
                          size: 18,
                          color: Color(0xff7464E4),
                        )
                      : SvgPicture.asset(
                          'assets/icons/Heart.svg',
                          width: 18,
                          height: 18,
                          colorFilter: const ColorFilter.mode(
                            Color(0xff4F4F4F),
                            BlendMode.srcIn,
                          ),
                        ),
                  onTap: () {
                    setState(() {
                      _isHeartFilled = !_isHeartFilled;
                    });
                    widget.onBookmark?.call();
                  },
                ),
                const SizedBox(width: 8),
                _buildIconButton(
                  child: SvgPicture.asset(
                    'assets/icons/fi-rr-share.svg',
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      Color(0xff4F4F4F),
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: widget.onShare,
                ),
              ],
            ),
          ),

          // Bottom banner
          if (widget.bannerType != BannerType.none)
            Positioned(
              bottom: widget.bannerType == BannerType.venueType ? -18 : -30,
              left: 0,
              right: 0,
              child: _buildBanner(),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterBadge() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/filter.svg',
          width: 18,
          height: 18,
          colorFilter: const ColorFilter.mode(
            Color(0xff7464E4),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({required Widget child, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Center(child: child),
      ),
    );
  }

  Widget _buildBanner() {
    switch (widget.bannerType) {
      case BannerType.dateTimeWithType:
        return _buildDateTimeBanner(showType: true);
      case BannerType.dateTimeOnly:
        return _buildDateTimeBanner(showType: false);
      case BannerType.venueType:
        return _buildVenueTypeBanner();
      case BannerType.package:
        return _buildPackageBanner();
      case BannerType.none:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDateTimeBanner({bool showType = false}) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                'assets/images/tilted_container.png',
                width: 200,
                height: 90,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 200,
                  height: 90,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff7464E4), Color(0xff1A00D2)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '${widget.event.date} | ${widget.event.time}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      '${widget.event.date} | ${widget.event.time}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (showType) ...[
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  'assets/icons/carnival_container.png',
                  width: 100,
                  height: 70,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 100,
                    height: 70,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff7464E4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.celebration,
                          size: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.typeBadgeText ?? 'New Year',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/celebration.png',
                            width: 13,
                            height: 13,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.typeBadgeText ?? 'Carnival',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVenueTypeBanner() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 240),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background image
            Image.asset(
              'assets/images/Rectangle 34624280.png',
              width: 240,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFF4E04D), Color(0xFFDBF658)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            // Text overlay
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lowest Price',
                    style: GoogleFonts.lexend(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff070707),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      '|',
                      style: TextStyle(color: Color(0xff070707)),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/logo/logo.svg',
                    width: 14,
                    height: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Recommended',
                    style: GoogleFonts.lexend(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff070707),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageBanner() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background image (not tilted)
          Image.asset(
            'assets/images/tilted_container.png',
            width: 240,
            height: 90,
            fit: BoxFit.fitWidth,
            errorBuilder: (context, error, stackTrace) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff7464E4), Color(0xff1A00D2)],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          // Text overlay
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Highest Price',
                  style: GoogleFonts.lexend(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text('|', style: TextStyle(color: Colors.white)),
                ),
                SvgPicture.asset('assets/logo/logo.svg', width: 14, height: 14),
                const SizedBox(width: 4),
                Text(
                  'Recommended',
                  style: GoogleFonts.lexend(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
