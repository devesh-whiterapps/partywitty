/// Search result models matching API response
class SearchClub {
  final String id;
  final String name;
  final String address;
  final String profilePic;
  final String category;
  final String clubLat;
  final String clubLong;
  final String cityName;
  final String areaName;
  final String slug;
  final int totalRating;
  final String totalAverageRating;
  final String addon;
  final String discount;
  final String distance;

  SearchClub({
    required this.id,
    required this.name,
    required this.address,
    required this.profilePic,
    required this.category,
    required this.clubLat,
    required this.clubLong,
    required this.cityName,
    required this.areaName,
    required this.slug,
    required this.totalRating,
    required this.totalAverageRating,
    required this.addon,
    required this.discount,
    required this.distance,
  });

  factory SearchClub.fromJson(Map<String, dynamic> json) {
    return SearchClub(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      profilePic: json['profile_pic']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      clubLat: json['clubLat']?.toString() ?? '',
      clubLong: json['clubLong']?.toString() ?? '',
      cityName: json['cityName']?.toString() ?? '',
      areaName: json['areaName']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      totalRating: int.tryParse(json['totalRating']?.toString() ?? '0') ?? 0,
      totalAverageRating: json['totalAverageRating']?.toString() ?? '0',
      addon: json['addon']?.toString() ?? '0',
      discount: json['discount']?.toString() ?? '0',
      distance: json['distance']?.toString() ?? '0',
    );
  }
}

class SearchPackage {
  final String id;
  final String clubId;
  final String title;
  final String packageThumbnail;
  final String clubLogo;
  final String clubName;
  final String address;
  final String clubLat;
  final String clubLong;
  final String cityName;
  final String areaName;
  final String clubSlug;
  final String packageSlug;
  final int totalRating;
  final String totalAverageRating;
  final String distance;

  SearchPackage({
    required this.id,
    required this.clubId,
    required this.title,
    required this.packageThumbnail,
    required this.clubLogo,
    required this.clubName,
    required this.address,
    required this.clubLat,
    required this.clubLong,
    required this.cityName,
    required this.areaName,
    required this.clubSlug,
    required this.packageSlug,
    required this.totalRating,
    required this.totalAverageRating,
    required this.distance,
  });

  factory SearchPackage.fromJson(Map<String, dynamic> json) {
    return SearchPackage(
      id: json['id']?.toString() ?? '',
      clubId: json['club_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      packageThumbnail: json['packageThumbnail']?.toString() ?? '',
      clubLogo: json['clubLogo']?.toString() ?? '',
      clubName: json['clubName']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      clubLat: json['clubLat']?.toString() ?? '',
      clubLong: json['clubLong']?.toString() ?? '',
      cityName: json['cityName']?.toString() ?? '',
      areaName: json['areaName']?.toString() ?? '',
      clubSlug: json['club_slug']?.toString() ?? '',
      packageSlug: json['package_slug']?.toString() ?? '',
      totalRating: int.tryParse(json['totalRating']?.toString() ?? '0') ?? 0,
      totalAverageRating: json['totalAverageRating']?.toString() ?? '0',
      distance: json['distance']?.toString() ?? '0',
    );
  }
}

class SearchEvent {
  final String id;
  final String clubId;
  final String name;
  final String eventDate;
  final String eventTime;
  final String eventEndTime;
  final String category;
  final String image;
  final String video;
  final String clubLogo;
  final String clubName;
  final String address;
  final String clubLat;
  final String clubLong;
  final String cityName;
  final String areaName;
  final String eventSlug1;
  final String eventSlug2;
  final String minPrice;
  final int totalRating;
  final String totalAverageRating;
  final String distance;

  SearchEvent({
    required this.id,
    required this.clubId,
    required this.name,
    required this.eventDate,
    required this.eventTime,
    required this.eventEndTime,
    required this.category,
    required this.image,
    required this.video,
    required this.clubLogo,
    required this.clubName,
    required this.address,
    required this.clubLat,
    required this.clubLong,
    required this.cityName,
    required this.areaName,
    required this.eventSlug1,
    required this.eventSlug2,
    required this.minPrice,
    required this.totalRating,
    required this.totalAverageRating,
    required this.distance,
  });

  factory SearchEvent.fromJson(Map<String, dynamic> json) {
    return SearchEvent(
      id: json['id']?.toString() ?? '',
      clubId: json['club_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      eventDate: json['event_date']?.toString() ?? '',
      eventTime: json['event_time']?.toString() ?? '',
      eventEndTime: json['event_end_time']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      video: json['video']?.toString() ?? '',
      clubLogo: json['clubLogo']?.toString() ?? '',
      clubName: json['clubName']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      clubLat: json['clubLat']?.toString() ?? '',
      clubLong: json['clubLong']?.toString() ?? '',
      cityName: json['cityName']?.toString() ?? '',
      areaName: json['areaName']?.toString() ?? '',
      eventSlug1: json['event_slug1']?.toString() ?? '',
      eventSlug2: json['event_slug2']?.toString() ?? '',
      minPrice: json['min_price']?.toString() ?? '0',
      totalRating: int.tryParse(json['totalRating']?.toString() ?? '0') ?? 0,
      totalAverageRating: json['totalAverageRating']?.toString() ?? '0',
      distance: json['distance']?.toString() ?? '0',
    );
  }
}

class SearchData {
  final List<SearchClub> clubs;
  final List<SearchPackage> packages;
  final List<SearchEvent> events;

  SearchData({
    required this.clubs,
    required this.packages,
    required this.events,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) {
    List<SearchClub> clubs = [];
    List<SearchPackage> packages = [];
    List<SearchEvent> events = [];

    // Parse the data array
    if (json['data'] is List) {
      final dataList = json['data'] as List;
      for (var item in dataList) {
        if (item is Map<String, dynamic>) {
          if (item.containsKey('clubs') && item['clubs'] is List) {
            clubs = (item['clubs'] as List)
                .map(
                  (club) => SearchClub.fromJson(club as Map<String, dynamic>),
                )
                .toList();
          }
          if (item.containsKey('packages') && item['packages'] is List) {
            packages = (item['packages'] as List)
                .map(
                  (pkg) => SearchPackage.fromJson(pkg as Map<String, dynamic>),
                )
                .toList();
          }
          if (item.containsKey('events') && item['events'] is List) {
            events = (item['events'] as List)
                .map(
                  (event) =>
                      SearchEvent.fromJson(event as Map<String, dynamic>),
                )
                .toList();
          }
        }
      }
    }

    return SearchData(clubs: clubs, packages: packages, events: events);
  }
}

class SearchResponse {
  final bool status;
  final String message;
  final SearchData data;

  SearchResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      status: json['status'] ?? false,
      message: json['msg']?.toString() ?? '',
      data: SearchData.fromJson(json),
    );
  }
}

