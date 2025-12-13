import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:information_retrieval/data/models/search_model.dart';
import 'package:information_retrieval/core/config/api_config.dart';

class ApiService {
  // Search endpoint
  Future<SearchResponse> search(String query, SearchMethod method) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}/api/Search/query');

      int searchType;
      switch (method) {
        case SearchMethod.invertedIndex:
          searchType = 1;
          break;
        case SearchMethod.positionalIndex:
          searchType = 2;
          break;
        case SearchMethod.soundex:
          searchType = 3;
          break;
      }

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'query': query,
          'searchType': searchType,
        }),
      );

      if (response.statusCode == 200) {
        return SearchResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to search: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Search error: $e');
    }
  }

  Future<bool> addDocument(String content) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}/api/Documents');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': 0,
          'content': content,
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw Exception('Add document error: $e');
    }
  }
}
