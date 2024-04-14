import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'Favourite Page',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      )),
    );
  }
}
