import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';
import 'package:ploofypaws/chat/models/message.dart';

class MessageList extends StatelessWidget {
  final List<Message> messages;
  final UserModel currUser;

  const MessageList(
      {required this.messages, required this.currUser, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: messages[index].id == currUser.id
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                margin: messages[index].id == currUser.id
                    ? const EdgeInsets.only(left: 30)
                    : const EdgeInsets.only(right: 30),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: messages[index].id == currUser.id
                      ? Colors.grey.shade300
                      : Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  messages[index].text!,
                  style: TextStyle(
                    color: messages[index].id == currUser.id
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            ));
      },
      itemCount: messages.length,
    );
  }
}
