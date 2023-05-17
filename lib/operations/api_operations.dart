import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiOperations {
  final String featured_api_url =
      "?perPage=7";
  final String user_album_api_url =
      "";
  final String categories_url =
      "";

  Future<Map<String, dynamic>> fetchFeatured() async {
    final response = await http.get(Uri.parse(featured_api_url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load featured');
    }
  }

  Future<Map<String, dynamic>> fetchUserAlbums() async {
    final response = await http.get(Uri.parse(user_album_api_url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user albums');
    }
  }

  Future<Map<String, dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse(categories_url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
