import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/signin/signin_event.dart';
import 'package:travelwave_mobile/blocs/signin/signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInUser>((event, emit) async {
      try {
        emit(SignInLoading());
        print('emitted loading state ... ');

        await Future.delayed(const Duration(seconds: 4));

        emit(SignInSuccess());
        print('emitted success state ...');
      } catch (e) {
        emit(SignInFailure(message: e.toString()));
      }
    });
  }
}
