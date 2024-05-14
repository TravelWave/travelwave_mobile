import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/authentication/forgot_password.dart';
import 'package:travelwave_mobile/screens/home/home.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(5, (index) => TextEditingController());

  bool completed = false;

  @override
  void dispose() {
    super.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(10.v),
        child: Column(
          children: [
            SizedBox(height: 5.v),
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
            SizedBox(height: 50.v),
            const Text(
              'Phone Verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Text(
              'Enter your OTP code',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20.v),
            SizedBox(
              width: 300.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) => buildOtpTextField(index)),
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
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return const ForgotPasswordPage();
                        }),
                      );
                    },
                    child: Text(
                      'Resend again',
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
            GestureDetector(
              onTap: () {
                showSignupSuccessDialog(context);
              },
              child: Container(
                height: 45.v,
                width: 300.h,
                decoration: BoxDecoration(
                  color: (completed
                      ? Theme.of(context).primaryColor
                      : Colors.white),
                  borderRadius: BorderRadius.circular(10.v),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: Center(
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      color: completed
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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

  Widget buildOtpTextField(int index) {
    return Container(
      height: 60.v,
      width: 50.h,
      margin: EdgeInsets.all(3.v),
      child: TextField(
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        controller: _otpControllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        cursorColor: Colors.grey[800],
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3.v),
          filled: true,
          fillColor: _otpControllers[index].text.isNotEmpty
              ? Theme.of(context).primaryColor.withOpacity(0.3)
              : Colors.white,
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.v),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
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
          } else {
            if (index > 0) {
              FocusScope.of(context).previousFocus();
              setState(() {
                completed = false;
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
          icon: SizedBox(
            height: 100.v,
            width: 100.h,
            child: Image.asset('assets/success.png'),
          ),
          title: const Text(
            'Congratulations',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
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
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return const MainPage();
                    },
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
