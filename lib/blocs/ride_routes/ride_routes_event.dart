import 'package:travelwave_mobile/models/ride_info_model.dart';

abstract class RideRoutesEvent {}

class GetRideRoutes extends RideRoutesEvent {
  final String driverId;
  final String rideId;

  GetRideRoutes({
    required this.driverId,
    required this.rideId,
  });
}

class CreateRideRoutes extends RideRoutesEvent {}

class CancelRideRequest extends RideRoutesEvent {
  final String requestId;

  CancelRideRequest({
    required this.requestId,
  });
}
