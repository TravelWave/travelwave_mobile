import 'package:flutter/material.dart';
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
              top: 80,
              left: 100,
              child: Text(
                'Set Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 20,
              child: SizedBox(
                height: 45,
                width: 300,
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 20,
              child: SizedBox(
                height: 45,
                width: 300,
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 250,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PhoneVerificationPage(),
                    ),
                  );
                },
                child: Container(
                  height: 45,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
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
            ),
          ],
        ),
      ),
    );
  }
}
