/// Event model representing an event in the app
class EventModel {
  final String id;
  final String title;
  final String venue;
  final String location;
  final String imageUrl;
  final String date;
  final String time;
  final String type; // Carnival, Event, etc.
  final double rating;
  final int reviewCount;
  final String eventCategory; // Stand-up Comedy, etc.
  final List<String> inclusions;
  final double advancePaid;
  final double balanceAmount;
  final double distance;

  EventModel({
    required this.id,
    required this.title,
    required this.venue,
    required this.location,
    required this.imageUrl,
    required this.date,
    required this.time,
    required this.type,
    required this.rating,
    required this.reviewCount,
    required this.eventCategory,
    required this.inclusions,
    required this.advancePaid,
    required this.balanceAmount,
    required this.distance,
  });
}

