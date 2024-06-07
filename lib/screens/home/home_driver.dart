import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travelwave_mobile/blocs/auth/auth_bloc_bloc.dart';
import 'package:travelwave_mobile/blocs/notification/notification_bloc.dart';
import 'package:travelwave_mobile/blocs/notification/notification_event.dart';
import 'package:travelwave_mobile/blocs/notification/notification_state.dart';
import 'package:travelwave_mobile/blocs/pasenger/passenger_bloc_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/createRide/create_ride_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/rideRequest/ride_request_bloc.dart';
import 'package:travelwave_mobile/blocs/vehicles/vehicles_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/models/create_ride.dart';
import 'package:travelwave_mobile/models/riderequest_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/blocs/signin/signin_bloc.dart';
import 'package:travelwave_mobile/blocs/signin/signin_state.dart';
import 'package:travelwave_mobile/data/decode_token.dart';
import 'package:travelwave_mobile/screens/home/ride_detail.dart';

import 'package:travelwave_mobile/screens/home/search.dart';
import 'package:travelwave_mobile/screens/home/search_location.dart';
import 'package:travelwave_mobile/screens/location/index.dart';
import 'package:travelwave_mobile/screens/notification/notifications.dart';
import 'package:travelwave_mobile/screens/side_menu/index.dart';
import 'package:travelwave_mobile/screens/transport/ride_request.dart';
import 'package:travelwave_mobile/screens/transport/select_transport.dart';
import 'package:travelwave_mobile/services/utils/app_constant.dart';
import 'package:travelwave_mobile/services/utils/avater.dart';
import 'package:travelwave_mobile/services/utils/formatter.dart';
import 'package:travelwave_mobile/services/utils/location.dart';
import 'package:travelwave_mobile/widgets/driver_form.dart';
import 'package:travelwave_mobile/widgets/notification_dialog.dart';
import 'package:travelwave_mobile/widgets/res_handle.dart';

class HomePageDriver extends StatefulWidget {
  final String driverId;
  const HomePageDriver({super.key, required this.driverId});

  @override
  _HomePageDriverState createState() => _HomePageDriverState();
}

class _HomePageDriverState extends State<HomePageDriver>
    with SingleTickerProviderStateMixin {
  bool isOnline = false;
  bool notCreated = true;
  io.Socket? socket;
  late double latitude;
  late double longitude;
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initDataWithSocket();
    _tabController = TabController(length: 2, vsync: this);
  }

  void initDataWithSocket() async {
    final position = await getCurrentLocation();
    socket = io.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
    });

    socket?.on('connect', (_) {
      print('connected');
    });

    socket?.on('notification', (data) {
      BlocProvider.of<NotificationBloc>(context)
          .add(NewNotificationReceived(data['message'], data['userId']));
    });

    socket?.on('disconnect', (_) {
      print('disconnected');
    });

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
                        title: const Text('Allow Scheduled Ride'),
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
                            : const Text('Create Ride'),
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
  void dispose() {
    socket?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehiclesBloc, VehiclesState>(
      builder: (context, state) {
        print(state);
        if (state is VehiclesFetchError) {
          return Scaffold(
            body: emptyWidget(
              msg: "Can't get vehicle data Please retry",
              retry: () {
                BlocProvider.of<VehiclesBloc>(context)
                    .add(FetchVehiclesByDriver(id: widget.driverId));
              },
            ),
          );
        }
        if (state is VehiclesFetchSuccess) {
          if (state.vehicle == null) {
            return DriverFormScreen();
          }
          if (state.vehicle?.isVerified == false) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Pending..."),
                ),
                body: RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<VehiclesBloc>(context)
                        .add(FetchVehiclesByDriver(id: widget.driverId));
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                      height:
                          MediaQuery.of(context).size.height - kToolbarHeight,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(ImageConstant.imgwatch),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: Text(
                                "We will look through your documents and reach out to you within",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            SizedBox(
                              height: 15.v,
                            ),
                            Text(
                              "12 Hours",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                            ),
                            SizedBox(
                              height: 20.v,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<VehiclesBloc>(context).add(
                                      FetchVehiclesByDriver(
                                          id: widget.driverId));
                                },
                                child: Text("Refresh"))
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          }
          if (state.vehicle!.isVerified) {
            return Scaffold(
              key: _scaffoldKey,
              drawer: const SideMenu(),
              body: BlocConsumer<NotificationBloc, NotificationState>(
                  listener: (context, state) {
                if (state is NotificationReceived) {
                  notificationDialogBox(context, msg: state.message);
                }
              }, builder: (context, state) {
                return Padding(
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                fontSize: 20,
                                                color: Colors.white),
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
                                  const Spacer(),
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
                );
              }),
            );
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
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
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<PassengerBloc>(context).add(
                          PassengerFetch(id: upcomingRequest[index].passenger));
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) =>
                            BlocConsumer<PassengerBloc, PassengerBlocState>(
                          listener: (context, state) {
                            if (state is PassengerBlocError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          "Something went wrong Please try again later")));
                            }
                          },
                          builder: (context, state) {
                            print(state);
                            if (state is PassengerBlocSuccess) {
                              return RideDetailsModal(
                                passengerData: state.passenger,
                                rideData: upcomingRequest[index],
                              );
                            }
                            if (state is PassengerBlocError) {
                              return emptyWidget(
                                  msg:
                                      "An error occured while fetching passenger data",
                                  retry: () {
                                    BlocProvider.of<PassengerBloc>(context).add(
                                        PassengerFetch(
                                            id: upcomingRequest[index]
                                                .passenger));
                                  });
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      );
                    },
                    child: Card(
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Start:  ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: PrimaryColors.amber500),
                                  ),
                                  TextSpan(
                                      text:
                                          upcomingRequest[index].startLocation,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Destination:  ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: PrimaryColors.amber500),
                                  ),
                                  TextSpan(
                                      text: upcomingRequest[index].endLocation,
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
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
                                              color: Colors.white,
                                              fontSize: 12),
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
                                              color: Colors.white,
                                              fontSize: 12),
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
                                    BlocProvider.of<RideRequestBloc>(context)
                                        .add(
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
                                    BlocProvider.of<RideRequestBloc>(context)
                                        .add(
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
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Start:  ',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: PrimaryColors.amber500),
                              ),
                              TextSpan(
                                  text: acceptedRequest[index].startLocation,
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Destination:  ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: PrimaryColors.amber500),
                              ),
                              TextSpan(
                                  text: acceptedRequest[index].endLocation,
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
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
