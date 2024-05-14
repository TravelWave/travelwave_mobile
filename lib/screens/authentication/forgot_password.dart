import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/authentication/set_password.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(5, (index) => TextEditingController());

  bool completed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(10.v),
        child: Column(
          children: [
            const Text(
              'Forgot Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const Text(
              'Code has been sent to ***** ***99',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20.v),
            SizedBox(
              width: 300.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                  (index) => _buildOtpTextField(index),
                ),
              ),
            ),
            Container(
              width: 340.h,
              height: 50.v,
              padding: EdgeInsets.symmetric(horizontal: 40.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Didn't receive code?",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Resend again',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return const SetPasswordPage();
                    },
                  ),
                );
              },
              child: Container(
                height: 45.v,
                width: 300.h,
                decoration: BoxDecoration(
                  color: (completed
                      ? Theme.of(context).primaryColor
                      : Colors.white),
                  borderRadius: BorderRadius.circular(15.v),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      color: completed
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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

  Widget _buildOtpTextField(int index) {
    return Container(
      width: 50.h,
      margin: EdgeInsets.all(3.v),
      child: TextField(
        controller: _otpControllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: _otpControllers[index].text.isNotEmpty
              ? Theme.of(context).primaryColor.withOpacity(0.3)
              : Colors.white,
          counterText: "", // Hide the counter text
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.v),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.v),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 3,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            if (index < _otpControllers.length - 1) {
              FocusScope.of(context).nextFocus();
            } else {
              setState(() {
                completed = true;
              });
            }
          }
        },
      ),
    );
  }

  void showSignupSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(
            Icons.check_circle,
            color: Colors.green[400],
            size: 80,
          ),
          title: const Text('Congratulations',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )),
          content: Text(
            'Your account is ready to use. You will be redirected to the Home Page in a few seconds.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
