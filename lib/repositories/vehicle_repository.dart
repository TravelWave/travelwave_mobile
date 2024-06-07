import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelwave_mobile/models/driver_model.dart';

import 'package:travelwave_mobile/models/feedback_model.dart';
import 'package:travelwave_mobile/models/user_info.dart';

class VehicleRepository {
  static const String _baseUrl =
      'https://travelwave-backend.onrender.com/v1/vehicles';

  final String token;
  VehicleRepository({required this.token});
  Future<DriverModel> getvehicleDriver(String id) async {
    final url = Uri.parse('$_baseUrl//get-vehicle-by-driver/$id');

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

  Future<DriverModel> createvehicleDriver(DriverModel driverData) async {
    final url = Uri.parse(_baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "name": driverData.name,
          "make": driverData.make,
          "model": driverData.model,
          "color": driverData.color,
          "license_plate": driverData.driverLicense,
          "number_of_seats": driverData.numberOfSeats.toString(),
          "year": driverData.year.toString(),
          "is_busy": driverData.isBusy.toString(),
          "driver_license": "889900112",
          "driver_license_expiration_date":
              driverData.driverLicenseExpirationDate.toString(),
          "is_verified": driverData.isVerified.toString()
        },
      );

      if (response.statusCode == 201) {
        return DriverModel.fromJson(jsonDecode(response.body));
        // Feedback submitted successfully
      }
      throw Exception('Failed to create vehicle');
    } catch (e) {
      throw Exception('Failed to create vehicle: $e');
    }
  }
}
