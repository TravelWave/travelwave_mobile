import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/signup/signup_event.dart';
import 'package:travelwave_mobile/blocs/signup/signup_state.dart';
 
import 'package:travelwave_mobile/repositories/auth_repository.dart';
 

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegisterUser>((event, emit) async {
      emit(RegistrationLoading());

      final response = await AuthRepository.registerUser(
        fullName: event.fullName,
        phoneNumber: event.phoneNumber,
        isDriver: event.isDriver,
        password: event.password,
      );
      await Future.delayed(const Duration(seconds: 4));

      if (response['status'] == "success") {
        emit(RegistrationSuccess());
      } else {
        emit(RegistrationFailure(error: response['message']));
      }
    });
  }
}
