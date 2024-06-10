import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelwave_mobile/main.dart';
import 'package:travelwave_mobile/models/chats.dart';
import 'package:travelwave_mobile/repositories/chat_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial()) {
    on<MessageEvent>((event, emit) async {
      if (event is FetchChatHistory) {
        emit(MessageLoading());
        print(event.recieverId);
        final res =
            await ChatRepository(token: await data.readFromStorage("Token"))
                .getChatHistory(recieverId: event.recieverId);
        print(res);
        emit(MessageSuccess(chats: res));
      }
      if (event is SentMessage) {
        final updatedChats = List<Chats>.from((state as MessageSuccess).chats);
        emit(MessageLoading());
        print(updatedChats.length);

        updatedChats.add(event.chat);
        print(updatedChats.length);
        emit(MessageSuccess(chats: updatedChats));
      }
      if (event is GetMessage) {
        final updatedChats = List<Chats>.from((state as MessageSuccess).chats);
        emit(MessageLoading());
        updatedChats.add(event.chat);
        emit(MessageSuccess(chats: updatedChats));
      }
      // TODO: implement event handler
    });
  }
}
