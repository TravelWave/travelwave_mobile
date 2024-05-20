import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/models/riderequest_model.dart';
import 'package:travelwave_mobile/repositories/riderequest_repository.dart';

part 'ride_request_event.dart';
part 'ride_request_state.dart';

class RideRequestBloc extends Bloc<RideRequestEvent, RideRequestState> {
  final LocalStorage localData;
  RideRequestBloc({required this.localData}) : super(RideRequestInitial()) {
    on<RideRequestEvent>((event, emit) async {
      if (event is CreateRideRequest) {
        emit(RideRequestedLoading());
        // final token = await localData.readFromStorage('Token');
        // Call the repository to submit the feedback
        try {
          await RideRequestRepository(token: "token")
              .createRideRequest(event.rideRequest);

          emit(RideRequestedSucess());
        } catch (e) {
          emit(RideRequestedError(e.toString()));
        }
      }
    });
  }
}
