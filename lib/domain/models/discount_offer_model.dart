/// Model for Discount Offer API response
class DiscountOfferModel {
  final String orderId;
  final double totalAmount;
  final double cashbackAmount;
  final double discountedAmount;
  final double payableAmount;
  final double platformFee;
  final double netPayableAmount;

  DiscountOfferModel({
    required this.orderId,
    required this.totalAmount,
    required this.cashbackAmount,
    required this.discountedAmount,
    required this.payableAmount,
    required this.platformFee,
    required this.netPayableAmount,
  });

  factory DiscountOfferModel.fromJson(Map<String, dynamic> json) {
    return DiscountOfferModel(
      orderId: json['order_id'] ?? '',
      totalAmount: double.tryParse(json['total_amount']?.toString() ?? '0') ?? 0.0,
      cashbackAmount: double.tryParse(json['cashback_amount']?.toString() ?? '0') ?? 0.0,
      discountedAmount: double.tryParse(json['discounted_amount']?.toString() ?? '0') ?? 0.0,
      payableAmount: double.tryParse(json['payable_amount']?.toString() ?? '0') ?? 0.0,
      platformFee: double.tryParse(json['platform_fee']?.toString() ?? '0') ?? 0.0,
      netPayableAmount: double.tryParse(json['net_payable_amount']?.toString() ?? '0') ?? 0.0,
    );
  }
}

/// Response wrapper for Discount Offer API
class DiscountOfferResponse {
  final bool status;
  final String message;
  final List<DiscountOfferModel> data;

  DiscountOfferResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DiscountOfferResponse.fromJson(Map<String, dynamic> json) {
    return DiscountOfferResponse(
      status: json['status'] ?? false,
      message: json['msg'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => DiscountOfferModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

