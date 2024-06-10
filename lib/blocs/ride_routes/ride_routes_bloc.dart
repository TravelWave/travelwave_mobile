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
      final token = await localData.readFromStorage('Token');
      try {
        final driver = await PassRideRequestRepository(token: token)
            .getUserInfo(event.driverId);

        final rideInfo = await PassRideRequestRepository(token: token)
            .getRideInfo(event.rideId);

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
    on<CancelRideRequest>((event, emit) async {
      emit(RideRoutesStateLoading());
      // final token = await localData.readFromStorage('Token');
      final token = await localData.readFromStorage('Token');
      try {
        await PassRideRequestRepository(token: token)
            .cancelRideRequest(event.requestId);
      } catch (e) {
        print(e);
      }
    });
  }
}
