import 'package:flutter/material.dart';

import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/location/cancel_ride.dart';
import 'package:travelwave_mobile/screens/location/message_screen.dart';
import 'package:travelwave_mobile/screens/payment/index.dart';
import 'package:travelwave_mobile/screens/side_menu/index.dart';
import 'package:travelwave_mobile/widgets/custom_button.dart';
import 'package:travelwave_mobile/widgets/custom_icon_button.dart';
import 'package:travelwave_mobile/widgets/custom_image_view.dart';

// ignore_for_file: must_be_immutable

class LocationScreenConfirmBottomsheet extends StatelessWidget {
  const LocationScreenConfirmBottomsheet({super.key});

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
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0.4),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
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
                      "Your driver is coming in 3:35",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                SizedBox(height: 12.v),
                const Divider(),
                SizedBox(height: 15.v),
                _buildRowsergioramasi(context),
                SizedBox(height: 16.v),
                const Divider(),
                SizedBox(height: 12.v),
                _buildRowpaymentmetho(context),
                SizedBox(height: 13.v),
                _buildRowtelevision(context),
                SizedBox(height: 27.v),
                _buildRowcallone(context),
                SizedBox(height: 38.v)
              ],
            ),
          ),
        ),
      ]),
    );
  }

  /// Section Widget
  Widget _buildRowsergioramasi(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle553,
            height: 59.v,
            width: 54.h,
            radius: BorderRadius.circular(
              4.h,
            ),
            margin: EdgeInsets.only(top: 2.v),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text("Sergio Ramasis",
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
                    Text("800m 5 mins away",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: PrimaryColors.gray500,
                                  fontSize: 10.fSize,
                                )),
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
                        child: Text("4.9 (531 reviews)",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: PrimaryColors.gray500,
                                  fontSize: 10.fSize,
                                )),
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
  Widget _buildRowpaymentmetho(BuildContext context) {
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
              "Payment method",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Text(
            "\$220.00",
            style: Theme.of(context).textTheme.headlineMedium,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowtelevision(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const PaymentCheckOutScreen();
          },
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.h),
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 5.v,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder4,
          color: PrimaryColors.yellow50,
          border: Border.all(
            color: PrimaryColors.amberA400,
            width: 1.h,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgTelevision,
              height: 35.v,
              width: 45.h,
              margin: EdgeInsets.only(
                top: 5.v,
                bottom: 6.v,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 13.h,
                top: 3.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "**** **** **** 8970",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "Expires: 12/26",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowcallone(BuildContext context) {
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
                    return MessageScreen();
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
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const CancelRideScreen();
                  },
                ));
              },
              width: 189.h,
              center: true,
              text: "Cancel Ride",
              buttonTextStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.background))
        ],
      ),
    );
  }
}
