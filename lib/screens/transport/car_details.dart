import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travelwave_mobile/widgets/transport_widgets.dart';

class CarDetailPage extends StatefulWidget {
  const CarDetailPage({super.key});

  @override
  State<CarDetailPage> createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  int index = 0;
  final items = [
    Container(
      height: 200,
      width: 280,
      margin: const EdgeInsets.all(5),
      child: Image.asset('assets/mustang.png'),
    ),
    Container(
      height: 200,
      width: 280,
      margin: const EdgeInsets.all(5),
      child: Image.asset('assets/car.png'),
    ),
    Container(
      height: 200,
      width: 280,
      margin: const EdgeInsets.all(5),
      child: Image.asset('assets/taxi.png'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 30, bottom: 10),
                padding: const EdgeInsets.all(5),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 18),
                    Text('Back'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Mustang Shelby GT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Row(
              children: [
                Icon(
                  Iconsax.star1,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 5),
                const Text(
                  '4.9 (531 reviews)',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 110,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        index = (index - 1) % items.length;
                      });
                    },
                    child: const Icon(Icons.arrow_back_ios),
                  ),
                  items[index],
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        index = (index + 1) % items.length;
                      });
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Car features',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                carFeaturesWidget(context, 'Model', 'GT5000'),
                carFeaturesWidget(context, 'Capacity', '760hp'),
                carFeaturesWidget(context, 'Color', 'Red'),
                carFeaturesWidget(context, 'Fuel type', 'Octane'),
                carFeaturesWidget(context, 'Gear type', 'Automatic'),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const RideRequestPage();
                //     },
                //   ),
                // );
              },
              child: Container(
                height: 40,
                width: 250,
                margin: const EdgeInsets.only(left: 40),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Ride Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
