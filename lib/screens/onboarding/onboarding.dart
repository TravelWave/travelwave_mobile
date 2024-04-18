import 'package:flutter/material.dart';
import 'package:travelwave_mobile/screens/authentication/welcome.dart';
import 'package:travelwave_mobile/widgets/onboarding_widgets.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final pages = [
      onboardingWidget(
        context,
        'assets/01_onboarding.png',
        'Anywhere you are',
        'Our ridesharing service is ready to take you there safely and conveniently.',
        0,
        () {
          pageController.nextPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeIn,
          );
        },
      ),
      onboardingWidget(
        context,
        'assets/02_onboarding.png',
        'At anytime',
        'You can rely on our ridesharing service to provide you with a ride, day or night.',
        1,
        () {
          pageController.nextPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeIn,
          );
        },
      ),
      onboardingWidget(
        context,
        'assets/03_onboarding.png',
        'Book your car',
        'Enjoy a comfortable ride to your destination with our ridesharing service.',
        2,
        () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return const WelcomePage();
            },
          ));
        },
        isLastPage: true,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const WelcomePage();
                  },
                ),
              );
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
    );
  }
}
