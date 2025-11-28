
import '../../domain/entities/feed/feed_event.dart';
import '../../domain/entities/feed/feed_item.dart';




class FeedItemModel {
  static FeedItem fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    final component = json['component'];
    final id = json['id'];
    
    // The inner 'data' field structure changes based on type
    final dynamic innerData = json['data'];

    switch (type) {
      case 'event':
        return EventItem(
          id: id,
          type: type,
          component: component,
          name: innerData['name'] ?? '',
          eventDate: innerData['event_date'] ?? '',
          imageUrl: innerData['image'] ?? '',
        );
      
      case 'teaser':
        return TeaserItem(
          id: id,
          type: type,
          component: component,
          title: innerData['title'] ?? '',
          videoUrl: innerData['video'] ?? '',
        );

      case 'package':
        // Handle list inside data
        final List<dynamic> pkgs = innerData ?? [];
        return PackageItem(
          id: id,
          type: type,
          component: component,
          packages: pkgs.map((e) => SubPackage(
            id: e['id'],
            name: e['name'],
            img: e['img'],
          )).toList(),
        );

      case 'gallery':
         // Handle list of objects with 'img' key
         final List<dynamic> imgs = innerData['images'] ?? [];
         return GalleryItem(
           id: id,
           type: type,
           component: component,
           images: imgs.map((e) => e['img'].toString()).toList(),
         );

      default:
        // Fallback or throw exception for unknown types
        throw FormatException("Unknown type: $type");
    }
  }
}