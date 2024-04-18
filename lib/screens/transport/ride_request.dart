import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelwave_mobile/screens/home/home.dart';
import 'package:travelwave_mobile/screens/location/index.dart';

class RideRequestPage extends StatefulWidget {
  const RideRequestPage({super.key});

  @override
  State<RideRequestPage> createState() => _RideRequestPageState();
}

class _RideRequestPageState extends State<RideRequestPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
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
                const SizedBox(width: 20),
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 20, top: 25),
                  child: const Text(
                    'Request for Ride',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 16,
                  ),
                  title: Text(
                    'Current Location',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: const Text(
                    '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                  title: Text(
                    'Office',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: const Text(
                    '1901 Thornridge Cir. Shiloh, Hawaii 81063',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Mustang Shelby GT',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Theme.of(context).primaryColor,
                            size: 18,
                          ),
                          const Text(
                            '4.9 (531 reviews)',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                    width: 100,
                    child: Image.asset('assets/mustang.png'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Charge',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mustang/per hours',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '\$200',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vat (5%)',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '\$10',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Promo Code',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '-\$5',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  'Pickup day: ',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(
                    DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                    ),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  'Pickup time: ',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat('hh:mm a').format(
                    DateTime(
                      selectedDate.hour,
                      selectedDate.minute,
                    ),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return LocationScreenConfirmBottomsheet();
                    },
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Confirm Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }
}
