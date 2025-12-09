/// Model for Tulips API response
class TulipsModel {
  final int availableTulips;
  final int usableTulips;
  final double tulipValue; // Value of each tulip in rupees

  TulipsModel({
    required this.availableTulips,
    required this.usableTulips,
    required this.tulipValue,
  });

  factory TulipsModel.fromJson(Map<String, dynamic> json) {
    return TulipsModel(
      availableTulips: json['available_tulips'] ?? json['availableTulips'] ?? 0,
      usableTulips: json['usable_tulips'] ?? json['usableTulips'] ?? 0,
      tulipValue: (json['tulip_value'] ?? json['tulipValue'] ?? 1.0).toDouble(),
    );
  }
}

