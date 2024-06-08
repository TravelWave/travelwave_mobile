import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/blocs/notification/notification_bloc.dart';
import 'package:travelwave_mobile/blocs/notification/notification_state.dart';
import 'package:travelwave_mobile/blocs/ride/rideRequest/ride_request_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/models/models.dart';
import 'package:travelwave_mobile/models/riderequest_model.dart';
import 'package:travelwave_mobile/models/user_info.dart';
import 'package:travelwave_mobile/services/utils/avater.dart';
import 'package:travelwave_mobile/services/utils/formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RideDetailsModal extends StatelessWidget {
  final UserInfo passengerData;
  final RideRequestWithLocation rideData;

  RideDetailsModal({
    super.key,
    required this.passengerData,
    required this.rideData,
  });
  LatLng myLocation = const LatLng(9.0192, 38.7525);
  MapController mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is CancelNotificationReceived) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Ride Request Cancelled from user: ${state.message}"),
          ));
          Navigator.pop(context);

          BlocProvider.of<RideRequestBloc>(context).add(const GetRideRequest());
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.v,
              ),
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter:
                        LatLng(rideData.startLatitude, rideData.startLongitude),
                    initialZoom: 14.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
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
                          points: decodePolyline(rideData.shortestPath),
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
                          point: LatLng(
                              rideData.startLatitude, rideData.startLongitude),
                          child: Container(
                            child: Image.asset(
                              ImageConstant.imgride,
                            ),
                          ),
                        ),
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(
                              rideData.endLatitude, rideData.endLongitude),
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
              Padding(
                padding: const EdgeInsets.all(12.0).copyWith(top: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Avatar(
                          textStyle: const TextStyle(
                              fontSize: 20, color: Colors.white),
                          name: passengerData.fullName,
                          shape: AvatarShape.circle(50)),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          passengerData.fullName!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: passengerData.rating != null
                              ? passengerData.rating!.toDouble()
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
                          passengerData.phoneNumber!,
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
                        final url = 'tel:${passengerData.phoneNumber!}';
                        if (await canLaunchUrlString(url)) {
                          await launchUrlString(url);
                        } else {
                          // Handle the case where the phone dialer can't be launched
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Could not launch phone dialer'),
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.phone),
                      label: Text('Call'),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
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
                      rideData.startLocation,
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
                      rideData.endLocation,
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
                      getRelativeTimeString(rideData.requestTime),
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
                            rideData.status)),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 7),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle accept or reject button press
                        },
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.blue,
                          // onPrimary: Colors.white,

                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                        child: Text('Accept Ride'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle accept or reject button press
                        },
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.blue,
                          // onPrimary: Colors.white,

                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                        child: Text('Decline Ride'),
                      ),
                    ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
