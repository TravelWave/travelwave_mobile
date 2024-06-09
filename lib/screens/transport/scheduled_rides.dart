import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/constants.dart';

class ScheduledRidesPage extends StatefulWidget {
  const ScheduledRidesPage({super.key});

  @override
  State<ScheduledRidesPage> createState() => _ScheduledRidesPageState();
}

class _ScheduledRidesPageState extends State<ScheduledRidesPage> {
  late LatLng myLocation;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return Future<void>.value();
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
                'Scheduled Rides',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 721.v,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 220.h,
                      height: 180.v,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.h,
                                      vertical: 2.v,
                                    ),
                                    child: Text(
                                      'Volkswagen',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Automatic | 5 seats | 1034AA',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Shared Ride',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      '${DateFormat('MMM dd, yyyy').format(DateTime.now())} : @${DateFormat('hh:mm a').format(DateTime.now())}',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 120.h),
                              Container(
                                height: 80.v,
                                width: 90.h,
                                margin: EdgeInsets.symmetric(horizontal: 20.v),
                                child: Image.asset('assets/ride.png'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 35.v,
                                  width: 130.h,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10.v),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Cancel Ride',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.h),
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
      ),
    );
  }
}
