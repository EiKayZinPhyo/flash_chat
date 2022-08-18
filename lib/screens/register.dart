import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passwordvisible = false;

  var userErrorText = '';
  var passwordErrorText = '';

  void error() {
    if (usernameController.text.isEmpty == true) {
      userErrorText = "Email can't be blank";
    } else {
      userErrorText = '';
    }
    if (passwordController.text.isEmpty == true) {
      passwordErrorText = 'Password can not be blank';
    } else {
      passwordErrorText = '';
    }
  }

  void saveData() async {
    try {
      final auth = FirebaseAuth.instance;
      final newemail = await auth.createUserWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
      print('>>>>>>>>>>');
      print(newemail);
      Navigator.pushNamed(context, 'login');
    } catch (e) {
      const snackbar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('The email address is already  use by another account'),
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
        title: const Text(
          'Register',
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
              padding: const EdgeInsets.only(bottom: 10, top: 100),
              child: const Text(
                "Create Account",
                style: TextStyle(
                    color: Color(0xFf466443),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                errorText: userErrorText,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'Enter your email',
                prefixIcon: const Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
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
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            height: 95,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Color(0xFf466443)),
              onPressed: () async {
                setState(() {
                  error();
                  if (usernameController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    saveData();
                  }
                  usernameController.clear();
                  passwordController.clear();
                });
              },
              child: const Text("Register"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'login');
            },
            child: Container(
              child: Text('Already have an account? Login'),
            ),
          ),
        ],
      ),
    );
  }
}
