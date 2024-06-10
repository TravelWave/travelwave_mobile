import 'package:travelwave_mobile/models/accepted_ride_request_model.dart';
import 'package:travelwave_mobile/models/available_rides_model.dart';
import 'package:travelwave_mobile/models/ride_info_model.dart';

abstract class AvailableRidesState {}

class AvailableRidesInitialState extends AvailableRidesState {}

class AvailableRidesLoadingState extends AvailableRidesState {}

class AvailableScheduledRidesLoadingState extends AvailableRidesState {}

class AvailableRidesSuccessState extends AvailableRidesState {
  final List<AvailableRides> rideList;
  AvailableRidesSuccessState({required this.rideList});
}

class AvailableScheduledRidesSuccessState extends AvailableRidesState {
  final List<AvailableRides> rideList;
  AvailableScheduledRidesSuccessState({required this.rideList});
}

class AvailableRidesFailureState extends AvailableRidesState {
  final String error;
  AvailableRidesFailureState({required this.error});
}

class AvailableScheduledRidesFailureState extends AvailableRidesState {
  final String error;
  AvailableScheduledRidesFailureState({required this.error});
}

class JoinRideStateLoading extends AvailableRidesState {}

class JoinScheduledRideStateLoading extends AvailableRidesState {}

class AskJoinRideStateSuccess extends AvailableRidesState {
  final AcceptedRideRequestModel acceptedRideRequest;

  AskJoinRideStateSuccess({
    required this.acceptedRideRequest,
  });
}

class AskJoinScheduledRideStateSuccess extends AvailableRidesState {
  final AcceptedRideRequestModel acceptedRideRequest;

  AskJoinScheduledRideStateSuccess({
    required this.acceptedRideRequest,
  });
}

class JoinRideStateFailure extends AvailableRidesState {
  final String error;
  JoinRideStateFailure({required this.error});
}

class JoinScheduledRideStateFailure extends AvailableRidesState {
  final String error;
  JoinScheduledRideStateFailure({required this.error});
}

class JoinPooledRideStateLoad extends AvailableRidesState {}
