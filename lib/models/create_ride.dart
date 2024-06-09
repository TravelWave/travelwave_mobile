class Ride {
  int numPassenger;
  int seats;
  double longitude;
  double latitude;
  bool isPooled;
  bool isScheduled;

  Ride({
    required this.latitude,
    required this.longitude,
    required this.numPassenger,
    required this.seats,
    required this.isPooled,
    required this.isScheduled,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      numPassenger: json['number_of_passengers'] ?? 0,
      seats: json['available_seats'] ?? 0,
      isPooled: json['is_pooled'],
      isScheduled: json['is_scheduled'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['available_seats'] = seats;
    data['number_of_passengers'] = numPassenger;
    data['latitude'] = latitude;

    data['longitude'] = longitude;

    data['is_pooled'] = isPooled;

    data['is_scheduled'] = isScheduled;

    return data;
  }

  Map<String, dynamic> toRideJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['available_seats'] = seats;
    data['number_of_passengers'] = numPassenger;
    data['latitude'] = latitude;

    data['longitude'] = longitude;

    return data;
  }

  static List<Ride> fromJsonList(List<dynamic> json) {
    return json.map((e) => Ride.fromJson(e)).toList();
  }
}
