class Passenger {
  String? fullName;
  String? phoneNumber;
  bool? isDriver;
  String? password;
  String? gender;

  Passenger({
    this.fullName,
    this.phoneNumber,
    this.isDriver,
    this.password,
    this.gender,
  });

  Passenger.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    isDriver = json['is_driver'];
    password = json['password'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    data['is_driver'] = this.isDriver;
    data['password'] = this.password;
    data['gender'] = this.gender;
    return data;
  }
}
