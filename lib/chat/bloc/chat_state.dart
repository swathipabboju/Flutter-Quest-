part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  
  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}


class MessageLoading extends ChatState {}

class MessageLoaded extends ChatState {
  final List<Message> messages;

  MessageLoaded(this.messages);
}

class MessageError extends ChatState {
  final String error;

  MessageError(this.error);
}

class MessageSentSuccess extends ChatState {}

class MessageSentError extends ChatState {
  final String error;

  MessageSentError(this.error);
}
