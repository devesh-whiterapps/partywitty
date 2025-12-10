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
    // Debug logging to trace inconsistent backend payloads.
    // ignore: avoid_print
    print('[PaymentService] submitCarnivalPass decoded: $decoded');
    final status = decoded['status'] == true;
    final message = decoded['msg']?.toString() ?? 'Unable to start payment';

    // The backend sometimes returns the order payload under `data` (map or list)
    // and other times under `order`. Normalise here so the caller always gets
    // the Razorpay order info (expects keys like `rzp_order_id`, `amount` etc).
    Map<String, dynamic>? _extractMap(dynamic value) {
      if (value is Map<String, dynamic>) {
        return value;
      }
      if (value is List && value.isNotEmpty && value.first is Map) {
        return Map<String, dynamic>.from(value.first as Map);
      }
      return null;
    }

    final payload =
        _extractMap(decoded['data']) ??
        _extractMap(decoded['order']) ??
        // Fallback: some responses may already be the payload at top level
        (decoded.containsKey('rzp_order_id') ? decoded : null);

    if (status && payload != null) {
      // ignore: avoid_print
      print('[PaymentService] submitCarnivalPass payload: $payload');
      return Map<String, dynamic>.from(payload);
    }

    // ignore: avoid_print
    print(
      '[PaymentService] submitCarnivalPass failed: status=$status msg=$message payload=$payload',
    );
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
