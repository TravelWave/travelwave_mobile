import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travelwave_mobile/blocs/signin/signin_bloc.dart';
import 'package:travelwave_mobile/blocs/signin/signin_event.dart';
import 'package:travelwave_mobile/blocs/signin/signin_state.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/authentication/forgot_password.dart';
import 'package:travelwave_mobile/screens/authentication/signup.dart';
import 'package:travelwave_mobile/screens/home/home.dart';
import 'package:travelwave_mobile/widgets/custom_textformfield.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          // if (state is SignInSuccess) {
          //   Navigator.of(context).pop();
          // }
          if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: PrimaryColors.amberA400,
              ),
            );
          }
        },
        child: BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.all(10.v),
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 150.v),
                      SizedBox(
                        height: 150.v,
                        width: 250.h,
                        child: Image.asset('assets/01_onboarding.png'),
                      ),
                      SizedBox(height: 50.v),
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        height: 60.v,
                        width: 340.h,
                        margin: EdgeInsets.all(5.v),
                        child: CustomTextFieldWidget(
                          function: validatePhoneNumber,
                          prefixIcon: const Icon(
                            Ionicons.person_outline,
                            size: 18,
                          ),
                          title: 'Phone number',
                          controller: phoneNumberController,
                        ),
                      ),
                      Container(
                        height: 60.v,
                        width: 340.h,
                        margin: EdgeInsets.all(10.v),
                        child: CustomTextFieldWidget(
                          function: validatePassword,
                          prefixIcon: const Icon(
                            Ionicons.lock_closed_outline,
                            size: 18,
                          ),
                          title: 'Password',
                          controller: passwordController,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) {
                                  return const SignUp();
                                },
                              ));
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.v),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SignInBloc>().add(
                                  SignInUser(
                                    phoneNumber: phoneNumberController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          }
                        },
                        child: Container(
                          height: 50.v,
                          width: 340.h,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.v),
                          ),
                          child: Center(
                            child: state is SignInLoading
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 150.v),
                      const Divider(),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) {
                              return const SignUp();
                            },
                          ));
                        },
                        child: Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }

  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }

  // bool hasUppercase = false;
  // bool hasLowercase = false;
  // bool hasDigit = false;
  // bool hasSpecialChar = false;

  // for (int i = 0; i < value.length; i++) {
  //   if (RegExp(r'[A-Z]').hasMatch(value[i])) {
  //     hasUppercase = true;
  //   } else if (RegExp(r'[a-z]').hasMatch(value[i])) {
  //     hasLowercase = true;
  //   } else if (RegExp(r'[0-9]').hasMatch(value[i])) {
  //     hasDigit = true;
  //   } else if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value[i])) {
  //     hasSpecialChar = true;
  //   }
  // }

  // if (!hasUppercase) {
  //   return 'Password must contain at least one uppercase letter';
  // }

  // if (!hasLowercase) {
  //   return 'Password must contain at least one lowercase letter';
  // }

  // if (!hasDigit) {
  //   return 'Password must contain at least one number';
  // }

  // if (!hasSpecialChar) {
  //   return 'Password must contain at least one special character';
  // }

  return null;
}
