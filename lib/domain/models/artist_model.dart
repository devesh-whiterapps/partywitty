/// Artist model representing an artist/performer
class ArtistModel {
  final String id;
  final String name;
  final String imageUrl;
  final String role; // Artist, Performer, etc.

  ArtistModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.role,
  });
}

