import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travelwave_mobile/blocs/signup/signup_bloc.dart';
import 'package:travelwave_mobile/blocs/signup/signup_event.dart';
import 'package:travelwave_mobile/blocs/signup/signup_state.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/authentication/phone_verification.dart';
import 'package:travelwave_mobile/screens/authentication/signin.dart';
import 'package:travelwave_mobile/widgets/custom_textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;
  String selectedValue = 'male';
  String countryCode = "eth";
  bool isObscure1 = true;
  bool isObscure2 = true;

  TextEditingController fullName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => RegistrationBloc(),
        child: SingleChildScrollView(
          child: BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              if (state is RegistrationSuccess) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return const PhoneVerificationPage();
                    },
                  ),
                );
              } else if (state is RegistrationFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(child: Text(state.error)),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<RegistrationBloc, RegistrationState>(
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150.v,
                        width: 250.h,
                        child: Image.asset('assets/03_onboarding.png'),
                      ),
                      SizedBox(height: 10.v),
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10.v),
                      Container(
                        width: 340.h,
                        margin: EdgeInsets.all(5.v),
                        child: CustomTextFieldWidget(
                          function: validateFullName,
                          prefixIcon: const Icon(
                            Ionicons.person_outline,
                            size: 18,
                          ),
                          title: 'Full name',
                          controller: fullName,
                        ),
                      ),
                      Container(
                        width: 340.h,
                        margin: EdgeInsets.all(5.v),
                        child: CustomTextFieldWidget(
                          function: validatePhoneNumber,
                          prefixIcon: const Icon(Ionicons.call_outline),
                          title: 'Phone number',
                          controller: phoneNumber,
                        ),
                      ),
                      SizedBox(
                        width: 340.h,
                        child: DropdownButtonFormField(
                          menuMaxHeight: 100,
                          value: selectedValue,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.v),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.v),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'male',
                              child: SizedBox(
                                width: 200.h,
                                child: const Text(
                                  'Male',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'female',
                              child: SizedBox(
                                width: 200.h,
                                child: const Text(
                                  'Female',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value.toString();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 340.h,
                        margin: EdgeInsets.all(5.v),
                        child: CustomTextFieldWidget(
                          function: validatePassword,
                          prefixIcon: const Icon(
                            Ionicons.lock_closed_outline,
                            size: 18,
                          ),
                          title: 'Password',
                          controller: password,
                        ),
                      ),
                      Container(
                        width: 340.h,
                        margin: EdgeInsets.all(5.v),
                        child: CustomTextFieldWidget(
                          function: (value) =>
                              confirmPassword(value, password.text),
                          prefixIcon: const Icon(
                            Ionicons.lock_closed_outline,
                            size: 18,
                          ),
                          title: 'Confirm password',
                          controller: confirm,
                        ),
                      ),
                      SizedBox(
                        height: 45.v,
                        width: 350.h,
                        child: Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (_) {
                                setState(() => isChecked = !isChecked);
                              },
                            ),
                            const Expanded(
                              child: Text(
                                'By signing up, you agree to the Terms of service and and Privacy policy.',
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<RegistrationBloc>().add(
                                  RegisterUser(
                                    fullName: fullName.text,
                                    phoneNumber: phoneNumber.text,
                                    password: password.text,
                                    isDriver: false,
                                    gender: selectedValue,
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
                            child: state is RegistrationLoading
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.v),
                      const Divider(),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignIn();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Already have an account? Sign in',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

String? validatePhoneNumber(String? value) {
  // Check if the phone number is empty
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }

  // Check if the phone number contains only digits
  final RegExp digitRegExp = RegExp(r'^[0-9]+$');
  if (!digitRegExp.hasMatch(value)) {
    return 'Phone number must contain only digits';
  }

  // Check the length of the phone number
  if (value.length != 10) {
    return 'Phone number must be 10 digits long';
  }

  return null;
}

String? validateFullName(String? value) {
  // Check if the full name is empty
  if (value == null || value.isEmpty) {
    return 'Full name is required';
  }

  // Check if the full name contains only alphabetic characters and spaces
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
  if (!nameRegExp.hasMatch(value)) {
    return 'Full name must contain only alphabetic characters and spaces';
  }

  // If all checks pass, return null
  return null;
}

String? validatePassword(String? value) {
  // Check if the password is empty
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }

  // Check if the password length is at least 8 characters
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }

  // If all checks pass, return null
  return null;
}

String? confirmPassword(String? value, String? password) {
  if (value == null) {
    return "Password confirmation is required";
  } else if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}
