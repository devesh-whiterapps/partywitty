import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static const String _baseUrl =
      'https://admin.partywitty.com/master/APIs/Carnival';

  Future<Map<String, dynamic>> submitCarnivalPass({
    required String orderId,
    required String paymentGateway,
    String couponCode = '',
    bool carrotUse = false,
  }) async {
    final uri = Uri.parse('$_baseUrl/submitCarnivalPass');
    final request = http.MultipartRequest('POST', uri);

    request.fields['order_id'] = orderId;
    request.fields['coupon_code'] = couponCode;
    request.fields['payment_gateway'] = paymentGateway;
    request.fields['carrot_use'] = carrotUse ? 'true' : 'false';

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to start payment (${response.statusCode}): ${response.body}',
      );
    }

    final decoded = json.decode(response.body) as Map<String, dynamic>;
    // Debug log to help diagnose API issues during integration.
    // ignore: avoid_print
    print('submitCarnivalPass response: $decoded');
    final status = decoded['status'] == true;
    final data = decoded['data'];
    final message = decoded['msg']?.toString() ?? 'Unable to start payment';

    if (status && data is Map<String, dynamic>) {
      return Map<String, dynamic>.from(data);
    }

    if (status && data is List && data.isNotEmpty && data.first is Map) {
      return Map<String, dynamic>.from(data.first as Map);
    }

    throw Exception(message);
  }

  Future<bool> verifyRazorpayPayment(
    Map<String, dynamic> razorpayResponse,
  ) async {
    final uri = Uri.parse('$_baseUrl/verifyRzpPayment');
    final request = http.MultipartRequest('POST', uri);
    request.fields['response'] = json.encode(razorpayResponse);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Failed to verify payment: ${response.statusCode}');
    }

    final decoded = json.decode(response.body) as Map<String, dynamic>;
    return decoded['status'] == true;
  }
}

