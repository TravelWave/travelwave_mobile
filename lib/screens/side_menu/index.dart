import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/about_us/index.dart';
import 'package:travelwave_mobile/screens/complain/index.dart';
import 'package:travelwave_mobile/screens/history/index.dart';
import 'package:travelwave_mobile/screens/referral/index.dart';
import 'package:travelwave_mobile/screens/settings/index.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(70.h),
          bottomRight: Radius.circular(70.h),
        ),
        child: Drawer(
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5.h,
                        ),
                        const Icon(Icons.arrow_back_ios),
                        Text(
                          'Back',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage(ImageConstant.imgEllipse42),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 30.v,
                              width: 30.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  border: Border.all(
                                    width: 1.5,
                                    color: PrimaryColors.amberA400,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: SvgPicture.asset(
                                  ImageConstant.imgCamera,
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                      SizedBox(height: 15.v),
                      Text(
                        'John Doe',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'johndoe@example.com',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 25.v),
                    ],
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    ImageConstant.imgHistory,
                    scale: 1.2,
                  ),
                  title: Text(
                    'History',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const HistoryScreen();
                      },
                    ));
                    // Handle home tile tap
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Image.asset(
                    ImageConstant.imgComplain,
                    scale: 1.2,
                  ),
                  title: Text(
                    'Complain',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    // Handle settings tile tap
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ComplainPage();
                      },
                    ));
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Image.asset(
                    ImageConstant.imgReferral,
                    scale: 1.2,
                  ),
                  title: Text(
                    'Referral',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    // Handle settings tile tap
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ReferalPage();
                      },
                    ));
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Image.asset(
                    ImageConstant.imgabout,
                    scale: 1.2,
                  ),
                  title: Text(
                    'About Us',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    // Handle settings tile tap
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const AboutUsPage();
                      },
                    ));
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Image.asset(
                    ImageConstant.imgsetting,
                    scale: 1.2,
                  ),
                  title: Text(
                    'Settings',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    // Handle settings tile tap
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const SettingPage();
                      },
                    ));
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Image.asset(
                    ImageConstant.imgsupport,
                    scale: 1.2,
                  ),
                  title: Text(
                    'Help and Support',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    // Handle settings tile tap
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Image.asset(
                    ImageConstant.imglogout,
                    scale: 1.2,
                  ),
                  title: Text(
                    'Logout',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    // Handle settings tile tap
                  },
                ),
                const Divider(),
              ],
            ),
          ),
        ));
  }
}
