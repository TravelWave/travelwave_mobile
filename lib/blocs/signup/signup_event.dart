import 'package:flutter/material.dart';

@immutable
abstract class RegistrationEvent {}

class RegisterUser extends RegistrationEvent {
  final String fullName;
  final String phoneNumber;
  final bool is_driver;
  final String password;
  final String gender;

  RegisterUser({
    required this.fullName,
    required this.phoneNumber,
    required this.is_driver,
    required this.password,
    required this.gender,
  });
}
