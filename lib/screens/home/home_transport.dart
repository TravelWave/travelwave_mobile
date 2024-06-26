import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/blocs/passRideRequest/pass_ride_request_bloc.dart';
import 'package:travelwave_mobile/blocs/passRideRequest/pass_ride_request_event.dart';
import 'package:travelwave_mobile/blocs/passRideRequest/pass_ride_request_state.dart';
import 'package:travelwave_mobile/blocs/signin/signin_bloc.dart';
import 'package:travelwave_mobile/blocs/signin/signin_state.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/models/accepted_ride_request_model.dart';
import 'package:travelwave_mobile/models/pass_riderequest_model.dart';
import 'package:travelwave_mobile/screens/home/home.dart';

import 'package:travelwave_mobile/screens/home/search.dart';
import 'package:travelwave_mobile/screens/home/search_location.dart';
import 'package:travelwave_mobile/screens/location/index.dart';
import 'package:travelwave_mobile/screens/notification/notifications.dart';
import 'package:travelwave_mobile/screens/side_menu/index.dart';
import 'package:travelwave_mobile/screens/transport/available_cars.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:travelwave_mobile/services/utils/app_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool shareRide = false;
  bool scheduled = false;
  LatLng myLocation = const LatLng(9.0192, 38.7525);

  MapController mapController = MapController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDateTime = DateTime.now();

  final socketUrl = 'wss://travelwave-backend.onrender.com';
  late final AcceptedRideRequestModel rideInfo;

  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((value) {
      setState(() {
        print(value);
        myLocation = value;
      });
    });

    final socket = io.io(socketUrl, <String, dynamic>{
      'transports': ['websocket']
    });

    socket.on('connect', (data) {
      print('connected');
    });
    socket.on('new notification accepted', (data) {
      print("new not recieved");
      print(data);
      rideInfo = AcceptedRideRequestModel.fromJson(data);
      context.read<PassRideRequestBloc>().add(MakeItAccepted());
    });

    socket.on('disconnect', (data) {
      print('disconnected');
    });
  }

  Future<void> pickDateTime() async {
    final initialDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: initialDate,
      lastDate: initialDate.add(const Duration(days: 15)),
    );
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = pickedDate.add(
              Duration(hours: pickedTime.hour, minutes: pickedTime.minute));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      body: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Stack(children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                onTap: (tapPosition, point) {
                  print(tapPosition);
                  print(point);
                  mapController.move(point, 15);
                },
                initialCenter: myLocation,
                initialZoom: 15,
              ),
              children: [
                openStreetMapTileLayer,
                MarkerLayer(
                  markers: [
                    Marker(
                      point: myLocation,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 40,
              left: 40,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: PrimaryColors.amberA400,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(Iconsax.menu_1),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 130,
                  width: 300,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBE7),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 45,
                              width: 230,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFBE7),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 1,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  selectAddress(
                                    context,
                                    shareRide,
                                    selectedDateTime,
                                  );
                                },
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 14.h),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey[700],
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(left: 0, top: 7),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Where would you go?',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: pickDateTime,
                            icon: const Icon(Icons.access_time),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 45,
                        width: 264,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBE7),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  shareRide = false;
                                });
                              },
                              child: Container(
                                height: 45,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: shareRide
                                      ? const Color(0xFFFFFBE7)
                                      : Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Single Ride',
                                    style: TextStyle(
                                      color: shareRide
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  shareRide = true;
                                });
                              },
                              child: Container(
                                height: 45,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: shareRide
                                      ? Theme.of(context).primaryColor
                                      : const Color(0xFFFFFBE7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Share Ride',
                                    style: TextStyle(
                                      color: shareRide
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }

  Future<dynamic> showNotifications(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Notifications',
              style: TextStyle(fontSize: 14),
            ),
          ),
          content: SizedBox(
            height: 200,
            child: ListView(
              children: const [],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const NotificationPage();
                    },
                  ),
                );
              },
              child: const Text('More'),
            ),
            const SizedBox(width: 80),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void selectAddress(BuildContext context, bool shareRide, DateTime dateTime) {
    TextEditingController fromController = TextEditingController(
        text: 'Tulu Dimtu, Akaki Kaliti, Addis Ababa, Ethiopia');
    TextEditingController toController = TextEditingController(
        text:
            'CBE kilinto branch, 4, Akaki Beseka, Akaki Kaliti, Addis Ababa, Ethiopia');

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select address',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Divider(color: Colors.grey[500], thickness: 1),
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.h),
                child: GestureDetector(
                  onTap: () async {
                    fromController.text = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const LocationSearch();
                        },
                      ),
                    );
                  },
                  child: TextField(
                    enabled: false,
                    controller: fromController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.my_location),
                      labelText: 'From',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.h),
                child: GestureDetector(
                  onTap: () async {
                    toController.text = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const LocationSearch();
                        },
                      ),
                    );
                  },
                  child: TextField(
                    enabled: false,
                    controller: toController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_on),
                      labelText: 'To',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 15.v).copyWith(top: 20.v),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (shareRide) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AvailableCarsPage(
                              scheduled: false,
                              source: fromController.text,
                              destination: toController.text,
                            );
                          },
                        ),
                      );
                    } else {
                      confirmAddress(
                        context,
                        fromController.text,
                        toController.text,
                        shareRide,
                        dateTime,
                      );
                    }
                  },
                  child: Container(
                    height: 45,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void confirmAddress(
    BuildContext context,
    String fromLocation,
    String toLocation,
    bool shareRide,
    DateTime scheduledTime,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocListener<PassRideRequestBloc, PassRideRequestState>(
          listener: (context, state) async {
            if (state is PassScheduledRideRequestSuccess) {
              final rideInfo = AcceptedRideRequestModel(
                userId: "664dadf1f310f773ea5027ef",
                message:
                    "A Red Sedan, Toyota Camry color Red with license plate ABC123 is on the way to pick you up.",
                fareAmount: 271.1823,
                rideId: "665f9843a2269aa745df5a8f",
                eta: "0 second",
                distance: 27,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green[300],
                  content: Text(rideInfo.message!),
                ),
              );

              Navigator.of(context).pop();
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const MainPage();
                  },
                ),
              );
            } else if (state is PassRideRequestSuccess) {
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return LocationScreenConfirmBottomsheet(
                      message: rideInfo,
                    );
                  },
                ),
              );
            } else if (state is PassRideRequestFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Failed to send ride request'),
                ),
              );
            }
          },
          child: BlocBuilder<PassRideRequestBloc, PassRideRequestState>(
            builder: (context, state) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Selected address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Divider(color: Colors.grey[500], thickness: 1),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 20,
                          ),
                          title: Text(
                            parseLocation(fromLocation)['placeName']!,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            parseLocation(fromLocation)['address']!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                          title: Text(
                            parseLocation(toLocation)['placeName']!,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            parseLocation(toLocation)['address']!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.v),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final start = await getLocation(fromLocation);
                                final end = await getLocation(toLocation);

                                PassRideRequest rideInfo = PassRideRequest(
                                  startLatitude: start.latitude,
                                  startLongitude: start.longitude,
                                  endLatitude: end.latitude,
                                  endLongitude: end.longitude,
                                  requestTime: DateTime.now().toString(),
                                  status: 'pending',
                                  scheduledTime: scheduledTime.toString(),
                                );

                                context.read<PassRideRequestBloc>().add(
                                      CreatePassScheduledRideRequest(
                                          rideInfo: rideInfo),
                                    );
                              },
                              child: Container(
                                height: 40.v,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                child: Center(
                                  child:
                                      state is PassScheduledRideRequestLoading
                                          ? const CircularProgressIndicator()
                                          : const Text(
                                              'Schedule Ride',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14.h,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.read<PassRideRequestBloc>().add(
                                    CreatePassRideRequest(
                                        fromLoc: fromLocation,
                                        toLoc: toLocation));
                              },
                              child: Container(
                                height: 40.v,
                                width: 280.h,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                child: Center(
                                  child: state is PassRideRequestLoading
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'Ride Now',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      );

  Future<LatLng> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(
      position.latitude,
      position.longitude,
    );
  }
}

Map<String, String> parseLocation(String locationString) {
  final parts = locationString.split(',');
  if (parts.length < 3) {
    return {'placeName': locationString, 'address': ''};
  }

  final placeName = parts.sublist(0, 3).join(', ');
  final address = parts.skip(3).join(', ');

  return {'placeName': placeName, 'address': address};
}

Future<LatLng> getLocation(String location) async {
  String baseURL =
      "https://nominatim.openstreetmap.org/search?format=json&q=$location";

  final response = await http.get(Uri.parse(baseURL));

  final loc = jsonDecode(response.body)[0];

  final latitude = loc['lat'];
  final longitude = loc['lon'];
  return LatLng(double.parse(latitude), double.parse(longitude));
}
