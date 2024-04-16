import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/location/message_screen.dart';
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
        leading: Padding(
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
      drawer: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(70.h),
            bottomRight: Radius.circular(70.h),
          ),
          child: Drawer(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5.h,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios)),
                        Text(
                          'Back',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage(ImageConstant.imgEllipse42),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 30.v,
                                width: 30.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    border: Border.all(
                                      width: 1.5,
                                      color: PrimaryColors.amberA400,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: SvgPicture.asset(
                                    ImageConstant.imgCamera,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                        SizedBox(height: 15.v),
                        Text(
                          'John Doe',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'johndoe@example.com',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 25.v),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Image.asset(
                      ImageConstant.imgHistory,
                      scale: 1.2,
                    ),
                    title: Text(
                      'History',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      // Handle home tile tap
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(
                      ImageConstant.imgComplain,
                      scale: 1.2,
                    ),
                    title: Text(
                      'Complain',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      // Handle settings tile tap
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(
                      ImageConstant.imgReferral,
                      scale: 1.2,
                    ),
                    title: Text(
                      'Referral',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      // Handle settings tile tap
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(
                      ImageConstant.imgabout,
                      scale: 1.2,
                    ),
                    title: Text(
                      'About Us',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      // Handle settings tile tap
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(
                      ImageConstant.imgsetting,
                      scale: 1.2,
                    ),
                    title: Text(
                      'Settings',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      // Handle settings tile tap
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(
                      ImageConstant.imgsupport,
                      scale: 1.2,
                    ),
                    title: Text(
                      'Help and Support',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      // Handle settings tile tap
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(
                      ImageConstant.imglogout,
                      scale: 1.2,
                    ),
                    title: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      // Handle settings tile tap
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
          )),
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
    return Container(
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
