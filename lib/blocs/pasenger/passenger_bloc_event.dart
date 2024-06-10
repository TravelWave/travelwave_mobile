part of 'passenger_bloc_bloc.dart';

sealed class PassengerBlocEvent extends Equatable {
  const PassengerBlocEvent();

  @override
  List<Object> get props => [];
}

class PassengerFetch extends PassengerBlocEvent {
  final String id;
  const PassengerFetch({required this.id});
  @override
  List<Object> get props => [id];
}
