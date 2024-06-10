part of 'accept_ride_bloc.dart';

sealed class AcceptRideEvent extends Equatable {
  const AcceptRideEvent();

  @override
  List<Object> get props => [];
}

class AcceptRide extends AcceptRideEvent {
  final String rideId;
  final String requestId;
  final String passengerId;
  final bool isPooled;
  final bool isScheduled;

  const AcceptRide(
      {required this.rideId,
      required this.requestId,
      required this.passengerId,
      required this.isPooled,
      required this.isScheduled});

  @override
  List<Object> get props =>
      [rideId, requestId, passengerId, isPooled, isScheduled];
}
