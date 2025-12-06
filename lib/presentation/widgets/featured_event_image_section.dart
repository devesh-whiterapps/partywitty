import 'package:flutter/material.dart';
import '../../domain/models/event_model.dart';

/// Reusable featured event image section widget
/// Shows the event image with overlay elements (bookmark, share, date/time banner)
class FeaturedEventImageSection extends StatelessWidget {
  final EventModel featuredEvent;

  const FeaturedEventImageSection({super.key, required this.featuredEvent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Event image
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 0),
            width: double.infinity,
            height: double.maxFinite,
            child: Image.asset('assets/images/carnival_image.png'),
          ),
          // Top icons
          Positioned(
            top: 25,
            right: 12,
            child: Row(
              children: [
                Image.asset('assets/icons/bookmark.png', width: 26, height: 26),
                const SizedBox(width: 8),
                Image.asset('assets/icons/share.png', width: 26, height: 26),
                const SizedBox(width: 8),
              ],
            ),
          ),
          // Bottom banner with date/time
          Positioned(
            bottom: -28,
            left: 43,
            child: Container(
              padding: const EdgeInsets.only(bottom: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        'assets/images/tilted_container.png',
                        width: 200,
                        height: 90,
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Text(
                              '${featuredEvent.date} | ${featuredEvent.time}',
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
                  Image.asset(
                    'assets/images/carnival_container.png',
                    width: 120,
                    height: 90,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
