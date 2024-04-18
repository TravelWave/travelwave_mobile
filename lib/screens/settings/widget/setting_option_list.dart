import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';

class SettingListTile extends StatelessWidget {
  final String option;
  final Function() onPressed;
  const SettingListTile(
      {super.key, required this.option, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: PrimaryColors.amberA400,
          )),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: ListTile(
            title: Text(
              option,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 20,
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
