import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtistCard extends StatelessWidget {
  final String artistName;
  final String artistType;
  final double rating;
  final String eventDate;
  final String eventTime;
  final String eventEndTime;
  final List<String> genres;
  final int followers;

  const ArtistCard({
    super.key,
    required this.artistName,
    required this.artistType,
    required this.rating,
    required this.eventDate,
    required this.eventTime,
    required this.eventEndTime,
    required this.genres,
    required this.followers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Artist Image/Video
          Stack(
            children: [
              Container(
                height: 180,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                  image: DecorationImage(
                    image: NetworkImage('https://picsum.photos/320/180'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Overlay
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),

              // Play Button
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 20,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),

          // Artist Details
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF02070D), Color(0xFF030406)],
              ),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Artist Name and Rating
                Row(
                  children: [
                    Text(
                      artistName,
                      style: GoogleFonts.lexend(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Artist Type
                Text(
                  artistType,
                  style: GoogleFonts.lexend(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                // Event Details
                Row(
                  children: [
                    _buildEventDetail('', 'Event', eventDate),
                    const SizedBox(width: 42),
                    _buildEventDetail('⏰', 'Time', eventTime),
                    const SizedBox(width: 42),
                    _buildEventDetail('⏰', 'Event End Time', eventEndTime),
                  ],
                ),
                const SizedBox(height: 10),

                // Genre Tags
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildGenreChip('POP', true),
                      const SizedBox(width: 8),
                      ...genres.map((genre) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _buildGenreChip(genre, false),
                      )),
                      _buildGenreChip('Followers: $followers', false),
                      const SizedBox(width: 8),
                      _buildGenreChip('Book Now', false),
                      const SizedBox(width: 8),
                      _buildGenreChip('Top Rated', false),
                      const SizedBox(width: 8),
                      _buildGenreChip('Available on 30 Jan', false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetail(String emoji, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildGenreChip(String label, bool isPrimary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(isPrimary ? 0.3 : 0.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        label,
        style: GoogleFonts.lexend(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}