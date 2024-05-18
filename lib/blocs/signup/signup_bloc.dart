import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/signup/signup_event.dart';
import 'package:travelwave_mobile/blocs/signup/signup_state.dart';
import 'package:http/http.dart' as http;
import 'package:travelwave_mobile/repositories/auth_repository.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegisterUser>((event, emit) async {
      // TODO: implement event handler
      emit(RegistrationLoading());
      await Future.delayed(const Duration(seconds: 2));

      // final response = await AuthRepository.registerUser(event.user);
      emit(RegistrationSuccess());
    });
  }
}
