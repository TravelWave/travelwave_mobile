part of 'vehicles_bloc.dart';

sealed class VehiclesEvent extends Equatable {
  const VehiclesEvent();

  @override
  List<Object> get props => [];
}

class FetchVehiclesByDriver extends VehiclesEvent {
  final String id;
  const FetchVehiclesByDriver({required this.id});
  @override
  List<Object> get props => [id];
}

class CreateVehiclesByDriver extends VehiclesEvent {
  final DriverModel vehicle;
  const CreateVehiclesByDriver({required this.vehicle});
  @override
  List<Object> get props => [vehicle];
}
