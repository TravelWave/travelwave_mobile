import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';

Future<dynamic> loginDialogBox(BuildContext context,
    {required String title,
    required String subtitle,
    bool poptwice = true,
    required Function onpressed}) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.7),
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 19.2),
              ),
              const SizedBox(
                height: 11,
              ),
              Text(
                subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 13.2),
              ),
              const SizedBox(
                height: 21,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7)
                    .copyWith(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onpressed.call();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10)
                              .copyWith(top: 13, bottom: 13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.72),
                              color: PrimaryColors.amberA400),
                          child: const Center(
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16.4,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10)
                              .copyWith(top: 13, bottom: 13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.72),
                              color: PrimaryColors.gray900),
                          child: const Center(
                            child: Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
