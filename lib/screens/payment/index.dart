import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/payment/widget/review_modalsheet.dart';
import 'package:travelwave_mobile/widgets/custom_button.dart';
import 'package:travelwave_mobile/widgets/custom_image_view.dart';
import 'package:travelwave_mobile/widgets/dashed_line.dart';

class PaymentCheckOutScreen extends StatelessWidget {
  const PaymentCheckOutScreen({super.key});

  void showSuccessDialog(context) {
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
                          ImageConstant.imgsuccess,
                          scale: 1.4,
                        ),
                      ),
                      Text('Payment Success',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      SizedBox(height: 10.v),
                      Text(
                          'Your money has been successfully sent to Sergio Ramasis',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  )),
                      SizedBox(height: 16.v),
                      Text('Amount',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  )),
                      SizedBox(height: 6.v),
                      Text('\$215',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  )),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Expanded(child: Container()),
                        const MySeparator(color: Colors.grey),
                        Container(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.v,
                  ),

                  Text('How is Your trip',
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 23.h)
                        .copyWith(top: 5.v),
                    child: Text(
                        'Your feedback will help us to improve your driving experience better',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            )),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.h, vertical: 10.v)
                            .copyWith(top: 26.v),
                    child: CustomElevatedButton(
                        onPressed: () {
                          // print("object");
                          reviewDialog(context);
                        },
                        // width: 189.h,
                        center: true,
                        text: "Provide Feedback",
                        buttonTextStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.background)),
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

  void reviewDialog(context) {
    Navigator.pop(context);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return const SingleChildScrollView(child: ReviewScreenBottomsheet());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 15.h,
            vertical: 23.v,
          ),
          child: Column(
            children: [
              _buildRowmustangshelb(context),
              SizedBox(height: 17.v),
              _buildColumncharge(context),
              SizedBox(height: 30.v),
              _buildColumnselectpay(context),
              SizedBox(height: 5.v)
            ],
          ),
        ),
        bottomNavigationBar: _buildConfirmride(context),
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
            top: 14.v,
            bottom: 17.v,
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
                  padding: EdgeInsets.only(bottom: 3.v),
                  child: Text("Back",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: PrimaryColors.gray800,
                          ))),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                  padding: EdgeInsets.only(
                    left: 79.h,
                    top: 1.v,
                  ),
                  child: Text("Payment",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: PrimaryColors.gray800,
                          ))),
            )
          ],
        ),
      ),
    );

    // CustomAppBar(
    //   leadingWidth: 32.h,
    //   leading: AppbarLeadingImage(
    //     imagePath: ImageConstant.imgArrowLeft,
    // margin: EdgeInsets.only(
    //   left: 8.h,
    //   top: 14.v,
    //   bottom: 17.v,
    // ),
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
    //           margin: EdgeInsets.only(bottom: 3.v),
    //         ),
    //         AppbarTitle(
    //           text: "lbl_payment".tr,
    // margin: EdgeInsets.only(
    //   left: 79.h,
    //   top: 1.v,
    // ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  /// Section Widget
  Widget _buildRowmustangshelb(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1.h),
      padding: EdgeInsets.all(11.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder4,
        color: PrimaryColors.yellow50,
        border: Border.all(
          color: PrimaryColors.amberA400,
          width: 1.h,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 2.v,
              bottom: 1.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mustang Shelby GT",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 3.v),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgSignal,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      margin: EdgeInsets.only(
                        top: 3.v,
                        bottom: 1.v,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 7.h),
                      child: Text(
                        "4.9 (531 reviews)",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage3,
            height: 54.v,
            width: 93.h,
            margin: EdgeInsets.only(right: 2.h),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumncharge(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Charge",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 5.v),
          _buildVat5(
            context,
            vatfive: "Mustang/per hours",
            price: "\$200",
          ),
          SizedBox(height: 5.v),
          _buildVat5(
            context,
            vatfive: "Vat (5%)",
            price: "\$20",
          ),
          SizedBox(height: 5.v),
          _buildVat5(
            context,
            vatfive: "Promo Code",
            price: "\$52",
          ),
          SizedBox(height: 3.v),
          Divider(
            color: PrimaryColors.gray200,
          ),
          SizedBox(height: 13.v),
          Padding(
            padding: EdgeInsets.only(right: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "\$215",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnselectpay(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1.v),
                  child: Text("Select payment method",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 18.fSize,
                          )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.v),
                  child: Text(
                    "View All",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: PrimaryColors.amber500,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.v),
          _buildRowuserOne(context,
              userOne: ImageConstant.imgTelevision,
              eightthousandni: "**** **** **** 8970",
              expires12twenty: "Expires: 12/26",
              gray: false),
          SizedBox(height: 8.v),
          _buildRowuserOne(context,
              userOne: ImageConstant.imgUserYellow800,
              eightthousandni: "**** **** **** 8970",
              expires12twenty: "Expires: 12/26",
              gray: true),
          SizedBox(height: 8.v),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 5.v,
            ),
            decoration: BoxDecoration(
              color: PrimaryColors.yellow50.withOpacity(0.2),
              border: Border.all(
                color: PrimaryColors.amberA400.withOpacity(0.3),
                width: 1.h,
              ),
              borderRadius: BorderRadiusStyle.roundedBorder4,
            ),
            // decoration: BoxDecoration(
            //   color: PrimaryColors.yellow50,
            //   border: Border.all(
            //     color: PrimaryColors.amberA400,
            //     width: 1.h,
            //   ),
            //   borderRadius: BorderRadiusStyle.roundedBorder4,
            // ),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgPayment,
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
                    top: 4.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "mailaddress@mail.com",
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
          SizedBox(height: 8.v),

          //   CustomTextFormField(
          //   controller: thumbsupController,
          //   hintText: "Cash",
          //   hintStyle: Theme.of(context).textTheme.titleMedium!,
          //   textInputAction: TextInputAction.done,
          //   prefix: Container(
          //     margin: EdgeInsets.fromLTRB(15.h, 8.v, 11.h, 8.v),
          //     child: CustomImageView(
          //       imagePath: ImageConstant.imgThumbsup,
          //       height: 43.v,
          //       width: 45.h,
          //     ),
          //   ),
          //   prefixConstraints: BoxConstraints(
          //     maxHeight: 60.v,
          //   ),
          //   contentPadding: EdgeInsets.only(
          //     top: 17.v,
          //     right: 30.h,
          //     bottom: 17.v,
          //   ),
          //   borderDecoration: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(4.h),
          //     borderSide: BorderSide(
          //       color: PrimaryColors.amberA400,
          //       width: 1,
          //     ),
          //   ),
          //   filled: true,
          //   fillColor: PrimaryColors.yellow50,
          // ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildConfirmride(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        showSuccessDialog(context);
      },
      text: "Confirm Ride",
      center: true,
      margin: EdgeInsets.only(
        left: 15.h,
        right: 16.h,
        bottom: 16.v,
      ),
      buttonTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
    );
  }

  /// Common widget
  Widget _buildVat5(
    BuildContext context, {
    required String vatfive,
    required String price,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: vatfive,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              // TextSpan(
              //   text: price,
              //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
              //         color: PrimaryColors.gray700,
              //         fontSize: 10.fSize,
              //       ),
              // )
            ],
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          price,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: PrimaryColors.gray700,
              ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildRowuserOne(BuildContext context,
      {required String userOne,
      required String eightthousandni,
      required String expires12twenty,
      required bool gray}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 5.v,
      ),
      decoration: BoxDecoration(
        color: gray
            ? PrimaryColors.yellow50.withOpacity(0.2)
            : PrimaryColors.yellow50,
        border: Border.all(
          color: gray
              ? PrimaryColors.amberA400.withOpacity(0.3)
              : PrimaryColors.amberA400,
          width: 1.h,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: userOne,
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
                  eightthousandni,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: PrimaryColors.gray700,
                      ),
                ),
                Text(
                  expires12twenty,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
}
