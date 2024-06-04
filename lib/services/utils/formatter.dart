import 'package:geocoding/geocoding.dart';

Future<String> getLocationFromCoordinates(
    double latitude, double longitude) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks.first;
    String location = '${place.street}, ${place.locality}, ${place.country}';
    return location;
  } catch (e) {
    print('Error: $e');
    return 'Unable to determine location';
  }
}

String getRelativeTimeString(String timestamp) {
  DateTime now = DateTime.now();
  DateTime requestTime = DateTime.parse(timestamp);
  Duration difference = now.difference(requestTime);

  if (difference.inSeconds < 60) {
    return "Just now";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes} min ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} hr ago";
  } else if (difference.inDays < 7) {
    return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
  } else if (difference.inDays < 30) {
    return "${(difference.inDays / 7).floor()} week${(difference.inDays ~/ 7) > 1 ? 's' : ''} ago";
  } else if (difference.inDays < 365) {
    return "${(difference.inDays / 30).floor()} month${(difference.inDays ~/ 30) > 1 ? 's' : ''} ago";
  } else {
    int years = (difference.inDays / 365).floor();
    return "$years year${years > 1 ? 's' : ''} ago";
  }
}
