import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/authentication/signin.dart';
import 'package:travelwave_mobile/screens/authentication/signup.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 100.v),
            SizedBox(
              height: 220.v,
              width: 350.h,
              child: Image.asset('assets/05_welcome.png'),
            ),
            const Text(
              'Welcome',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Text(
              'Have a better sharing experience',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 200.v),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUp();
                    },
                  ),
                );
              },
              child: Container(
                height: 35.v,
                width: 280.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.v),
                ),
                child: const Center(
                  child: Text(
                    'Create an account',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignIn();
                    },
                  ),
                );
              },
              child: Container(
                height: 35.v,
                width: 280.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.v),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
