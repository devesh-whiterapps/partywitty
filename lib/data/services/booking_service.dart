import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/booking_history_model.dart';

class BookingService {
  static const String baseUrl = 'https://admin.partywitty.com/master/APIs/Carnival';

  /// Fetch booking history from API
  Future<BookingHistoryResponse> getBookingHistory({
    required String userId,
    required String longitude,
    required String latitude,
    required String type, // 'upcoming' or 'past'
    String? sessionCookie,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/bookingHistory');
      
      final request = http.MultipartRequest('POST', uri);
      
      // Add form fields
      request.fields['user_id'] = userId;
      request.fields['longitude'] = longitude;
      request.fields['latitude'] = latitude;
      request.fields['type'] = type;
      
      // Add cookie if provided
      if (sessionCookie != null) {
        request.headers['Cookie'] = sessionCookie;
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return BookingHistoryResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load booking history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching booking history: $e');
    }
  }
}

