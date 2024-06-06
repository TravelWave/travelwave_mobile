import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/rideRequest/ride_request_bloc.dart';

Future<dynamic> notificationDialogBox(
  BuildContext context, {
  required String msg,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('New Ride Request'),
        content: Text(msg),
        icon: const Icon(Icons.notifications_sharp),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              // Handle accept action
              BlocProvider.of<RideRequestBloc>(context)
                  .add(const GetRideRequest());
              Navigator.of(context).pop();
            },
            child: const Text('Refetch'),
          ),
        ],
      );
    },
  );
}
