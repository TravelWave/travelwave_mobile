import 'package:flutter/material.dart';

import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/history/widget/filter_list_tile.dart';
import 'package:travelwave_mobile/screens/side_menu/index.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  List<Map> items = [
    {
      "name": "Nate",
      "car": "Today at 09:20 am",
      "time": "\$570.00",
      "img": ImageConstant.imgUp
    },
    {
      "name": "Henry",
      "car": "Today at 10:20 am",
      "time": "-\$570.00",
      "img": ImageConstant.imgDown
    },
    {
      "name": "William",
      "car": "Tommorrow at 01:20 am",
      "time": "\$570.00",
      "img": ImageConstant.imgUp
    },
    {
      "name": "Nate",
      "car": "Today at 7:20 am",
      "time": "-\$570.00",
      "img": ImageConstant.imgDown
    },
    {
      "name": "Nate",
      "car": "Today at 19:20 am",
      "time": "\$570.00",
      "img": ImageConstant.imgDown
    },
    {
      "name": "Nate",
      "car": "Today at 09:20 am",
      "time": "-\$570.00",
      "img": ImageConstant.imgDown
    },
    {
      "name": "Nate",
      "car": "Today at 09:20 am",
      "time": "\$570.00",
      "img": ImageConstant.imgUp
    },
    {
      "name": "Nate",
      "car": "Today at 09:20 am",
      "time": "\$570.00",
      "img": ImageConstant.imgUp
    },
    {
      "name": "william",
      "car": "Tomorrow at 05:20 am",
      "time": "-\$570.00",
      "img": ImageConstant.imgUp
    },
    {
      "name": "Henry",
      "car": "Today at 10:20 am",
      "time": "\$570.00",
      "img": ImageConstant.imgDown
    },
    {
      "name": "William",
      "car": "Tomorrow at 09:20 am",
      "time": "-\$570.00",
      "img": ImageConstant.imgUp
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 15.h, top: 20.v),
              // padding: EdgeInsets.all(5.fSize).copyWith(top: 0),
              decoration: BoxDecoration(
                  color: PrimaryColors.yellowish,
                  borderRadius: BorderRadius.circular(7)),
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 28,
                ),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15.h, top: 20.v),
              // padding: EdgeInsets.all(0.fSize).copyWith(top: 0),
              decoration: BoxDecoration(
                  color: PrimaryColors.yellowish,
                  borderRadius: BorderRadius.circular(7)),
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  size: 28,
                ),
                onPressed: () {},
              ),
            ),
          ],
          leading: Container(
            padding: EdgeInsets.only(left: 30.h, top: 20.v),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.v,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 145.v,
                width: 166.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1.2,
                      color: PrimaryColors.amberA400,
                    ),
                    color: PrimaryColors.pink300),
                child: Column(
                  children: [
                    SizedBox(
                      height: 36.v,
                    ),
                    Text(
                      "\$200",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 21.v,
                    ),
                    Text(
                      "Total Expend",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 30.v,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 80.v,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Transactions",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 18.fSize,
                          )),
                  Text(
                    "See All",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: PrimaryColors.amber500,
                          fontWeight: FontWeight.w400,
                        ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return FilterList(
                    image: items[index]["img"],
                    item: items[index],
                  );
                },
              ),
            )
          ],
        ));
  }
}
