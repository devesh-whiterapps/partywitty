import 'package:flutter/material.dart';
import 'dart:ui';

class SortModal extends StatefulWidget {
  const SortModal({super.key});

  @override
  State<SortModal> createState() => _SortModalState();
}

class _SortModalState extends State<SortModal> {
  String? selectedSort;

  final List<Map<String, String>> sortOptions = [
    {'id': 'price_low_high', 'label': 'Price: Low To High'},
    {'id': 'distance', 'label': 'Distance (Nearest First)'},
    {'id': 'top_rated', 'label': 'Top Rated (Reviews)'},
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4),
        topRight: Radius.circular(4),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.75)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  // color: Colors.white,
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
                        color: Color(0xFF4F4F4F),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Title
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff070707),
                      ),
                    ),
                  ],
                ),
              ),

              // Sort options
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ...sortOptions.map(
                      (option) =>
                          _buildSortOption(option['id']!, option['label']!),
                    ),
                    const SizedBox(height: 16),

                    // Apply button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Apply sort and close
                          Navigator.pop(context, selectedSort);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff7464E4),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Apply',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Clear All button
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedSort = null;
                        });
                      },
                      child: Text(
                        'Clear All',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffFF5252),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSortOption(String id, String label) {
    final isSelected = selectedSort == id;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSort = id;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xff7464E4) : Color(0xffE0E0E0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isSelected ? Color(0xff7464E4) : Color(0xFF4F4F4F),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Color(0xff7464E4) : Color(0xFF4F4F4F),
                  width: 2,
                ),
                color: isSelected ? Color(0xff7464E4) : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
