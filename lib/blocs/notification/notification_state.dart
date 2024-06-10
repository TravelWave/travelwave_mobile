import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationReceived extends NotificationState {
  final String message;
  final String userId;
  final String rideId;
  final String rideRequestId;
  final bool isPooled;
  final bool isscheduled;

  const NotificationReceived(
      {required this.isPooled,
      required this.isscheduled,
      required this.message,
      required this.userId,
      required this.rideId,
      required this.rideRequestId});

  @override
  List<Object> get props => [message];
}

class CancelNotificationReceived extends NotificationState {
  final String message;
  final String userId;

  const CancelNotificationReceived(this.message, this.userId);

  @override
  List<Object> get props => [message];
}

class RideFinishNotificationReceived extends NotificationState {
  final String message;
  final String userId;

  const RideFinishNotificationReceived(this.message, this.userId);

  @override
  List<Object> get props => [message];
}

class RideFinishedNotificationReceived extends NotificationState {
  final String message;
  final String userId;

  const RideFinishedNotificationReceived(this.message, this.userId);

  @override
  List<Object> get props => [message];
}

class NotificationHandled extends NotificationState {}
