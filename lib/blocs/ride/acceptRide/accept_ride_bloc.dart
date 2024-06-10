import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/models/riderequest_model.dart';
import 'package:travelwave_mobile/repositories/ride_repository.dart';
import 'package:travelwave_mobile/repositories/riderequest_repository.dart';
import 'package:travelwave_mobile/services/utils/formatter.dart';

part 'accept_ride_event.dart';
part 'accept_ride_state.dart';

class AcceptRideBloc extends Bloc<AcceptRideEvent, AcceptRideState> {
  final LocalStorage localdata;
  AcceptRideBloc({required this.localdata}) : super(AcceptRideInitial()) {
    on<AcceptRideEvent>((event, emit) async {
      if (event is AcceptRide) {
        final isPooled = event.isPooled;

        final isScheduled = event.isScheduled;
        emit(AcceptRideLoading());
        try {
          Map res = {};
          final token = await localdata.readFromStorage('Token');
          if (isPooled && isScheduled) {
            res = await RideRequestRepository(token: token)
                .acceptPooledRideRequest(event.requestId, event.passengerId);
          } else if (isScheduled && !isPooled) {
            res = await RideRequestRepository(token: token)
                .acceptRideRequestScheduled(event.requestId);
          } else if (!isScheduled && isPooled) {
            print("object");
            res = await RideRequestRepository(token: token)
                .acceptPooledRideRequest(event.rideId, event.passengerId);
          } else {
            print("object");
            res = await RideRequestRepository(token: token)
                .acceptRideRequest(event.requestId);
          }
          print(res);
          if (res['status'] == 'error') {
            emit(AcceptRideError(error: res['message']));
            return;
          }

          RideRequest rideReq = res['data'];
          String startLocation = await getLocationFromCoordinates(
            rideReq.startLatitude,
            rideReq.startLongitude,
          );
          String endLocation = await getLocationFromCoordinates(
            rideReq.endLatitude,
            rideReq.endLongitude,
          );
          RideRequestWithLocation ride = RideRequestWithLocation(
            id: rideReq.id,
            rideId: rideReq.rideId,
            passenger: rideReq.passengerId,
            startLatitude: rideReq.startLatitude,
            startLongitude: rideReq.startLongitude,
            endLatitude: rideReq.endLatitude,
            endLongitude: rideReq.endLongitude,
            startLocation: startLocation,
            endLocation: endLocation,
            requestTime: rideReq.requestTime,
            status: rideReq.status,
            isPooled: rideReq.isPooled,
            isScheduled: rideReq.isScheduled,
            shortestPath: rideReq.shortestPath,
          );

          emit(AcceptRideSuccess(rideRequest: ride));
        } catch (e) {
          print(e);
          emit(AcceptRideError(error: "Error accepting ride:${e.toString()}"));
        }
      }
      // TODO: implement event handler
    });
  }
}
