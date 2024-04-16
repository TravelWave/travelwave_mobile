import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/settings/widget/custom_textfield.dart';
import 'package:travelwave_mobile/screens/settings/widget/setting_option_list.dart';
import 'package:travelwave_mobile/widgets/custom_button.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leadingWidth: 100.h,
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
      body: ListView(
        children: [
          const CustomPasswordField(hint: "Old Password"),
          const CustomPasswordField(hint: "New Password"),
          const CustomPasswordField(hint: "Confirm Password"),
          SizedBox(
            height: 18.v,
          ),
          CustomElevatedButton(
            onPressed: () {},
            text: "Save",
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
