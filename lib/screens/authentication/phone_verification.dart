import 'package:flutter/material.dart';
import 'package:travelwave_mobile/screens/home/home_transport.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());

  bool completed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: [
            const Positioned(
              top: 50,
              left: 40,
              child: Text(
                'Phone Verification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const Positioned(
              top: 100,
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
              top: 150,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Distribute boxes evenly
                children: List.generate(
                  6,
                  (index) => _buildOtpTextField(index),
                ),
              ),
            ),
            Positioned(
              top: 200,
              child: Container(
                width: 340,
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 40),
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
            ),
            Positioned(
              top: 300,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  width: 340,
                  decoration: BoxDecoration(
                    color: (completed
                        ? Theme.of(context).primaryColor
                        : Colors.white),
                    borderRadius: BorderRadius.circular(15),
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      left: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      right: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      bottom: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
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
            ),
          ],
        ),
      ),
    );
  }

// Function to build each OTP text field
  Widget _buildOtpTextField(int index) {
    return Container(
      width: 50.0, // Set the width of each box
      margin: const EdgeInsets.all(3),
      child: TextField(
        controller: _otpControllers[index],
        textAlign: TextAlign.center, // Center the text
        keyboardType: TextInputType.number, // Allow only numbers
        maxLength: 1, // Limit input to single character
        decoration: InputDecoration(
          filled: true,
          fillColor: _otpControllers[index].text.isNotEmpty
              ? Theme.of(context).primaryColor.withOpacity(0.3)
              : Colors.white,
          counterText: "", // Hide the counter text
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Rounded corners for boxes
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Rounded corners for boxes
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 3,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            // Move focus to the next field if a number is entered
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
}
