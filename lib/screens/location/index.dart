import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelwave_mobile/blocs/ride_routes/ride_routes_bloc.dart';
import 'package:travelwave_mobile/blocs/ride_routes/ride_routes_event.dart';
import 'package:travelwave_mobile/blocs/ride_routes/ride_routes_state.dart';

import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/models/accepted_ride_request_model.dart';
import 'package:travelwave_mobile/screens/location/cancel_ride.dart';
import 'package:travelwave_mobile/screens/location/message_screen.dart';
import 'package:travelwave_mobile/screens/side_menu/index.dart';
import 'package:travelwave_mobile/widgets/custom_button.dart';
import 'package:travelwave_mobile/widgets/custom_icon_button.dart';
import 'package:travelwave_mobile/widgets/custom_image_view.dart';

// ignore_for_file: must_be_immutable

class LocationScreenConfirmBottomsheet extends StatefulWidget {
 
  final AcceptedRideRequestModel message;
  const LocationScreenConfirmBottomsheet({
    super.key,
    required this.message,
  });


  @override
  State<LocationScreenConfirmBottomsheet> createState() =>
      _LocationScreenConfirmBottomsheetState();
}

class _LocationScreenConfirmBottomsheetState
    extends State<LocationScreenConfirmBottomsheet> {
  bool shareRide = false;
  LatLng myLocation = const LatLng(9.0192, 38.7525);
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((value) {
      setState(() {
        myLocation = value;
      });
    });
    print('userId: ${widget.message.userId}');
    print('rideId: ${widget.message.rideId}');
    context.read<RideRoutesBloc>().add(
          GetRideRoutes(
            driverId: widget.message.userId!,
            rideId: widget.message.rideId!,
          ),
        );
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      );

  Future<LatLng> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(
      position.latitude,
      position.longitude,
    );
  }

  Future<String> getLocationName(LatLng location) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );

    if (placemarks.isNotEmpty) {
      return placemarks[0].name!;
    } else {
      return "Unknown location";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15.h, top: 20.v),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none_outlined,
                size: 28,
              ),
              onPressed: () {},
            ),
          ),
        ],
        leading: Container(
          padding: EdgeInsets.only(left: 30.h, top: 20.v),
          child: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Image.asset(ImageConstant.hamburgermenu),
              );
            },
          ),
        ),
      ),
      drawer: const SideMenu(),
      body: BlocListener<RideRoutesBloc, RideRouteState>(
        listener: (context, state) {
          if (state is RideRoutesStateInitial) {
            context.read<RideRoutesBloc>().add(
                  GetRideRoutes(
                    driverId: widget.message.userId!,
                    rideId: widget.message.rideId!,
                  ),
                );
          } else if (state is RideRoutesStateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(''),
              ),
            );
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<RideRoutesBloc, RideRouteState>(
          builder: (context, state) {
            if (state is! RideRoutesStateSuccess) {
              context.read<RideRoutesBloc>().add(
                    GetRideRoutes(
                      driverId: widget.message.userId!,
                      rideId: widget.message.rideId!,
                    ),
                  );
            }
            return Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      onTap: (tapPosition, point) {},
                      initialCenter: const LatLng(9.0192, 38.7525),
                      initialZoom: 15,
                      interactionOptions: const InteractionOptions(
                        flags: ~InteractiveFlag.doubleTapZoom,
                      ),
                    ),
                    children: [
                      openStreetMapTileLayer,
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: myLocation,
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red[900],
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: (state is! RideRoutesStateSuccess)
                      ? const CircularProgressIndicator()
                      : Container(
                          padding: EdgeInsets.symmetric(vertical: 9.v),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadiusStyle.customBorderTL24,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgArrowRight,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(right: 10.h),
                              ),
                              SizedBox(height: 25.v),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15.h),
                                  child: Text(
                                    widget.message.message!,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.v),
                              const Divider(),
                              SizedBox(height: 15.v),
                              buildRowUserProfile(
                                context,
                                state.userInfo.fullName!,
                                state.userInfo.rating!,
                                widget.message.distance!,
                              ),
                              SizedBox(height: 16.v),
                              const Divider(),
                              SizedBox(height: 12.v),
                              buildRowPaymentMethod(context),
                              SizedBox(height: 27.v),
                              buildRowCall(
                                  context, state.userInfo.phoneNumber!),
                              SizedBox(height: 38.v),
                            ],
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget buildRowUserProfile(BuildContext context, String driverName,
      int driverRating, double distance) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle553,
            height: 59.v,
            width: 54.h,
            radius: BorderRadius.circular(4.h),
            margin: EdgeInsets.only(top: 2.v),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(driverName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: PrimaryColors.gray900, fontSize: 18.fSize)),
                ),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLinkedin,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                    ),
                    Text(
                      "${(distance / 1000).toStringAsFixed(2)} km away",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: PrimaryColors.gray500,
                            fontSize: 10.fSize,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 4.v),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgSignal,
                        height: 8.adaptSize,
                        width: 8.adaptSize,
                        margin: EdgeInsets.only(
                          top: 4.v,
                          bottom: 2.v,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.h),
                        child: Text(
                          "$driverRating rating",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: PrimaryColors.gray500,
                                    fontSize: 10.fSize,
                                  ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgImage3,
            height: 54.v,
            width: 93.h,
            margin: EdgeInsets.only(top: 5.v),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget buildRowPaymentMethod(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.h,
        right: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 11.v,
              bottom: 5.v,
            ),
            child: Text(
              "Total Amount",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Text(
            "\$${widget.message.fareAmount}",
            style: Theme.of(context).textTheme.headlineMedium,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget buildRowCall(BuildContext context, String driverPhone) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.v),
            child: CustomIconButton(
              height: 50.adaptSize,
              width: 50.adaptSize,
              padding: EdgeInsets.all(7.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgCall,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 9.h,
              top: 2.v,
              bottom: 2.v,
            ),
            child: CustomIconButton(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MessageScreen(
                      recieverId: "",
                    );
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
          const Spacer(),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CancelRideScreen();
                  },
                ),
              );
            },
            width: 189.h,
            center: true,
            text: "Cancel Ride",
            buttonTextStyle: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.background),
          ),
        ],
      ),
    );
  }
}
