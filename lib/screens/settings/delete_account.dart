import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/user/user_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/widgets/custom_button.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Delete Account",
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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
            child: Text(
              textAlign: TextAlign.start,
              "Are you sure you want to delete your account? Please read how account deletion will affect.\nDeleting your account removes personal information our database. Tour email becomes permanently reserved and same email cannot be re-use to register a new account.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: PrimaryColors.gray500,
                  fontWeight: FontWeight.w400),
            ),
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return CustomElevatedButton(
                onPressed: () {
                  BlocProvider.of<UserBloc>(context).add(DeleteUser());
                },
                isloading: state is DeleteuserRequesting ? true : false,
                text: "Delete",
                center: true,
                buttonStyle: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xffF44336)),
                ),
                margin: EdgeInsets.only(
                  left: 15.h,
                  right: 16.h,
                  bottom: 42.v,
                ),
                buttonTextStyle:
                    Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
              );
            },
          ),
        ],
      ),
    );
  }
}
