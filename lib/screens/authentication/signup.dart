import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/authentication/set_password.dart';
import 'package:travelwave_mobile/screens/authentication/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isChecked = false;
  String selectedValue = 'male';
  String countryCode = "eth";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(10.v),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 50.v),
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
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: const TextStyle(fontSize: 13),
                  fillColor: Colors.grey,
                  contentPadding: EdgeInsets.all(20.v),
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
            SizedBox(height: 10.v),
            SizedBox(
              width: 300.h,
              height: 45.v,
              child: Row(
                children: [
                  SizedBox(
                    height: 45.v,
                    width: 80.h,
                    child: DropdownButtonFormField(
                      value: countryCode,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.v),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.v),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      validator: (value) =>
                          value == null ? 'country code' : null,
                      items: const [
                        DropdownMenuItem(
                          value: 'eth',
                          child: Text(
                            '+251',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'usa',
                          child: Text(
                            '+1',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          countryCode = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10.v),
                  SizedBox(
                    height: 45.v,
                    width: 210.h,
                    child: TextField(
                      cursorColor: Colors.grey[800],
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        hintStyle: const TextStyle(fontSize: 13),
                        contentPadding: EdgeInsets.all(10.v),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.v),
                          borderSide: const BorderSide(color: Colors.grey),
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
                ],
              ),
            ),
            SizedBox(height: 10.v),
            Container(
              height: 45.v,
              width: 300.h,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: DropdownButtonFormField(
                menuMaxHeight: 100,
                value: selectedValue,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.v),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.v),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                validator: (value) =>
                    value == null ? 'Please select your gender' : null,
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
                    selectedValue = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 20.v),
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
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SetPasswordPage(),
                  ),
                );
              },
              child: Container(
                height: 45.v,
                width: 300.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.v),
                ),
                child: const Center(
                  child: Text(
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
            SizedBox(height: 100.v),
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
                    'Already have an account?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignIn();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Sign in',
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
    );
  }
}
