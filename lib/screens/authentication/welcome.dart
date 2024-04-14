import 'package:flutter/material.dart';
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
        child: Stack(
          children: [
            Positioned(
              child: SizedBox(
                height: 300,
                width: 350,
                child: Image.asset('assets/05_welcome.png'),
              ),
            ),
            const Positioned(
              top: 300,
              left: 100,
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const Positioned(
              top: 350,
              left: 50,
              child: Text(
                'Have a better sharing experience',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              top: 540,
              left: 12,
              child: GestureDetector(
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
                  height: 50,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Create an account',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 600,
              left: 12,
              child: GestureDetector(
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
                  height: 50,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                        fontSize: 16,
                      ),
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
