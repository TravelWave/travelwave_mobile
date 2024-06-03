import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/user/user_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/settings/widget/custom_textfield.dart';

import 'package:travelwave_mobile/widgets/custom_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldpass = TextEditingController();

  final newpass = TextEditingController();

  final newpassconfirm = TextEditingController();
  String error = '';

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
      body: BlocConsumer<UserBloc, UserState>(listener: (context, state) {
        if (state is ChangePasswordsucess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Password changed successfully"),
          ));
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is ChangePasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(state.message),
          ));
        }
      }, builder: (BuildContext context, UserState state) {
        return ListView(
          children: [
            CustomPasswordField(
              hint: "Old Password",
              controller: oldpass,
            ),
            CustomPasswordField(
              hint: "New Password",
              controller: newpass,
            ),
            CustomPasswordField(
              hint: "Confirm Password",
              controller: newpassconfirm,
            ),
            if (error != '')
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(error,
                              style: const TextStyle(color: Colors.red))),
                    )
                  ],
                ),
              ),
            SizedBox(
              height: 18.v,
            ),
            CustomElevatedButton(
              onPressed: () {
                if (newpass.text.trim() != newpassconfirm.text.trim()) {
                  setState(() {
                    error = "the provided password does not match";
                  });
                  return;
                } else {
                  error = '';
                }
                BlocProvider.of<UserBloc>(context).add(ChangePasswordEvent(
                  oldpass: oldpass.text.trim(),
                  newpass: newpass.text.trim(),
                ));
              },
              text: "Save",
              isloading: state is ChangePasswordRequesting ? true : false,
              center: true,
              margin: EdgeInsets.only(
                left: 15.h,
                right: 16.h,
                bottom: 42.v,
              ),
              buttonTextStyle:
                  Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
            ),
          ],
        );
      }),
    );
  }
}
