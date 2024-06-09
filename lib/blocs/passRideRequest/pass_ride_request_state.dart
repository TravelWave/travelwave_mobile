abstract class PassRideRequestState {
  toJson() {}
}

class PassRideRequestInitial extends PassRideRequestState {}

class PassRideRequestLoading extends PassRideRequestState {}

class PassScheduledRideRequestLoading extends PassRideRequestState {}

class PassRideRequestSuccess extends PassRideRequestState {}

class PassScheduledRideRequestSuccess extends PassRideRequestState {}

class PassRideRequestFailure extends PassRideRequestState {
  final String error;

  PassRideRequestFailure(this.error);
}

class PassScheduledRideRequestFailure extends PassRideRequestState {
  final String error;

  PassScheduledRideRequestFailure(this.error);
}
