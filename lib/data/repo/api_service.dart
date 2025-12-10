import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:information_retrieval/data/models/search_model.dart';

class ApiService {
  static const String baseUrl = 'https://ir-search-engine.runasp.net';
  
  // Search endpoint
  Future<SearchResponse> search(String query, SearchMethod method) async {
    try {
      final url = Uri.parse('$baseUrl/api/Search/query');
      
      // Map SearchMethod to API searchType (1 for inverted, 2 for positional)
      int searchType;
      switch (method) {
        case SearchMethod.invertedIndex:
          searchType = 1;
          break;
        case SearchMethod.positionalIndex:
          searchType = 2;
          break;
        case SearchMethod.soundex:
          searchType = 1; // Default to inverted index if soundex not supported
          break;
      }
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'query': query,
          'searchType': searchType,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SearchResponse.fromJson(data);
      } else {
        throw Exception('Failed to search: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Search error: $e');
    }
  }
  
  // Add document endpoint
  Future<bool> addDocument(String content) async {
    try {
      final url = Uri.parse('$baseUrl/api/Documents');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': 0,
          'content': content,
        }),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to add document: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Add document error: $e');
    }
  }
}