import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:travelwave_mobile/constants.dart';

import 'package:travelwave_mobile/widgets/custom_button.dart';

class ComplainPage extends StatefulWidget {
  const ComplainPage({super.key});

  @override
  State<ComplainPage> createState() => _ComplainPageState();
}

bool isCopied = false;
TextEditingController _referalcode = TextEditingController();
List<String> items = ["Vehicle not clean", "rider not good", "not family car"];

class _ComplainPageState extends State<ComplainPage> {
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
                      Text('Send Successful',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      SizedBox(height: 10.v),
                      Text('Your complain has been send successfully',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  )),
                    ]),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.h, vertical: 10.v)
                            .copyWith(top: 26.v),
                    child: CustomElevatedButton(
                        onPressed: () {
                          // print("object");
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Complain",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leadingWidth: 150.h,
        leading: Row(
          children: [
            SizedBox(width: 16.h),
            const Icon(Icons.arrow_back_ios),
            Expanded(
              child: Text(
                "Back",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.v),
            child: DropdownButtonFormField<String>(
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 24.fSize,
              ),
              decoration: InputDecoration(
                hintText: "Select Complain options",
                hintStyle: Theme.of(context).textTheme.titleSmall,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Custom border radius
                  borderSide: BorderSide(
                      color: PrimaryColors.gray500), // Custom border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Custom border radius
                  borderSide: BorderSide(
                      color: PrimaryColors.gray500), // Custom border color
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Custom border radius
                  borderSide: BorderSide(
                      color: PrimaryColors.gray500), // Custom border color
                ),
                // Custom suffix icon and color
              ),
              items: items
                  .map((val) => DropdownMenuItem(
                        value: val,
                        child: Text(
                          val,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ))
                  .toList(),
              onChanged: (String? value) {
                // Handle dropdown value change
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: TextField(
              decoration: InputDecoration(
                hintStyle: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w300),
                hintText: 'Write your complain here (minimum 10 characters)',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PrimaryColors.gray500),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: PrimaryColors.gray500),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              maxLines: 4,
            ),
          ),
          SizedBox(
            height: 35.v,
          ),
          CustomElevatedButton(
            onPressed: () {
              showSuccessDialog(context);
            },
            text: "Submit",
            center: true,
            margin: EdgeInsets.only(
              left: 15.h,
              right: 16.h,
            ),
            buttonTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
        ],
      ),
    );
  }
}
