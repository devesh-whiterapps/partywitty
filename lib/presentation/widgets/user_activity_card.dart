import 'package:flutter/material.dart';
import '../../domain/models/user_activity_model.dart';

/// User activity card showing recent activities with stacked avatars
class UserActivityCard extends StatelessWidget {
  final List<UserActivityModel> users;

  const UserActivityCard({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Stacked user avatars
          _buildStackedAvatars(),
          const SizedBox(width: 12),
          // Activity text
          Expanded(
            child: Text(
              '${users.first.name} +${users.length - 1} more Attended a party here last m...',
              style: const TextStyle(fontSize: 13, color: Colors.black87),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackedAvatars() {
    final displayCount = 3; // Always show 3 stacked images
    final avatarSize = 24.0;
    final overlap = 10.0; // How much each avatar overlaps the previous one
    final totalWidth = (displayCount * overlap) + (avatarSize - overlap);

    return SizedBox(
      height: avatarSize,
      width: totalWidth,
      child: Stack(
        children: [
          // Display exactly 3 stacked images
          ...List.generate(
            displayCount,
            (index) => Positioned(
              left: index * overlap,
              child: _CircularAvatarWithBorder(
                size: avatarSize,

                borderColor:
                    Colors.grey[200]!, //  borderColor: _getBorderColor(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBorderColor(int index) {
    final colors = [
      Colors.purple[300]!,
      Colors.purple[400]!,
      Colors.purple[500]!,
      Colors.purple[600]!,
    ];
    return colors[index % colors.length];
  }
}

/// Circular avatar with border for stacked display
class _CircularAvatarWithBorder extends StatelessWidget {
  final double size;
  final Color borderColor;

  const _CircularAvatarWithBorder({
    required this.size,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/Ellipse 4.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback if image fails to load
            return Container(
              color: Colors.grey[300],
              child: const Icon(Icons.person, size: 12, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }
}
