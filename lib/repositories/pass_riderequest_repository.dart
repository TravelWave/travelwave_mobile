import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/models/accepted_ride_request_model.dart';
import 'package:travelwave_mobile/models/available_rides_model.dart';
import 'package:travelwave_mobile/models/driver_info.dart';
import 'package:travelwave_mobile/models/pass_riderequest_model.dart';
import 'package:travelwave_mobile/models/ride_info_model.dart';

class PassRideRequestRepository {
  static const _baseUrl = 'http://localhost:8000/v1/ride-requests';

  final String token;
  PassRideRequestRepository({required this.token});

  Future<bool> createScheduledRideRequest(PassRideRequest ridebody) async {
    final url = Uri.parse('$_baseUrl/createOneScheduledRideRequest/');

    try {
      print('about to sent http ...');
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: ridebody.toJson(),
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        return true;
        // Feedback submitted successfully
      }
      return false;
    } catch (e) {
      throw Exception('Failed to send scheduled ride request: $e');
    }
  }

  Future<bool> createRideRequest(PassRideRequest ridebody) async {
    final url = Uri.parse('$_baseUrl/createOneRideRequest/');

    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: ridebody.toJson(),
      );

      if (response.statusCode == 201) {
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

  Future<AcceptedRideRequestModel> askToJoinPooledScheduledRide(
    String id,
    LatLng start,
    LatLng end,
  ) async {
    final url = Uri.parse(
        'http://localhost:8000/v1/ride-requests/createScheduledPooledRideRequest/$id/');
    try {
      print('about to call httpp ...');

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "start_latitude": "8.995481382007103",
          "start_longitude": "38.827046178861494",
          "end_latitude": "9.032659481621629",
          "end_longitude": "38.71189435187503",
        },

        //  body: {
        //   "start_latitude": start.latitude.toString(),
        //   "start_longitude": start.longitude.toString(),
        //   "end_latitude": end.latitude.toString(),
        //   "end_longitude": end.longitude.toString(),
        // }
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final res =
            AcceptedRideRequestModel.fromJson(jsonDecode(response.body));
        print('RESULT: $res');
        return res;
      } else {
        print('failed in the else statement ...');
        throw Exception('Join Request Refused');
      }
    } catch (e) {
      print('failed in catch ...');
      throw Exception('Join Request Refused');
    }
  }

  Future<AcceptedRideRequestModel> askToJoinPooledRide(
    String id,
    LatLng start,
    LatLng end,
  ) async {
    final url = Uri.parse(
        'http://localhost:8000/v1/ride-requests/createPooledRideRequest/$id/');
    try {
      print('about to call httpp ...');

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "start_latitude": "8.995481382007103",
          "start_longitude": "38.827046178861494",
          "end_latitude": "9.032659481621629",
          "end_longitude": "38.71189435187503",
        },

        //  body: {
        //   "start_latitude": start.latitude.toString(),
        //   "start_longitude": start.longitude.toString(),
        //   "end_latitude": end.latitude.toString(),
        //   "end_longitude": end.longitude.toString(),
        // }
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final res =
            AcceptedRideRequestModel.fromJson(jsonDecode(response.body));
        print('RESULT: $res');
        return res;
      } else {
        print('failed in the else statement ...');
        throw Exception('Join Request Refused');
      }
    } catch (e) {
      print('failed in catch ...');
      throw Exception('Join Request Refused');
    }
  }

  Future<DriverInfo> getUserInfo(String id) async {
    final url = Uri.parse('http://localhost:8000/v1/users/$id');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final userInfo = DriverInfo.fromJson(jsonDecode(response.body));
        return userInfo;
      } else {
        throw Exception('Failed to get user info');
      }
    } catch (e) {
      throw Exception('Failed to get user info: ${e.toString()}');
    }
  }

  Future<List<AvailableRides>> getRidePooledScheduled(LatLng location) async {
    final url = Uri.parse('http://localhost:8000/v1/rides/pooled/');

    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"latitude": "8.85", "longitude": "38.81666"},
        // body: {
        //   "latitude": location.latitude.toString(),
        //   "longitude": location.longitude.toString(),
        // },
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final List<AvailableRides> rideList = [];

        for (var res in decodedResponse) {
          rideList.add(AvailableRides.fromJson(res));
        }

        return rideList;
      } else {
        throw Exception('Failed to get ride list');
      }
    } catch (e) {
      throw Exception('Failed to get ride list: ${e.toString()}');
    }
  }

  Future<List<AvailableRides>> getRidePooled(LatLng location) async {
    final url = Uri.parse('http://localhost:8000/v1/rides/pooled/');

    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"latitude": "8.85", "longitude": "38.81666"},
        // body: {
        //   "latitude": location.latitude.toString(),
        //   "longitude": location.longitude.toString(),
        // },
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final List<AvailableRides> rideList = [];

        for (var res in decodedResponse) {
          rideList.add(AvailableRides.fromJson(res));
        }

        return rideList;
      } else {
        throw Exception('Failed to get ride list');
      }
    } catch (e) {
      throw Exception('Failed to get ride list: ${e.toString()}');
    }
  }

  Future<RideInfo> getRideInfo(String id) async {
    final url = Uri.parse('http://localhost:8000/v1/rides/$id');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final rideInfo = RideInfo.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return rideInfo;
      } else {
        throw Exception('Failed to get ride info');
      }
    } catch (e) {
      throw Exception('Failed to get ride info');
    }
  }
}
