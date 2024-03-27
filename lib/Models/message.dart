import 'package:chat/Constance.dart';

class Message {
  final String message;

  Message({required this.message});

  factory Message.fromjson(jsondata) {
    return Message(message: jsondata[Kmessage]);
  }
}
