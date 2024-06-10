import 'package:bloc/bloc.dart';
import 'package:travelwave_mobile/blocs/passRideRequest/pass_ride_request_event.dart';
import 'package:travelwave_mobile/blocs/passRideRequest/pass_ride_request_state.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/models/pass_riderequest_model.dart';
import 'package:travelwave_mobile/repositories/pass_riderequest_repository.dart';
import 'package:travelwave_mobile/screens/home/home_transport.dart';

class PassRideRequestBloc
    extends Bloc<PassRideRequestEvent, PassRideRequestState> {
  final LocalStorage localData;

  PassRideRequestBloc({required this.localData})
      : super(PassRideRequestInitial()) {
    on<CreatePassScheduledRideRequest>((event, emit) async {
      emit(PassScheduledRideRequestLoading());

      try {
        print('about to request ....');
        final token = await localData.readFromStorage('Token');
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

      try {
        final token = await localData.readFromStorage('Token');
        final start = await getLocation(event.fromLoc);
        final end = await getLocation(event.toLoc);
        print(start);
        print("aftr geting location");
        PassRideRequest rideInfo = PassRideRequest(
          startLatitude: start.latitude,
          startLongitude: start.longitude,
          endLatitude: end.latitude,
          endLongitude: end.longitude,
          requestTime: DateTime.now().toString(),
          status: 'pending',
          scheduledTime: DateTime.now().toString(),
        );

        final ok = await PassRideRequestRepository(token: token)
            .createRideRequest(rideInfo);
        if (ok) {
          emit(PassRideRequestLoading());
        } else {
          throw Exception('Failed to create ride request');
        }
      } catch (e) {
        emit(PassRideRequestFailure(e.toString()));
      }
    });
    on<MakeItAccepted>((event, emit) {
      emit(PassRideRequestSuccess());
    });
  }
}
