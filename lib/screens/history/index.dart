import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/ride/ridehistory/ride_history_bloc.dart';

import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/history/widget/filter_list_tile.dart';
import 'package:travelwave_mobile/screens/history/widget/history_filter.dart';
import 'package:travelwave_mobile/widgets/res_handle.dart';

class HistoryScreen extends StatefulWidget {
  final String userId;
  const HistoryScreen({super.key, required this.userId});

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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
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
      ),
      body: BlocBuilder<RideHistoryBloc, RideHistoryState>(
        builder: (context, state) {
          print(state);
          if (state is RideHistorySuccess) {
            if (state.rideHistory.isEmpty) {
              return emptyWidget(
                msg:
                    "No Completed Ride History Found, Try Our System and Enjoy the flexible Ride option available",
                icon: Icons.history,
                retry: () {
                  BlocProvider.of<RideHistoryBloc>(context)
                      .add(FetchRideHistory(id: widget.userId));
                },
              );
            }
            return Column(
              children: [
                // HistoryFilter(
                //   shuffle: shuffleList,
                // ),
                Text("Completed Ride History"),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.rideHistory.length,
                    itemBuilder: (context, index) {
                      return FilterList(
                        item: items[index],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
