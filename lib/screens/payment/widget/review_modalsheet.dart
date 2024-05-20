import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:travelwave_mobile/blocs/feedback/feedback_bloc_bloc.dart';

// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/models/feedback_model.dart';
import 'package:travelwave_mobile/widgets/custom_button.dart';
import 'package:travelwave_mobile/widgets/custom_image_view.dart';

class ReviewScreenBottomsheet extends StatefulWidget {
  const ReviewScreenBottomsheet({super.key});

  @override
  State<ReviewScreenBottomsheet> createState() =>
      _ReviewScreenBottomsheetState();
}

class _ReviewScreenBottomsheetState extends State<ReviewScreenBottomsheet> {
  final List<String> tips = ["\$0", "\$2", "\$5", "\$10", "\$20"];
  final TextEditingController _msg = TextEditingController();
  late double _rating;
  final _formKey = GlobalKey<FormState>();

  String _selected = "";
  void showThanksDialog(context) {
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
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.v),
                          child: Image.asset(
                            ImageConstant.imgsuccess,
                            scale: 1.4,
                          ),
                        ),
                        Text('Thank You',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        SizedBox(height: 10.v),
                        Text(
                          'Thank you for your valuable feedback and tip',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.v),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.h, vertical: 10.v)
                            .copyWith(top: 26.v),
                    child: CustomElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBlocBloc, FeedbackBlocState>(
      builder: (context, state) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              ListView(shrinkWrap: true, reverse: true, children: [
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 7.h,
                    vertical: 9.v,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadiusStyle.customBorderTL24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImageView(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        imagePath: ImageConstant.imgArrowRight,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        alignment: Alignment.centerRight,
                      ),
                      SizedBox(height: 33.v),
                      RatingBar.builder(
                        ignoreGestures: false,
                        glow: false,
                        initialRating: 1.5,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemSize: 30.v,
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
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                      SizedBox(height: 21.v),
                      Text(
                        "Excellent",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 20.fSize,
                            ),
                      ),
                      SizedBox(height: 7.v),
                      Text(
                        "You rated Sergio Ramasis 4 star",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                      ),
                      SizedBox(height: 22.v),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.h),
                        child: TextFormField(
                          controller: _msg,
                          decoration: InputDecoration(
                            hintText: 'Write your text',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          maxLines: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a feedback comment';
                            }
                            return null;
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //     left: 8.h,
                      //     right: 9.h,
                      //   ),
                      //   child: CustomTextFormField(
                      //     // controller: inputoneController,
                      //     hintText: "lbl_write_your_text".tr,
                      //     prefix: Container(
                      //       margin: EdgeInsets.fromLTRB(17.h, 30.v, -52.h, 14.v),
                      //       child: CustomImageView(
                      //         imagePath: ImageConstant.imgUserYellow800,
                      //         height: 35.v,
                      //         width: 45.h,
                      //       ),
                      //     ),
                      //     prefixConstraints: BoxConstraints(
                      //       maxHeight: 118.v,
                      //     ),
                      //     maxLines: 5,
                      //     contentPadding: EdgeInsets.only(
                      //       top: 18.v,
                      //       right: 10.h,
                      //       bottom: 18.v,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 24.v),
                      Text(
                        "Give some tips to Sergio Ramasis",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 21.v),
                      Wrap(
                          direction: Axis.horizontal,
                          spacing: 15,
                          children: tips
                              .map(
                                (tip) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selected = tip;
                                    });
                                  },
                                  child: Container(
                                    width: 60.h,
                                    height: 60.v,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _selected == tip
                                            ? PrimaryColors.amberA400
                                            : Colors.grey,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: Text(tip,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  color: tip == _selected
                                                      ? PrimaryColors.amberA400
                                                      : null)),
                                    ),
                                  ),
                                ),
                              )
                              .toList()),
                      // Padding(
                      //     padding: EdgeInsets.only(
                      //       left: 8.h,
                      //       right: 9.h,
                      //     ),
                      //     child: CustomPinCodeTextField(
                      //       context: context,
                      //       // controller: otpController,
                      //       onChanged: (value) {
                      //         // otpController?.text = value;
                      //       },
                      //     )),
                      SizedBox(height: 11.v),
                      // Text(
                      //   "msg_enter_other_amount".tr,
                      //   style: CustomTextStyles.labelLargeAmberA400,
                      // ),
                      SizedBox(height: 20.v),
                      CustomElevatedButton(
                          isloading: state is FeedbackSubmitting,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<FeedbackBlocBloc>(context).add(
                                FeedbackSubmit(
                                  feedback: FeedBackMsg(
                                    rating: _rating,
                                    feedback: _msg.text,
                                  ),
                                ),
                              );
                            }
                            // Navigator.pop(context);
                            // showThanksDialog(context);
                          },
                          text: "Submit",
                          center: true,
                          margin: EdgeInsets.only(
                            left: 8.h,
                            right: 9.h,
                          ),
                          buttonTextStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                              )),
                      SizedBox(height: 29.v)
                    ],
                  ),
                ),
              ]),
            ]),
          ),
        );
      },
    );
  }
}
