import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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

  final pages = [
    const HomePage(),
    const WalletPage(),
    OfferPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).primaryColor,
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        unselectedItemColor: Colors.grey[800],
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
            activeIcon: Icon(Iconsax.home),
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(
                'assets/wallet.png',
                color: currentPage == 2
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
            ),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(
                'assets/offer.png',
                color: currentPage == 3
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
            ),
            label: 'Offer',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(
                'assets/profile.png',
                color: currentPage == 4
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
