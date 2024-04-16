import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:travelwave_mobile/constants.dart';

import 'package:travelwave_mobile/widgets/custom_button.dart';

class ReferalPage extends StatefulWidget {
  const ReferalPage({super.key});

  @override
  State<ReferalPage> createState() => _ReferalPageState();
}

bool isCopied = false;
TextEditingController _referalcode = TextEditingController();

class _ReferalPageState extends State<ReferalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Referral",
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
            padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 15.v),
            child: Text("Refer a friend and Earn \$20",
                style: Theme.of(context).textTheme.titleMedium),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: TextField(
              controller: _referalcode,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: PrimaryColors.gray200,
                      width: 1.5,
                      style: BorderStyle.solid),
                ),
                hintText: "Refer friends",
                hintStyle: Theme.of(context).textTheme.titleSmall,
                // fillColor: Theme.of(context).colorScheme.background,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: PrimaryColors.gray200,
                      width: 1.5,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: PrimaryColors.gray200, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: RotatedBox(
                  quarterTurns: 2,
                  child: IconButton(
                    icon: Icon(
                      Icons.copy,
                      size: 22.fSize,
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _referalcode.text));
                      setState(() {
                        isCopied = !isCopied;
                      });
                      // Handle visibility toggle
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.v,
          ),
          CustomElevatedButton(
            onPressed: () {},
            text: "Invite",
            center: true,
            margin: EdgeInsets.only(
              left: 15.h,
              right: 16.h,
              bottom: 42.v,
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
