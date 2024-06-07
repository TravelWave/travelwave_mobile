import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/models/create_ride.dart';
import 'package:travelwave_mobile/models/riderequest_model.dart';
import 'package:travelwave_mobile/repositories/riderequest_repository.dart';
import 'package:travelwave_mobile/services/utils/formatter.dart';

part 'ride_request_event.dart';
part 'ride_request_state.dart';

class RideRequestBloc extends Bloc<RideRequestEvent, RideRequestState> {
  final LocalStorage localData;
  RideRequestBloc({required this.localData}) : super(RideRequestInitial()) {
    on<RideRequestEvent>((event, emit) async {
      final token = await localData.readFromStorage('Token');
      if (event is CreateRideRequest) {
        emit(RideRequestedLoading());
        // final token = await localData.readFromStorage('Token');
        // Call the repository to submit the feedback
        try {
          await RideRequestRepository(token: token)
              .createRideRequest(event.rideRequest);

          emit(RideRequestedSucess());
        } catch (e) {
          emit(RideRequestedError(e.toString()));
        }
      }
      if (event is GetRideRequest) {
        emit(GetRidesLoading());
        try {
          final rideRequest =
              await RideRequestRepository(token: token).getRideRequests();
          List<RideRequestWithLocation> rides = [];
          for (var request in rideRequest) {
            String startLocation = await getLocationFromCoordinates(
              request.startLatitude,
              request.startLongitude,
            );
            String endLocation = await getLocationFromCoordinates(
              request.endLatitude,
              request.endLongitude,
            );
            rides.add(
              RideRequestWithLocation(
                shortestPath: request.shortestPath,
                endLatitude: request.endLatitude,
                endLongitude: request.endLongitude,
                startLatitude: request.startLatitude,
                startLongitude: request.startLongitude,
                id: request.id,
                passenger: request.passengerId,
                startLocation: startLocation,
                endLocation: endLocation,
                requestTime: request.requestTime,
                status: request.status,
                isPooled: request.isPooled,
                isScheduled: request.isScheduled,
              ),
            );
          }
          emit(GetRidesSucess(rideInfo: rides));
        } catch (e) {
          emit(GetRidesError(e.toString()));
        }
      }
      if (event is DeclineRideRequest) {
        print("object");

        final currstate = state as GetRidesSucess;
        emit(GetRidesLoading());
        print(currstate);
        final updatedRideInfo = currstate.rideInfo
            .where((request) => request.id != event.requestId)
            .toList();
        print(updatedRideInfo);
        print(currstate.rideInfo);

        emit(GetRidesSucess(rideInfo: updatedRideInfo));
      }
      if (event is AcceptRideRequest) {
        final isPooled = event.rideRequest.isPooled;
        final currstate = state as GetRidesSucess;

        final isScheduled = event.rideRequest.isScheduled;
        emit(GetRidesLoading());
        try {
          Map res = {};
          final token = await localData.readFromStorage('Token');
          if (isPooled && isScheduled) {
            await RideRequestRepository(token: token).acceptPooledRideRequest(
                event.rideRequest.id, event.rideRequest.passenger);
          } else if (isScheduled && !isPooled) {
            await RideRequestRepository(token: token)
                .acceptRideRequestScheduled(event.rideRequest.id);
          } else if (!isScheduled && isPooled) {
            await RideRequestRepository(token: token).acceptPooledRideRequest(
                event.rideRequest.id, event.rideRequest.passenger);
          } else {
            print("object");
            res = await RideRequestRepository(token: token)
                .acceptRideRequest(event.rideRequest.id);
          }
          print(res);
          if (res['status'] == 'error') {
            emit(AcceptRideRequestError(error: res['message']));
            return;
          }
          final rideRequest =
              await RideRequestRepository(token: token).getRideRequests();
          List<RideRequestWithLocation> rides = [];
          for (var request in rideRequest) {
            String startLocation = await getLocationFromCoordinates(
              request.startLatitude,
              request.startLongitude,
            );
            String endLocation = await getLocationFromCoordinates(
              request.endLatitude,
              request.endLongitude,
            );
            rides.add(
              RideRequestWithLocation(
                shortestPath: request.shortestPath,
                endLatitude: request.endLatitude,
                endLongitude: request.endLongitude,
                startLatitude: request.startLatitude,
                startLongitude: request.startLongitude,
                id: request.id,
                passenger: request.passengerId,
                startLocation: startLocation,
                endLocation: endLocation,
                requestTime: request.requestTime,
                status: request.status,
                isPooled: request.isPooled,
                isScheduled: request.isScheduled,
              ),
            );
          }
          emit(GetRidesSucess(rideInfo: rides));
        } catch (e) {
          emit(AcceptRideRequestError(error: e.toString()));
        }
      }
    });
  }
}
