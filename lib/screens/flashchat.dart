import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class FlashChat extends StatefulWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  State<FlashChat> createState() => _FlashChatState();
}

class _FlashChatState extends State<FlashChat> {
  final _auth = FirebaseAuth.instance;
  User? loginUser;

  void getUser() {
    loginUser = _auth.currentUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/firstscreen');
            },
            icon: const Icon(Icons.logout))
      ]),
      backgroundColor: const Color(0xFFF9FCF8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 400,
            child: ListView(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('messages')
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<Message> chat_messages = [];
                      if (snapshot.hasData) {
                        var chat = snapshot.data!.docs;
                        for (var chats in chat) {
                          chat_messages.add(Message(
                              text: chats['text'],
                              sender: chats['sender'],
                              isMe: FirebaseAuth.instance.currentUser!.email ==
                                      chats['sender']
                                  ? true
                                  : false));
                        }
                      }
                      return Column(
                        children: chat_messages,
                      );
                    }),
              ],
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type something',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1),
                          borderSide: BorderSide(color: Colors.green)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    controller: messageController,
                    // onChanged: (value) {
                    //   messageText == value;
                    // },
                  ),
                ),
                Container(
                  child: IconButton(
                    onPressed: () async {
                      // final user = FirebaseAuth.instance.currentUser;
                      // String? username = user?.displayName;
                      // print('>>>>>>>>>');
                      // print(username);
                      // if (messageController.text.isNotEmpty) {
                      _firestore.collection("messages").add({
                        "sender": loginUser!.email,
                        // "sender":
                        //     FirebaseAuth.instance.currentUser!.displayName,
                        "text": messageController.text,
                      });
                      messageController.clear();
                    },
                    // },
                    icon: Icon(Icons.send),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  Message({required this.text, required this.sender, required this.isMe});
  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12.0,
            ),
          ),
          Material(
            color: isMe ? Colors.lightBlueAccent : Colors.green,
            elevation: 5.0,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.green : Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
