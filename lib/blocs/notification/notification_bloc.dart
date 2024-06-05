import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NewNotificationReceived>((event, emit) {
      emit(NotificationInitial());
      emit(NotificationReceived(event.message, event.userId));
    });
  }
}
