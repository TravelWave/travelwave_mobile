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
            const Positioned(
              top: 10,
              left: 100,
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Positioned(
              top: 80,
              child: SizedBox(
                height: 100,
                width: 340,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Name',
                    fillColor: Colors.grey,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 160,
              child: SizedBox(
                width: 340,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: DropdownButtonFormField(
                        value: countryCode,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        validator: (value) =>
                            value == null ? 'country code' : null,
                        items: const [
                          DropdownMenuItem(
                            value: 'eth',
                            child: Text('+251'),
                          ),
                          DropdownMenuItem(
                            value: 'usa',
                            child: Text('+1'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            countryCode = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 230,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Phone number',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
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
              top: 240,
              child: Container(
                width: 340,
                height: 100,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: DropdownButtonFormField(
                  menuMaxHeight: 100,
                  value: selectedValue,
                  decoration: InputDecoration(
                    labelText: 'Select your gender',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) =>
                      value == null ? 'Please select your gender' : null,
                  items: const [
                    DropdownMenuItem(
                      value: 'male',
                      child: SizedBox(
                        width: 250,
                        child: Text('Male'),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'female',
                      child: SizedBox(
                        width: 250,
                        child: Text('Female'),
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
              top: 350,
              child: SizedBox(
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
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 410,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SetPasswordPage(),
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  width: 340,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 500,
              left: 0,
              right: 0,
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            Positioned(
              top: 500,
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
                        fontSize: 16,
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
                          fontSize: 16,
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
