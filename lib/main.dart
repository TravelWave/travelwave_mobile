import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travelwave_mobile/blocs/auth/bloc/auth_bloc_bloc.dart';
import 'package:travelwave_mobile/blocs/feedback/feedback_bloc_bloc.dart';
import 'package:travelwave_mobile/blocs/signin/signin_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

const FlutterSecureStorage storage = FlutterSecureStorage();
final LocalStorage data = LocalStorage(storage: storage);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            lazy: false,
            create: (context) =>
                AuthenticationBloc(localData: data)..add(AppStarted())),
        BlocProvider(create: (context) => FeedbackBlocBloc(localData: data)),
        BlocProvider(
          create: (context) => SignInBloc(
              authBloc: BlocProvider.of<AuthenticationBloc>(context)),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'TravelWave',
            theme: lightTheme(),
            debugShowCheckedModeBanner: false,
            home: const MainPage(),
          );
        },
      ),
    );
  }
}
