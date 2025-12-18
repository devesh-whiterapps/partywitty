import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/models/user_activity_model.dart';

/// Reusable user activity section showing stacked avatars and activity text
class CardUserActivitySection extends StatelessWidget {
  final List<UserActivityModel> users;
  final EdgeInsetsGeometry padding;

  const CardUserActivitySection({
    super.key,
    required this.users,
    this.padding = const EdgeInsets.only(top: 12, left: 15, right: 15),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          _buildStackedAvatars(),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              '${users.first.name} +${users.length - 1} more Attended a party here last m...',
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xff1c1b1d),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackedAvatars() {
    return SizedBox(
      height: 24,
      width: 52,
      child: Stack(
        children: List.generate(
          3.clamp(0, users.length),
          (index) => Positioned(
            left: index * 12.0,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
                image: const DecorationImage(
                  image: AssetImage('assets/images/Ellipse 4.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
