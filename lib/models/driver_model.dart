class DriverModel {
  String name;
  String make;
  String model;
  String color;
  String licensePlate;
  int numberOfSeats;
  int year;
  bool isBusy;
  String driverLicense;
  String driverLicenseExpirationDate;
  bool isVerified;

  DriverModel(
      {required this.name,
      required this.make,
      required this.model,
      required this.color,
      required this.licensePlate,
      required this.numberOfSeats,
      required this.year,
      required this.isBusy,
      required this.driverLicense,
      required this.driverLicenseExpirationDate,
      required this.isVerified});

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
        name: json['name'],
        make: json['make'],
        model: json['model'],
        color: json['color'],
        licensePlate: json['license_plate'],
        numberOfSeats: json['number_of_seats'],
        year: json['year'],
        isBusy: json['is_busy'],
        driverLicense: json['driver_license'],
        driverLicenseExpirationDate: json['driver_license_expiration_date'],
        isVerified: json['is_verified']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['make'] = make;
    data['model'] = model;
    data['color'] = color;
    data['license_plate'] = licensePlate;
    data['number_of_seats'] = numberOfSeats;
    data['year'] = year;
    data['is_busy'] = isBusy;
    data['driver_license'] = driverLicense;
    data['driver_license_expiration_date'] = driverLicenseExpirationDate;
    data['is_verified'] = isVerified;
    return data;
  }
}
