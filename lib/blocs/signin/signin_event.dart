import 'package:flutter/material.dart';

@immutable
abstract class SignInEvent {}

class SignInUser extends SignInEvent {
  final String phoneNumber;
  final String password;

  SignInUser({
    required this.phoneNumber,
    required this.password,
  });
}
