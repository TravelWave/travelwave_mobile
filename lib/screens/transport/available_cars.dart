import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/blocs/available_rides/available_rides_bloc.dart';
import 'package:travelwave_mobile/blocs/available_rides/available_rides_event.dart';
import 'package:travelwave_mobile/blocs/available_rides/available_rides_state.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travelwave_mobile/models/accepted_ride_request_model.dart';
import 'package:travelwave_mobile/screens/home/home_transport.dart';
import 'package:travelwave_mobile/screens/location/index.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class AvailableCarsPage extends StatefulWidget {
  final String source;
  final String destination;
  final bool scheduled;

  const AvailableCarsPage({
    super.key,
    required this.scheduled,
    required this.source,
    required this.destination,
  });

  @override
  State<AvailableCarsPage> createState() => _AvailableCarsPageState();
}

class _AvailableCarsPageState extends State<AvailableCarsPage> {
  LatLng myLocation = const LatLng(9.0192, 38.7525);
  // final socketUrl = 'ws://localhost:8000/';
  final socketUrl = 'wss://travelwave-backend.onrender.com';
  late final AcceptedRideRequestModel rideInfo;

  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((value) {
      setState(() {
        myLocation = value;
      });
    });

    final socket = io.io(socketUrl, <String, dynamic>{
      'transports': ['websocket']
    });

    socket.on('connect', (data) {
      print('shared connected');
    });

    socket.on('new notification accepted pooled', (data) {
      print('shared data: $data');
      rideInfo = AcceptedRideRequestModel.fromJson(data);
      context
          .read<AvailableRidesBloc>()
          .add(MakePooledAccepted(rideInfo: rideInfo));
    });

    socket.on('disconnect', (data) {
      print('shared disconnected');
    });
  }

  Future<LatLng> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(
      position.latitude,
      position.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AvailableRidesBloc, AvailableRidesState>(
        builder: (context, state) {
          if (state is AvailableRidesInitialState) {
            context.read<AvailableRidesBloc>().add(
                  GetAvailableRides(currentLocation: myLocation),
                );
            return Container();
          } else if (state is JoinRideStateFailure) {
            context.read<AvailableRidesBloc>().add(
                  GetAvailableRides(currentLocation: myLocation),
                );

            return Container();
          } else if (state is JoinRideStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AvailableRidesFailureState) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AvailableRidesBloc>().add(
                      GetAvailableRides(currentLocation: myLocation),
                    );
              },
              child: Container(
                padding: EdgeInsets.all(10.v),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 30.v, bottom: 20.v),
                        padding: EdgeInsets.all(5.v),
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back_ios, size: 18),
                            Text('Back'),
                          ],
                        ),
                      ),
                    ),
                    const Text(
                      'Available rides to join',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      '0 cars found',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 100),
                    const Center(
                        child: Text(
                      'No available ride',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
                  ],
                ),
              ),
            );
          } else if (state is AvailableRidesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AskJoinRideStateSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return LocationScreenConfirmBottomsheet(
                      message: state.acceptedRideRequest);
                },
              ),
            );
            return Container();
          } else if (state is AvailableRidesSuccessState) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AvailableRidesBloc>().add(
                      GetAvailableRides(currentLocation: myLocation),
                    );
              },
              child: Container(
                padding: EdgeInsets.all(10.v),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 30.v, bottom: 20.v),
                        padding: EdgeInsets.all(5.v),
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back_ios, size: 18),
                            Text('Back'),
                          ],
                        ),
                      ),
                    ),
                    const Text(
                      'Available rides to join',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${state.rideList.length} cars found',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    state is AvailableRidesLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 690.v,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: state.rideList.length,
                              itemBuilder: (context, index) {
                                final dist = state.rideList[index].distance;
                                return Container(
                                  width: 220.h,
                                  height: 150.v,
                                  margin: EdgeInsets.only(top: 10.v),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFFBE7),
                                    borderRadius: BorderRadius.circular(10.v),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10.h,
                                                  vertical: 2.v,
                                                ),
                                                child: Text(
                                                  state.rideList[index].vehicle!
                                                      .driver!,
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                child: Text(
                                                  'Automatic | ${state.rideList[index].availableSeats} seats | ${state.rideList[index].vehicle!.licensePlate}',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10,
                                                    bottom: 3,
                                                    top: 5),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.location_on,
                                                        size: 15),
                                                    SizedBox(width: 5.h),
                                                    Text(
                                                      parseDistance(dist),
                                                      style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 80.v,
                                            width: 90.h,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20.v),
                                            child:
                                                Image.asset('assets/ride.png'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              print(
                                                  'join request being sent ...');
                                              final start = await getLocation(
                                                  widget.source);
                                              final end = await getLocation(
                                                  widget.destination);
                                              context
                                                  .read<AvailableRidesBloc>()
                                                  .add(
                                                    JoinScheduledRideRequestEvent(
                                                      rideId: state
                                                          .rideList[index].sId!,
                                                      source: start,
                                                      destination: end,
                                                    ),
                                                  );
                                            },
                                            child: !widget.scheduled
                                                ? Container()
                                                : Container(
                                                    height: 35.v,
                                                    width: 130.h,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.v),
                                                      border: Border.all(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: state
                                                              is JoinScheduledRideStateLoading
                                                          ? const CircularProgressIndicator()
                                                          : const Text(
                                                              'Schedule Ride',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                          ),
                                          SizedBox(width: 10.h),
                                          GestureDetector(
                                            onTap: () async {
                                              print(
                                                  'join request being sent ...');
                                              final start = await getLocation(
                                                  widget.source);
                                              final end = await getLocation(
                                                  widget.destination);
                                              context
                                                  .read<AvailableRidesBloc>()
                                                  .add(
                                                    JoinRideRequestEvent(
                                                      rideId: state
                                                          .rideList[index].id!,
                                                      source: start,
                                                      destination: end,
                                                    ),
                                                  );
                                            },
                                            child: Container(
                                              height: 35.v,
                                              width: 130.h,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10.v),
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Join Ride',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

Future<double> getDistanceInMeters(
    double lat1, double lon1, double lat2, double lon2) async {
  final distance = await Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  return distance;
}

String parseDistance(double distance) {
  return '${(distance / 1000).toStringAsFixed(2)} km away';
}
