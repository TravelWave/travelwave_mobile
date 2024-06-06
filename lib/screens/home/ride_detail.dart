import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/models/models.dart';
import 'package:travelwave_mobile/models/riderequest_model.dart';
import 'package:travelwave_mobile/models/user_info.dart';
import 'package:travelwave_mobile/services/utils/avater.dart';
import 'package:travelwave_mobile/services/utils/formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RideDetailsModal extends StatelessWidget {
  final UserInfo passengerData;
  final RideRequestWithLocation rideData;

  const RideDetailsModal({
    Key? key,
    required this.passengerData,
    required this.rideData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0).copyWith(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: Avatar(
                    textStyle:
                        const TextStyle(fontSize: 20, color: Colors.white),
                    name: passengerData.fullName,
                    shape: AvatarShape.circle(50)),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    passengerData.fullName!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  RatingBar.builder(
                    ignoreGestures: true,
                    initialRating: passengerData.rating != null
                        ? passengerData.rating!.toDouble()
                        : 2.5,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 30,
                    unratedColor: Colors.grey[300],
                    itemCount: 5,
                    updateOnDrag: true,
                    itemBuilder: (context, _) {
                      return Icon(
                        Icons.star,
                        color: PrimaryColors.yellow700,
                      );
                    },
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(height: 5),
                  Text(
                    passengerData.phoneNumber!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Icon(Icons.star, color: Colors.amber, size: 18),
                  //     SizedBox(width: 4),
                  //     Text(
                  //       passengerData.rating.toString(),
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         color: Colors.grey[600],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  final url = 'tel:${passengerData.phoneNumber!}';
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url);
                  } else {
                    // Handle the case where the phone dialer can't be launched
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Could not launch phone dialer'),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.phone),
                label: Text('Call'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Text(
            'Ride Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Start Location:   '),
              Flexible(
                  child: Text(
                rideData.startLocation,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Destination:   '),
              Flexible(
                  child: Text(
                rideData.endLocation,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Request Time:'),
              Text(
                getRelativeTimeString(rideData.requestTime),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Status:'),
              Flexible(
                  child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      rideData.status)),
            ],
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Handle accept or reject button press
            },
            style: ElevatedButton.styleFrom(
              // primary: Colors.blue,
              // onPrimary: Colors.white,

              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text('Accept Ride'),
          ),
        ],
      ),
    );
  }
}
