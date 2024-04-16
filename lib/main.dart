import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/onboarding/splash_screen.dart';
import 'package:travelwave_mobile/screens/settings/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'TravelWave',
        theme: lightTheme(),
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   primaryColor: primaryColor,
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        home: const SettingPage(),
      );
    });
  }
}
