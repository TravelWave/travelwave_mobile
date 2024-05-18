import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/signup/signup_bloc.dart';
import 'package:travelwave_mobile/blocs/signup/signup_event.dart';
import 'package:travelwave_mobile/blocs/signup/signup_state.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/authentication/phone_verification.dart';
import 'package:travelwave_mobile/screens/authentication/signin.dart';

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
                      SizedBox(height: 20.v),
                      SizedBox(
                        height: 45.v,
                        width: 300.h,
                        child: TextFormField(
                          controller: fullName,
                          validator: validateFullName,
                          decoration: InputDecoration(
                            hintText: 'Full name',
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
                          ),
                        ),
                      ),
                      SizedBox(height: 15.v),
                      SizedBox(
                        width: 300.h,
                        height: 45.v,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 50.v,
                              width: 300.h,
                              child: TextFormField(
                                controller: phoneNumber,
                                validator: validatePhoneNumber,
                                cursorColor: Colors.grey[800],
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: 'Phone number',
                                  hintStyle: const TextStyle(fontSize: 13),
                                  contentPadding: EdgeInsets.all(10.v),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.v),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.v),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.v),
                      SizedBox(
                        height: 45.v,
                        width: 300.h,
                        child: DropdownButtonFormField(
                          menuMaxHeight: 100,
                          value: selectedValue,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.v),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.v),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                            ),
                          ),
                          validator: (value) => value == null
                              ? 'Please select your gender'
                              : null,
                          items: [
                            DropdownMenuItem(
                              value: 'male',
                              child: SizedBox(
                                width: 200.h,
                                child: const Text(
                                  'Male',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'female',
                              child: SizedBox(
                                width: 200.h,
                                child: const Text(
                                  'Female',
                                  style: TextStyle(fontSize: 12),
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
                      SizedBox(height: 25.v),
                      SizedBox(
                        height: 45.v,
                        width: 300.h,
                        child: TextFormField(
                          obscureText: isObscure1,
                          controller: password,
                          validator: validatePassword,
                          cursorColor: Colors.grey[800],
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscure1 = !isObscure1;
                                });
                              },
                              icon: Icon(
                                isObscure1
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey[600],
                                size: 18,
                              ),
                            ),
                            hintText: 'Enter Your Password',
                            hintStyle: const TextStyle(fontSize: 13),
                            contentPadding: EdgeInsets.all(10.v),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.v),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.v),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.v),
                      SizedBox(
                        height: 45.v,
                        width: 300.h,
                        child: TextFormField(
                          obscureText: isObscure2,
                          controller: confirm,
                          validator: (value) =>
                              confirmPassword(value, password.text),
                          cursorColor: Colors.grey[800],
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscure2 = !isObscure2;
                                });
                              },
                              icon: Icon(
                                isObscure2
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey[600],
                                size: 18,
                              ),
                            ),
                            hintText: 'Confirm Password',
                            hintStyle: const TextStyle(fontSize: 13),
                            contentPadding: EdgeInsets.all(10.v),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.v),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.v),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.v),
                      SizedBox(
                        height: 45.v,
                        width: 327.h,
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
                                    TextStyle(color: Colors.grey, fontSize: 12),
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
                                    is_driver: false,
                                    gender: selectedValue,
                                  ),
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
                            child: state is RegistrationLoading
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.v),
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

  // Optional: Check if the full name has at least two words
  final List<String> words = value.split(' ');
  if (words.length < 2) {
    return 'Please enter your full name';
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

  // Check if the password contains at least one uppercase letter
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }

  // Check if the password contains at least one lowercase letter
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }

  // Check if the password contains at least one digit
  if (!RegExp(r'\d').hasMatch(value)) {
    return 'Password must contain at least one digit';
  }

  // Check if the password contains at least one special character
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return 'Password must contain at least one special character';
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
