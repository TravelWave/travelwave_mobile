part of 'message_bloc.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageState {}

final class MessageLoading extends MessageState {}

final class MessageSuccess extends MessageState {
  final List<Chats> chats;
  const MessageSuccess({required this.chats});
}

final class MessageError extends MessageState {
  final String error;

  const MessageError({required this.error});
}
