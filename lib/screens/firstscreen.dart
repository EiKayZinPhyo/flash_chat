import 'package:flutter/material.dart';

class FirstScreenPage extends StatefulWidget {
  const FirstScreenPage({Key? key}) : super(key: key);

  @override
  State<FirstScreenPage> createState() => _FirstScreenPageState();
}

class _FirstScreenPageState extends State<FirstScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FCF8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/speech.png',
            width: 100,
          ),
          Center(
              child: Text(
            "Flash Chat",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFf466443)),
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFf466443)),
                onPressed: () {
                  Navigator.pushNamed(context, 'register');
                },
                child: Text("Register"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Container(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18, color: Color(0xFf466443)),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1.0, color: Color(0xFf466443)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
