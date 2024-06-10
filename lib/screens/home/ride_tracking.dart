import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/blocs/messages/message_bloc.dart';
import 'package:travelwave_mobile/blocs/notification/notification_bloc.dart';
import 'package:travelwave_mobile/blocs/notification/notification_state.dart';
import 'package:travelwave_mobile/blocs/ride/rideRequest/ride_request_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/models/models.dart';
import 'package:travelwave_mobile/models/riderequest_model.dart';
import 'package:travelwave_mobile/models/user_info.dart';
import 'package:travelwave_mobile/screens/location/message_screen.dart';
import 'package:travelwave_mobile/services/utils/avater.dart';
import 'package:travelwave_mobile/services/utils/formatter.dart';
import 'package:travelwave_mobile/services/utils/global_https.dart';
import 'package:travelwave_mobile/services/utils/location.dart';
import 'package:travelwave_mobile/widgets/custom_icon_button.dart';
import 'package:travelwave_mobile/widgets/custom_image_view.dart';
import 'package:travelwave_mobile/widgets/notification_dialog.dart';
import 'package:travelwave_mobile/widgets/res_handle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RideTracking extends StatefulWidget {
  final UserInfo passengerData;
  final RideRequestWithLocation rideData;

  RideTracking({
    super.key,
    required this.passengerData,
    required this.rideData,
  });

  @override
  State<RideTracking> createState() => _RideTrackingState();
}

class _RideTrackingState extends State<RideTracking> {
  late LatLng myLocation;
  bool isclicked = false;
  late final MapController _mapController;

  MapController mapController = MapController();
  Timer? _timer;
  @override
  void initState() {
    _mapController = MapController();
    myLocation = LatLng(
      widget.rideData.startLatitude,
      widget.rideData.startLongitude,
    );
    super.initState();
    // _startLocationUpdates();
  }

  @override
  void dispose() {
    _stopLocationUpdates();
    super.dispose();
  }

  void _startLocationUpdates() {
    _timer = Timer.periodic(Duration(seconds: 2), (_) async {
      print("object");
      print(widget.rideData.rideId);
      _fetchDriverLocation();
    });
  }

  void _stopLocationUpdates() {
    _timer?.cancel();
    _timer = null;
  }

  void _fetchDriverLocation() async {
    // Fetch the driver's location from the server
    final location = await getCurrentLocation();
    print(widget.rideData.id);
    LatLng driverLocation = await fetchDriverLocationFromServer(
        widget.rideData.rideId ?? widget.rideData.id,
        LatLng(location.latitude, location.longitude));

    // Update the myLocation variable

    setState(() {
      myLocation = driverLocation;
    });
  }

  void _moveToCurrentLocation() {
    _mapController.move(myLocation, 16.0);
    // Zoom level 15
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationReceived) {
          notificationDialogBox(
            isPooled: state.isPooled,
            isScheduled: state.isscheduled,
            passengerId: state.userId,
            requestId: state.rideRequestId,
            rideId: state.rideId,
            context,
            msg: state.message,
          );
        }

        if (state is CancelNotificationReceived) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Ride Request Cancelled from user: ${state.message}"),
          ));
          BlocProvider.of<RideRequestBloc>(context).add(const GetRideRequest());
          Navigator.pop(context);
        }
        if (state is RideFinishNotificationReceived) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Ride Finished"),
          ));
          BlocProvider.of<RideRequestBloc>(context).add(const GetRideRequest());
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(widget.rideData.startLatitude,
                          widget.rideData.startLongitude),
                      initialZoom: 14.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'dev.fleaflet.flutter_map.example',
                      ),
                      TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app'
                          // subdomains: ['a', 'b', 'c'],
                          ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points:
                                decodePolyline(widget.rideData.shortestPath),
                            strokeWidth: 4.0,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: myLocation,
                            child: Container(
                              child: Image.asset(
                                ImageConstant.imgride,
                              ),
                            ),
                          ),
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(widget.rideData.endLatitude,
                                widget.rideData.endLongitude),
                            child: Container(
                              child: Icon(
                                Icons.location_on,
                                color: Colors.green,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!isclicked) ...[
                  Padding(
                    padding: const EdgeInsets.all(12.0).copyWith(top: 16),
                    child: Row(
                      children: [
                        widget.passengerData.profilePicture != null
                            ? networkImageLoader(
                                shape: BoxShape.circle,
                                height: 70,
                                width: 70,
                                url: widget.passengerData.profilePicture!,
                              )
                            : CircleAvatar(
                                radius: 30,
                                child: Avatar(
                                    textStyle: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                    name: widget.passengerData.fullName,
                                    shape: AvatarShape.circle(50)),
                              ),
                        // CircleAvatar(
                        //   radius: 30,
                        //   child: passengerData.profilePicture != null
                        //       ? networkImageLoader(
                        //           shape: BoxShape.circle,
                        //           height: 56,
                        //           width: 56,
                        //           url: passengerData.profilePicture!,
                        //         )
                        //       : Avatar(
                        //           textStyle: const TextStyle(
                        //               fontSize: 20, color: Colors.white),
                        //           name: passengerData.fullName,
                        //           shape: AvatarShape.circle(50)),
                        // ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.passengerData.fullName!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: widget.passengerData.rating != null
                                  ? widget.passengerData.rating!.toDouble()
                                  : 2.5,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemSize: 30,
                              unratedColor: Colors.grey[300],
                              itemCount: 5,
                              updateOnDrag: true,
                              itemBuilder: (context, _) {
                                return Icon(
                                  Icons.star,
                                  color: PrimaryColors.yellow700,
                                );
                              },
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.passengerData.phoneNumber!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Icon(Icons.star, color: Colors.amber, size: 18),
                            //     SizedBox(width: 4),
                            //     Text(
                            //       passengerData.rating.toString(),
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //         color: Colors.grey[600],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                        Spacer(),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final url =
                                'tel:${widget.passengerData.phoneNumber!}';
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            } else {
                              // Handle the case where the phone dialer can't be launched
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Could not launch phone dialer'),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.phone),
                          label: Text('Call'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Ride Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Start Location:   '),
                        Flexible(
                            child: Text(
                          widget.rideData.startLocation,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Destination:   '),
                        Flexible(
                            child: Text(
                          widget.rideData.endLocation,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Request Time:'),
                        Text(
                          getRelativeTimeString(widget.rideData.requestTime),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status:'),
                        Flexible(
                            child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                widget.rideData.status)),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12)
                        .copyWith(bottom: 7),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isclicked = true;
                              });
                              _moveToCurrentLocation();
                              _startLocationUpdates();
                              // Handle accept or reject button press
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  isclicked ? Colors.grey[600] : null,
                              // primary: Colors.blue,
                              // onPrimary: Colors.white,

                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                            ),
                            child: Text('Start Ride'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 9.h,
                              top: 2.v,
                              bottom: 2.v,
                            ),
                            child: CustomIconButton(
                              onTap: () {
                                print(widget.rideData.passenger);
                                BlocProvider.of<MessageBloc>(context).add(
                                    FetchChatHistory(
                                        recieverId: widget.rideData.passenger));
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return MessageScreen(
                                        recieverId: widget.rideData.passenger);
                                  },
                                ));
                              },
                              height: 50.adaptSize,
                              width: 50.adaptSize,
                              padding: EdgeInsets.all(7.h),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgMessageSvgrepoCom,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
                if (isclicked) ...[
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${LocationUtils.estimateTravelTime(LocationUtils.calculateDistance(
                                          myLocation,
                                          LatLng(widget.rideData.endLatitude,
                                              widget.rideData.endLongitude),
                                        ), 50.0).toString()} min',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${LocationUtils.calculateDistance(myLocation, LatLng(widget.rideData.endLatitude, widget.rideData.endLongitude)).toString()} Km',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Current Time: ${DateFormat.Hm().format(DateTime.now())}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _moveToCurrentLocation();
                              },
                              icon: Icon(Icons.navigation,
                                  color: Colors.blue, size: 30),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
