import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFEC400);

// These are used in the code as a reference to create your UI Responsively.
const num figamaDesignWIDTH = 393;
const num figamaDesignHEIGHT = 852;
const num figamaDesignStatusBar = 0;

extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;
  double get _height => SizeUtils.height;
  double get h => ((this * _width) / figamaDesignWIDTH);
  double get v =>
      (this * _height) / (figamaDesignHEIGHT - figamaDesignStatusBar);
  double get adaptSize {
    var height = v;
    var width = h;
    return height < width ? height.toDoubleValue() : width.toDoubleValue();
  }

  double get fSize => adaptSize;
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuild = Widget Function(
    BuildContext context, Orientation orientation, DeviceType deviceType);

class Sizer extends StatelessWidget {
  const Sizer({super.key, required this.builder});

  /// Builds the widget whenever the orientation changes.
  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.setScreenSize(constraints, orientation);
        return builder(context, orientation, SizeUtils.deviceType);
      });
    });
  }
}
// ignore_for_file: must_be_immutable

class SizeUtils {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's Orientation
  static late Orientation orientation;

  /// Type of Device
  ///
  /// This can either be mobile or tablet
  static late DeviceType deviceType;

  /// Device's Height
  static late double height;

  /// Device's Width
  static late double width;

  static void setScreenSize(
    BoxConstraints constraints,
    Orientation currentOrientation,
  ) {
    boxConstraints = constraints;
    orientation = currentOrientation;
    if (orientation == Orientation.portrait) {
      width =
          boxConstraints.maxWidth.isNonZero(defaultValue: figamaDesignWIDTH);
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      width =
          boxConstraints.maxHeight.isNonZero(defaultValue: figamaDesignWIDTH);
      height = boxConstraints.maxWidth.isNonZero();
    }
    deviceType = DeviceType.mobile;
  }
}

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    primaryColor: const Color(0xFFEDAE10),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: PrimaryColors.gray800,
        fontSize: 16.fSize,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: PrimaryColors.gray700,
        fontSize: 14.fSize,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: PrimaryColors.gray600,
        fontSize: 12.fSize,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        color: PrimaryColors.gray900,
        fontSize: 28.fSize,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
      labelLarge: TextStyle(
        color: ColorSchemes.primaryColorScheme.errorContainer,
        fontSize: 12.fSize,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        color: PrimaryColors.gray900,
        fontSize: 22.fSize,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: PrimaryColors.gray700,
        fontSize: 16.fSize,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: ColorSchemes.primaryColorScheme.secondaryContainer,
        fontSize: 14.fSize,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFFEDAE10)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        overlayColor: MaterialStateProperty.all<Color>(const Color(0xFFFEC400)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: Color(0xFFFEC400)),
          ),
        ),
      ),
    ),
  );
}

class ColorSchemes {
  static const primaryColorScheme = ColorScheme.light(
    primary: Color(0XFFEDAE10),
    primaryContainer: Color(0XFFFEC400),
    secondaryContainer: Color(0XFFB8B8B8),
    errorContainer: Color(0XFF898989),
    onError: Color(0XFFDDDDDD),
    onPrimaryContainer: Color(0XFFFFFFFF),
  );
}

class PrimaryColors {
  // Amber
  static Color get amber500 => const Color(0XFFF4BD05);
  static Color get amberA400 => const Color(0XFFFEC400);
// Black
  static Color get black900 => const Color(0XFF000000);
// BlueGray
  static Color get blueGray100 => const Color(0XFFD0D0D0);
  static Color get blueGray400 => const Color(0XFF888888);
// Gray
  static Color get gray200 => const Color(0XFFE8E8E8);
  static Color get pink300 => const Color(0XFFFFFBE7);
  static Color get gray500 => const Color(0XFFA0A0A0);
  static Color get gray600 => const Color(0XFF717171);
  static Color get gray700 => const Color(0XFF5A5A5A);
  static Color get gray800 => const Color(0XFF414141);
  static Color get gray900 => const Color(0XFF2A2A2A);
// Green
  static Color get green600 => const Color(0XFF43A048);
// Indigo
  static Color get indigo100 => const Color(0XFFC2CCDE);
// Yellow
  static Color get yellow50 => const Color(0XFFFFFAE6);
  static Color get yellow700 => const Color(0XFFFBC02D);
  static Color get yellow800 => const Color(0XFFF79E1B);
}
