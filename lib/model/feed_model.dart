class FeedItem {
  final String name;
  final String username;
  final int hoursSince; // Represents "since(time in hrs)"
  final String? subtitle;
  final bool isAd;
  final String? caption;
  
  /// Only populated if [isAd] is true
  final DateTime? adDateTime; 
  
  /// Logic: The item usually has EITHER a videoUrl OR a list of imageUrls
  final String? videoUrl;
  final List<String>? imageUrls;

  // Stats
  final int commentCount;
  final int likeCount;
  final int followerCount;

  FeedItem({
    required this.name,
    required this.username,
    required this.hoursSince,
    this.subtitle,
    required this.isAd,
    this.caption,
    this.adDateTime,
    this.videoUrl,
    this.imageUrls,
    this.commentCount = 0,
    this.likeCount = 0,
    this.followerCount = 0,
  }) : assert(
         // valid: isAd is false OR (isAd is true AND adDateTime is not null)
         !isAd || (isAd && adDateTime != null),
         'If isAd is true, adDateTime must be provided.',
       );

  // ---------------------------------------------------------------------------
  // Helper Getters (Optional but useful)
  // ---------------------------------------------------------------------------
  
  bool get hasVideo => videoUrl != null && videoUrl!.isNotEmpty;
  bool get hasImages => imageUrls != null && imageUrls!.isNotEmpty;

  // ---------------------------------------------------------------------------
  // JSON Serialization
  // ---------------------------------------------------------------------------

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
      name: json['name'] as String,
      username: json['username'] as String,
      hoursSince: json['since'] as int,
      subtitle: json['subtitle'] as String?,
      isAd: json['isAd'] as bool? ?? false, // Defaults to false if null
      caption: json['caption'] as String?,
      adDateTime: json['dateTime'] != null 
          ? DateTime.parse(json['dateTime'] as String) 
          : null,
      videoUrl: json['videoUrl'] as String?,
      imageUrls: (json['imgUrl'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      commentCount: json['comment'] as int? ?? 0,
      likeCount: json['like'] as int? ?? 0,
      followerCount: json['followers'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'since': hoursSince,
      'subtitle': subtitle,
      'isAd': isAd,
      'caption': caption,
      'dateTime': adDateTime?.toIso8601String(),
      'videoUrl': videoUrl,
      'imgUrl': imageUrls,
      'comment': commentCount,
      'like': likeCount,
      'followers': followerCount,
    };
  }
}