class AcceptedRideRequestModel {
  String? userId;
  String? message;
  double? fareAmount;
  String? rideId;
  String? eta;
  double? distance;
  String? detourDistance;
  String? passengerId;

  AcceptedRideRequestModel({
    this.userId,
    this.message,
    this.fareAmount,
    this.rideId,
    this.eta,
    this.distance,
    this.detourDistance,
    this.passengerId,
  });

  AcceptedRideRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? json['driverId'];
    message = json['message'];
    fareAmount = json['fareAmount'];
    rideId = json['rideId'];
    // eta = json['eta'];
    distance = json['distance'] ?? json['totalDistance'];
    // detourDistance = json['detourDistance'];
    passengerId = json['passengerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['message'] = this.message;
    data['fareAmount'] = this.fareAmount;
    data['rideId'] = this.rideId;
    data['eta'] = this.eta;
    data['distance'] = this.distance;
    return data;
  }
}
