import 'package:flutter/material.dart';
import '../../domain/models/event_model.dart';

/// Featured event card with large image
class FeaturedEventCard extends StatelessWidget {
  final EventModel event;

  const FeaturedEventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Event image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purple[400]!,
                    Colors.blue[400]!,
                    Colors.orange[400]!,
                  ],
                ),
              ),
              child: _buildEventImageContent(),
            ),
          ),
          // Top icons
          Positioned(
            top: 12,
            right: 12,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.bookmark_border, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Bottom banner
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomBanner(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventImageContent() {
    return Stack(
      children: [
        // Background pattern with galaxy effect
        Positioned.fill(
          child: CustomPaint(
            painter: _GalaxyPainter(),
          ),
        ),
        // Text content on left
        Positioned(
          top: 50,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.venue.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'DESI TECHNO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  height: 1.0,
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -6),
                child: const Text(
                  'tuesdays',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Decorative figure on right (simplified woman silhouette)
        Positioned(
          right: 30,
          top: 50,
          child: CustomPaint(
            size: const Size(100, 160),
            painter: _WomanSilhouettePainter(),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.purple[700],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${event.date} | ${event.time}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Icon(Icons.local_activity, color: Colors.white, size: 18),
              const SizedBox(width: 4),
              Text(
                event.type,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Custom painter for galaxy/light trail effect
class _GalaxyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 25);

    // Draw swirling light trails in purple, blue, and orange
    final colors = [
      Colors.purple.withValues(alpha: 0.4),
      Colors.blue.withValues(alpha: 0.4),
      Colors.orange.withValues(alpha: 0.4),
    ];

    for (int i = 0; i < 8; i++) {
      paint.color = colors[i % 3];
      final x = size.width * (0.1 + (i * 0.12));
      final y = size.height * (0.2 + (i % 3) * 0.25);
      canvas.drawCircle(
        Offset(x, y),
        size.width * 0.12,
        paint,
      );
    }

    // Additional smaller light particles
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
    for (int i = 0; i < 12; i++) {
      paint.color = colors[i % 3].withValues(alpha: 0.3);
      canvas.drawCircle(
        Offset(
          size.width * (0.15 + (i * 0.07)),
          size.height * (0.3 + (i % 4) * 0.2),
        ),
        size.width * 0.06,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for woman silhouette
class _WomanSilhouettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withValues(alpha: 0.25);

    // Head (circle)
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.15),
      size.width * 0.15,
      paint,
    );

    // Body (rounded rectangle)
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.3,
        size.height * 0.3,
        size.width * 0.4,
        size.height * 0.5,
      ),
      const Radius.circular(20),
    );
    canvas.drawRRect(bodyRect, paint);

    // Saree/Lehenga flow (curved shape)
    final path = Path();
    path.moveTo(size.width * 0.3, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.9,
      size.width * 0.7,
      size.height * 0.8,
    );
    path.lineTo(size.width * 0.7, size.height);
    path.lineTo(size.width * 0.3, size.height);
    path.close();
    canvas.drawPath(path, paint);

    // Bindi (small circle on head)
    paint.color = Colors.white.withValues(alpha: 0.4);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.12),
      size.width * 0.03,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

