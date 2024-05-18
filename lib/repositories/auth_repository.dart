import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelwave_mobile/models/passenger_model.dart';

class AuthRepository {
  static const baseURL = 'http://localhost:8000/v1/users/';

  static Future<Map<String, dynamic>> registerUser(Passenger user) async {
    try {
      final response = await http.post(
        Uri.parse(baseURL),
        body: user.toJson(),
      );

      if (response.statusCode == 201) {
        return {
          'status': 'success',
          'message': 'User registered successfully.'
        };
      } else {
        throw Exception('An error occurred. Please try again later.');
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> loginUser(
      String phoneNumber, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseURL/login/'),
        body: {
          'phone_number': phoneNumber,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return {
          'status': 'success',
          'message': 'User logged in successfully.',
          'access': jsonDecode(response.body)['access'],
        };
      } else {
        throw Exception('An error occurred. Please try again later.');
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> sendOTP(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('$baseURL/verify/'),
        body: {'phone_number': phoneNumber},
      );

      if (response.statusCode == 200) {
        return {
          'status': 'success',
          'message': 'OTP sent successfully.',
        };
      } else {
        throw Exception('An error occurred. Please try again later.');
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': e.toString(),
      };
    }
  }
}
