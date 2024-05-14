import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/authentication/phone_verification.dart';

class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({super.key});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  bool isObscure1 = true;
  bool isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(10.v),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: EdgeInsets.only(top: 30.v, bottom: 20.v),
                padding: EdgeInsets.all(5.v),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 18),
                    Text('Back'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100.v),
            const Text(
              'Set Password',
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
                obscureText: isObscure1,
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
            SizedBox(height: 10.v),
            SizedBox(
              height: 45.v,
              width: 300.h,
              child: TextField(
                obscureText: isObscure2,
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
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PhoneVerificationPage(),
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
                    'Register',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
