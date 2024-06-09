import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:travelwave_mobile/blocs/auth/auth_bloc_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/screens/side_menu/index.dart';
import 'package:travelwave_mobile/services/utils/avater.dart';
import 'package:travelwave_mobile/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedValue = 'male';
  String countryCode = "eth";

  final TextEditingController _email =
      TextEditingController(text: "nate@email.con");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Edit Profile",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          leading: Container(
            padding: EdgeInsets.only(
              left: 30.h,
            ),
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                print(state.userInfo.userId);
                final TextEditingController phone = TextEditingController(
                    text: state.userInfo.phoneNumber?.split("+251")[1]);
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 24.v),
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                child: Avatar(
                                    textStyle: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                    name: state.userInfo.fullName,
                                    shape: AvatarShape.circle(50)),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.userInfo.fullName ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontSize: 21.fSize,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 24.v,
                          ),
                          TextField(
                            controller: _email,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              fillColor: Colors.grey,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.v,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DropdownButtonFormField(
                                  value: countryCode,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  validator: (value) =>
                                      value == null ? 'country code' : null,
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'eth',
                                      child: Text('+251'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'usa',
                                      child: Text('+1'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      countryCode = value!;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 16.h,
                              ),
                              Flexible(
                                flex: 3,
                                child: TextField(
                                  controller: phone,
                                  decoration: InputDecoration(
                                    labelText: 'Phone number',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.v,
                          ),
                          DropdownButtonFormField(
                            menuMaxHeight: 100,
                            value: selectedValue,
                            decoration: InputDecoration(
                              labelText: 'Select your gender',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) => value == null
                                ? 'Please select your gender'
                                : null,
                            items: const [
                              DropdownMenuItem(
                                value: 'male',
                                child: SizedBox(
                                  width: 250,
                                  child: Text('Male'),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'female',
                                child: SizedBox(
                                  width: 250,
                                  child: Text('Female'),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          SizedBox(
                            height: 16.v,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Address',
                              fillColor: Colors.grey,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomElevatedButton(
                        text: "Update",
                        onPressed: () {},
                        center: true,
                      ),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: Text("Not authorized"),
                );
              }
            },
          ),
        ));
  }
}
