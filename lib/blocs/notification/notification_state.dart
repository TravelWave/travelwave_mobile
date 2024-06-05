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

  const NotificationReceived(this.message, this.userId);

  @override
  List<Object> get props => [message];
}

class NotificationHandled extends NotificationState {}
