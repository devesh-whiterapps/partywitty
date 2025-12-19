import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  // Selected filters state
  Set<String> selectedQuickFilters = {};
  Set<String> selectedRecommended = {};
  RangeValues distanceRange = RangeValues(0, 24.5);
  Set<int> selectedStars = {};
  Set<String> selectedEventTypes = {};

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4),
        topRight: Radius.circular(4),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.77),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 7),
                width: 50,
                height: 6,
                decoration: BoxDecoration(
                  color: Color(0xff4F4F4F),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1C1B1D),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff7464E4),
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff7C3AED).withOpacity(0.2),
                            blurRadius: 6.947,
                            offset: Offset(0, 1.737),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // Apply filters and close
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(3),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 6,
                            ),
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quick Filter
                      _buildSectionTitle('Quick Filter'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildChip('Counter Bid (4/5)', 'counter_bid'),
                          _buildChip('Social (32)', 'social'),
                          _buildChip('Live Music', 'live_music'),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Recommended For You
                      _buildSectionTitle('Recommended For You'),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _buildRecommendedCard(
                              'Jazz',
                              'assets/icons/Hotel.svg',
                              'jazz',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildRecommendedCard(
                              'Clubs',
                              'assets/icons/club.png',
                              'clubs',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildRecommendedCard(
                              'Resorts',
                              'assets/icons/Hotel.svg',
                              'resorts',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Distance
                      _buildSectionTitle('Distance'),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            // Distance bar chart with gradient
                            Container(
                              height: 70,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(19, (index) {
                                  final heights = [
                                    31.0,
                                    44.0,
                                    45.0,
                                    38.0,
                                    17.0,
                                    61.0,
                                    29.0,
                                    52.0,
                                    27.0,
                                    58.0,
                                    37.0,
                                    50.0,
                                    35.0,
                                    37.0,
                                    18.0,
                                    12.0,
                                    22.0,
                                    12.0,
                                    7.0,
                                  ];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: index < 18 ? 4 : 0,
                                    ),
                                    child: Container(
                                      width: 5,
                                      height: heights[index],
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Color(0xff7464E4),
                                            Color(0xff3354F4),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(height: 0),
                            // Range Slider with two pointers
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Color(0xff7464E4),
                                inactiveTrackColor: Color(0xff7464E4),
                                thumbColor: Color(0xff7464E4),
                                overlayColor: Color(
                                  0xff7464E4,
                                ).withOpacity(0.2),
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 8,
                                ),
                                trackHeight: 2,
                                rangeThumbShape: RoundRangeSliderThumbShape(
                                  enabledThumbRadius: 8,
                                ),
                              ),
                              child: RangeSlider(
                                values: distanceRange,
                                min: 0,
                                max: 50,
                                onChanged: (RangeValues values) {
                                  setState(() {
                                    distanceRange = values;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Min and Max labels with white background
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Minimum',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff666666),
                                        ),
                                      ),
                                      Text(
                                        '${distanceRange.start.toStringAsFixed(1)} KM',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff070707),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Maximum',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff666666),
                                        ),
                                      ),
                                      Text(
                                        '${distanceRange.end.toStringAsFixed(1)} KM',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff070707),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // White line separator before Review
                      Container(height: 1, color: Colors.white),
                      const SizedBox(height: 12),

                      // Review
                      _buildSectionTitle('Review'),
                      const SizedBox(height: 2),
                      Text(
                        'Filter base on costumer\'s Review',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff4F4F4F),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStarRating(5),
                          _buildStarRating(4),
                          _buildStarRating(3),
                          _buildStarRating(2),
                          _buildStarRating(1),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // White line separator before Type of Event
                      Container(height: 1, color: Colors.white),
                      const SizedBox(height: 12),

                      // Type of Event
                      _buildSectionTitle('Type of Event'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildEventTypeChip('None', 'none'),
                          _buildEventTypeChip('DJ Night', 'dj_night'),
                          _buildEventTypeChip('EDM Party', 'edm_party'),
                          _buildEventTypeChip('Theme Party', 'theme_party'),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xff21182B),
      ),
    );
  }

  Widget _buildChip(String label, String key) {
    final isSelected = selectedQuickFilters.contains(key);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedQuickFilters.remove(key);
          } else {
            selectedQuickFilters.add(key);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff7464E4) : Colors.white,
          border: Border.all(
            color: isSelected ? Color(0xff7464E4) : Color(0xffE0E0E0),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isSelected ? Colors.white : Color(0xff4F4F4F),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedCard(String label, String assetPath, String key) {
    final isSelected = selectedRecommended.contains(key);
    final isSvg = assetPath.endsWith('.svg');

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedRecommended.remove(key);
          } else {
            selectedRecommended.add(key);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xffEFEFEF),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? Color(0xff7464E4) : Color(0xffEFEFEF),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              child: isSvg
                  ? SvgPicture.asset(assetPath, width: 60, height: 60)
                  : Image.asset(assetPath, width: 60, height: 60),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff4F4F4F),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating(int stars) {
    final isSelected = selectedStars.contains(stars);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedStars.remove(stars);
          } else {
            selectedStars.add(stars);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff7464E4) : Colors.white,
          border: Border.all(
            color: isSelected ? Color(0xff7464E4) : Color(0xffE0E0E0),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$stars',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Color(0xff4F4F4F),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.star,
              size: 16,
              color: isSelected ? Colors.white : Color(0xffFFA500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventTypeChip(String label, String key) {
    final isSelected = selectedEventTypes.contains(key);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedEventTypes.remove(key);
          } else {
            selectedEventTypes.add(key);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff7464E4) : Colors.white,
          border: Border.all(
            color: isSelected ? Color(0xff7464E4) : Color(0xffE0E0E0),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isSelected ? Colors.white : Color(0xff4F4F4F),
          ),
        ),
      ),
    );
  }
}
