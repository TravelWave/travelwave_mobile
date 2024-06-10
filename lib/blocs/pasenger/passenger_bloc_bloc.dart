import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/models/user_info.dart';
import 'package:travelwave_mobile/repositories/user_repository.dart';

part 'passenger_bloc_event.dart';
part 'passenger_bloc_state.dart';

class PassengerBloc extends Bloc<PassengerBlocEvent, PassengerBlocState> {
  final LocalStorage localdata;
  PassengerBloc({required this.localdata}) : super(PassengerBlocInitial()) {
    on<PassengerBlocEvent>((event, emit) async {
      if (event is PassengerFetch) {
        emit(PassengerBlocFetching());
        try {
          final passenger = await UserRepository(
                  token: await localdata.readFromStorage("Token"))
              .getUser(event.id);
          emit(PassengerBlocSuccess(passenger: passenger));
        } catch (e) {
          print(e);
          emit(PassengerBlocError());
        }
      }
    });
  }
}
