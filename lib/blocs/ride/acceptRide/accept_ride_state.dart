part of 'accept_ride_bloc.dart';

sealed class AcceptRideState extends Equatable {
  const AcceptRideState();

  @override
  List<Object> get props => [];
}

final class AcceptRideInitial extends AcceptRideState {}

final class AcceptRideLoading extends AcceptRideState {}

final class AcceptRideError extends AcceptRideState {
  final String error;

  const AcceptRideError({required this.error});
}

final class AcceptRideSuccess extends AcceptRideState {
  final RideRequestWithLocation rideRequest;
  const AcceptRideSuccess({required this.rideRequest});
}
