part of 'ride_history_bloc.dart';

sealed class RideHistoryState extends Equatable {
  const RideHistoryState();

  @override
  List<Object> get props => [];
}

final class RideHistoryInitial extends RideHistoryState {}

final class RideHistoryFetching extends RideHistoryState {}

final class RideHistorySuccess extends RideHistoryState {
  final List<RideHistory> rideHistory;
  const RideHistorySuccess({required this.rideHistory});
}

final class RideHistoryError extends RideHistoryState {}
