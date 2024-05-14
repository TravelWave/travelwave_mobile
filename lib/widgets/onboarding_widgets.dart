import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/onboarding/arc_indicator.dart';

Widget onboardingWidget(BuildContext context, String img, String title,
    String description, int pageIndex, Function func,
    {bool isLastPage = false}) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    margin: EdgeInsets.all(10.v),
    child: Column(
      children: [
        SizedBox(height: 100.v),
        SizedBox(
          width: 300.h,
          height: 180.v,
          child: Image.asset(img),
        ),
        Container(
          height: 150.v,
          width: 300.h,
          margin: EdgeInsets.all(10.v),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Expanded(
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 150.v),
        GestureDetector(
          onTap: () {
            func();
          },
          child: CustomPaint(
            painter: ArcPainter(
              progress: (pageIndex + 1) / 3,
            ),
            child: Container(
              width: 50.h,
              height: 50.v,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(80.v),
              ),
              child: !isLastPage
                  ? Icon(
                      Icons.arrow_forward,
                      weight: 100.h,
                      size: 20,
                    )
                  : const Center(
                      child: Text(
                        'Go',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ],
    ),
  );
}
