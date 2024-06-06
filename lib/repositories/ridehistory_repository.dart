import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:travelwave_mobile/models/ridehistory_model.dart';

class RideHistoryRepository {
  static const String _baseUrl =
      'https://travelwave-backend.onrender.com/v1/ride-histories/';

  final String token;
  RideHistoryRepository({required this.token});
  Future<RideHistory> getRideHistory(String id) async {
    final url = Uri.parse(_baseUrl + id);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return RideHistory.fromJson(jsonDecode(response.body));
        // Feedback submitted successfully
      }
      throw Exception('Failed to get ride info');
    } catch (e) {
      throw Exception('Failed to  get ride info: $e');
    }
  }

  Future<List<RideHistory>> getRideHistorys() async {
    final url = Uri.parse(_baseUrl);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return RideHistory.tolist(jsonDecode(response.body));
        // Feedback submitted successfully
      }
      throw Exception('Failed to get ride info');
    } catch (e) {
      throw Exception('Failed to  get ride info: $e');
    }
  }

  Future<bool> createRideHistory(RideHistory ridebody) async {
    final url = Uri.parse(_baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: ridebody.toJson(),
      );

      if (response.statusCode == 200) {
        return true;
        // Feedback submitted successfully
      }
      return false;
    } catch (e) {
      throw Exception('Failed to create Ride Request: $e');
    }
  }

  Future<bool> deleteRideHistory(String id) async {
    final url = Uri.parse(_baseUrl + id);

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true;
        // Feedback submitted successfully
      }
      throw Exception('Failed to get ride info');
    } catch (e) {
      throw Exception('Failed to  get ride info: $e');
    }
  }

  Future<List<RideHistory>> getRideHistoryByUser(String id) async {
    final url = Uri.parse("$_baseUrl$id");
    print(url);
    print(token);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return RideHistory.fromJsonList(jsonDecode(response.body));
        // Feedback submitted successfully
      }
      throw Exception('Failed to get ride info');
    } catch (e) {
      throw Exception('Failed to  get ride info: $e');
    }
  }
}
