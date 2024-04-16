import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';

import 'package:travelwave_mobile/widgets/custom_icon_button.dart';
import 'package:travelwave_mobile/widgets/custom_image_view.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  final message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _buildAppbar(context),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 15.h,
              vertical: 23.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgEllipse42,
                      height: 36.adaptSize,
                      width: 36.adaptSize,
                      radius: BorderRadius.circular(
                        18.h,
                      ),
                      margin: EdgeInsets.only(bottom: 18.v),
                    ),
                    SizedBox(
                      width: 5.h,
                    ),
                    Wrap(direction: Axis.vertical, spacing: 9, children: [
                      _buildGoodevening(context, "Good Evening!"),
                      _buildGoodevening(
                          context, "Welcome to Car2go Customer \nService"),
                    ]),
                  ],
                ),
                SizedBox(height: 9.v),
                Padding(
                  padding: EdgeInsets.only(left: 48.h),
                  child: Text(
                    "8:29 pm",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(height: 28.v),
                _buildChatone(
                  context,
                ),
                SizedBox(height: 9.v),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "8:29 pm",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(height: 28.v),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgEllipse42,
                      height: 36.adaptSize,
                      width: 36.adaptSize,
                      radius: BorderRadius.circular(
                        18.h,
                      ),
                      margin: EdgeInsets.only(bottom: 18.v),
                    ),
                    SizedBox(
                      width: 5.h,
                    ),
                    Wrap(direction: Axis.vertical, spacing: 9, children: [
                      _buildGoodevening(
                          context, "Welcome to Car2go Customer \nService"),
                    ]),
                  ],
                ),
                SizedBox(height: 9.v),
                Padding(
                  padding: EdgeInsets.only(left: 47.h),
                  child: Text(
                    "8:29 pm",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(height: 28.v),
                _buildChatone(
                  context,
                ),
                SizedBox(height: 7.v),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Just now",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(height: 5.v)
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildRowcloseone(context),
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
                  child: Text("Chat",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: PrimaryColors.gray800,
                          ))),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildGoodevening(BuildContext context, String msg) {
    return SizedBox(
      width: 270.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: PrimaryColors.gray200,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.h),
              bottomLeft: Radius.circular(16.h),
              bottomRight: Radius.circular(16.h),
            ),
          ),
          child: Text(
            msg,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1.57,
                ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildChatone(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 63.h),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: PrimaryColors.pink300,
            border: Border.all(width: 1.5, color: PrimaryColors.amberA400),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.h),
              bottomLeft: Radius.circular(16.h),
              bottomRight: Radius.circular(16.h),
            ),
          ),
          child: Text(
            "Welcome to Car2go Customer Service",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1.57,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: EdgeInsets.only(
            left: 7.h,
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: TextFormField(
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              controller: message,
              style: Theme.of(context).textTheme.bodyMedium,
              obscureText: false,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Type Your Message",
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: PrimaryColors.blueGray100,
                    ),
                suffixIcon: Container(
                  margin: EdgeInsets.fromLTRB(30.h, 14.v, 9.h, 14.v),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgUser,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                  ),
                ),
                suffixIconConstraints: BoxConstraints(
                  maxHeight: 52.v,
                ),
                isDense: true,
                contentPadding: EdgeInsets.only(
                  left: 16.h,
                  top: 13.v,
                  bottom: 13.v,
                ),
                filled: false,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.h),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.h),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.h),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      16.h,
                    ),
                    bottomLeft: Radius.circular(
                      16.h,
                    ),
                    bottomRight: Radius.circular(
                      16.h,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: PrimaryColors.amberA400,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      16.h,
                    ),
                    bottomLeft: Radius.circular(
                      16.h,
                    ),
                    bottomRight: Radius.circular(
                      16.h,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: PrimaryColors.amberA400,
                    width: 1,
                  ),
                ),
                errorStyle: TextStyle(
                  color: PrimaryColors.amberA400,
                  fontSize: 12.fSize,
                ),
              ),
            ),
          )

          //  CustomTextFormField(
          //   controller: message,
          //   hintText: "Type Your Message",
          //   textInputAction: TextInputAction.done,
          //   suffix:
          //
          // Container(
          //     margin: EdgeInsets.fromLTRB(30.h, 14.v, 9.h, 14.v),
          //     child: CustomImageView(
          //       imagePath: ImageConstant.imgUser,
          //       height: 24.adaptSize,
          //       width: 24.adaptSize,
          //     ),
          //   ),
          //   suffixConstraints:
          // BoxConstraints(
          //     maxHeight: 52.v,
          //   ),
          //   contentPadding:
          // EdgeInsets.only(
          //     left: 16.h,
          //     top: 13.v,
          //     bottom: 13.v,
          //   ),
          // )

          ),
    );
  }

  /// Section Widget
  Widget _buildRowcloseone(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 15.h,
          right: 15.h,
          // bottom: 31.v,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10.v),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.v),
            child: CustomIconButton(
              decoration: BoxDecoration(
                // color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                borderRadius: BorderRadius.circular(25.h),
              ),
              height: 24.adaptSize,
              width: 24.adaptSize,
              padding: EdgeInsets.all(3.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgClose,
              ),
            ),
          ),
          _buildMessage(context),
          CustomImageView(
            imagePath: ImageConstant.imgTelevisionIndigo100,
            height: 32.adaptSize,
            width: 32.adaptSize,
            margin: EdgeInsets.only(
              left: 7.h,
              top: 6.v,
              bottom: 13.v,
            ),
          )
        ],
      ),
    );
  }
}
