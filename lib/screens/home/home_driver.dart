import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/models/riderequest_model.dart';

import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/blocs/signin/signin_bloc.dart';
import 'package:travelwave_mobile/blocs/signin/signin_state.dart';
import 'package:travelwave_mobile/data/decode_token.dart';

import 'package:travelwave_mobile/screens/home/search.dart';
import 'package:travelwave_mobile/screens/home/search_location.dart';
import 'package:travelwave_mobile/screens/location/index.dart';
import 'package:travelwave_mobile/screens/notification/notifications.dart';
import 'package:travelwave_mobile/screens/side_menu/index.dart';
import 'package:travelwave_mobile/screens/transport/ride_request.dart';
import 'package:travelwave_mobile/screens/transport/select_transport.dart';
import 'package:travelwave_mobile/services/utils/avater.dart';

class HomePageDriver extends StatefulWidget {
  const HomePageDriver({super.key});

  @override
  _HomePageDriverState createState() => _HomePageDriverState();
}

class _HomePageDriverState extends State<HomePageDriver>
    with SingleTickerProviderStateMixin {
  bool isOnline = false;
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: GestureDetector(
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
                  ),
                  SizedBox(
                    width: 15.h,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Avatar(
                            textStyle: const TextStyle(
                                fontSize: 20, color: Colors.white),
                            name: "state.userInfo.fullName",
                            shape: AvatarShape.circle(50)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor:
                              isOnline ? Colors.green : PrimaryColors.gray200,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Text('Driver Name'),
                  Spacer(),
                  Switch(
                    value: isOnline,
                    onChanged: (value) {
                      setState(() {
                        isOnline = value;
                      });
                    },
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Upcoming Requests'),
                Tab(text: 'Accepted Requests'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  UpcomingRequestsTab(),
                  AcceptedRequestsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpcomingRequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Example data count
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ride Request ${index + 1}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text('Start: Location A'),
                Text('Destination: Location B'),
                Text('Details of Ride ${index + 1}'),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Accept ride logic
                      },
                      child: Text('Accept'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Decline ride logic
                      },
                      child: Text('Decline'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AcceptedRequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Example data count
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Accepted Ride ${index + 1}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text('Start: Location A'),
                Text('Destination: Location B'),
                Text('Details of Accepted Ride ${index + 1}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
