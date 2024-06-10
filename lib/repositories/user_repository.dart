import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:travelwave_mobile/models/feedback_model.dart';
import 'package:travelwave_mobile/models/user_info.dart';

class UserRepository {
  static const String _baseUrl =
      'https://travelwave-backend.onrender.com/v1/users';

  final String token;
  UserRepository({required this.token});
  Future<UserInfo> getUser(String id) async {
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
        return UserInfo.fromJson2(jsonDecode(response.body));
        // Feedback submitted successfully
      }
      throw Exception('Failed to fetch user');
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }
}
