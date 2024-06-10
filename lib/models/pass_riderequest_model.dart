class PassRideRequest {
  double? startLatitude;
  double? startLongitude;
  double? endLatitude;
  double? endLongitude;
  String? requestTime;
  String? status;
  String? scheduledTime;

  PassRideRequest(
      {this.startLatitude,
      this.startLongitude,
      this.endLatitude,
      this.endLongitude,
      this.requestTime,
      this.status,
      this.scheduledTime});

  PassRideRequest.fromJson(Map<String, dynamic> json) {
    startLatitude = json['start_latitude'];
    startLongitude = json['start_longitude'];
    endLatitude = json['end_latitude'];
    endLongitude = json['end_longitude'];
    requestTime = json['request_time'];
    status = json['status'];
    scheduledTime = json['scheduled_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_latitude'] = this.startLatitude.toString();
    data['start_longitude'] = this.startLongitude.toString();
    data['end_latitude'] = this.endLatitude.toString();
    data['end_longitude'] = this.endLongitude.toString();
    data['request_time'] = this.requestTime.toString();
    data['status'] = this.status.toString();
    data['scheduled_time'] = this.scheduledTime.toString();
    return data;
  }
}
