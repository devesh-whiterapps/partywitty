import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/search_model.dart';

class SearchService {
  static const String baseUrl = 'https://admin.partywitty.com/master/APIs/Web';

  /// Global search API
  Future<SearchResponse> globalSearch({
    required String keyword,
    required String latitude,
    required String longitude,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/globalSearch');

      final request = http.MultipartRequest('POST', uri);

      // Add form fields
      request.fields['keyword'] = keyword;
      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return SearchResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load search results: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching search results: $e');
    }
  }
}





