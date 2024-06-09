import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/auth/auth_bloc_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/createRide/create_ride_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/rideRequest/ride_request_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/models/create_ride.dart';
import 'package:travelwave_mobile/models/riderequest_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travelwave_mobile/screens/side_menu/index.dart';
import 'package:travelwave_mobile/services/utils/avater.dart';
import 'package:travelwave_mobile/services/utils/formatter.dart';
import 'package:travelwave_mobile/services/utils/location.dart';
import 'package:travelwave_mobile/widgets/res_handle.dart';

class HomePageDriver extends StatefulWidget {
  const HomePageDriver({super.key});

  @override
  _HomePageDriverState createState() => _HomePageDriverState();
}

class _HomePageDriverState extends State<HomePageDriver>
    with SingleTickerProviderStateMixin {
  bool isOnline = false;
  bool notCreated = true;

  late double latitude;
  late double longitude;
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getLocation();
    _tabController = TabController(length: 2, vsync: this);
  }

  void getLocation() async {
    final position = await getCurrentLocation();
    print("object");
    print(position);
    latitude = position.latitude;
    longitude = position.longitude;
  }

  void _showRideOptionsModal(BuildContext context, bool val) {
    showModalBottomSheet(
      context: context,
      builder: (
        context,
      ) {
        bool isPooled = false;
        bool isScheduled = false;

        return BlocConsumer<CreateRideBloc, CreateRideState>(
          listener: (context, state) {
            if (state is CreateRideSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Ride created successfully'),
                ),
              );

              setState(() {
                isOnline = val;
                notCreated = false;
              });

              Navigator.pop(context);
            }
            if (state is CreateRideError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Ride Sharing Preferences',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Would you like to enable pooled or shared ride requests for your driving shifts?',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: PrimaryColors.gray500),
                      ),
                      const SizedBox(height: 20),
                      CheckboxListTile(
                        title: const Text('Allow Pooled Ride'),
                        value: isPooled,
                        onChanged: (value) {
                          setState(() {
                            isPooled = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Allow Shared Ride'),
                        value: isScheduled,
                        onChanged: (value) {
                          setState(() {
                            isScheduled = value ?? false;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          // Dispatch the CreateRide event

                          BlocProvider.of<CreateRideBloc>(context).add(
                            CreateRide(
                                rideInfo: Ride(
                                    latitude: latitude,
                                    longitude: longitude,
                                    numPassenger: 0,
                                    seats: 5,
                                    isPooled: isPooled,
                                    isScheduled: isScheduled)),
                          );
                          // Navigator.pop(context);
                        },
                        child: state is CreateRideLoading
                            ? const Padding(
                                padding: EdgeInsets.all(5),
                                child: CircularProgressIndicator())
                            : Text('Create Ride'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return Column(
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
                                  name: state.userInfo.fullName,
                                  shape: AvatarShape.circle(50)),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 6,
                                backgroundColor: isOnline
                                    ? Colors.green
                                    : PrimaryColors.gray200,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Text(state.userInfo.fullName ?? ""),
                        Spacer(),
                        Switch(
                          value: isOnline,
                          onChanged: (value) {
                            if (!isOnline && notCreated) {
                              _showRideOptionsModal(context, value);
                            } else {
                              setState(() {
                                isOnline = value;
                              });
                            }
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: PrimaryColors.gray700,
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: PrimaryColors.amber500,
                    tabs: const [
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
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You are not logged in'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class UpcomingRequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RideRequestBloc, RideRequestState>(
      builder: (context, state) {
        print(state);
        if (state is GetRidesSucess) {
          print(state.rideInfo);
          final List<RideRequestWithLocation> upcomingRequest = state.rideInfo
              .where((request) => request.status == 'pending')
              .toList();
          upcomingRequest
              .sort((a, b) => b.requestTime.compareTo(a.requestTime));
          if (upcomingRequest.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<RideRequestBloc>(context)
                    .add(const GetRideRequest());
              },
              child: ListView.builder(
                itemCount: upcomingRequest.length, // Example data count
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(5.0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              getRelativeTimeString(
                                  upcomingRequest[index].requestTime),
                              style: TextStyle(
                                color: PrimaryColors.gray500,
                              ),
                            ),
                          ),
                          Text(
                            'Ride Request ${index + 1}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            upcomingRequest[index].status,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                              'Start: ${upcomingRequest[index].startLocation}'),
                          Text(
                              'Destination: ${upcomingRequest[index].endLocation}'),
                          SizedBox(height: 5.v),
                          if (upcomingRequest[index].isPooled ||
                              upcomingRequest[index].isScheduled)
                            Wrap(
                              spacing: 8,
                              children: [
                                if (upcomingRequest[index].isPooled)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: PrimaryColors.amberA400,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Pooled",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                if (upcomingRequest[index].isScheduled)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: PrimaryColors.amberA400,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Scheduled",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<RideRequestBloc>(context).add(
                                    AcceptRideRequest(
                                      rideRequest: upcomingRequest[index],
                                    ),
                                  );
                                  // Accept ride logic
                                },
                                child: Text('Accept'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<RideRequestBloc>(context).add(
                                    DeclineRideRequest(
                                        upcomingRequest[index].id),
                                  );
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
              ),
            );
          } else {
            return emptyWidget(msg: "No upcoming requests Found");
          }
        }
        if (state is GetRidesError) {
          return emptyWidget(msg: state.error);
        }
        if (state is AcceptRideRequestError) {
          return emptyWidget(
              msg: state.error,
              retry: () {
                BlocProvider.of<RideRequestBloc>(context)
                    .add(const GetRideRequest());
              });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class AcceptedRequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RideRequestBloc, RideRequestState>(
      builder: (context, state) {
        if (state is GetRidesSucess) {
          final List<RideRequestWithLocation> acceptedRequest = state.rideInfo
              .where((request) => request.status == 'accepted')
              .toList();
          acceptedRequest
              .sort((a, b) => b.requestTime.compareTo(a.requestTime));
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<RideRequestBloc>(context)
                  .add(const GetRideRequest());
            },
            child: ListView.builder(
              itemCount: acceptedRequest.length, // Example data count
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
                        Text('Start: ${acceptedRequest[index].startLocation}'),
                        Text(
                            'Destination: ${acceptedRequest[index].endLocation}'),
                        SizedBox(height: 5.v),
                        if (acceptedRequest[index].isPooled ||
                            acceptedRequest[index].isScheduled)
                          Wrap(
                            spacing: 8,
                            children: [
                              if (acceptedRequest[index].isPooled)
                                Container(
                                  decoration: BoxDecoration(
                                    color: PrimaryColors.amberA400,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Pooled",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                              if (acceptedRequest[index].isScheduled)
                                Container(
                                  decoration: BoxDecoration(
                                    color: PrimaryColors.amberA400,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Scheduled",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                )
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
