import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/auth/auth_bloc_bloc.dart';
import 'package:travelwave_mobile/constants.dart';

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
          BlocProvider.of<AuthenticationBloc>(context).add(OnBoardSeen());
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) {
          //     return const WelcomePage();
          //   },
          // ));
        },
        isLastPage: true,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(OnBoardSeen());
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return const WelcomePage();
              //     },
              //   ),
              // );
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(width: 10.h),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: PageView.builder(
          controller: pageController,
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
        ),
      ),
    );
  }
}
