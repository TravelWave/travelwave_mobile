import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travelwave_mobile/blocs/auth/bloc/auth_bloc_bloc.dart';
import 'package:travelwave_mobile/blocs/feedback/feedback_bloc_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/screens/authentication/signin.dart';
import 'package:travelwave_mobile/screens/onboarding/splash_screen.dart';
import 'package:travelwave_mobile/screens/payment/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    final LocalStorage data = LocalStorage(storage: storage);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            lazy: false,
            create: (context) =>
                AuthenticationBloc(localData: data)..add(AppStarted())),
        BlocProvider(create: (context) => FeedbackBlocBloc(localData: data)),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'TravelWave',
            theme: lightTheme(),
            debugShowCheckedModeBanner: false,
            home: const PaymentCheckOutScreen(),
          );
        },
      ),
    );
  }
}
