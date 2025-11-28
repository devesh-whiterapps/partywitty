import 'package:partywitty/model/feed_model.dart';

List<FeedItem> sampleFeed = [
  // 1. Standard Post: Multiple Images (Carousel)
  FeedItem(
    usershared: false,
    name: "Sarah Jenkins",
    username: "@sarah_j_travels",
    hoursSince: 2,
    subtitle: "Travel Vlogger",
    isAd: false,
    caption: "Exploring the hidden gems of Kyoto today! 🌸 The colors are unreal.",
    imageUrls: [
      "https://images.pexels.com/photos/402028/pexels-photo-402028.jpeg",
      "https://images.pexels.com/photos/356807/pexels-photo-356807.jpeg",
    ],
    likeCount: 1240,
    commentCount: 85,
    followerCount: 15000,
  ),

  // 2. Video Post
  FeedItem(
     usershared: true,
    name: "Tech Daily",
    username: "@tech_daily_official",
    hoursSince: 5,
    isAd: false,
    caption: "Unboxing the new Foldable Phone Z. Is it worth the hype?",
    videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4", // Sample flutter video
    likeCount: 4500,
    commentCount: 320,
    followerCount: 102000,
  ),

  // 3. Advertisement: Video Ad
  FeedItem(
     usershared: false,
    name: "Nike",
    username: "@nike",
    hoursSince: 1, // "Sponsored" posts usually appear fresh
    subtitle: "Sponsored",
    isAd: true,
    adDateTime: DateTime.now().add(const Duration(days: 2)), // Event/Sale date
    caption: "Just Do It. The new collection drops this Friday. Set your reminders.",
    videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    likeCount: 15000,
    commentCount: 45, // Ads usually have lower comment/like ratios
    followerCount: 5000000,
  ),

  // 4. Standard Post: Single Image
  FeedItem(
     usershared: false,
    name: "Minimalist Art",
    username: "@minimal_art",
    hoursSince: 12,
    isAd: false,
    caption: "Monday Mood. ☕️",
    imageUrls: [
      "https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg"
    ],
    likeCount: 300,
    commentCount: 12,
    followerCount: 4500,
  ),

  // 5. Advertisement: Image Ad (Sale)
  FeedItem(
     usershared: true,
    name: "Burger King",
    username: "@burgerking",
    hoursSince: 0,
    subtitle: "Sponsored",
    isAd: true,
    adDateTime: DateTime.now().add(const Duration(hours: 5)), // Limited time offer
    caption: "Flash Sale! 50% off all Whoppers for the next 5 hours only.",
    imageUrls: [
      "https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg"
    ],
    likeCount: 8000,
    commentCount: 120,
    followerCount: 230000,
  ),

  // 6. Text-Heavy / Status Update (No media)
  FeedItem(
     usershared: false,
    name: "Elon Musk",
    username: "@elonmusk",
    hoursSince: 1,
    isAd: false,
    caption: "Thinking about rockets again... 🚀 Mars looks nice this time of year.",
    // No videoUrl or imageUrls provided
    likeCount: 54000,
    commentCount: 12000,
    followerCount: 90000000,
  ),
];

class FeedItem {
  final String name;
  final String username;
  final int hoursSince; // Represents "since(time in hrs)"
  final String? subtitle;
  final bool isAd;
   final bool usershared;
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
    required this.usershared,
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
      usershared: json['usershared'] as bool??false
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
      'usershared':usershared
    };
  }
}