import 'package:flutter/material.dart';
import '../../domain/models/user_activity_model.dart';

/// Reusable user activity section widget
/// Shows stacked avatars and activity text
class UserActivitySection extends StatelessWidget {
  final List<UserActivityModel> users;

  const UserActivitySection({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 12.0,
        bottom: 0.0,
        left: 12.0,
        right: 12.0,
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
    final displayCount = 3;
    final avatarSize = 24.0;
    final overlap = 10.0;
    final totalWidth = (displayCount * overlap) + (avatarSize - overlap);

    return SizedBox(
      height: avatarSize,
      width: totalWidth,
      child: Stack(
        children: [
          ...List.generate(
            displayCount,
            (index) => Positioned(
              left: index * overlap,
              child: _CircularAvatarWithBorder(
                size: avatarSize,
                borderColor: Colors.grey[200]!,
              ),
            ),
          ),
        ],
      ),
    );
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
