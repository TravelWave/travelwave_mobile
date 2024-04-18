import 'package:flutter/material.dart';
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
    // for (var focusNode in _focusNodes.) {
    //   focusNode.dispose();
    // }
  }

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
              top: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  padding: const EdgeInsets.all(5),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 18),
                      Text('Back'),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 90,
              left: 80,
              child: Text(
                'Phone Verification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const Positioned(
              top: 120,
              left: 90,
              child: Text(
                'Enter your OTP code',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: 30,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Distribute boxes evenly
                children: List.generate(
                  5,
                  (index) => buildOtpTextField(index),
                ),
              ),
            ),
            Positioned(
              top: 260,
              child: Container(
                width: 340,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 40),
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
                      onTap: () {},
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
            ),
            Positioned(
              top: 320,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  showSignupSuccessDialog(context);
                },
                child: Container(
                  height: 45,
                  width: 300,
                  decoration: BoxDecoration(
                    color: (completed
                        ? Theme.of(context).primaryColor
                        : Colors.white),
                    borderRadius: BorderRadius.circular(10),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOtpTextField(int index) {
    return Container(
      height: 60,
      width: 50,
      margin: const EdgeInsets.all(3),
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
          contentPadding: const EdgeInsets.only(bottom: 3),
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
            borderRadius: BorderRadius.circular(10.0),
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
            height: 100,
            width: 100,
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
