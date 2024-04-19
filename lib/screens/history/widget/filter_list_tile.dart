import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/widgets/custom_image_view.dart';

class FilterList extends StatelessWidget {
  final Map item;
  final String? image;
  const FilterList({super.key, required this.item, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.v, horizontal: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: PrimaryColors.amberA400,
        ),
      ),
      child: ListTile(
        leading: image != null
            ? CustomImageView(
                imagePath: image,
              )
            : null,
        title: Text(
          overflow: TextOverflow.ellipsis,
          item["name"].toString(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
            overflow: TextOverflow.ellipsis,
            item["car"].toString(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: PrimaryColors.gray500,
                )),
        trailing: Text(
          overflow: TextOverflow.ellipsis,
          item["time"].toString(),
        ),
      ),
    );
  }
}
