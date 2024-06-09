import 'package:travelwave_mobile/models/pass_riderequest_model.dart';

abstract class PassRideRequestEvent {}

class CreatePassRideRequest extends PassRideRequestEvent {
  final PassRideRequest rideInfo;

  CreatePassRideRequest({required this.rideInfo});
}

class CreatePassScheduledRideRequest extends PassRideRequestEvent {
  final PassRideRequest rideInfo;

  CreatePassScheduledRideRequest({required this.rideInfo});
}

class MakeItAccepted extends PassRideRequestEvent {}

class CancelPassRideRequest extends PassRideRequestEvent {}

class SchedulePassRideRequest extends PassRideRequestEvent {}
