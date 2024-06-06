class RideRequest {
  String id;
  String passengerId;
  double startLatitude;
  double startLongitude;
  double endLatitude;
  double endLongitude;
  String requestTime;
  String status;

  bool isPooled;
  bool isScheduled;

  RideRequest({
    required this.id,
    required this.passengerId,
    required this.startLatitude,
    required this.startLongitude,
    required this.endLatitude,
    required this.endLongitude,
    required this.requestTime,
    required this.status,
    required this.isPooled,
    required this.isScheduled,
  });

  factory RideRequest.fromJson(Map<String, dynamic> json) {
    return RideRequest(
      id: json['_id'] ?? '',
      passengerId: json['passenger'] ?? '',
      startLatitude: (json['start_latitude'] ?? 0).toDouble(),
      startLongitude: (json['start_longitude'] ?? 0).toDouble(),
      endLatitude: (json['end_latitude'] ?? 0).toDouble(),
      endLongitude: (json['end_longitude'] ?? 0).toDouble(),
      requestTime: json['request_time'] ?? '',
      status: json['status'] ?? '',
      isPooled: json['is_pooled'] ?? false,
      isScheduled: json['is_scheduled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['passenger'] = passengerId;
    data['start_latitude'] = startLatitude;
    data['start_longitude'] = startLongitude;
    data['end_latitude'] = endLatitude;
    data['end_longitude'] = endLongitude;
    data['request_time'] = requestTime;
    data['status'] = status;

    data['is_pooled'] = isPooled;
    data['is_scheduled'] = isScheduled;

    return data;
  }

  static List<RideRequest> fromJsonList(List<dynamic> json) {
    return json.map((e) => RideRequest.fromJson(e)).toList();
  }
}

class RideRequestWithLocation {
  final String id;
  final String passenger;
  final String startLocation;
  final String endLocation;
  final String requestTime;
  double startLatitude;
  double startLongitude;
  double endLatitude;
  double endLongitude;
  final String status;
  final bool isPooled;

  final bool isScheduled;

  RideRequestWithLocation({
    required this.id,
    required this.passenger,
    required this.startLocation,
    required this.endLocation,
    required this.requestTime,
    required this.endLatitude,
    required this.endLongitude,
    required this.startLatitude,
    required this.startLongitude,
    required this.status,
    required this.isPooled,
    required this.isScheduled,
  });
}
