import 'package:chat/Constance.dart';
import 'package:chat/Models/message.dart';
import 'package:chat/Widgets/ChatBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  TextEditingController controller = TextEditingController();
  static String id = 'ChatScreen';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages = FirebaseFirestore.instance.collection('Chats');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: messages.orderBy("createAt").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageslist = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              messageslist.add(
                Message.fromjson(snapshot.data!.docs[i]),
              );
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                    ),
                    Text(
                      "chat",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              body: Container(
                color: Colors.blue.shade100,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: messageslist.length,
                        itemBuilder: (context, index) {
                          return ChatBuble(message: messageslist[index]);
                        },
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          controller: controller,
                          onSubmitted: (value) {
                            messages.add(
                                {'message': value, "createAt": DateTime.now()});
                            controller.clear();
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.send)),
                            focusColor: Colors.amber,
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            label: Text(
                              'Message',
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'type a message ....',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: kPrimarycolor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text('loading');
          }
        });
  }
}
