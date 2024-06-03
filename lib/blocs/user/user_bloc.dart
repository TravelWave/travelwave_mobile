import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/repositories/auth_repository.dart';
import 'package:travelwave_mobile/repositories/deleteuser_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final LocalStorage localData;
  UserBloc({required this.localData}) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      final token = await localData.readFromStorage("Token");
      if (event is DeleteUser) {
        emit(DeleteuserRequesting());
        DeleteUserRepository(token: token).deleteUser("id").then((value) {
          emit(Deleteusersucess());
        }).catchError((e) {
          emit(DeleteuserError(message: e.toString()));
        });
      }
      if (event is ChangePasswordEvent) {
        emit(ChangePasswordRequesting());
        await AuthRepository.changePassword(event.oldpass, event.newpass, token)
            .then((value) {
          if (value["status"] == 'error') {
            emit(ChangePasswordError(message: value["message"]));
          } else {
            emit(ChangePasswordsucess());
          }
        }).catchError((e) {
          emit(ChangePasswordError(message: e.toString()));
        });
      }
    });
  }
}
