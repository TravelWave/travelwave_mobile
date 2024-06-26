part of 'auth_bloc_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class OnBoardSeen extends AuthenticationEvent {
  @override
  String toString() => 'OnBoardSeen';
}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final UserInfo user;

  const LoggedIn({required this.token, required this.user});

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthenticationEvent {}
