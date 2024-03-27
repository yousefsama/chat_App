import 'package:chat/Models/message.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(right: 70.0),
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 16),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(25),
              topRight: Radius.circular(20),
            ),
            color: Colors.black,
          ),
          child: Text(
            message.message,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
