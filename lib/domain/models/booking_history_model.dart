/// Booking history model matching API response
class BookingHistoryModel {
  final String id;
  final String partyDate;
  final String orderId;
  final String totalAmount;
  final String status;
  final String clubName;
  final String clubId;
  final String latitude;
  final String longitude;
  final String address;
  final String clubImg;
  final String carnivalName;
  final String carnivalImg;
  final String categoryType;
  final String startTime;
  final String endTime;
  final dynamic distance; // Can be String or int
  final CarnivalInfo carnivalInfo;

  BookingHistoryModel({
    required this.id,
    required this.partyDate,
    required this.orderId,
    required this.totalAmount,
    required this.status,
    required this.clubName,
    required this.clubId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.clubImg,
    required this.carnivalName,
    required this.carnivalImg,
    required this.categoryType,
    required this.startTime,
    required this.endTime,
    required this.distance,
    required this.carnivalInfo,
  });

  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) {
    return BookingHistoryModel(
      id: json['id']?.toString() ?? '',
      partyDate: json['party_date']?.toString() ?? '',
      orderId: json['order_id']?.toString() ?? '',
      totalAmount: json['total_amount']?.toString() ?? '0',
      status: json['status']?.toString() ?? '',
      clubName: json['club_name']?.toString() ?? '',
      clubId: json['club_id']?.toString() ?? '',
      latitude: json['latitude']?.toString() ?? '',
      longitude: json['longitude']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      clubImg: json['club_img']?.toString() ?? '',
      carnivalName: json['Carnival_name']?.toString() ?? '',
      carnivalImg: json['carnial_img']?.toString() ?? '',
      categoryType: json['category_type']?.toString() ?? '',
      startTime: json['start_time']?.toString() ?? '',
      endTime: json['end_time']?.toString() ?? '',
      distance: json['distance'],
      carnivalInfo: CarnivalInfo.fromJson(json['carnival_info'] ?? {}),
    );
  }

  double get distanceAsDouble {
    if (distance is String) {
      return double.tryParse(distance) ?? 0.0;
    } else if (distance is int) {
      return distance.toDouble();
    } else if (distance is double) {
      return distance;
    }
    return 0.0;
  }

  double get totalAmountAsDouble {
    return double.tryParse(totalAmount) ?? 0.0;
  }
}

class CarnivalInfo {
  final String id;
  final String coupleAmount;
  final String maleAmount;
  final String femaleAmount;
  final String coupleQty;
  final String maleQty;
  final String femaleQty;
  final String couponCode;

  CarnivalInfo({
    required this.id,
    required this.coupleAmount,
    required this.maleAmount,
    required this.femaleAmount,
    required this.coupleQty,
    required this.maleQty,
    required this.femaleQty,
    required this.couponCode,
  });

  factory CarnivalInfo.fromJson(Map<String, dynamic> json) {
    return CarnivalInfo(
      id: json['id']?.toString() ?? '',
      coupleAmount: json['couple_amount']?.toString() ?? '0',
      maleAmount: json['male_amount']?.toString() ?? '0',
      femaleAmount: json['female_amount']?.toString() ?? '0',
      coupleQty: json['couple_qty']?.toString() ?? '0',
      maleQty: json['male_qty']?.toString() ?? '0',
      femaleQty: json['female_qty']?.toString() ?? '0',
      couponCode: json['coupon_code']?.toString() ?? '',
    );
  }
}

class BookingHistoryResponse {
  final bool status;
  final String message;
  final List<BookingHistoryModel> data;

  BookingHistoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BookingHistoryResponse.fromJson(Map<String, dynamic> json) {
    return BookingHistoryResponse(
      status: json['status'] ?? false,
      message: json['msg']?.toString() ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => BookingHistoryModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

