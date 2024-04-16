import 'dart:math';

import 'package:flutter/material.dart';

import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/history/widget/filter_list_tile.dart';
import 'package:travelwave_mobile/screens/history/widget/history_filter.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map> items = [
    {"name": "Nate", "car": "Mustang Shelby GT", "time": "Today at 09:20 am"},
    {"name": "Henry", "car": "Mustang Shelby GT", "time": "Today at 10:20 am"},
    {
      "name": "William",
      "car": "Mustang Shelby GT",
      "time": "Tomorrow at 09:20 am"
    },
    {"name": "Nate", "car": "Mustang Shelby GT", "time": "Today at 09:20 am"},
    {"name": "Nate", "car": "Mustang Shelby GT", "time": "Today at 09:20 am"},
    {"name": "Nate", "car": "Mustang Shelby GT", "time": "Today at 09:20 am"},
    {"name": "Nate", "car": "Mustang Shelby GT", "time": "Today at 09:20 am"},
    {"name": "Nate", "car": "Mustang Shelby GT", "time": "Today at 09:20 am"},
    {
      "name": "william",
      "car": "Mustang Shelby GT",
      "time": "Tomorrow at 05:20 am"
    },
    {"name": "Henry", "car": "Mustang Shelby GT", "time": "Today at 10:20 am"},
    {
      "name": "William",
      "car": "Mustang Shelby GT",
      "time": "Tomorrow at 09:20 am"
    },
  ];
  void shuffleList() {
    // Create a copy of the input list
    List<Map> shuffledList = List.from(items);

    // Shuffle the list randomly
    shuffledList.shuffle(Random());

    setState(() {
      items = shuffledList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "History",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leadingWidth: 150.h,
        leading: Row(
          children: [
            SizedBox(width: 16.h),
            const Icon(Icons.arrow_back_ios),
            Expanded(
              child: Text(
                "Back",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          HistoryFilter(
            shuffle: shuffleList,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return FilterList(
                  item: items[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
