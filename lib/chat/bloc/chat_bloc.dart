import 'dart:async';
import 'package:TalkNest/model/message_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  StreamSubscription<List<Message>>? _messageSubscription;

  ChatBloc() : super(ChatInitial()) {
    on<FetchMessagesEvent>(_onFetchMessagesEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
    on<UpdateMessagesEvent>(_onUpdateMessagesEvent);
  }

  // Method to get messages for a specific sender and receiver
  Stream<List<Message>> _getMessageStream(String senderId, String receiverId) {
    return FirebaseFirestore.instance
        .collection('messages')
        .where('senderId', isEqualTo: senderId)
        .where('receiverId', isEqualTo: receiverId)
        .orderBy('timestamp', descending: true) // Ensure messages are ordered
        .snapshots()
        .map((snapshot) {
      final messages = snapshot.docs
          .map((doc) => Message.fromFirestore(doc.data()))
          .toList();

      // Log messages count for debugging
      print("Fetched messages: ${messages.length}");
      return messages;
    });
  }

  // Fetch messages event handler
  Future<void> _onFetchMessagesEvent(FetchMessagesEvent event, Emitter<ChatState> emit) async {
    emit(MessageLoading());
    try {
      final senderId = firebaseAuth.currentUser?.email;
      if (senderId == null) {
        emit(MessageError("User not authenticated"));
        return;
      }

      _messageSubscription?.cancel();
      _messageSubscription = _getMessageStream(senderId, event.receiverId).listen((messages) {
        add(UpdateMessagesEvent(messages));  // Update messages when stream emits
      });
    } catch (e) {
      emit(MessageError("Failed to fetch messages: $e"));
    }
  }

  // Update messages event handler
  void _onUpdateMessagesEvent(UpdateMessagesEvent event, Emitter<ChatState> emit) {
    print("Updated messages: ${event.messages.length}");
    emit(MessageLoaded(event.messages));  // Emit the new message list
  }

  // Send message event handler
  Future<void> _onSendMessageEvent(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      final senderId = firebaseAuth.currentUser?.email;
      if (senderId == null) {
        emit(MessageError("User not authenticated"));
        return;
      }

      // Add the message to Firestore
      await FirebaseFirestore.instance.collection('messages').add({
        'senderId': senderId,
        'receiverId': event.receiverId,
        'message': event.message,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // After sending a message, re-fetch messages to update the UI
      add(FetchMessagesEvent(event.receiverId));  // Trigger re-fetch of messages

      emit(MessageSentSuccess());
    } catch (e) {
      emit(MessageSentError("Failed to send message: $e"));
    }
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
