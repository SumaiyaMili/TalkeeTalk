import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talketalk/screens/chat_screen.dart';
import '../constants.dart';
import 'msg_bubble_widget.dart';

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key? key,
    required FirebaseFirestore fireStore,
  })  : _fireStore = fireStore,
        super(key: key);

  final FirebaseFirestore _fireStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _fireStore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data!.docs.reversed;
            List<MessageBubble> messageBubbles = [];
            for (var msg in messages) {
              final messageText = (msg.data() as dynamic)['text'];
              final messageSender = (msg.data() as dynamic)['sender'];
              final currentUser = loggedInUser.email;

              final messageBubble = MessageBubble(
                  messageText: messageText,
                  messageSender: messageSender,
                  isMe: (messageSender == currentUser));
              messageBubbles.add(messageBubble);
            }
            return Expanded(
              child: ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: messageBubbles,
              ),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }
}
