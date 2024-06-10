part of 'ride_request_bloc.dart';

sealed class RideRequestEvent extends Equatable {
  const RideRequestEvent();

  @override
  List<Object> get props => [];
}

class CreateRideRequest extends RideRequestEvent {
  final RideRequest rideRequest;

  const CreateRideRequest({required this.rideRequest});

  @override
  List<Object> get props => [rideRequest];
}

class GetRideRequest extends RideRequestEvent {
  const GetRideRequest();

  @override
  List<Object> get props => [];
}

class CancelRideRequest extends RideRequestEvent {
  final String rideId;

  const CancelRideRequest({required this.rideId});

  @override
  List<Object> get props => [rideId];
}

class DeclineRideRequest extends RideRequestEvent {
  final String requestId;

  const DeclineRideRequest(this.requestId);
}

class AcceptRideRequest extends RideRequestEvent {
  final bool isPooled;
  final bool isScheduled;
  final String requestId;
  final String rideId;
  final String passengerId;

  const AcceptRideRequest(
      {required this.isPooled,
      required this.isScheduled,
      required this.requestId,
      required this.rideId,
      required this.passengerId});
}
