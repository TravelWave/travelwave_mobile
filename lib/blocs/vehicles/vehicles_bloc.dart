import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/models/driver_model.dart';
import 'package:travelwave_mobile/repositories/vehicle_repository.dart';

part 'vehicles_event.dart';
part 'vehicles_state.dart';

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> {
  final LocalStorage localdata;
  VehiclesBloc({required this.localdata}) : super(VehiclesInitial()) {
    on<VehiclesEvent>((event, emit) async {
      if (event is FetchVehiclesByDriver) {
        emit(VehiclesFetching());
        try {
          final vehicles = await VehicleRepository(
                  token: await localdata.readFromStorage("Token"))
              .getvehicleDriver(event.id);
          emit(VehiclesFetchSuccess(vehicle: vehicles));
        } catch (e) {
          emit(VehiclesFetchError());
        }
      }
      if (event is CreateVehiclesByDriver) {
        emit(VehiclesFetching());
        try {
          final vehicles = await VehicleRepository(
                  token: await localdata.readFromStorage("Token"))
              .createvehicleDriver(event.vehicle);
          emit(VehiclesFetchSuccess(vehicle: vehicles));
        } catch (e) {
          print(e);
          emit(VehiclesFetchError());
        }
      }
    });
  }
}
