import 'package:flutter/material.dart';
import 'dart:ui';

class TicketInclusionModal extends StatefulWidget {
  const TicketInclusionModal({super.key});

  @override
  State<TicketInclusionModal> createState() => _TicketInclusionModalState();
}

class _TicketInclusionModalState extends State<TicketInclusionModal> {
  // Track which sections are expanded
  Set<String> expandedSections = {'breads'}; // Breads expanded by default

  // Sample data for each category
  final Map<String, List<String>> inclusionData = {
    'breads': [
      'Paneer Tikka',
      'Veg Spring Rolls',
      'Chicken Tikka',
      'Crispy Corn',
      'Fish Fingers',
    ],
    'main_course': [
      'Butter Chicken',
      'Dal Makhani',
      'Paneer Butter Masala',
      'Biryani',
      'Naan',
    ],
    'desserts': ['Gulab Jamun', 'Ice Cream', 'Brownie', 'Rasgulla'],
    'drinks': ['Soft Drinks', 'Fresh Juice', 'Mocktails', 'Water'],
  };

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    // Drag handle
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Color(0xffD0D0D0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Title
                    Text(
                      'Ticket Inclusion',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff070707),
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
                    children: [
                      _buildExpandableSection(
                        'breads',
                        'Breads',
                        inclusionData['breads']!,
                      ),
                      const SizedBox(height: 12),
                      _buildExpandableSection(
                        'main_course',
                        'Main Course:',
                        inclusionData['main_course']!,
                      ),
                      const SizedBox(height: 12),
                      _buildExpandableSection(
                        'desserts',
                        'Desserts:',
                        inclusionData['desserts']!,
                      ),
                      const SizedBox(height: 12),
                      _buildExpandableSection(
                        'drinks',
                        'Drinks:',
                        inclusionData['drinks']!,
                      ),
                      const SizedBox(height: 16),
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

  Widget _buildExpandableSection(String id, String title, List<String> items) {
    final isExpanded = expandedSections.contains(id);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () {
              print('Tapped on section: $id');
              print('Before - isExpanded: $isExpanded');
              print('Before - expandedSections: $expandedSections');
              setState(() {
                if (expandedSections.contains(id)) {
                  expandedSections.remove(id);
                } else {
                  expandedSections.add(id);
                }
              });
              print('After - expandedSections: $expandedSections');
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff070707),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Color(0xff070707),
                    size: 24,
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          if (isExpanded) ...[
            Divider(height: 1, color: Color(0xffE0E0E0)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Color(0xff070707),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4F4F4F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
