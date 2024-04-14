import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(37.7833, -122.4167),
    zoom: 15.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: initialCameraPosition,
              mapType: MapType.normal,
              myLocationEnabled: true,
            ),
            Positioned(
              top: 30,
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Iconsax.menu_1),
                  ),
                  const SizedBox(width: 180),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Iconsax.search_normal),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Iconsax.notification),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
