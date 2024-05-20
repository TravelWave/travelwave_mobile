import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:travelwave_mobile/models/riderequest_model.dart';

class RideRequestRepository {
  static const String _baseUrl =
      'https://travelwave-backend.onrender.com/v1/ride-requests/';

  final String token;
  RideRequestRepository({required this.token});
  Future<RideRequest> getRideRequest(String id) async {
    final url = Uri.parse(_baseUrl + id);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return RideRequest.fromJson(jsonDecode(response.body));
        // Feedback submitted successfully
      }
      throw Exception('Failed to get ride info');
    } catch (e) {
      throw Exception('Failed to  get ride info: $e');
    }
  }

  Future<RideRequest> getRideRequests() async {
    final url = Uri.parse(_baseUrl);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return RideRequest.fromJson(jsonDecode(response.body));
        // Feedback submitted successfully
      }
      throw Exception('Failed to get ride info');
    } catch (e) {
      throw Exception('Failed to  get ride info: $e');
    }
  }

  Future<bool> createRideRequest(RideRequest ridebody) async {
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

  Future<bool> cancelRideRequest(String id) async {
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

  Future<bool> acceptRideRequest(String id) async {
    final url = Uri.parse("$_baseUrl$id/accept");

    try {
      final response = await http.put(
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
}
