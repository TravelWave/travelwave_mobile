import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travelwave_mobile/blocs/available_rides/available_rides_event.dart';
import 'package:travelwave_mobile/blocs/available_rides/available_rides_state.dart';
import 'package:travelwave_mobile/blocs/ride/rideRequest/ride_request_bloc.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/models/available_rides_model.dart';
import 'package:travelwave_mobile/repositories/pass_riderequest_repository.dart';

class AvailableRidesBloc
    extends Bloc<AvailableRidesEvent, AvailableRidesState> {
  final LocalStorage localData;
  final token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjRkYWRmMWYzMTBmNzczZWE1MDI3ZWYiLCJmdWxsX25hbWUiOiJVc2VyIiwicGhvbmVfbnVtYmVyIjoiKzI1MTk2NjAxOTQyOSIsImlzX3N0YWZmIjp0cnVlLCJpc19kcml2ZXIiOmZhbHNlLCJyYXRpbmciOjUsImlzX2FjdGl2ZSI6dHJ1ZSwiaWF0IjoxNzE2NDA5Mzg1fQ.RmkV69hCB0nGyIsRQymTTp6UqGWluRVZ6pLquXshGnA';

  AvailableRidesBloc({required this.localData})
      : super(AvailableRidesInitialState()) {
    on<GetAvailableScheduledRides>((event, emit) async {
      emit(AvailableScheduledRidesLoadingState());

      try {
        final response = await PassRideRequestRepository(token: token)
            .getRidePooledScheduled(event.currentLocation);

        if (response.isNotEmpty) {
          for (AvailableRides res in response) {
            final lat = res.currentLocationLatitude;
            final lon = res.currentLocationLongitude;

            final distance = getDistanceInMeters(
              lat!,
              lon!,
              event.currentLocation.latitude,
              event.currentLocation.longitude,
            );

            res.distance = distance;
          }
          response.sort((a, b) {
            return -a.distance.compareTo(-b.distance);
          });
          emit(AvailableScheduledRidesSuccessState(rideList: response));
        } else {
          emit(AvailableScheduledRidesFailureState(error: 'No available ride'));
        }
      } catch (e) {
        emit(AvailableScheduledRidesFailureState(error: e.toString()));
      }
    });
    on<GetAvailableRides>((event, emit) async {
      emit(AvailableRidesLoadingState());

      try {
        final response = await PassRideRequestRepository(token: token)
            .getRidePooled(event.currentLocation);

        if (response.isNotEmpty) {
          for (AvailableRides res in response) {
            final lat = res.currentLocationLatitude;
            final lon = res.currentLocationLongitude;

            final distance = getDistanceInMeters(
              lat!,
              lon!,
              event.currentLocation.latitude,
              event.currentLocation.longitude,
            );

            res.distance = distance;
          }
          response.sort((a, b) {
            return -a.distance.compareTo(-b.distance);
          });
          emit(AvailableRidesSuccessState(rideList: response));
        } else {
          emit(AvailableRidesFailureState(error: 'No available ride'));
        }
      } catch (e) {
        emit(AvailableRidesFailureState(error: e.toString()));
      }
    });
    on<JoinRideRequestEvent>((event, emit) async {
      emit(JoinRideStateLoading());
      const token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjVmOGZjOGEyMjY5YWE3NDVkZjVhNDMiLCJmdWxsX25hbWUiOiJEcml2ZXIgMyIsInBob25lX251bWJlciI6IisyNTE5ODg5MDI3MTIiLCJpc19zdGFmZiI6dHJ1ZSwiaXNfZHJpdmVyIjp0cnVlLCJyYXRpbmciOjUsImlzX2FjdGl2ZSI6dHJ1ZSwiaWF0IjoxNzE3OTIxMzgyfQ.SxJBEx9J16Vv3GgQGw3hfI9Zv0KdzXJposCA5AeL3mA";
      try {
        print('about to join the ride ...');
        final response = await PassRideRequestRepository(token: token)
            .askToJoinPooledRide(
                "665f994aa2269aa745df5ac7", event.source, event.destination);

        print('after the join pooled request repo call ..');

        emit(AskJoinRideStateSuccess(acceptedRideRequest: response));
      } catch (e) {
        emit(JoinRideStateFailure(error: e.toString()));
      }
    });
    on<JoinScheduledRideRequestEvent>((event, emit) async {
      emit(JoinScheduledRideStateLoading());
      const token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjVmOGZjOGEyMjY5YWE3NDVkZjVhNDMiLCJmdWxsX25hbWUiOiJEcml2ZXIgMyIsInBob25lX251bWJlciI6IisyNTE5ODg5MDI3MTIiLCJpc19zdGFmZiI6dHJ1ZSwiaXNfZHJpdmVyIjp0cnVlLCJyYXRpbmciOjUsImlzX2FjdGl2ZSI6dHJ1ZSwiaWF0IjoxNzE3OTIxMzgyfQ.SxJBEx9J16Vv3GgQGw3hfI9Zv0KdzXJposCA5AeL3mA";
      try {
        print('about to join the ride ...');
        final response = await PassRideRequestRepository(token: token)
            .askToJoinPooledScheduledRide(
                "665f994aa2269aa745df5ac7", event.source, event.destination);

        print('after the join pooled request repo call ..');

        emit(AskJoinScheduledRideStateSuccess(acceptedRideRequest: response));
      } catch (e) {
        emit(JoinScheduledRideStateFailure(error: e.toString()));
      }
    });
  }
}

double getDistanceInMeters(double lat1, double lon1, double lat2, double lon2) {
  final distance = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  return distance;
}
