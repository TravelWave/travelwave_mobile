import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/settings/change_password.dart';
import 'package:travelwave_mobile/screens/settings/delete_account.dart';
import 'package:travelwave_mobile/screens/settings/privacy_policy.dart';
import 'package:travelwave_mobile/screens/settings/widget/setting_option_list.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leadingWidth: 150.h,
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
      body: Column(
        children: [
          SettingListTile(
            option: "Change Password",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const ChangePassword();
                },
              ));
            },
          ),
          // SettingListTile(
          //   option: "Change Language",
          //   onPressed: () {},
          // ),
          SettingListTile(
            option: "Privacy Policy",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const PrivacyPolicyScreen();
                },
              ));
            },
          ),
          SettingListTile(
            option: "Delete Account",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const DeleteAccountScreen();
                },
              ));
            },
          )
        ],
      ),
    );
  }
}
