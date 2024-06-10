import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:shimmer/shimmer.dart';
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

Widget shimmerLoader(
    {required double height,
    required double width,
    BoxShape shape = BoxShape.rectangle}) {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ttb,
    baseColor: const Color(0xffeeeeee),
    highlightColor: const Color(0xfff5f5f5),
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: Colors.white, shape: shape),
    ),
  );
}

Widget networkImageLoader(
        {required String url,
        required double height,
        required double width,
        double? radius,
        BoxFit fit = BoxFit.cover,
        BoxShape shape = BoxShape.rectangle,
        Widget? placeholder}) =>
    CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: radius == null ? null : BorderRadius.circular(radius),
          shape: shape,
          image: DecorationImage(fit: fit, image: imageProvider),
        ),
        height: height,
        width: width,
      ),
      placeholder: (context, url) =>
          placeholder ??
          shimmerLoader(height: height - 1, width: width - 1, shape: shape),
      errorWidget: (context, url, error) =>
          placeholder ??
          Container(
              decoration: BoxDecoration(shape: shape),
              height: height - 1,
              width: width - 1,
              child: const Icon(Icons.error)),
    );

class LocationUtils {
  static double calculateDistance(LatLng start, LatLng end) {
    final Distance distance = Distance();
    return distance.as(LengthUnit.Kilometer, start, end);
  }

  static int estimateTravelTime(
      double distanceKm, double averageSpeedKmPerHour) {
    return (distanceKm / averageSpeedKmPerHour * 60).toInt();
  }
}
