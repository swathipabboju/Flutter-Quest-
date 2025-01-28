import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TalkNest/chat/bloc/chat_bloc.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;

  ChatScreen({required this.receiverId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController msgController = TextEditingController();
  final FocusNode msgNode = FocusNode();
  bool isEmojiPickerVisible = false;

  void toggleEmojiPicker() {
    setState(() {
      isEmojiPickerVisible = !isEmojiPickerVisible;
    });
    if (isEmojiPickerVisible) {
      msgNode.unfocus();
    } else {
      msgNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatBloc()..add(FetchMessagesEvent(widget.receiverId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat with ${widget.receiverId}'),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is MessageLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is MessageError) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  if (state is MessageLoaded) {
                    final messages = state.messages;
                    return ListView.builder(
                      reverse: true, // To show recent messages at the bottom
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isCurrentUser = message.senderId ==
                            context
                                .read<ChatBloc>()
                                .firebaseAuth
                                .currentUser
                                ?.email;

                        return Align(
                          alignment: isCurrentUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            constraints: BoxConstraints(maxWidth: 250),
                            decoration: BoxDecoration(
                              color: isCurrentUser
                                  ? Colors.blueAccent
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.message,
                                  style: TextStyle(
                                    color: isCurrentUser
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    DateFormat('h:mm a')
                                        .format(message.timestamp.toDate()),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isCurrentUser
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: Text('No messages yet.'));
                },
              ),
            ),
            /*  if (isEmojiPickerVisible)
              Expanded(
                child: Container(
                  height: 250,
                  child: Center(child: Text("Emoji Picker Placeholder")),
                ),
              ), */
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.emoji_emotions_outlined),
                    // onPressed:
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      onEditingComplete: () {
                        msgNode.unfocus();
                      },
                      onSubmitted: (value) {
                        msgNode.unfocus();
                      },
                      controller: msgController,
                      focusNode: msgNode,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      final message = msgController.text.trim();
                      if (message.isNotEmpty) {
                        context.read<ChatBloc>().add(SendMessageEvent(
                              widget.receiverId,
                              message,
                            ));

                        msgController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
