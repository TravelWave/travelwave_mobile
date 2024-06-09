import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelwave_mobile/blocs/auth/auth_bloc_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/about_us/index.dart';
import 'package:travelwave_mobile/screens/complain/index.dart';
import 'package:travelwave_mobile/screens/history/index.dart';
import 'package:travelwave_mobile/screens/referral/index.dart';
import 'package:travelwave_mobile/screens/settings/index.dart';
import 'package:travelwave_mobile/services/utils/avater.dart';
import 'package:travelwave_mobile/widgets/log_out_dialog.dart';

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
                  child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state is AuthenticationAuthenticated) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              child: Avatar(
                                  textStyle: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                  name: state.userInfo.fullName,
                                  shape: AvatarShape.circle(50)),
                            ),
                            SizedBox(height: 10.v),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                state.userInfo.fullName ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10)
                                      .copyWith(top: 5),
                              child: Text(
                                "Phone:    ${state.userInfo.phoneNumber ?? ""}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            SizedBox(height: 15.v),
                          ],
                        );
                      } else {
                        return const Center(
                            child: Text(
                                'Unexpected error: User not authenticated'));
                      }
                    },
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
                    loginDialogBox(context,
                        title: "Log Out",
                        subtitle: "Are you sure you want to logout ?",
                        onpressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoggedOut());
                      Navigator.pop(context);
                    });
                  },
                ),
                const Divider(),
              ],
            ),
          ),
        ));
  }
}
