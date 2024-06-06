import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelwave_mobile/models/create_ride.dart';

import 'package:travelwave_mobile/models/riderequest_model.dart';

class RideRepository {
  static const String _baseUrl =
      'https://travelwave-backend.onrender.com/v1/rides';

  final String token;
  RideRepository({required this.token});
  Future<void> createOneRide(Ride rideinfo) async {
    final url = Uri.parse('$_baseUrl/createOneRide/');

    try {
      final response = await http.post(
        url,
        body: {
          "available_seats": rideinfo.seats.toString(),
          "number_of_passengers": rideinfo.numPassenger.toString(),
          "latitude": rideinfo.latitude.toString(),
          "longitude": rideinfo.longitude.toString(),
          "is_pooled": rideinfo.isPooled.toString(),
          "is_scheduled": rideinfo.isScheduled.toString(),
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      }
      throw Exception('Failed to create ride');
    } catch (e) {
      throw Exception('Failed to create ride: $e');
    }
  }

  Future<void> createOneScheduledRide(Ride rideinfo) async {
    final url = Uri.parse('$_baseUrl/createOneScheduledRide/');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "available_seats": rideinfo.seats.toString(),
          "number_of_passengers": rideinfo.numPassenger.toString(),
          "latitude": rideinfo.latitude.toString(),
          "longitude": rideinfo.longitude.toString(),
        },
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
        // Feedback submitted successfully
      }
      throw Exception('Failed to create ride');
    } catch (e) {
      throw Exception('Failed to create ride: $e');
    }
  }

  Future<void> createPooledRide(Ride rideinfo) async {
    final url = Uri.parse('$_baseUrl/createPooledRide');
    print(_baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "available_seats": rideinfo.seats.toString(),
          "number_of_passengers": rideinfo.numPassenger.toString(),
          "latitude": rideinfo.latitude.toString(),
          "longitude": rideinfo.longitude.toString(),
        },
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
        // Feedback submitted successfully
      }
      throw Exception('Failed to create ride');
    } catch (e) {
      throw Exception('Failed to create ride: $e');
    }
  }

  Future<void> createScheduledPooledRide(Ride rideinfo) async {
    final url = Uri.parse('$_baseUrl/createScheduledPooledRide');
    print(_baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "available_seats": rideinfo.seats.toString(),
          "number_of_passengers": rideinfo.numPassenger.toString(),
          "latitude": rideinfo.latitude.toString(),
          "longitude": rideinfo.longitude.toString(),
        },
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
        // Feedback submitted successfully
      }
      throw Exception('Failed to create ride');
    } catch (e) {
      throw Exception('Failed to create ride: $e');
    }
  }
}
