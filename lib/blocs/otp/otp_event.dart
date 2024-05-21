abstract class OtpEvent {}

class OtpVerifyEvent extends OtpEvent {
  final String phoneNumber;
  final String otp;

  OtpVerifyEvent({required this.phoneNumber, required this.otp});
}

class OtpResendEvent extends OtpEvent {}
