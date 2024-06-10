part of 'passenger_bloc_bloc.dart';

sealed class PassengerBlocState extends Equatable {
  const PassengerBlocState();

  @override
  List<Object> get props => [];
}

final class PassengerBlocInitial extends PassengerBlocState {}

final class PassengerBlocFetching extends PassengerBlocState {}

final class PassengerBlocError extends PassengerBlocState {}

final class PassengerBlocSuccess extends PassengerBlocState {
  final UserInfo passenger;
  const PassengerBlocSuccess({required this.passenger});
}
