part of 'create_ride_bloc.dart';

sealed class CreateRideState extends Equatable {
  const CreateRideState();

  @override
  List<Object> get props => [];
}

final class CreateRideInitial extends CreateRideState {}

class CreateRideError extends CreateRideState {
  final String error;

  const CreateRideError(this.error);
}

class CreateRideLoading extends CreateRideState {}

class CreateRideSuccess extends CreateRideState {
  const CreateRideSuccess();
}
