import 'package:flutter/material.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'Offer Page',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      )),
    );
  }
}
