import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/settings/change_password.dart';
import 'package:travelwave_mobile/screens/settings/widget/setting_option_list.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leadingWidth: 130.h,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              SizedBox(width: 16.h),
              const Icon(Icons.arrow_back_ios),
              Expanded(
                child: Text(
                  "Back",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
        child: ListView(
          children: [
            Text(
              "Privacy Policy for Ride share",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 12.h),
            Text(
              textAlign: TextAlign.start,
              "At Rideshare, accessible from rideshare.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by rideshare and how we use it.\nIf you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in rideshare. This policy is not applicable to any information collected offline or via channels other than this website. Our Privacy Policy was created with the help of the Free Privacy Policy Generator.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: PrimaryColors.gray500,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
