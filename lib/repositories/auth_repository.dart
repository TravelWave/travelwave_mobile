import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelwave_mobile/services/utils/app_constant.dart';

class AuthRepository {
  // static const baseURL = 'http://localhost:8000/v1/users/';
  static const baseURL = '$baseUrl/users';

  static Future<Map<String, dynamic>> registerUser({
    required String fullName,
    required String phoneNumber,
    required String password,
    required bool isDriver,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseURL),
        body: {
          'full_name': fullName,
          'phone_number': phoneNumber,
          'password': password,
          'is_driver': isDriver,
        },
      );
      print(jsonDecode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'status': 'success',
          'message': 'User registered successfully.'
        };
      } else {
        return {
          'status': 'error',
          'message': 'An error occurred. Please try again later.',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'An error occurred. Please try again later.',
        "detail": e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> loginUser(
      String phoneNumber, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseURL/login'),
        body: {
          'phone_number': phoneNumber,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return {
          'status': 'success',
          'message': 'User logged in successfully.',
          'access': jsonDecode(response.body)["token"],
        };
      } else {
        return {
          'status': 'error',
          'message': jsonDecode(response.body)['error'],
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> changePassword(
      String oldPass, String newPass, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$baseURL/changePassword/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'old_password': oldPass,
          'new_password': newPass,
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return {
          'status': 'success',
          'message': 'User Change password successfully.',
        };
      } else {
        return {
          'status': 'error',
          'message': jsonDecode(response.body)['error'],
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> sendOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseURL/verify/"),
        body: {
          "phone_number": phoneNumber,
          "otp": otp,
        },
      );

      if (!jsonDecode(response.body).containsKey('error')) {
        return {
          'status': 'success',
          'message': 'User verified successfully.',
        };
      } else {
        return {
          'status': 'error',
          'message': 'An error occurred. Please try again later.',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': e.toString(),
      };
    }
  }
}
