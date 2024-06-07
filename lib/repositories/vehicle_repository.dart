import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelwave_mobile/models/driver_model.dart';

import 'package:travelwave_mobile/models/feedback_model.dart';
import 'package:travelwave_mobile/models/user_info.dart';

class VehicleRepository {
  static const String _baseUrl =
      'https://travelwave-backend.onrender.com/v1/vehicles/get-vehicle-by-driver';

  final String token;
  VehicleRepository({required this.token});
  Future<DriverModel> getvehicleDriver(String id) async {
    final url = Uri.parse('$_baseUrl/$id');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return DriverModel.fromJson(jsonDecode(response.body)[0]);
        // Feedback submitted successfully
      }
      throw Exception('Failed to fetch vehicle');
    } catch (e) {
      throw Exception('Failed to fetch vehicle: $e');
    }
  }
}
