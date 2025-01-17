import 'dart:async';
import 'package:TalkNest/model/message_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

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

  Stream<List<Message>> _getMessageStream(String senderId, String receiverId) {
    final sentMessagesStream = FirebaseFirestore.instance
        .collection('messages')
        .where('senderId', isEqualTo: senderId)
        .where('receiverId', isEqualTo: receiverId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Message.fromFirestore(doc.data()))
            .toList());

    final receivedMessagesStream = FirebaseFirestore.instance
        .collection('messages')
        .where('senderId', isEqualTo: receiverId)
        .where('receiverId', isEqualTo: senderId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Message.fromFirestore(doc.data()))
            .toList());

    return Rx.combineLatest2<List<Message>, List<Message>, List<Message>>(
      sentMessagesStream,
      receivedMessagesStream,
      (sent, received) {
        final allMessages = [...sent, ...received];
        allMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        return allMessages;
      },
    );
  }

  Future<void> _onFetchMessagesEvent(
      FetchMessagesEvent event, Emitter<ChatState> emit) async {
    emit(MessageLoading());
    try {
      final senderId = firebaseAuth.currentUser?.email;
      if (senderId == null) {
        emit(MessageError("User not authenticated"));
        return;
      }
      _messageSubscription?.cancel();
      _messageSubscription =
          _getMessageStream(senderId, event.receiverId).listen((messages) {
        add(UpdateMessagesEvent(messages));
      });
    } catch (e) {
      emit(MessageError("Failed to fetch messages: $e"));
    }
  }

  void _onUpdateMessagesEvent(
      UpdateMessagesEvent event, Emitter<ChatState> emit) {
    emit(MessageLoaded(event.messages));
  }

  Future<void> _onSendMessageEvent(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      final senderId = firebaseAuth.currentUser?.email;
      if (senderId == null) {
        emit(MessageError("User not authenticated"));
        return;
      }

      await FirebaseFirestore.instance.collection('messages').add({
        'senderId': senderId,
        'receiverId': event.receiverId,
        'message': event.message,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'sent',
      });

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
