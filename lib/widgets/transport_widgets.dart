import 'package:flutter/material.dart';

Widget carFeaturesWidget(
    BuildContext context, String title, String description) {
  return Container(
    height: 50,
    margin: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Theme.of(context).primaryColor,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget paymentCardWidget(
    BuildContext context, String img, String title, String subtitle) {
  return Container(
    height: 70,
    margin: const EdgeInsets.only(bottom: 5),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFBE7),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 2,
      ),
    ),
    child: ListTile(
      leading: SizedBox(
        height: 40,
        width: 50,
        child: Image.asset(img),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.bold,
          fontSize: title == "Cash" ? 20 : 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
