import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordvisible = false;

  var userErrorText = '';
  var passwordErrorText = '';

  void error() {
    if (usernameController.text.isEmpty == true) {
      userErrorText = "Username can't be blank";
    } else {
      userErrorText = '';
    }
    if (passwordController.text.isEmpty == true) {
      passwordErrorText = 'Password can not be blank';
    } else {
      passwordErrorText = '';
    }
  }

  void loginData() async {
    try {
      final auth = FirebaseAuth.instance;
      final singinemail = await auth.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);

      print('>>>>>>>>>>');
      print(singinemail);
      Navigator.pushNamed(context, 'flashchat');
    } catch (e) {
      const snackbar = SnackBar(
        backgroundColor: Colors.red,
        content:
            Text('The email or password is Wrong and You need to register '),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Color(0xFf466443)),
        ),
        leading: IconButton(
          color: Color(0xFf466443),
          onPressed: () {
            Navigator.pushNamed(context, 'firstscreen');
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Color(0xFFF9FCF8),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF9FCF8),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10, top: 100),
            child: const Text(
              "Welcome Back",
              style: TextStyle(
                  color: Color(0xFf466443),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                errorText: userErrorText,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'Username',
                prefixIcon: const Icon(Icons.person),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              obscureText: !_passwordvisible,
              controller: passwordController,
              decoration: InputDecoration(
                errorText: passwordErrorText,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordvisible = !_passwordvisible;
                    });
                  },
                  icon: Icon(
                    _passwordvisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'register');
            },
            child: Container(
              padding: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width,
              child: const Text('Forget Password'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            height: 95,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: const Color(0xFf466443)),
              onPressed: () {
                setState(() {
                  error();
                });
                if (usernameController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  loginData();
                }
                usernameController.clear();
                passwordController.clear();
              },
              child: const Text("Login"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'register');
            },
            child: Container(
                child: RichText(
                    text: const TextSpan(
                        text: "Don't have an account?",
                        children: [
                  TextSpan(text: 'Sign UP'),
                ]))),
          )
        ],
      ),
    );
  }
}
