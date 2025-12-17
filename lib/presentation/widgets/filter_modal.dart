import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  // Selected filters state
  Set<String> selectedQuickFilters = {};
  Set<String> selectedRecommended = {};
  double distanceValue = 24.5;
  Set<int> selectedStars = {};
  Set<String> selectedEventTypes = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff070707),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Apply filters and close
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff7464E4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Apply',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Filter
                  _buildSectionTitle('Quick Filter'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildChip('Counter Bid (4/5)', 'counter_bid'),
                      _buildChip('Social (32)', 'social'),
                      _buildChip('Live Music', 'live_music'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Recommended For You
                  _buildSectionTitle('Recommended For You'),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildRecommendedCard('Lounge', Icons.deck, 'lounge'),
                      _buildRecommendedCard('Clubs', Icons.people, 'clubs'),
                      _buildRecommendedCard(
                        'Resorts',
                        Icons.apartment,
                        'resorts',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Distance
                  _buildSectionTitle('Distance'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Distance bar chart (simplified)
                        Container(
                          height: 80,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(20, (index) {
                              final heights = [
                                40.0,
                                60.0,
                                30.0,
                                70.0,
                                50.0,
                                80.0,
                                45.0,
                                65.0,
                                35.0,
                                55.0,
                                40.0,
                                50.0,
                                60.0,
                                45.0,
                                70.0,
                                30.0,
                                50.0,
                                40.0,
                                60.0,
                                35.0,
                              ];
                              return Container(
                                width: 8,
                                height: heights[index % heights.length],
                                decoration: BoxDecoration(
                                  color: index < 10
                                      ? Color(0xff7464E4)
                                      : Color(0xffD0D0D0),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Slider
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Color(0xff7464E4),
                            inactiveTrackColor: Color(0xffD0D0D0),
                            thumbColor: Color(0xff7464E4),
                            overlayColor: Color(0xff7464E4).withOpacity(0.2),
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 10,
                            ),
                            trackHeight: 4,
                          ),
                          child: Slider(
                            value: distanceValue,
                            min: 0,
                            max: 50,
                            onChanged: (value) {
                              setState(() {
                                distanceValue = value;
                              });
                            },
                          ),
                        ),
                        // Min and Max labels
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Minimum',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff666666),
                                  ),
                                ),
                                Text(
                                  '${distanceValue.toStringAsFixed(1)} KM',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff070707),
                                  ),
                                ),
                              ],
                            ),
                            Column(
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
                                  '50 KM',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff070707),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Review
                  _buildSectionTitle('Review'),
                  const SizedBox(height: 4),
                  Text(
                    'Filter base on customer\'s Review',
                    style: TextStyle(fontSize: 12, color: Color(0xff666666)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStarRating(5),
                      _buildStarRating(4),
                      _buildStarRating(3),
                      _buildStarRating(2),
                      _buildStarRating(1),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Type of Event
                  _buildSectionTitle('Type of Event'),
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xff070707),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff7464E4) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color(0xff7464E4) : Color(0xffE0E0E0),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Color(0xff070707),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedCard(String label, IconData icon, String key) {
    final isSelected = selectedRecommended.contains(key);
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
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xff7464E4) : Color(0xffE0E0E0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? Color(0xff7464E4) : Color(0xff666666),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? Color(0xff7464E4) : Color(0xff070707),
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
          borderRadius: BorderRadius.circular(8),
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
                color: isSelected ? Colors.white : Color(0xff070707),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff7464E4) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color(0xff7464E4) : Color(0xffE0E0E0),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Color(0xff070707),
          ),
        ),
      ),
    );
  }
}
