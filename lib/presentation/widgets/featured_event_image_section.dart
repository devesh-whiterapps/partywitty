import 'package:flutter/material.dart';
import '../../domain/models/event_model.dart';

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
            left: (MediaQuery.of(context).size.width - 330) / 2,
            child: Container(
              padding: const EdgeInsets.only(bottom: 0),
              child: Row(
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

                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        'assets/icons/carnival_container.png',
                        width: 100,
                        height: 70,
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/celebration.png',
                                  width: 13,
                                  height: 13,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Carnival',
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
                  // Image.asset(
                  //   'assets/icons/carnival_container.png',
                  //   width: 120,
                  //   height: 90,
                  // ),
                  // Container(
                  //   width: 100,
                  //   height: 90,
                  //   padding: const EdgeInsets.all(0.0),
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage(
                  //         'assets/icons/carnival_container.png',
                  //       ),
                  //       // fit: BoxFit
                  //       //     .cover, // or BoxFit.fill, BoxFit.contain, etc.
                  //     ),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Image.asset(
                  //         'assets/icons/celebration.png',
                  //         width: 13,
                  //         height: 13,
                  //       ),
                  //       const SizedBox(width: 4),
                  //       Text(
                  //         'Carnival',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 13,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
