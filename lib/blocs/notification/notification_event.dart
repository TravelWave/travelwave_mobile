import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NewNotificationReceived extends NotificationEvent {
  final String message;
  final String userId;
  final String rideId;
  final String rideRequestId;
  final bool isPooled;
  final bool scheduled;

  const NewNotificationReceived(
      {required this.message,
      required this.userId,
      required this.rideId,
      required this.rideRequestId,
      required this.isPooled,
      required this.scheduled});

  @override
  List<Object> get props =>
      [message, userId, rideId, rideRequestId, isPooled, scheduled];
}

class CancelNewNotificationReceived extends NotificationEvent {
  final String message;
  final String userId;

  const CancelNewNotificationReceived(this.message, this.userId);

  @override
  List<Object> get props => [message];
}

class RideFinishedNotification extends NotificationEvent {
  final String message;
  final String userId;

  const RideFinishedNotification(this.message, this.userId);

  @override
  List<Object> get props => [message];
}
