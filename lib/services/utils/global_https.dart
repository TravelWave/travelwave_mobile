import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/main.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

fetchDriverLocationFromServer(String id, LatLng location) async {
  print("in");
  final token = data.readFromStorage("Token");
  final response = await http.put(
      Uri.parse(
          'https://travelwave-backend.onrender.com/v1/rides/track-driver-location/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "latitude": location.latitude.toString(),
        "longitude": location.longitude.toString()
      });
  print(response.body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    final resp = jsonDecode(response.body);
    print(resp);
    return LatLng(resp["ride"]['current_location_latitude'],
        resp["ride"]['current_location_longitude']);
    // Feedback submitted successfully
  }
  throw Exception('Failed to get ride info');
}

sendMsgToServer(String id, String msg) async {
  print("inside");
  final token = await data.readFromStorage("Token");
  print(token);
  print(id);
  print(msg);
  final response = await http.post(
      Uri.parse('https://travelwave-backend.onrender.com/v1/messages/send/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "message": msg,
      });
  print(response.body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    return true;
    // Feedback submitted successfully
  }
  throw Exception('Failed to save chat info');
}
