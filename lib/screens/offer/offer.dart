import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/side_menu/index.dart';
import 'package:travelwave_mobile/widgets/custom_image_view.dart';

class OfferPage extends StatelessWidget {
  OfferPage({super.key});
  final List<Map> items = [
    {
      "name": "Discount 15% off",
      "sub": "Special Promo valid for Black Friday",
      "img": ImageConstant.imgRedshop
    },
    {
      "name": "Discount 15% off",
      "sub": "Special Weekend deal promo",
      "img": ImageConstant.imgGreenshop
    },
    {
      "name": "Discount 15% off",
      "sub": "Special Promo valid for today",
      "img": ImageConstant.imgBlueshop
    },
    {
      "name": "Discount 15% off",
      "sub": "Special Promo valid for Black Friday",
      "img": ImageConstant.imgRedshop
    },
    {
      "name": "Discount 15% off",
      "sub": "Special Promo valid for Black Friday",
      "img": ImageConstant.imgBlueshop
    },
    {
      "name": "Discount 15% off",
      "sub": "Special Promo valid for Black Friday",
      "img": ImageConstant.imgRedshop
    },
    {
      "name": "Discount 15% off",
      "sub": "Special Promo valid for Black Friday",
      "img": ImageConstant.imgGreenshop
    },
    {
      "name": "Discount 15% off",
      "sub": "Special Promo valid for Black Friday",
      "img": ImageConstant.imgRedshop
    },
    {
      "name": "Discount 15% off",
      "sub": "Special Promo valid for Black Friday",
      "img": ImageConstant.imgRedshop
    },
    {
      "name": "Discount 15% off",
      "sub": "Special Promo valid for Black Friday",
      "img": ImageConstant.imgRedshop
    },
    {
      "name": "Discount 15% off",
      "sub": "Special Promo valid for Black Friday",
      "img": ImageConstant.imgRedshop
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Special Offer",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: Container(
          padding: EdgeInsets.only(
            left: 30.h,
          ),
          child: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Image.asset(ImageConstant.hamburgermenu),
              );
            },
          ),
        ),
      ),
      drawer: const SideMenu(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.v),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10.v, horizontal: 15.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: PrimaryColors.amberA400,
                ),
              ),
              child: ListTile(
                leading: CustomImageView(
                  imagePath: items[index]["img"],
                ),
                title: Text(
                  overflow: TextOverflow.ellipsis,
                  items[index]["name"].toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                    overflow: TextOverflow.ellipsis,
                    items[index]["sub"].toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: PrimaryColors.gray500,
                        )),
              ),
            );
          },
        ),
      ),
    );
  }
}
