import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/models/create_ride.dart';
import 'package:travelwave_mobile/models/riderequest_model.dart';
import 'package:travelwave_mobile/repositories/ride_repository.dart';
import 'package:travelwave_mobile/repositories/riderequest_repository.dart';

part 'create_ride_event.dart';
part 'create_ride_state.dart';

class CreateRideBloc extends Bloc<CreateRideEvent, CreateRideState> {
  final LocalStorage localData;
  CreateRideBloc({required this.localData}) : super(CreateRideInitial()) {
    on<CreateRide>((event, emit) async {
      final isPooled = event.rideInfo.isPooled;

      final isScheduled = event.rideInfo.isScheduled;

      emit(CreateRideLoading());
      try {
        final token = await localData.readFromStorage('Token');
        if (isPooled && isScheduled) {
          print("dsjdhj");
          await RideRepository(token: token)
              .createScheduledPooledRide(event.rideInfo);
        } else if (isScheduled) {
          await RideRepository(token: token)
              .createOneScheduledRide(event.rideInfo);
        } else if (isPooled) {
          await RideRepository(token: token).createPooledRide(event.rideInfo);
        } else {
          print("object");
          await RideRepository(token: token).createOneRide(event.rideInfo);
        }
        emit(const CreateRideSuccess());
      } catch (e) {
        print(e);
        emit(CreateRideError(e.toString()));
      }
    });
  }
}
