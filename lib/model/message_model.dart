import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  final String status;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.status,
  });

  factory Message.fromFirestore(Map<String, dynamic> data) {
    // If timestamp is null, default to the current server time
    Timestamp? timestamp = data['timestamp'];
    if (timestamp == null) {
      timestamp = Timestamp.now(); // Default to current time
    }

    return Message(
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      message: data['message'] ?? '',
      timestamp: timestamp,
      status: data['status'] ?? '',
    );
  }
}
