import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/discount_offer_model.dart';

class DiscountOfferService {
  static const String baseUrl = 'https://admin.partywitty.com/master/APIs/PartyWittyPay';

  /// Get discount offer from API
  Future<DiscountOfferResponse> getDiscountOffer({
    required String amount,
    required String clubId,
    required String userId,
    required String type,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/getDiscountOffer');
      
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'amount': amount,
          'club_id': clubId,
          'user_id': userId,
          'type': type,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return DiscountOfferResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load discount offer: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching discount offer: $e');
    }
  }
}

