import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  String? _latestUserId;
  NotificationBloc() : super(NotificationInitial()) {
    on<NewNotificationReceived>((event, emit) {
      if (event.userId != _latestUserId) {
        _latestUserId = event.userId;

        emit(NotificationInitial());
        emit(NotificationReceived(
            isPooled: event.isPooled,
            isscheduled: event.scheduled,
            message: event.message,
            userId: event.userId,
            rideId: event.rideId,
            rideRequestId: event.rideRequestId));
      }
    });

    on<CancelNewNotificationReceived>((event, emit) {
      emit(NotificationInitial());
      emit(CancelNotificationReceived(event.message, event.userId));
    });

    on<RideFinishedNotification>((event, emit) {
      emit(NotificationInitial());
      emit(RideFinishNotificationReceived(event.message, event.userId));
    });
  }
}
