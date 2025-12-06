import 'package:flutter/material.dart';

/// Dialog showing ticket inclusions organized by categories
class InclusionsDialog extends StatefulWidget {
  final Map<String, List<String>> inclusionsByCategory;

  const InclusionsDialog({super.key, required this.inclusionsByCategory});

  @override
  State<InclusionsDialog> createState() => _InclusionsDialogState();
}

class _InclusionsDialogState extends State<InclusionsDialog> {
  final Map<String, bool> _expandedCategories = {};

  @override
  void initState() {
    super.initState();
    // Initialize all categories as collapsed
    for (var category in widget.inclusionsByCategory.keys) {
      _expandedCategories[category] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //  Top indicator
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          // Title
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ticket Inclusion',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // Inclusions list
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CustomPaint(
                  //   painter: _DottedBorderPainter(),
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      children: [
                        // ...widget.inclusionsByCategory.entries
                        //     .toList()
                        //     .asMap()
                        //     .entries
                        //     .map((entry) {
                        //       final index = entry.key;
                        //       final categoryEntry = entry.value;
                        //       final category = categoryEntry.key;
                        //       final items = categoryEntry.value;
                        //       final isExpanded =
                        //           _expandedCategories[category] ?? false;
                        //       final isLast =
                        //           index ==
                        //           widget.inclusionsByCategory.length - 1;

                        //       return _buildCategorySection(
                        //         category: category,
                        //         items: items,
                        //         isExpanded: isExpanded,
                        //         isLast: isLast,
                        //       );
                        //     }),
                        _buildCategorySection(
                          category: 'Starters',
                          items: [
                            'Paneer Tikka',
                            'Chicken Wings',
                            'Spring Rolls',
                          ],
                          isExpanded: false,
                          isLast: false,
                        ),
                        SizedBox(height: 2),
                        _buildCategorySection(
                          category: 'Main Course',
                          items: [
                            'Butter Chicken',
                            'Biryani',
                            'Dal Makhani',
                            'Naan',
                          ],
                          isExpanded: false,
                          isLast: false,
                        ),
                        SizedBox(height: 2),
                        _buildCategorySection(
                          category: 'Desserts',
                          items: ['Gulab Jamun', 'Ice Cream', 'Brownie'],
                          isExpanded: false,
                          isLast: false,
                        ),
                        SizedBox(height: 2),
                        _buildCategorySection(
                          category: 'Drinks',
                          items: ['Soft Drinks', 'Mocktails', 'Water'],
                          isExpanded: false,
                          isLast: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection({
    required String category,
    required List<String> items,
    required bool isExpanded,
    required bool isLast,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _expandedCategories[category] = !isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 14.0,
            ),
            margin: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$category:',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 20,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: CustomPaint(painter: _DottedLinePainter()),
          ),
        if (isExpanded)
          Container(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              top: 8.0,
              bottom: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    '• $item',
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

/// Custom painter for dotted border
class _DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff7464E4)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 3.0;
    const dashSpace = 2.0;
    final radius = 4.0;

    // Draw dotted border around the container
    _drawDottedRect(
      canvas,
      paint,
      Offset(0, 0),
      size,
      radius,
      dashWidth,
      dashSpace,
    );
  }

  void _drawDottedRect(
    Canvas canvas,
    Paint paint,
    Offset offset,
    Size size,
    double radius,
    double dashWidth,
    double dashSpace,
  ) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    final dashPath = _dashPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _dashPath(Path path, double dashWidth, double dashSpace) {
    final dashPath = Path();
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    return dashPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for dotted line
class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 3.0;
    const dashSpace = 2.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
