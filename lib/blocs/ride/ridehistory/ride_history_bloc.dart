import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/models/ridehistory_model.dart';
import 'package:travelwave_mobile/repositories/ridehistory_repository.dart';

part 'ride_history_event.dart';
part 'ride_history_state.dart';

class RideHistoryBloc extends Bloc<RideHistoryEvent, RideHistoryState> {
  final LocalStorage localdata;
  RideHistoryBloc({required this.localdata}) : super(RideHistoryInitial()) {
    on<RideHistoryEvent>((event, emit) async {
      if (event is FetchRideHistory) {
        emit(RideHistoryFetching());
        try {
          final rides = await RideHistoryRepository(
                  token: await localdata.readFromStorage("Token"))
              .getRideHistoryByUser(event.id);
          emit(RideHistorySuccess(rideHistory: rides));
        } catch (e) {
          emit(RideHistoryError());
        }
      }
      // TODO: implement event handler
    });
  }
}
