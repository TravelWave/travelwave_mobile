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

class CancelRideRequest extends RideRequestEvent {
  final String rideId;

  const CancelRideRequest({required this.rideId});

  @override
  List<Object> get props => [rideId];
}
