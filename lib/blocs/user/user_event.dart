part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class DeleteUser extends UserEvent {
  @override
  List<Object> get props => [];
}

class ChangePasswordEvent extends UserEvent {
  final String newpass;
  final String oldpass;

  const ChangePasswordEvent({required this.newpass, required this.oldpass});

  @override
  List<Object> get props => [];
}
