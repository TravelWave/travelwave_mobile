part of 'create_ride_bloc.dart';

sealed class CreateRideEvent extends Equatable {
  const CreateRideEvent();

  @override
  List<Object> get props => [];
}

class CreateRide extends CreateRideEvent {
  final Ride rideInfo;

  const CreateRide({required this.rideInfo});

  @override
  List<Object> get props => [rideInfo];
}
