class RideHistory {
  double? pickupLatitude;
  double? pickupLongitude;
  double? dropoffLatitude;
  double? dropoffLongitude;
  int? fareAmount;
  String? startDatetime;
  int? distance;
  int? totalEarning;
  int? totalExpenditure;

  RideHistory(
      {this.pickupLatitude,
      this.pickupLongitude,
      this.dropoffLatitude,
      this.dropoffLongitude,
      this.fareAmount,
      this.startDatetime,
      this.distance,
      this.totalEarning,
      this.totalExpenditure});

  RideHistory.fromJson(Map<String, dynamic> json) {
    pickupLatitude = json['pickup_latitude'];
    pickupLongitude = json['pickup_longitude'];
    dropoffLatitude = json['dropoff_latitude'];
    dropoffLongitude = json['dropoff_longitude'];
    fareAmount = json['fare_amount'];
    startDatetime = json['start_datetime'];
    distance = json['distance'];
    totalEarning = json['total_earning'];
    totalExpenditure = json['total_expenditure'];
  }
  static List<RideHistory> tolist(List data) {
    final allhistory = data.map((e) => RideHistory.fromJson(e)).toList();
    return allhistory;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pickup_latitude'] = pickupLatitude;
    data['pickup_longitude'] = pickupLongitude;
    data['dropoff_latitude'] = dropoffLatitude;
    data['dropoff_longitude'] = dropoffLongitude;
    data['fare_amount'] = fareAmount;
    data['start_datetime'] = startDatetime;
    data['distance'] = distance;
    data['total_earning'] = totalEarning;
    data['total_expenditure'] = totalExpenditure;
    return data;
  }
}
