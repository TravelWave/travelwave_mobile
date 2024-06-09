import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/ride_routes/ride_routes_event.dart';
import 'package:travelwave_mobile/blocs/ride_routes/ride_routes_state.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/repositories/pass_riderequest_repository.dart';

class RideRoutesBloc extends Bloc<RideRoutesEvent, RideRouteState> {
  final LocalStorage localData;
  RideRoutesBloc({required this.localData}) : super(RideRoutesStateInitial()) {
    on<GetRideRoutes>((event, emit) async {
      emit(RideRoutesStateLoading());
      // final token = await localData.readFromStorage('Token');
      const token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjRkYWRmMWYzMTBmNzczZWE1MDI3ZWYiLCJmdWxsX25hbWUiOiJVc2VyIiwicGhvbmVfbnVtYmVyIjoiKzI1MTk2NjAxOTQyOSIsImlzX3N0YWZmIjp0cnVlLCJpc19kcml2ZXIiOmZhbHNlLCJyYXRpbmciOjUsImlzX2FjdGl2ZSI6dHJ1ZSwiaWF0IjoxNzE2NDA5Mzg1fQ.RmkV69hCB0nGyIsRQymTTp6UqGWluRVZ6pLquXshGnA";
      try {
        print('fetching driver data ...');
        final driver = await PassRideRequestRepository(token: token)
            .getUserInfo(event.driverId);
        print('done fetching driver data ...');

        print('fetching ride info ...');

        final rideInfo = await PassRideRequestRepository(token: token)
            .getRideInfo(event.rideId);
        print('done fetching ride info ...');

        emit(
          RideRoutesStateSuccess(
            userInfo: driver,
            rideInfo: rideInfo,
          ),
        );
      } catch (e) {
        emit(RideRoutesStateFailure(error: e.toString()));
      }
    });
  }
}
