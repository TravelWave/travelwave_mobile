part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class FetchChatHistory extends MessageEvent {
  final String recieverId;

  FetchChatHistory({required this.recieverId});

  @override
  List<Object> get props => [recieverId];
}

class SentMessage extends MessageEvent {
  final Chats chat;

  SentMessage({required this.chat});

  @override
  List<Object> get props => [chat];
}

class GetMessage extends MessageEvent {
  final Chats chat;

  GetMessage({required this.chat});

  @override
  List<Object> get props => [chat];
}
