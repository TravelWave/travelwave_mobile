import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
 
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/models/user_info.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LocalStorage localData;

  AuthenticationBloc({required this.localData})
      : super(AuthenticationUninitialized()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is OnBoardSeen) {
        await localData.writeToStorage('first', 'True');
        emit(AuthenticationUnauthenticated());
      }
      if (event is AppStarted) {
        emit(AuthenticationLoading());
        final isfirstTime = await localData.readFromStorage('first');
        final hasToken = await localData.readFromStorage('Token');
        if (isfirstTime == '') {
          await localData.writeToStorage('first', 'True');
          emit(AuthenticationUninitialized());
        } else if (isfirstTime != '' && hasToken == '') {
          emit(AuthenticationUnauthenticated());
        } else {
          // final userdata = await localData.readUserData();
          hasToken.isEmpty
              ? emit(AuthenticationUnauthenticated())
              : emit(AuthenticationAuthenticated());
        }
      }
      if (event is LoggedIn) {
        await localData.writeToStorage('Token', event.token);
        await localData.writeUserData(event.user.toJson().toString());

        emit(AuthenticationAuthenticated());
      }
      if (event is LoggedOut) {
        await localData.deleteToken('Token');

        emit(AuthenticationUnauthenticated());
      }
    });
  }
}
