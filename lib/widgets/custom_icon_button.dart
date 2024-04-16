import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      this.alignment,
      this.height,
      this.width,
      this.padding,
      this.decoration,
      this.child,
      this.onTap});

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget(context))
        : iconButtonWidget(context);
  }

  Widget iconButtonWidget(ctx) => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  // color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                  borderRadius: BorderRadius.circular(25.h),
                  border: Border.all(
                    color: PrimaryColors.amberA400,
                    width: 1.h,
                  ),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}
