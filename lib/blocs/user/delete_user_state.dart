part of 'delete_user_bloc.dart';

sealed class DeleteuserState extends Equatable {
  const DeleteuserState();

  @override
  List<Object> get props => [];
}

final class DeleteuserInitial extends DeleteuserState {}

final class DeleteuserRequesting extends DeleteuserState {}

final class Deleteusersucess extends DeleteuserState {}

final class DeleteuserError extends DeleteuserState {
  final String message;

  const DeleteuserError({required this.message});
}
