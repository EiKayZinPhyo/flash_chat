import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/firebase_options.dart';
import 'package:flash_chat/screens/firstscreen.dart';
import 'package:flash_chat/screens/flashchat.dart';
import 'package:flash_chat/screens/login.dart';
import 'package:flash_chat/screens/register.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/flashchat',
      routes: {
        "/firstscreen": (context) => FirstScreenPage(),
        "/register": (context) => RegisterPage(),
        "/login": (context) => LoginPage(),
        '/flashchat': (context) => FlashChat()
      },
    );
  }
}
