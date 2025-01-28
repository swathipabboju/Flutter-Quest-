part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class FetchMessagesEvent extends ChatEvent {
  final String receiverId;

  const FetchMessagesEvent(this.receiverId);

  @override
  List<Object> get props => [receiverId];
}

class SendMessageEvent extends ChatEvent {
  final String receiverId;
  final String message;

  const SendMessageEvent(this.receiverId, this.message);

  @override
  List<Object> get props => [receiverId, message];
}

class UpdateMessagesEvent extends ChatEvent {
  final List<Message> messages;
  const UpdateMessagesEvent(this.messages);
  @override
  List<Object> get props => [messages];
}

class MarkMessagesAsReadEvent extends ChatEvent {
  final String receiverId;

  const MarkMessagesAsReadEvent(this.receiverId);

  @override
  List<Object> get props => [receiverId];
}
