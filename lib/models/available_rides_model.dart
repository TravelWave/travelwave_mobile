import 'package:geolocator/geolocator.dart';
import 'package:travelwave_mobile/models/user_info.dart';

class AvailableRides {
  String? sId;
  Vehicle? vehicle;
  String? driver;
  List<UserInfo>? passengers;
  int? numberOfPassengers;
  double? latitude;
  double? longitude;
  double? currentLocationLatitude;
  double? currentLocationLongitude;
  int? availableSeats;
  Null? shortestPath;
  bool? isPooled;
  bool? isScheduled;
  int? iV;
  String? id;
  double distance = 1e9;

  AvailableRides({
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
    this.iV,
    this.id,
  });

  AvailableRides.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vehicle =
        json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
    driver = json['driver'];
    numberOfPassengers = json['number_of_passengers'];
    currentLocationLatitude = json['current_location_latitude'];
    currentLocationLongitude = json['current_location_longitude'];
    availableSeats = json['available_seats'];
    iV = json['__v'];
    id = json['id'];
  }
}

class Vehicle {
  String? sId;
  String? driver;
  String? name;
  String? make;
  String? model;
  String? color;
  String? licensePlate;
  int? numberOfSeats;
  int? year;
  bool? isBusy;
  String? driverLicense;
  String? driverLicenseExpirationDate;
  bool? isVerified;
  int? iV;
  String? id;

  Vehicle({
    this.sId,
    this.driver,
    this.name,
    this.make,
    this.model,
    this.color,
    this.licensePlate,
    this.numberOfSeats,
    this.year,
    this.isBusy,
    this.driverLicense,
    this.driverLicenseExpirationDate,
    this.isVerified,
    this.iV,
    this.id,
  });

  Vehicle.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    driver = json['driver'];
    name = json['name'];
    make = json['make'];
    model = json['model'];
    color = json['color'];
    licensePlate = json['license_plate'];
    numberOfSeats = json['number_of_seats'];
    year = json['year'];
    isBusy = json['is_busy'];
    driverLicense = json['driver_license'];
    driverLicenseExpirationDate = json['driver_license_expiration_date'];
    isVerified = json['is_verified'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['driver'] = this.driver;
    data['name'] = this.name;
    data['make'] = this.make;
    data['model'] = this.model;
    data['color'] = this.color;
    data['license_plate'] = this.licensePlate;
    data['number_of_seats'] = this.numberOfSeats;
    data['year'] = this.year;
    data['is_busy'] = this.isBusy;
    data['driver_license'] = this.driverLicense;
    data['driver_license_expiration_date'] = this.driverLicenseExpirationDate;
    data['is_verified'] = this.isVerified;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}
