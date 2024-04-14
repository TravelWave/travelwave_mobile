import 'package:flutter/material.dart';

import 'package:travelwave_mobile/screens/widget/custom_elevated_button.dart';
import 'package:travelwave_mobile/screens/widget/customimage_view.dart';
import '../../core/app_export.dart';

class CancelRideScreen extends StatefulWidget {
  const CancelRideScreen({super.key});

  @override
  State<CancelRideScreen> createState() => _CancelRideScreenState();
}

num? selected;
List<String> item = [
  "Waiting for long time",
  "Unable to contact driver",
  "Driver denied to go to destination",
  "Driver denied to come to pickup",
  "Wrong address shown",
  "The price is not reasonable"
];
void showCancelDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.h),
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23.h),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.v),
                      child: Image.asset(
                        ImageConstant.imgemoji,
                        scale: 1.4,
                      ),
                    ),
                    Text("We're so sad about your cancellation",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    SizedBox(height: 10.v),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.h),
                  child: Text(
                      'We will continue to improve our service & satify you on the next trip.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                          )),
                ),

                SizedBox(
                  height: 16.v,
                ),

                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 13.h, vertical: 10.v)
                          .copyWith(top: 26.v),
                  child: CustomElevatedButton(
                      onPressed: () {
                        // print("object");
                        // reviewDialog(context);
                      },
                      // width: 189.h,
                      center: true,
                      text: "Back Home",
                      buttonTextStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.background)),
                )
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: RaisedButton(
                //     child: Text('Submit'),
                //     onPressed: () {
                //       // Perform submit action
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _CancelRideScreenState extends State<CancelRideScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        resizeToAvoidBottomInset: true,
        appBar: _buildAppbar(context),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 10.h,
            ),
            child: Column(
              children: [
                Text(
                  "Please select the reason of cancellation.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 15.v),
                _buildForm(context),
                SizedBox(height: 15.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 6.h,
                    right: 5.h,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Other  ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    maxLines: 4,
                  ),
                ),
                SizedBox(height: 60.v),
                CustomElevatedButton(
                  onPressed: () {
                    showCancelDialog(context);
                  },
                  text: "Submit",
                  center: true,
                  margin: EdgeInsets.symmetric(horizontal: 6.h),
                  buttonTextStyle:
                      Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          ),
                ),
                // SizedBox(height: 5.v)
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: 32.h,
      leading: InkWell(
        onTap: () {
          Navigator.of(context);
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: 8.h,
            top: 16.v,
            bottom: 15.v,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgArrowLeft,
            height: 24.adaptSize,
            width: 24.adaptSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 5.h),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 1.v,
                  ),
                  child: Text("Back",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: PrimaryColors.gray800,
                          ))),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                  padding: EdgeInsets.only(left: 97.h),
                  child: Text("Cancel Taxi",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: PrimaryColors.gray800,
                          ))),
            )
          ],
        ),
      ),
    );
    // return CustomAppBar(
    //   leadingWidth: 32.h,
    //   leading: AppbarLeadingImage(
    //     imagePath: ImageConstant.imgArrowLeft,
    //     margin: EdgeInsets.only(
    //       left: 8.h,
    //       top: 16.v,
    //       bottom: 15.v,
    //     ),
    //     onTap: () {
    //       onTapArrowleftone(context);
    //     },
    //   ),
    //   title: Padding(
    //     padding: EdgeInsets.only(left: 5.h),
    //     child: Row(
    //       children: [
    //         AppbarSubtitle(
    //           text: "lbl_back".tr,
    //           margin: EdgeInsets.symmetric(vertical: 1.v),
    //         ),
    //         AppbarTitle(
    //           text: "lbl_cancel_taxi".tr,
    //           margin: EdgeInsets.only(left: 67.h),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  /// Section Widget
  Widget _buildForm(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: 6.h,
          right: 5.h,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 15.v,
            );
          },
          itemCount: item.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (selected == index) {
                    selected = null;
                  } else {
                    selected = index;
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 9.h,
                  vertical: 18.v,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  // border: Border.all(
                  //   color: PrimaryColors.amberA400,
                  //   width: 1.h,
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: selected != index
                          ? PrimaryColors.black900.withOpacity(0.24)
                          : PrimaryColors.amberA400.withOpacity(0.4),
                      spreadRadius: 1.h,
                      blurRadius: 1.h,
                      offset: const Offset(
                        0,
                        0,
                      ),
                    )
                  ],
                  borderRadius: BorderRadiusStyle.roundedBorder8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 20.adaptSize,
                        width: 20.adaptSize,
                        // margin: EdgeInsets.only(bottom: 4.v),
                        // padding: EdgeInsets.symmetric(
                        //   horizontal: 5.h,
                        //   vertical: 6.v,
                        // ),
                        decoration: selected == index
                            ? BoxDecoration(
                                borderRadius: BorderRadiusStyle.roundedBorder4,
                                color: Colors.green,
                                border:
                                    Border.all(width: 1, color: Colors.green))
                            : BoxDecoration(
                                borderRadius: BorderRadiusStyle.roundedBorder4,
                                color: Theme.of(context).colorScheme.background,
                                border: Border.all(
                                    width: 1, color: PrimaryColors.gray500)),
                        child: selected == index
                            ? const FittedBox(
                                fit: BoxFit.contain,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox()),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 14.h,
                        // bottom: 4.v,
                      ),
                      child: Text(
                        item[index],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
