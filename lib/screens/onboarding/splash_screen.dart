import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/auth/bloc/auth_bloc_bloc.dart';
import 'package:travelwave_mobile/screens/authentication/signin.dart';
import 'package:travelwave_mobile/screens/authentication/welcome.dart';
import 'package:travelwave_mobile/screens/home/home_transport.dart';
import 'package:travelwave_mobile/screens/onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), () {
      return Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return const SecondScreen();
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Text(
          'TravelWave',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationUninitialized) {
          return const OnboardingPage();
        }
        if (state is AuthenticationUnauthenticated) {
          if (Navigator.of(context).canPop()) {
            Navigator.pop(context);
          }
          return const WelcomePage();
        }
        // if (state is AuthenticationAuthenticated) {
        //   // context.read<UserProfileBloc>().add(LoadUserProfile());
        //   // if (Navigator.of(context).canPop()) {
        //   //   Navigator.pop(context);
        //   // }
        //   // final user = LocalStorage(storage: storage)
        //   // if (user.role == "admin"){
        //   return const HiddenDrawer();
        //   // }
        // }
        return HomePage();
      },
    );
  }
}
