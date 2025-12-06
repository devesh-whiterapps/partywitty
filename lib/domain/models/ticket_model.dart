/// Ticket model for event tickets
class TicketModel {
  final String id;
  final String title;
  final String type; // Single, Couple
  final String category; // Domestic, Imported
  final double price;
  final int quantity;
  final List<String> inclusions;

  TicketModel({
    required this.id,
    required this.title,
    required this.type,
    required this.category,
    required this.price,
    required this.quantity,
    required this.inclusions,
  });
}

