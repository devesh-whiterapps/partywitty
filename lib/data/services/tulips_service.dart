import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/tulips_model.dart';

class TulipsService {
  static const String baseUrl = 'https://node.partywitty.com/tulips';

  /// Get available tulips for a user
  Future<TulipsModel> getAvailableTulips({
    required String userId,
    required String clubId,
    required String netPayableAmount,
    required String packageCategory,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/getAvailableTulips');
      
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'user_id': userId,
          'club_id': clubId,
          'net_payable_amount': netPayableAmount,
          'package_category': packageCategory,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return TulipsModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load tulips: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tulips: $e');
    }
  }
}

