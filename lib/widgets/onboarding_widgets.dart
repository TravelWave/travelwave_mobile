import 'package:flutter/material.dart';
import 'package:travelwave_mobile/screens/onboarding/arc_indicator.dart';

Widget onboardingWidget(BuildContext context, String img, String title,
    String description, int pageIndex, Function func,
    {bool isLastPage = false}) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    margin: const EdgeInsets.all(10),
    child: Stack(
      children: [
        Positioned(
          child: SizedBox(
            width: 350,
            height: 200,
            child: Image.asset(img),
          ),
        ),
        Positioned(
          top: 200,
          left: 10,
          child: Container(
            height: 150,
            width: 300,
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                Expanded(
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          left: 120,
          child: GestureDetector(
            onTap: () {
              func();
            },
            child: CustomPaint(
              painter: ArcPainter(
                progress: (pageIndex + 1) / 3,
              ),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(80),
                ),
                child: !isLastPage
                    ? const Icon(
                        Icons.arrow_forward,
                        weight: 100,
                        size: 32,
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
        ),
      ],
    ),
  );
}
