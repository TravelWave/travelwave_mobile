class DriverInfo {
  bool? isStaff;
  int? rating;
  String? sId;
  String? fullName;
  String? phoneNumber;
  String? password;
  bool? isDriver;
  bool? isActive;
  String? imgProfile;
  String? createdAt;
  String? updatedAt;
  String? id;

  DriverInfo(
      {this.isStaff,
      this.rating,
      this.sId,
      this.fullName,
      this.phoneNumber,
      this.password,
      this.isDriver,
      this.imgProfile,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.id});

  DriverInfo.fromJson(Map<String, dynamic> json) {
    isStaff = json['is_staff'];
    rating = json['rating'];
    sId = json['_id'];
    imgProfile = json['profile_picture'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    isDriver = json['is_driver'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_staff'] = this.isStaff;
    data['rating'] = this.rating;
    data['_id'] = this.sId;
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    data['password'] = this.password;
    data['is_driver'] = this.isDriver;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fullName'] = this.fullName;
    data['id'] = this.id;
    return data;
  }
}
