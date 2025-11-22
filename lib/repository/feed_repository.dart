import 'package:partywitty/model/feed_model.dart';

List<FeedItem> sampleFeed = [
  // 1. Standard Post: Multiple Images (Carousel)
  FeedItem(
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