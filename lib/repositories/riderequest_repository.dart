import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:travelwave_mobile/models/riderequest_model.dart';

class RideRequestRepository {
  static const String _baseUrl =
      'https://travelwave-backend.onrender.com/v1/ride-requests';

  final String token;
  RideRequestRepository({required this.token});

  Future<List<RideRequest>> getRideRequest(String id) async {
    final url = Uri.parse('$_baseUrl/id');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return RideRequest.fromJsonList(jsonDecode(response.body));
        // Feedback submitted successfully
      }
      throw Exception('Failed to get ride info');
    } catch (e) {
      throw Exception('Failed to  get ride info: $e');
    }
  }

  Future<List<RideRequest>> getRideRequests() async {
    final url = Uri.parse(
        "https://travelwave-backend.onrender.com/v1/ride-requests/scheduled");
    // final url = Uri.parse(_baseUrl);
    print(_baseUrl);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return RideRequest.fromJsonList(jsonDecode(response.body));

        // Feedback submitted successfully
      }
      throw Exception('Failed to get ride info');
    } catch (e) {
      throw Exception('Failed to  get ride info: $e');
    }
  }


  Future<Map> createRideRequest(RideRequest ridebody) async {
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
        return {
          "message": jsonDecode(response.body)["message"],
          "status": "success"
        };
        // Feedback submitted successfully
      }
      return {
        "message": jsonDecode(response.body)["message"],
        "status": "error"
      };
    } catch (e) {
      throw Exception('Failed to create Ride Request: $e');
    }
  }

  Future<Map> cancelRideRequest(String id) async {
    final url = Uri.parse(_baseUrl + id);

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          "data": RideRequest.fromJson(jsonDecode(response.body), null),
          // "message": jsonDecode(response.body)["message"],
          "status": "success"
        };
        // Feedback submitted successfully
      }
      return {
        "message": jsonDecode(response.body)["message"],
        "status": "error"
      };
    } catch (e) {
      throw Exception('Failed to  get ride info: $e');
    }
  }

  Future<Map> acceptRideRequest(String id) async {
    final url = Uri.parse("$_baseUrl/$id/accept");

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          "data": RideRequest.fromJson(
              jsonDecode(response.body)["updatedRideRequest"],
              jsonDecode(response.body)['ride']),
          // "message": jsonDecode(response.body)["message"],
          "status": "success"
        };
        // Feedback submitted successfully
      }

      return {
        "message": jsonDecode(response.body)["message"],
        "status": "error"
      };
    } catch (e) {
      throw Exception('Failed to accept ride requset: $e');
    }
  }

  Future<Map> acceptRideRequestScheduled(String id) async {
    final url = Uri.parse("$_baseUrl/$id/accept/scheduled/");

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          "data": RideRequest.fromJson(
              jsonDecode(response.body)["updatedRideRequest"],
              jsonDecode(response.body)["ride"]),
          "status": "success"
        };
        // Feedback submitted successfully
      }
      return {
        "message": jsonDecode(response.body)["message"],
        "status": "error"
      };
    } catch (e) {
      throw Exception('Failed to accept ride requset: $e');
    }
  }

  Future<Map> acceptPooledRideRequest(String rideId, String passengerId) async {
    final url = Uri.parse("$_baseUrl/accept-join-request/");

    try {
      final response = await http.post(
        url,
        body: {"rideId": rideId, "passengerId": passengerId},
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "data": RideRequest.fromJson(jsonDecode(response.body)["ride"],
              jsonDecode(response.body)["ride"]),
          "status": "success"
        };
        // Feedback submitted successfully
      }

      return {
        "message": jsonDecode(response.body)["message"],
        "status": "error"
      };
    } catch (e) {
      throw Exception('Failed to accept ride requset: $e');
    }
  }
}
