import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/models/feedback_model.dart';

class FeedbackRepository {
  static const String _baseUrl =
      'https://travelwave-backend.onrender.com/v1/feedbacks/';

  final String token;
  FeedbackRepository({required this.token});
  Future<void> submitFeedback(FeedBackMsg feedback) async {
    final url = Uri.parse(_baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'message': feedback.feedback,
          'rating': feedback.rating.toString(),
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        // Feedback submitted successfully
      }
    } catch (e) {
      throw Exception('Failed to submit feedback: $e');
    }
  }
}
