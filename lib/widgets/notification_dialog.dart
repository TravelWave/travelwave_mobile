import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/acceptRide/accept_ride_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/rideRequest/ride_request_bloc.dart';

Future<dynamic> notificationDialogBox(
  BuildContext context, {
  required String msg,
  required bool isPooled,
  required bool isScheduled,
  required String requestId,
  required String rideId,
  required String passengerId,
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
            child: const Text('Decline'),
          ),
          TextButton(
            onPressed: () {
              // Handle accept action
              BlocProvider.of<AcceptRideBloc>(context).add(AcceptRide(
                  isPooled: isPooled,
                  isScheduled: isScheduled,
                  requestId: requestId,
                  rideId: rideId,
                  passengerId: passengerId));
              Navigator.of(context).pop();
            },
            child: const Text('Accept'),
          ),
        ],
      );
    },
  );
}
