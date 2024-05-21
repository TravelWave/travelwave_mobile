import 'package:travelwave_mobile/models/user_info.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final String message;
  final UserInfo user;

  SignInSuccess({required this.message, required this.user});
}

class SignInFailure extends SignInState {
  final String message;

  SignInFailure({required this.message});
}
