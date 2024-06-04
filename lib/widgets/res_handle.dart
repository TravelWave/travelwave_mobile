import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';

Widget emptyWidget(
    {IconData? icon,
    double iconSize = 80,
    required String msg,
    double fontSize = 16,
    VoidCallback? retry}) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon ?? Icons.error,
          size: iconSize,
          color: PrimaryColors.amberA400.withOpacity(0.5),
        ),
        const SizedBox(height: 20),
        Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize, color: PrimaryColors.gray800),
        ),
        const SizedBox(
          height: 8,
        ),
        if (retry != null)
          TextButton(onPressed: retry, child: const Text("retry"))
      ],
    ),
  );
}
