import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/models/artist_model.dart';

/// Reusable artist info section with avatar, name, and role
class CardArtistSection extends StatelessWidget {
  final ArtistModel artist;
  final bool showHeartIcon;

  const CardArtistSection({
    super.key,
    required this.artist,
    this.showHeartIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/user_img.png',
            width: 36,
            height: 36,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 36,
              height: 36,
              color: Colors.grey[300],
              child: const Icon(Icons.person, size: 20),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      artist.name,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff070707),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (showHeartIcon) ...[
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.favorite,
                      size: 16,
                      color: Color(0xff4F4F4F),
                    ),
                  ],
                ],
              ),
              Text(
                artist.role,
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff4F4F4F),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
