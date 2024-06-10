part of 'vehicles_bloc.dart';

sealed class VehiclesState extends Equatable {
  const VehiclesState();

  @override
  List<Object> get props => [];
}

final class VehiclesInitial extends VehiclesState {}

final class VehiclesFetching extends VehiclesState {}

final class VehiclesFetchSuccess extends VehiclesState {
  final DriverModel? vehicle;
  const VehiclesFetchSuccess({required this.vehicle});
}

final class VehiclesFetchError extends VehiclesState {}
