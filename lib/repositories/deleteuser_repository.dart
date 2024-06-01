import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

import 'package:travelwave_mobile/models/ridehistory_model.dart';
import 'package:travelwave_mobile/services/utils/app_constant.dart';

class DeleteUserRepository {
  final String token;
  DeleteUserRepository({required this.token});
  Future<bool> deleteUser(String id) async {
    final url = Uri.parse("${baseUrl}users/{}");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true;
        // Feedback submitted successfully
      }
      throw Exception('Failed to delete user');
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
