class RideRequest {
  double? startLatitude;
  double? startLongitude;
  double? endLatitude;
  double? endLongitude;
  String? requestTime;
  String? status;

  RideRequest(
      {this.startLatitude,
      this.startLongitude,
      this.endLatitude,
      this.endLongitude,
      this.requestTime,
      this.status});

  RideRequest.fromJson(Map<String, dynamic> json) {
    startLatitude = json['start_latitude'];
    startLongitude = json['start_longitude'];
    endLatitude = json['end_latitude'];
    endLongitude = json['end_longitude'];
    requestTime = json['request_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_latitude'] = startLatitude;
    data['start_longitude'] = startLongitude;
    data['end_latitude'] = endLatitude;
    data['end_longitude'] = endLongitude;
    data['request_time'] = requestTime;
    data['status'] = status;
    return data;
  }
}
