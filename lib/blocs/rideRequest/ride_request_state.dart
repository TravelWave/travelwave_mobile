part of 'ride_request_bloc.dart';

sealed class RideRequestState extends Equatable {
  const RideRequestState();

  @override
  List<Object> get props => [];
}

final class RideRequestInitial extends RideRequestState {}

class RideRequestedError extends RideRequestState {
  final String error;

  const RideRequestedError(this.error);
}

class RideRequestedLoading extends RideRequestState {}

class RideRequestedSucess extends RideRequestState {}
