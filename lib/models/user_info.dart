import 'package:travelwave_mobile/data/decode_token.dart';

class UserInfo {
  String? userId;
  String? fullName;
  String? phoneNumber;
  bool? isStaff;
  late bool isDriver;
  int? rating;
  bool? isActive;
  int? iat;

  UserInfo(
      {this.userId,
      this.fullName,
      this.phoneNumber,
      this.isStaff,
      this.isDriver = false,
      this.rating,
      this.isActive,
      this.iat});

  UserInfo.fromJson(String token) {
    final json = parseJwt(token);

    userId = json['userId'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    isStaff = json['is_staff'];
    isDriver = json['is_driver'] ?? false;
    rating = json['rating'];
    isActive = json['is_active'];
    iat = json['iat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['full_name'] = fullName;
    data['phone_number'] = phoneNumber;
    data['is_staff'] = isStaff;
    data['is_driver'] = isDriver;
    data['rating'] = rating;
    data['is_active'] = isActive;
    data['iat'] = iat;
    return data;
  }
}
