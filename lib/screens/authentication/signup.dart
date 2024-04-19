import 'package:flutter/material.dart';
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
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 40,
              child: SizedBox(
                height: 120,
                width: 250,
                child: Image.asset('assets/03_onboarding.png'),
              ),
            ),
            const Positioned(
              top: 10,
              left: 130,
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              top: 210,
              left: 20,
              child: SizedBox(
                height: 45,
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: const TextStyle(fontSize: 13),
                    fillColor: Colors.grey,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 270,
              left: 20,
              child: SizedBox(
                width: 300,
                height: 45,
                child: Row(
                  children: [
                    SizedBox(
                      height: 45,
                      width: 80,
                      child: DropdownButtonFormField(
                        value: countryCode,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
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
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 45,
                      width: 210,
                      child: TextField(
                        cursorColor: Colors.grey[800],
                        decoration: InputDecoration(
                          hintText: 'Phone number',
                          hintStyle: const TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
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
                  ],
                ),
              ),
            ),
            Positioned(
              top: 340,
              left: 20,
              child: Container(
                height: 45,
                width: 300,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: DropdownButtonFormField(
                  menuMaxHeight: 100,
                  value: selectedValue,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) =>
                      value == null ? 'Please select your gender' : null,
                  items: const [
                    DropdownMenuItem(
                      value: 'male',
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          'Male',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'female',
                      child: SizedBox(
                        width: 200,
                        child: Text(
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
            ),
            Positioned(
              top: 410,
              left: 10,
              child: SizedBox(
                height: 45,
                width: 330,
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
            ),
            Positioned(
              top: 460,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SetPasswordPage(),
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
            ),
            const Positioned(
              top: 530,
              left: 0,
              right: 0,
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            Positioned(
              top: 530,
              child: Container(
                height: 80,
                width: 340,
                padding: const EdgeInsets.symmetric(horizontal: 40),
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
            ),
          ],
        ),
      ),
    );
  }
}
