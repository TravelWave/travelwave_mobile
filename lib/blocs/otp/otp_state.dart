abstract class OtpState {}

class OtpInitialState extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpSuccessState extends OtpState {}

class OtpFailureState extends OtpState {
  final String error;

  OtpFailureState({required this.error});
}
