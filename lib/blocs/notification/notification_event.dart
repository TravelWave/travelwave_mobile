import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NewNotificationReceived extends NotificationEvent {
  final String message;
  final String userId;

  const NewNotificationReceived(this.message, this.userId);

  @override
  List<Object> get props => [message];
}

class CancelNewNotificationReceived extends NotificationEvent {
  final String message;
  final String userId;

  const CancelNewNotificationReceived(this.message, this.userId);

  @override
  List<Object> get props => [message];
}
