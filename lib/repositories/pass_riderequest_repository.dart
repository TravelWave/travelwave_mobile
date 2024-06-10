import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/models/accepted_ride_request_model.dart';
import 'package:travelwave_mobile/models/available_rides_model.dart';
import 'package:travelwave_mobile/models/driver_info.dart';
import 'package:travelwave_mobile/models/pass_riderequest_model.dart';
import 'package:travelwave_mobile/models/ride_info_model.dart';
import 'package:travelwave_mobile/services/utils/app_constant.dart';
import 'package:travelwave_mobile/services/utils/location.dart';

class PassRideRequestRepository {
  // static const _baseUrl = 'http://localhost:8000/v1/ride-requests';
  static const _baseUrl =
      'https://travelwave-backend.onrender.com/v1/ride-requests';

  final String token;
  PassRideRequestRepository({required this.token});

  Future<bool> createScheduledRideRequest(PassRideRequest ridebody) async {
    final url = Uri.parse('$_baseUrl/createOneScheduledRideRequest/');

    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: ridebody.toJson(),
      );

      if (response.statusCode == 201) {
        return true;
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
    final url = Uri.parse('$_baseUrl/$id');
    print(
        "--------------------------------------- RIDE Cancel _____________________");
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception('Failed to cancel ride');
    } catch (e) {
      throw Exception('Failed to  cancel ride: $e');
    }
  }

  Future<AcceptedRideRequestModel> askToJoinPooledScheduledRide(
    String id,
    LatLng start,
    LatLng end,
  ) async {
    final url = Uri.parse('$_baseUrl/createScheduledPooledRideRequest/$id/');
    try {
      print('about to call httpp ...');

      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token'
          },
          // body: {
          //   "start_latitude": "8.995481382007103",
          //   "start_longitude": "38.827046178861494",
          //   "end_latitude": "9.032659481621629",
          //   "end_longitude": "38.71189435187503",
          // },

          body: {
            "start_latitude": start.latitude.toString(),
            "start_longitude": start.longitude.toString(),
            "end_latitude": end.latitude.toString(),
            "end_longitude": end.longitude.toString(),
          });

      if (response.statusCode == 200) {
        final res =
            AcceptedRideRequestModel.fromJson(jsonDecode(response.body));
        return res;
      } else {
        throw Exception('Join Request Refused');
      }
    } catch (e) {
      throw Exception('Join Request Refused');
    }
  }

  Future<AcceptedRideRequestModel> askToJoinPooledRide(
    String id,
    LatLng start,
    LatLng end,
  ) async {
    print(token);
    print(id);
    final url = Uri.parse('$_baseUrl/createPooledRideRequest/$id');
    try {
      print('requesting pooled ride ...');
      print(start.latitude);
      print(start.longitude);
      print(end.longitude);
      print(end.longitude);
      print({
        "start_latitude": start.latitude.toString(),
        "start_longitude": start.longitude,
        "end_latitude": end.latitude,
        "end_longitude": end.longitude,
      });
      final response = await http.post(url,
          headers: {'Authorization': 'Bearer $token'},
          body: jsonEncode({
            "start_latitude": start.latitude.toString(),
            "start_longitude": start.longitude.toString(),
            "end_latitude": end.latitude.toString(),
            "end_longitude": end.longitude.toString(),
          })

          // body: {
          //   "start_latitude": "8.995481382007103",
          //   "start_longitude": "38.827046178861494",
          //   "end_latitude": "9.032659481621629",
          //   "end_longitude": "38.71189435187503",
          // },

          // body: {
          // "start_latitude": start.latitude,
          // "start_longitude": start.longitude,
          // "end_latitude": end.latitude,
          // "end_longitude": end.longitude,
          // }
          );
      print(response.statusCode);
      print('RESPONSE: ${response.body}');

      if (response.statusCode == 200) {
        final res =
            AcceptedRideRequestModel.fromJson(jsonDecode(response.body));
        print('res: $res');
        print('yaaay ....');
        return res;
      } else {
        throw Exception('Join Request Refused');
      }
    } catch (e) {
      print(e);
      throw Exception('Join Request Refused');
    }
  }

  Future<DriverInfo> getUserInfo(String id) async {
    final url = Uri.parse('$baseUrl/users/$id');
    print(id);
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
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
    final url = Uri.parse('$baseUrl/rides/pooled/');

    try {
      final pos = await getCurrentLocation();
      print(pos);
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "latitude": pos.latitude.toString(),
          "longitude": pos.longitude.toString(),
        },
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
    final url = Uri.parse('$baseUrl/rides/pooled/');

    try {
      final pos = await getCurrentLocation();
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        // body: {
        //   "latitude": "8.85",
        //   "longitude": "38.81666",
        // },
        body: {
          "latitude": pos.latitude.toString(),
          "longitude": pos.longitude.toString(),
        },
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
    final url = Uri.parse('$baseUrl/rides/$id');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
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
