import 'feed_item.dart';

class EventItem extends FeedItem {
  final String name;
  final String eventDate;
  final String imageUrl;

  EventItem({
    required super.id,
    required super.type,
    required super.component,
    required this.name,
    required this.eventDate,
    required this.imageUrl,
  });
}

// domain/entities/package_item.dart
// Note: The JSON 'package' type contains a LIST of sub-packages inside "data"
class PackageItem extends FeedItem {
  final List<SubPackage> packages;

  PackageItem({
    required super.id,
    required super.type,
    required super.component,
    required this.packages,
  });
}

class SubPackage {
  final int id;
  final String name;
  final String img;
  
  SubPackage({required this.id, required this.name, required this.img});
}

// domain/entities/teaser_item.dart
class TeaserItem extends FeedItem {
  final String videoUrl;
  final String title;

  TeaserItem({
    required super.id,
    required super.type,
    required super.component,
    required this.videoUrl,
    required this.title,
  });
}

// domain/entities/gallery_item.dart
class GalleryItem extends FeedItem {
  final List<String> images;

  GalleryItem({
    required super.id,
    required super.type,
    required super.component,
    required this.images,
  });
}