import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/auth/bloc/auth_bloc_bloc.dart';
import 'package:travelwave_mobile/blocs/signin/signin_bloc.dart';
import 'package:travelwave_mobile/blocs/signin/signin_event.dart';
import 'package:travelwave_mobile/blocs/signin/signin_state.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/data/decode_token.dart';
import 'package:travelwave_mobile/screens/authentication/forgot_password.dart';
import 'package:travelwave_mobile/screens/authentication/signup.dart';

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
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            Navigator.of(context).pop();
          }
          if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                    "Something went wrong: Please check Your credentials"),
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
                      SizedBox(height: 10.v),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.h),
                        child: TextFormField(
                          cursorColor: Colors.grey[800],
                          keyboardType: TextInputType.phone,
                          controller: phoneNumberController,
                          validator: validatePhoneNumber,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: const TextStyle(fontSize: 13),
                            fillColor: Colors.grey,
                            contentPadding: EdgeInsets.all(10.v),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10.v),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.v),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.v),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.v),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.h),
                        child: TextFormField(
                          validator: validatePassword,
                          cursorColor: Colors.grey[800],
                          obscureText: isObscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 18,
                              ),
                              color: Colors.grey[700],
                            ),
                            hintText: 'Enter Your Password',
                            hintStyle: const TextStyle(fontSize: 13),
                            contentPadding: EdgeInsets.all(10.v),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.v),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.v),
                      Row(
                        children: [
                          SizedBox(width: 220.h),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const ForgotPasswordPage();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Colors.red,
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
                                      phoneNumber:
                                          "+251${phoneNumberController.text.substring(1)}",
                                      password: passwordController.text),
                                );
                          }
                        },
                        child: Container(
                          height: 45.v,
                          width: 300.h,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.v),
                          ),
                          child: Center(
                            child: state is SignInLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 150.v),
                      const Divider(),
                      Container(
                        height: 80.v,
                        width: 340.h,
                        padding: EdgeInsets.symmetric(horizontal: 40.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
