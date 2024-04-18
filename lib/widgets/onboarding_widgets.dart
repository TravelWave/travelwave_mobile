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
          top: 60,
          left: 20,
          child: SizedBox(
            width: 300,
            height: 180,
            child: Image.asset(img),
          ),
        ),
        Positioned(
          top: 250,
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
        ),
        Positioned(
          bottom: 80,
          left: 140,
          child: GestureDetector(
            onTap: () {
              func();
            },
            child: CustomPaint(
              painter: ArcPainter(
                progress: (pageIndex + 1) / 3,
              ),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(80),
                ),
                child: !isLastPage
                    ? const Icon(
                        Icons.arrow_forward,
                        weight: 100,
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
        ),
      ],
    ),
  );
}
