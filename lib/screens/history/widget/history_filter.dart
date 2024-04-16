import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';

class HistoryFilter extends StatefulWidget {
  final Function? shuffle;
  const HistoryFilter({super.key, this.shuffle});

  @override
  State<HistoryFilter> createState() => _HistoryFilterState();
}

String selected = "upcoming";

class _HistoryFilterState extends State<HistoryFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.v, horizontal: 15.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: PrimaryColors.pink300,
          border: Border.all(
            color: PrimaryColors.amberA400,
            width: 1.5,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              widget.shuffle?.call();
              setState(() {
                selected = "upcoming";
              });
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 17.v),
                decoration: BoxDecoration(
                  color: selected == "upcoming"
                      ? PrimaryColors.amberA400
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Upcoming",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: selected == "upcoming" ? Colors.white : null),
                )),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selected = "completed";
              });
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 17.v),
                decoration: BoxDecoration(
                  color: selected == "completed"
                      ? PrimaryColors.amberA400
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("Completed",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: selected == "completed" ? Colors.white : null))),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = "cancelled";
                });
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 17.v),
                  decoration: BoxDecoration(
                    color: selected == "cancelled"
                        ? PrimaryColors.amberA400
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Cancelled",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              selected == "cancelled" ? Colors.white : null))),
            ),
          ),
        ],
      ),
    );
  }
}
