import 'package:flutter/material.dart';
import 'package:travelwave_mobile/screens/transport/available_cars.dart';

class SelectTransportPage extends StatelessWidget {
  const SelectTransportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 350,
        height: 800,
        margin: const EdgeInsets.all(10),
        child: Stack(
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
            const Positioned(
              top: 100,
              left: 75,
              child: Text(
                'Select your transport',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
                top: 180,
                left: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const AvailableCarsPage();
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEC400).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.asset('assets/car.png'),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Car',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const AvailableCarsPage();
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBE7),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.asset('assets/taxi.png'),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Taxi',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
