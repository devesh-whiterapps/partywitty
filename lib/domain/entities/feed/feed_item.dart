import 'package:partywitty/core/const/api_const.dart';

// abstract class FeedItem {
//   final String id;
//   final String type;
//   final String component;

//   FeedItem({
//     required this.id,
//     required this.type,
//     required this.component,
//   });
// }

class HomeResponse {
  final bool? status;
  final String? msg;
  final List<HomeItemModel>? data;

  HomeResponse({
    this.status,
    this.msg,
    this.data,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        status: json["status"] ?? false,
        msg: json["msg"] ?? "",
        data: (json["data"] as List<dynamic>?)
                ?.map((x) => HomeItemModel.fromJson(x))
                .toList() ??
            [],
      );
}

class HomeItemModel {
  final String? id;
  final String? type;
  final int? uniqueIndex;
  final String? component;
  final dynamic data;

  HomeItemModel({
    this.id,
    this.type,
    this.uniqueIndex,
    this.component,
    this.data,
  });

  factory HomeItemModel.fromJson(Map<String, dynamic> json) => HomeItemModel(
        id: json["id"] ?? "",
        type: json["type"] ?? "",
        uniqueIndex: json["uniqueIndex"] ?? 0,
        component: json["component"] ?? "",
        data: _mapData(json),
      );

  static dynamic _mapData(Map<String, dynamic> json) {
    final component = json["component"];

    switch (component) {
      case "LiveCard":
        return EventModel.fromJson(json["data"] ?? {});
      case "LiveCardVideo":
        return TeaserModel.fromJson(json["data"] ?? {});
      case "PackageCard":
        return (json["data"] as List<dynamic>?)
                ?.map((x) => PackageModel.fromJson(x))
                .toList() ??
            [];
      case "GalleryCard":
        return GalleryModel.fromJson(json["data"] ?? {});
      default:
        return json["data"];
    }
  }
}

class EventModel {
  final int? id;
  final int? clubId;
  final int? categoryId;
  final String? name;
  final String? eventDate;
  final String? eventTime;
  final String? eventEndTime;
  final String? image;
  final String? video;
  final String? eventSlug1;
  final String? eventSlug2;
  final num? minPrice;
  final String? categoryName;
  final String? addon;
  final String? discount;
  final String? clubName;
  final String? clubLogo;
  final String? cityName;
  final String? areaName;
  final String? latitude;
  final String? longitude;
  final String? address;
  final String? slug;
  final String? distance;
  final int? totalLikes;
  final bool? isLiked;
  final bool? isFavourite;

  EventModel({
    this.id,
    this.clubId,
    this.categoryId,
    this.name,
    this.eventDate,
    this.eventTime,
    this.eventEndTime,
    this.image,
    this.video,
    this.eventSlug1,
    this.eventSlug2,
    this.minPrice,
    this.categoryName,
    this.addon,
    this.discount,
    this.clubName,
    this.clubLogo,
    this.cityName,
    this.areaName,
    this.latitude,
    this.longitude,
    this.address,
    this.slug,
    this.distance,
    this.totalLikes,
    this.isLiked,
    this.isFavourite,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"] ?? 0,
        clubId: json["club_id"] ?? 0,
        categoryId: json["category_id"] ?? 0,
        name: json["name"] ?? "",
        eventDate: json["event_date"] ?? "",
        eventTime: json["event_time"] ?? "",
        eventEndTime: json["event_end_time"] ?? "",
        image: ApiConst.assetBaseUrl + json["image"] ?? "",
        video: ApiConst.assetBaseUrl +json["video"] ?? "",
        eventSlug1: json["event_slug1"] ?? "",
        eventSlug2: json["event_slug2"] ?? "",
        minPrice: json["min_price"] ?? 0,
        categoryName: json["categoryName"] ?? "",
        addon: json["addon"] ?? "",
        discount: json["discount"] ?? "",
        clubName: json["clubName"] ?? "",
        clubLogo: ApiConst.assetBaseUrl + json["clubLogo"] ?? "",
        cityName: json["cityName"] ?? "",
        areaName: json["areaName"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        address: json["address"] ?? "",
        slug: json["slug"] ?? "",
        distance: json["distance"] ?? "",
        totalLikes: json["total_likes"] ?? 0,
        isLiked: json["is_liked"] ?? false,
        isFavourite: json["isFavourite"] ?? false,
      );
}

class TeaserModel {
  final int? id;
  final String? clubId;
  final String? category;
  final String? title;
  final String? video;
  final String? date;
  final String? verifyStatus;
  final int? tulips;
  final String? verifiedAt;
  final String? updatedAt;
  final String? deleteStatus;
  final String? clubName;
  final String? clubSlug;
  final String? clubLogo;
  final String? clubAddress;
  final String? cityName;
  final String? areaName;
  final String? latitude;
  final String? longitude;
  final String? addon;
  final String? discount;
  final int? totalLikes;
  final bool? isLiked;
  final bool? isFavourite;
  final MetaModel? meta;

  TeaserModel({
    this.id,
    this.clubId,
    this.category,
    this.title,
    this.video,
    this.date,
    this.verifyStatus,
    this.tulips,
    this.verifiedAt,
    this.updatedAt,
    this.deleteStatus,
    this.clubName,
    this.clubSlug,
    this.clubLogo,
    this.clubAddress,
    this.cityName,
    this.areaName,
    this.latitude,
    this.longitude,
    this.addon,
    this.discount,
    this.totalLikes,
    this.isLiked,
    this.isFavourite,
    this.meta,
  });

  factory TeaserModel.fromJson(Map<String, dynamic> json) => TeaserModel(
        id: json["id"] ?? 0,
        clubId: json["club_id"] ?? "",
        category: json["category"] ?? "",
        title: json["title"] ?? "",
        video: ApiConst.assetBaseUrl + json["video"] ?? "",
        date: json["date"] ?? "",
        verifyStatus: json["verify_status"] ?? "",
        tulips: json["tulips"] ?? 0,
        verifiedAt: json["verified_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deleteStatus: json["delete_status"] ?? "",
        clubName: json["clubName"] ?? "",
        clubSlug: json["clubSlug"] ?? "",
        clubLogo: ApiConst.assetBaseUrl + json["clubLogo"] ?? "",
        clubAddress: json["clubAddress"] ?? "",
        cityName: json["cityName"] ?? "",
        areaName: json["areaName"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        addon: json["addon"] ?? "",
        discount: json["discount"] ?? "",
        totalLikes: json["total_likes"] ?? 0,
        isLiked: json["is_liked"] ?? false,
        isFavourite: json["isFavourite"] ?? false,
        meta: json["meta"] != null ? MetaModel.fromJson(json["meta"]) : null,
      );
}

class MetaModel {
  final String? address;
  final String? slug;

  MetaModel({
    this.address,
    this.slug,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
        address: json["address"] ?? "",
        slug: json["slug"] ?? "",
      );
}

class PackageModel {
  final int? id;
  final String? name;
  final String? img;
  final int? totalPackages;
  final int? totalLikes;
  final bool? isLiked;
  final bool? isFavourite;

  PackageModel({
    this.id,
    this.name,
    this.img,
    this.totalPackages,
    this.totalLikes,
    this.isLiked,
    this.isFavourite,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        img: ApiConst.assetBaseUrl + json["img"] ?? "",
        totalPackages: json["total_packages"] ?? 0,
        totalLikes: json["total_likes"] ?? 0,
        isLiked: json["is_liked"] ?? false,
        isFavourite: json["isFavourite"] ?? false,
      );
}

class GalleryModel {
  final int? clubId;
  final String? clubName;
  final String? clubLogo;
  final String? category;
  final List<GalleryImage>? images;

  GalleryModel({
    this.clubId,
    this.clubName,
    this.clubLogo,
    this.category,
    this.images,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
        clubId: json["club_id"] ?? 0,
        clubName: json["clubName"] ?? "",
        clubLogo: ApiConst.assetBaseUrl +  json["clubLogo"] ?? "",
        category: json["category"] ?? "",
        images: (json["images"] as List<dynamic>?)
                ?.map((x) => GalleryImage.fromJson(x))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "club_id": clubId,
        "clubName": clubName,
        "clubLogo": clubLogo,
        "category": category,
        "images": images?.map((x) => x.toJson()).toList(),
      };
}


class GalleryImage {
  final String? img;

  GalleryImage({this.img});

  factory GalleryImage.fromJson(Map<String, dynamic> json) => GalleryImage(
        img: ApiConst.assetBaseUrl +  json["img"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "img": img,
      };
}

