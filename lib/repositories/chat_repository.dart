import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelwave_mobile/models/chats.dart';
import 'package:travelwave_mobile/services/utils/app_constant.dart';

class ChatRepository {
  final String token;
  ChatRepository({required this.token});
  // static const baseURL = 'http://localhost:8000/v1/users/';
  static const baseURL = '$baseUrl/messages/get';

  Future<List<Chats>> getChatHistory({
    required String recieverId,
  }) async {
    try {
      print(token);
      print(recieverId);
      final response = await http.get(
        Uri.parse('$baseURL/$recieverId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        return Chats.fromList(jsonDecode(response.body));
      }
      throw Exception('Failed to get chat history');
    } catch (e) {
      throw Exception('Failed to get chat history: $e');
    }
  }
}
