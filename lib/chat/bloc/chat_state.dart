part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class MessageLoading extends ChatState {}

class MessageLoaded extends ChatState {
  final List<Message> messages;

  const MessageLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class MessageError extends ChatState {
  final String error;

  const MessageError(this.error);

  @override
  List<Object?> get props => [error];
}

class MessageSentSuccess extends ChatState {}

class MessageSentError extends ChatState {
  final String error;

  const MessageSentError(this.error);

  @override
  List<Object?> get props => [error];
}
