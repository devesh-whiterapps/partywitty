
// // 1. Extend the Domain Entity
// import '../../domain/entities/feed/feed_event.dart';

// class EventItemModel extends EventItem {
  
//   EventItemModel({
//     required super.id,
//     required super.type,
//     required super.component,
//     required super.name,
//     required super.eventDate,
//     required super.imageUrl,
//   });

//   // 2. Add the JSON parsing logic here
//   factory EventItemModel.fromJson(Map<String, dynamic> json) {
//     final data = json['data'] ?? {};
    
//     return EventItemModel(
//       id: json['id'].toString(),
//       type: json['type'],
//       component: json['component'],
//       // Access nested data safely
//       name: data['name'] ?? '',
//       eventDate: data['event_date'] ?? '',
//       imageUrl: data['image'] ?? '',
//     );
//   }
// }