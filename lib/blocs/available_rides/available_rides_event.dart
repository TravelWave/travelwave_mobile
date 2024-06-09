import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/models/accepted_ride_request_model.dart';
import 'package:travelwave_mobile/screens/home/home_driver.dart';

abstract class AvailableRidesEvent {}

class GetAvailableRides extends AvailableRidesEvent {
  final LatLng currentLocation;
  GetAvailableRides({required this.currentLocation});
}

class GetAvailableScheduledRides extends AvailableRidesEvent {
  final LatLng currentLocation;
  GetAvailableScheduledRides({required this.currentLocation});
}

class JoinRideRequestEvent extends AvailableRidesEvent {
  final String rideId;
  final LatLng source;
  final LatLng destination;
  JoinRideRequestEvent({
    required this.rideId,
    required this.source,
    required this.destination,
  });
}

class JoinScheduledRideRequestEvent extends AvailableRidesEvent {
  final String rideId;
  final LatLng source;
  final LatLng destination;

  JoinScheduledRideRequestEvent({
    required this.rideId,
    required this.source,
    required this.destination,
  });
}

class MakePooledAccepted extends AvailableRidesEvent {
  final AcceptedRideRequestModel rideInfo;
  MakePooledAccepted({required this.rideInfo});
}
