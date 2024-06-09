import 'package:bloc/bloc.dart';
import 'package:travelwave_mobile/blocs/passRideRequest/pass_ride_request_event.dart';
import 'package:travelwave_mobile/blocs/passRideRequest/pass_ride_request_state.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/repositories/pass_riderequest_repository.dart';

class PassRideRequestBloc
    extends Bloc<PassRideRequestEvent, PassRideRequestState> {
  final LocalStorage localData;

  PassRideRequestBloc({required this.localData})
      : super(PassRideRequestInitial()) {
    on<CreatePassScheduledRideRequest>((event, emit) async {
      emit(PassScheduledRideRequestLoading());

      // final token = await localData.readFromStorage('Token');
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjRkYWRmMWYzMTBmNzczZWE1MDI3ZWYiLCJmdWxsX25hbWUiOiJVc2VyIiwicGhvbmVfbnVtYmVyIjoiKzI1MTk2NjAxOTQyOSIsImlzX3N0YWZmIjp0cnVlLCJpc19kcml2ZXIiOmZhbHNlLCJyYXRpbmciOjUsImlzX2FjdGl2ZSI6dHJ1ZSwiaWF0IjoxNzE2NDA5Mzg1fQ.RmkV69hCB0nGyIsRQymTTp6UqGWluRVZ6pLquXshGnA';

      try {
        print('about to request ....');
        final ok = await PassRideRequestRepository(token: token)
            .createScheduledRideRequest(event.rideInfo);
        if (ok) {
          emit(PassScheduledRideRequestSuccess());
        } else {
          throw Exception('Failed to create ride request');
        }
      } catch (e) {
        emit(PassRideRequestFailure(e.toString()));
      }
    });
    on<CreatePassRideRequest>((event, emit) async {
      emit(PassRideRequestLoading());

      // final token = await localData.readFromStorage('Token');
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjRkYWRmMWYzMTBmNzczZWE1MDI3ZWYiLCJmdWxsX25hbWUiOiJVc2VyIiwicGhvbmVfbnVtYmVyIjoiKzI1MTk2NjAxOTQyOSIsImlzX3N0YWZmIjp0cnVlLCJpc19kcml2ZXIiOmZhbHNlLCJyYXRpbmciOjUsImlzX2FjdGl2ZSI6dHJ1ZSwiaWF0IjoxNzE2NDA5Mzg1fQ.RmkV69hCB0nGyIsRQymTTp6UqGWluRVZ6pLquXshGnA';

      try {
        final ok = await PassRideRequestRepository(token: token)
            .createRideRequest(event.rideInfo);
        if (ok) {
          emit(PassRideRequestSuccess());
        } else {
          throw Exception('Failed to create ride request');
        }
      } catch (e) {
        emit(PassRideRequestFailure(e.toString()));
      }
    });
  }
}

int getIntervalInMinutes(DateTime startTime, DateTime endTime) {
  final duration = endTime.difference(startTime);
  final minutes = duration.inMinutes.remainder(Duration.minutesPerHour);
  return minutes;
}
