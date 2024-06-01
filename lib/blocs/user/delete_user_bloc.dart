import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/repositories/deleteuser_repository.dart';

part 'delete_user_event.dart';
part 'delete_user_state.dart';

class DeleteuserBloc extends Bloc<DeleteuserEvent, DeleteuserState> {
  final LocalStorage localData;
  DeleteuserBloc({required this.localData}) : super(DeleteuserInitial()) {
    on<DeleteuserEvent>((event, emit) async {
      if (event is DeleteUser) {
        emit(DeleteuserRequesting());
        DeleteUserRepository(token: await localData.readFromStorage("Token"))
            .deleteUser("id")
            .then((value) {
          emit(Deleteusersucess());
        }).catchError((e) {
          emit(DeleteuserError(message: e.toString()));
        });
      }
    });
  }
}
