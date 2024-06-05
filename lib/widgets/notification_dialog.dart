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
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Decline'),
          ),
          TextButton(
            onPressed: () {
              // Handle accept action
              Navigator.of(context).pop();
              // BlocProvider.of<RideRequestBloc>(context).add(AcceptRideRequest(rideRequest: rideRequest));
            },
            child: const Text('Accept'),
          ),
        ],
      );
    },
  );
}
