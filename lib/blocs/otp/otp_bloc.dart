import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/otp/otp_event.dart';
import 'package:travelwave_mobile/blocs/otp/otp_state.dart';
import 'package:travelwave_mobile/repositories/auth_repository.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitialState()) {
    on<OtpVerifyEvent>((event, emit) async {
      emit(OtpLoadingState());

      print('about to send otp to the server ...');
      final response = await AuthRepository.sendOTP(
        otp: event.otp,
        phoneNumber: event.phoneNumber,
      );
      print('response: $response');

      if (response['status'] == 'success') {
        emit(OtpSuccessState());
      } else {
        emit(OtpFailureState(error: response['message']));
      }
    });

    on<OtpResendEvent>((event, emit) async {
      emit(OtpLoadingState());

      await Future.delayed(const Duration(seconds: 4));

      // emit(OtpSuccessState());
      emit(OtpFailureState(error: 'something is wrong'));
    });
  }
}
