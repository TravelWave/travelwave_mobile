import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travelwave_mobile/blocs/auth/auth_bloc_bloc.dart';
import 'package:travelwave_mobile/blocs/available_rides/available_rides_bloc.dart';
import 'package:travelwave_mobile/blocs/feedback/feedback_bloc_bloc.dart';

import 'package:travelwave_mobile/blocs/passRideRequest/pass_ride_request_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/createRide/create_ride_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/rideRequest/ride_request_bloc.dart';
import 'package:travelwave_mobile/blocs/ride_routes/ride_routes_bloc.dart';

import 'package:travelwave_mobile/blocs/messages/message_bloc.dart';
import 'package:travelwave_mobile/blocs/notification/notification_bloc.dart';
import 'package:travelwave_mobile/blocs/pasenger/passenger_bloc_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/acceptRide/accept_ride_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/createRide/create_ride_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/rideRequest/ride_request_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/ridehistory/ride_history_bloc.dart';

import 'package:travelwave_mobile/blocs/signin/signin_bloc.dart';
import 'package:travelwave_mobile/blocs/user/user_bloc.dart';
import 'package:travelwave_mobile/blocs/vehicles/vehicles_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/data/local_data.dart';

import 'package:travelwave_mobile/screens/onboarding/splash_screen.dart';
import 'package:travelwave_mobile/widgets/driver_form.dart';

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
              AuthenticationBloc(localData: data)..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) => FeedbackBlocBloc(localData: data),
        ),
        BlocProvider(
          create: (context) => SignInBloc(
              authBloc: BlocProvider.of<AuthenticationBloc>(context)),
        ),
        BlocProvider(
          create: (context) =>
              RideRequestBloc(localData: data)..add(const GetRideRequest()),
        ),
        BlocProvider(
          create: (context) => UserBloc(localData: data),
        ),
        BlocProvider(
          create: (context) => CreateRideBloc(localData: data),
        ),
        BlocProvider(
          create: (context) => PassRideRequestBloc(localData: data),
        ),
        BlocProvider(
          create: (context) => AvailableRidesBloc(localData: data),
        ),
        BlocProvider(
          create: (context) => RideRoutesBloc(localData: data),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(),
        ),
        BlocProvider(
          create: (context) => PassengerBloc(localdata: data),
        ),
        BlocProvider(
          create: (context) => RideHistoryBloc(localdata: data),
        ),
        BlocProvider(
          create: (context) => VehiclesBloc(localdata: data),
        ),
        BlocProvider(
          create: (context) => AcceptRideBloc(localdata: data),
        ),
        BlocProvider(
          create: (context) => MessageBloc(),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'TravelWave',
            theme: lightTheme(),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
