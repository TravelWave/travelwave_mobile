import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/models/riderequest_model.dart';
import 'package:travelwave_mobile/screens/home/search.dart';
import 'package:travelwave_mobile/screens/home/search_location.dart';
import 'package:travelwave_mobile/screens/location/index.dart';
import 'package:travelwave_mobile/screens/notification/notifications.dart';
import 'package:travelwave_mobile/screens/side_menu/index.dart';
import 'package:travelwave_mobile/screens/transport/ride_request.dart';
import 'package:travelwave_mobile/screens/transport/select_transport.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool shareRide = false;
  LatLng myLocation = const LatLng(9.0192, 38.7525);
  MapController mapController = MapController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((value) {
      setState(() {
        myLocation = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                onTap: (tapPosition, point) {},
                initialCenter: const LatLng(9.0192, 38.7525),
                initialZoom: 10,
                interactionOptions: const InteractionOptions(
                  flags: ~InteractiveFlag.doubleTapZoom,
                ),
              ),
              children: [
                openStreetMapTileLayer,
                MarkerLayer(
                  markers: [
                    Marker(
                      point: myLocation,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red[900],
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                      color: const Color(0xFFFFF1B1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Iconsax.menu_1),
                  ),
                ),
                const SizedBox(width: 180),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const SearchPage();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1B1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    showNotifications(context);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1B1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Iconsax.notification),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 70,
            bottom: 20,
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
                    child: GestureDetector(
                      onTap: () {
                        selectAddress(context);
                      },
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[700],
                          ),
                          suffixIcon: Icon(
                            Icons.favorite_border,
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
                                  color:
                                      shareRide ? Colors.black : Colors.white,
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
                                  color:
                                      shareRide ? Colors.white : Colors.black,
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
        ],
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

  void selectAddress(BuildContext context) {
    TextEditingController fromController = TextEditingController();
    TextEditingController toController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: Column(
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
              GestureDetector(
                onTap: () async {
                  fromController.text = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const LocationSearch();
                      },
                    ),
                  );
                },
                child: SizedBox(
                  height: 50,
                  width: 300,
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
              GestureDetector(
                onTap: () async {
                  toController.text = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const LocationSearch();
                      },
                    ),
                  );
                },
                child: SizedBox(
                  height: 50,
                  width: 300,
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
              const SizedBox(height: 80),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  confirmAddress(
                    context,
                    fromController.text,
                    toController.text,
                  );
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
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 260,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: Column(
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return LocationScreenConfirmBottomsheet();
                      },
                    ),
                  );
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
                      'Confirm Location',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
