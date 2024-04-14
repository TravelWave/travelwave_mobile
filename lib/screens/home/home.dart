import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travelwave_mobile/screens/favourites/favourite.dart';
import 'package:travelwave_mobile/screens/home/home_transport.dart';
import 'package:travelwave_mobile/screens/offer/offer.dart';
import 'package:travelwave_mobile/screens/profile/profile.dart';
import 'package:travelwave_mobile/screens/wallet/wallet.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;

  final pages = const [
    HomePage(),
    FavouritePage(),
    WalletPage(),
    OfferPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: pages[currentPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[800],
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
            activeIcon: Icon(Iconsax.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.heart),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.notification),
            label: 'Offer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
