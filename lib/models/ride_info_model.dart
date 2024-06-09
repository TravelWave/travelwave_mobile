import 'package:travelwave_mobile/models/user_info.dart';

class RideInfo {
  String? sId;
  String? vehicle;
  String? driver;
  List<UserInfo>? passengers;
  int? numberOfPassengers;
  double? latitude;
  double? longitude;
  double? currentLocationLatitude;
  double? currentLocationLongitude;
  int? availableSeats;
  String? shortestPath;
  bool? isPooled;
  bool? isScheduled;

  RideInfo({
    this.sId,
    this.vehicle,
    this.driver,
    this.passengers,
    this.numberOfPassengers,
    this.latitude,
    this.longitude,
    this.currentLocationLatitude,
    this.currentLocationLongitude,
    this.availableSeats,
    this.shortestPath,
    this.isPooled,
    this.isScheduled,
  });

  RideInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vehicle = json['vehicle'];
    driver = json['driver'];
    numberOfPassengers = json['number_of_passengers'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    currentLocationLatitude = json['current_location_latitude'];
    currentLocationLongitude = json['current_location_longitude'];
    availableSeats = json['available_seats'];
    shortestPath = json['shortest_path'];
    isPooled = json['is_pooled'];
    isScheduled = json['is_scheduled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['vehicle'] = this.vehicle;
    data['driver'] = this.driver;
    if (this.passengers != null) {
      data['passengers'] = this.passengers!.map((v) => v.toJson()).toList();
    }
    data['number_of_passengers'] = this.numberOfPassengers;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['current_location_latitude'] = this.currentLocationLatitude;
    data['current_location_longitude'] = this.currentLocationLongitude;
    data['available_seats'] = this.availableSeats;
    data['shortest_path'] = this.shortestPath;
    data['is_pooled'] = this.isPooled;
    data['is_scheduled'] = this.isScheduled;
    return data;
  }
}
