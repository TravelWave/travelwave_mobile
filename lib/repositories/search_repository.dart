import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class SearchRepository {
  static Future<List<Map<String, dynamic>>> searchPlaces(String query) async {
    const String nominatimUrl = 'https://nominatim.openstreetmap.org/search';
    final Map<String, String> params = {
      'q': query,
      'format': 'json',
      'limit': '5',
    };

    final uri = Uri.parse(nominatimUrl).replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((place) => place as Map<String, dynamic>).toList();
    } else {
      throw Exception(
          "Failed to fetch suggestions. Status code: ${response.statusCode}");
    }
  }

  static Future<LatLng> getLocation(String location) async {
    String baseURL =
        "https://nominatim.openstreetmap.org/search?format=json&q=$location";

    final response = await http.get(Uri.parse(baseURL));

    final loc = jsonDecode(response.body)[0];

    final latitude = loc['lat'];
    final longitude = loc['lon'];

    return LatLng(double.parse(latitude), double.parse(longitude));
  }
}
