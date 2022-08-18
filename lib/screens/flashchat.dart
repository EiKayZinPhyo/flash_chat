import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FlashChat extends StatefulWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  State<FlashChat> createState() => _FlashChatState();
}

class _FlashChatState extends State<FlashChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'firstscreen');
            },
            icon: Icon(Icons.logout))
      ]),
      backgroundColor: Color(0xFFF9FCF8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Welcome to Flash Chat',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
