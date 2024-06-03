part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class DeleteuserInitial extends UserState {}

final class DeleteuserRequesting extends UserState {}

final class Deleteusersucess extends UserState {}

final class DeleteuserError extends UserState {
  final String message;

  const DeleteuserError({required this.message});
}

final class ChangePasswordInitial extends UserState {}

final class ChangePasswordRequesting extends UserState {}

final class ChangePasswordsucess extends UserState {}

final class ChangePasswordError extends UserState {
  final String message;
  const ChangePasswordError({required this.message});
}
