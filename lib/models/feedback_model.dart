import 'dart:ffi';

class FeedBackMsg {
  double rating;
  String? feedback;

  FeedBackMsg({this.feedback, this.rating = 0.0});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feedback'] = feedback;
    data['rating'] = rating;

    return data;
  }
}
