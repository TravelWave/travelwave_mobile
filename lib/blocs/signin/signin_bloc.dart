import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/auth/bloc/auth_bloc_bloc.dart';
import 'package:travelwave_mobile/blocs/signin/signin_event.dart';
import 'package:travelwave_mobile/blocs/signin/signin_state.dart';
import 'package:travelwave_mobile/models/user_info.dart';
import 'package:travelwave_mobile/repositories/auth_repository.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationBloc authBloc;
  SignInBloc({required this.authBloc}) : super(SignInInitial()) {
    on<SignInUser>((event, emit) async {
      try {
        emit(SignInLoading());
        print('emitted loading state ... ');

        final res =
            await AuthRepository.loginUser(event.phoneNumber, event.password);
        ;
        if (res['status'] == 'error') {
          emit(SignInFailure(message: res['message']));
          return;
        }
        final token = res['access'];
        final user = UserInfo.fromJson(token);

        authBloc.add(LoggedIn(
          token: token,
          user: user,
        ));
        emit(SignInSuccess(message: res['message'], user: user));
        print('emitted success state ...');
      } catch (e) {
        emit(SignInFailure(message: e.toString()));
      }
    });
  }
}
