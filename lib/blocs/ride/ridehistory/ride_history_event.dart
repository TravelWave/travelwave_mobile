part of 'ride_history_bloc.dart';

sealed class RideHistoryEvent extends Equatable {
  const RideHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchRideHistory extends RideHistoryEvent {
  final String id;
  const FetchRideHistory({required this.id});
  @override
  List<Object> get props => [id];
}
