import 'dart:convert';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travelwave_mobile/blocs/messages/message_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/main.dart';
import 'package:travelwave_mobile/models/chats.dart';
import 'package:travelwave_mobile/models/user_info.dart';
import 'package:travelwave_mobile/services/utils/app_constant.dart';
import 'package:travelwave_mobile/services/utils/avater.dart';
import 'package:travelwave_mobile/services/utils/global_https.dart';

import 'package:travelwave_mobile/widgets/custom_icon_button.dart';
import 'package:travelwave_mobile/widgets/custom_image_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:travelwave_mobile/widgets/res_handle.dart';

class MessageScreen extends StatefulWidget {
  final String recieverId;
  MessageScreen({super.key, required this.recieverId});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

io.Socket? socket;
UserInfo? user;

class _MessageScreenState extends State<MessageScreen> {
  final message = TextEditingController();
  final _scrollController = ScrollController();
  bool _emojiShowing = false;
  List<Chats> chats = [];
  @override
  void initState() {
    initDataWithSocket();
    super.initState();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  void initDataWithSocket() async {
    final token = await data.readFromStorage("Token");
    user = UserInfo.fromJson(token);
    print('${user?.userId} new');
    print(token);
    socket = io.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket?.on('connect', (_) {
      print('connected');
    });
    socket?.emit('joinRoom', user?.userId);

    socket?.on('new message', (data) {
      BlocProvider.of<MessageBloc>(context)
          .add(GetMessage(chat: Chats.fromJson(data)));
    });

    socket?.on('disconnect', (_) {
      print('disconnected');
    });
  }

  // @override
  // void dispose() {
  //   socket?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _buildAppbar(context),
        body: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            if (state is MessageSuccess) {
              chats = state.chats;
              if (chats.isEmpty) {
                return const Center(
                  child: Text("No chat history"),
                );
              }
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.h,
                      vertical: 23.v,
                    ),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final ismine =
                            chats[index].senderId?.id == user?.userId;

                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!ismine)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    chats[index].senderId?.profilePic != null
                                        ? networkImageLoader(
                                            shape: BoxShape.circle,
                                            height: 35,
                                            width: 35,
                                            url: chats[index]
                                                .senderId!
                                                .profilePic!,
                                          )
                                        : CircleAvatar(
                                            radius: 25,
                                            child: Avatar(
                                                textStyle: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                                name: chats[index]
                                                    .senderId
                                                    ?.fullName,
                                                shape: AvatarShape.circle(50)),
                                          ),
                                    // CustomImageView(dssd
                                    //   imagePath: ImageConstant.imgEllipse42,
                                    //   height: 36.adaptSize,
                                    //   width: 36.adaptSize,
                                    //   radius: BorderRadius.circular(
                                    //     18.h,
                                    //   ),
                                    //   margin: EdgeInsets.only(bottom: 18.v),
                                    // ),
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                    Wrap(
                                        direction: Axis.vertical,
                                        spacing: 9,
                                        children: [
                                          _buildGoodevening(context,
                                              chats[index].message ?? ""),

                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 48.h),
                                            child: Text(
                                              DateFormat.jm().format(
                                                  DateTime.parse(
                                                      chats[index].createdAt ??
                                                          DateTime.now()
                                                              .toString())),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ),
                                          SizedBox(height: 18.v),
                                          // _buildGoodevening(context,
                                          //     "Welcome to Car2go Customer \nService"),
                                        ]),
                                  ],
                                ),
                              if (ismine) ...[
                                _buildChatone(
                                  context,
                                  chats[index].message ?? "",
                                ),
                                SizedBox(height: 9.v),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    DateFormat.jm().format(DateTime.parse(
                                        chats[index].createdAt ??
                                            DateTime.now().toString())),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                SizedBox(height: 28.v),
                              ],
                            ]);
                      },
                      itemCount: chats.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Row(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         CustomImageView(
                    //           imagePath: ImageConstant.imgEllipse42,
                    //           height: 36.adaptSize,
                    //           width: 36.adaptSize,
                    //           radius: BorderRadius.circular(
                    //             18.h,
                    //           ),
                    //           margin: EdgeInsets.only(bottom: 18.v),
                    //         ),
                    //         SizedBox(
                    //           width: 5.h,
                    //         ),
                    //         Wrap(direction: Axis.vertical, spacing: 9, children: [
                    //           _buildGoodevening(context, "Good Evening!"),
                    //           _buildGoodevening(context,
                    //               "Welcome to Car2go Customer \nService"),
                    //         ]),
                    //       ],
                    //     ),
                    //     SizedBox(height: 9.v),
                    //     Padding(
                    //       padding: EdgeInsets.only(left: 48.h),
                    //       child: Text(
                    //         "8:29 pm",
                    //         style: Theme.of(context).textTheme.bodySmall,
                    //       ),
                    //     ),
                    //     SizedBox(height: 28.v),
                    //     _buildChatone(
                    //       context,
                    //     ),
                    //     SizedBox(height: 9.v),
                    //     Align(
                    //       alignment: Alignment.centerRight,
                    //       child: Text(
                    //         "8:29 pm",
                    //         style: Theme.of(context).textTheme.bodySmall,
                    //       ),
                    //     ),
                    //     SizedBox(height: 28.v),
                    //     Row(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         CustomImageView(
                    //           imagePath: ImageConstant.imgEllipse42,
                    //           height: 36.adaptSize,
                    //           width: 36.adaptSize,
                    //           radius: BorderRadius.circular(
                    //             18.h,
                    //           ),
                    //           margin: EdgeInsets.only(bottom: 18.v),
                    //         ),
                    //         SizedBox(
                    //           width: 5.h,
                    //         ),
                    //         Wrap(direction: Axis.vertical, spacing: 9, children: [
                    //           _buildGoodevening(context,
                    //               "Welcome to Car2go Customer \nService"),
                    //         ]),
                    //       ],
                    //     ),
                    //     SizedBox(height: 9.v),
                    //     Padding(
                    //       padding: EdgeInsets.only(left: 47.h),
                    //       child: Text(
                    //         "8:29 pm",
                    //         style: Theme.of(context).textTheme.bodySmall,
                    //       ),
                    //     ),
                    //     SizedBox(height: 28.v),
                    //     _buildChatone(
                    //       context,
                    //     ),
                    //     SizedBox(height: 7.v),
                    //     Align(
                    //       alignment: Alignment.centerRight,
                    //       child: Text(
                    //         "Just now",
                    //         style: Theme.of(context).textTheme.bodySmall,
                    //       ),
                    //     ),
                    //     SizedBox(height: 5.v)
                    //   ],
                    // ),
                  ),
                  if (_emojiShowing)
                    SizedBox(
                      height: 250,
                      child: EmojiPicker(
                        textEditingController: message,
                        scrollController: _scrollController,
                        config: Config(
                          height: 256,
                          checkPlatformCompatibility: true,
                          emojiViewConfig: EmojiViewConfig(
                            // Issue: https://github.com/flutter/flutter/issues/28894
                            emojiSizeMax: 28 *
                                (foundation.defaultTargetPlatform ==
                                        TargetPlatform.iOS
                                    ? 1.2
                                    : 1.0),
                          ),
                          swapCategoryAndBottomBar: false,
                          skinToneConfig: const SkinToneConfig(),
                          categoryViewConfig: const CategoryViewConfig(),
                          bottomActionBarConfig: const BottomActionBarConfig(),
                        ),
                      ),
                    ),
                ]),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        bottomNavigationBar: _buildRowcloseone(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
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
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          ],
        ),
      ),
      title: Text(
        "Chat",
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  /// Section Widget
  Widget _buildGoodevening(BuildContext context, String msg) {
    return SizedBox(
      width: 270.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: PrimaryColors.gray200,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.h),
              bottomLeft: Radius.circular(16.h),
              bottomRight: Radius.circular(16.h),
            ),
          ),
          child: Text(
            msg,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1.57,
                ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildChatone(BuildContext context, String msg) {
    return Container(
      padding: EdgeInsets.only(left: 63.h),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: PrimaryColors.pink300,
            border: Border.all(width: 1.5, color: PrimaryColors.amberA400),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.h),
              bottomLeft: Radius.circular(16.h),
              bottomRight: Radius.circular(16.h),
            ),
          ),
          child: Text(
            msg,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1.57,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: EdgeInsets.only(
            left: 7.h,
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: TextFormField(
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              controller: message,
              style: Theme.of(context).textTheme.bodyMedium,
              obscureText: false,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Type Your Message",
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: PrimaryColors.blueGray100,
                    ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _emojiShowing = !_emojiShowing;
                    });
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30.h, 14.v, 9.h, 14.v),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgUser,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                    ),
                  ),
                ),
                suffixIconConstraints: BoxConstraints(
                  maxHeight: 52.v,
                ),
                isDense: true,
                contentPadding: EdgeInsets.only(
                  left: 16.h,
                  top: 13.v,
                  bottom: 13.v,
                ),
                filled: false,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.h),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.h),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.h),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      16.h,
                    ),
                    bottomLeft: Radius.circular(
                      16.h,
                    ),
                    bottomRight: Radius.circular(
                      16.h,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: PrimaryColors.amberA400,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      16.h,
                    ),
                    bottomLeft: Radius.circular(
                      16.h,
                    ),
                    bottomRight: Radius.circular(
                      16.h,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: PrimaryColors.amberA400,
                    width: 1,
                  ),
                ),
                errorStyle: TextStyle(
                  color: PrimaryColors.amberA400,
                  fontSize: 12.fSize,
                ),
              ),
            ),
          )

          //  CustomTextFormField(
          //   controller: message,
          //   hintText: "Type Your Message",
          //   textInputAction: TextInputAction.done,
          //   suffix:
          //
          // Container(
          //     margin: EdgeInsets.fromLTRB(30.h, 14.v, 9.h, 14.v),
          //     child: CustomImageView(
          //       imagePath: ImageConstant.imgUser,
          //       height: 24.adaptSize,
          //       width: 24.adaptSize,
          //     ),
          //   ),
          //   suffixConstraints:
          // BoxConstraints(
          //     maxHeight: 52.v,
          //   ),
          //   contentPadding:
          // EdgeInsets.only(
          //     left: 16.h,
          //     top: 13.v,
          //     bottom: 13.v,
          //   ),
          // )

          ),
    );
  }

  /// Section Widget
  Widget _buildRowcloseone(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 15.h,
          right: 15.h,
          // bottom: 31.v,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10.v),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.v),
            child: CustomIconButton(
              decoration: BoxDecoration(
                // color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                borderRadius: BorderRadius.circular(25.h),
              ),
              height: 24.adaptSize,
              width: 24.adaptSize,
              padding: EdgeInsets.all(3.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgClose,
              ),
            ),
          ),
          _buildMessage(context),
          // if (_emojiShowing)
          //   EmojiPicker(
          //     textEditingController: message,
          //     scrollController: _scrollController,
          //     config: Config(
          //       height: 256,
          //       checkPlatformCompatibility: true,
          //       emojiViewConfig: EmojiViewConfig(
          //         // Issue: https://github.com/flutter/flutter/issues/28894
          //         emojiSizeMax: 28 *
          //             (foundation.defaultTargetPlatform == TargetPlatform.iOS
          //                 ? 1.2
          //                 : 1.0),
          //       ),
          //       swapCategoryAndBottomBar: false,
          //       skinToneConfig: const SkinToneConfig(),
          //       categoryViewConfig: const CategoryViewConfig(),
          //       bottomActionBarConfig: const BottomActionBarConfig(),
          //       searchViewConfig: const SearchViewConfig(),
          //     ),
          //   ),
          CustomImageView(
            imagePath: ImageConstant.imgTelevisionIndigo100,
            height: 32.adaptSize,
            width: 32.adaptSize,
            onTap: () {
              sendMsgToServer(widget.recieverId, message.text);
              BlocProvider.of<MessageBloc>(context).add(SentMessage(
                  chat: Chats(
                message: message.text,
                createdAt: DateTime.now().toString(),
                senderId: SenderId(
                  id: user?.userId,
                  fullName: user?.fullName,
                ),
                receiverId: SenderId(
                  id: "",
                  fullName: "Admin",
                ),
              )));

              message.clear();
            },
            margin: EdgeInsets.only(
              left: 7.h,
              top: 6.v,
              bottom: 13.v,
            ),
          )
        ],
      ),
    );
  }
}
