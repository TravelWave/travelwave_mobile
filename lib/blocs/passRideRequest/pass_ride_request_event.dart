import 'package:travelwave_mobile/models/pass_riderequest_model.dart';

abstract class PassRideRequestEvent {}

class CreatePassRideRequest extends PassRideRequestEvent {
  // final PassRideRequest rideInfo;
  final String fromLoc;
  final String toLoc;

  CreatePassRideRequest({required this.fromLoc, required this.toLoc});
}

class CreatePassScheduledRideRequest extends PassRideRequestEvent {
  final PassRideRequest rideInfo;

  CreatePassScheduledRideRequest({required this.rideInfo});
}

class MakeItAccepted extends PassRideRequestEvent {}

class CancelPassRideRequest extends PassRideRequestEvent {}

class SchedulePassRideRequest extends PassRideRequestEvent {}
