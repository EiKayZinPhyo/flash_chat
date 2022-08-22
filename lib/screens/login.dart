import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordvisible = false;
  bool checking = false;
  bool loading = false;

  String? get userErrorText {
    if (usernameController.value.text.isEmpty) {
      return " Email can't be blank";
    }
    return null;
  }

  String? get passwordErrorText {
    if (usernameController.value.text.isEmpty) {
      return "Password can't be blank";
    }
    return null;
  }

  void loginData() async {
    // if (userErrorText == null && passwordErrorText == null) {
    try {
      final auth = FirebaseAuth.instance;
      final singinemail = await auth.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);

      print('>>>>>>>>>>');
      print(singinemail);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/flashchat');
    } catch (e) {
      const snackbar = SnackBar(
        backgroundColor: Colors.red,
        content:
            Text('The email or password is Wrong and You need to register '),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
  // }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var test = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Color(0xFf466443)),
        ),
        leading: IconButton(
          color: const Color(0xFf466443),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/firstscreen');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: const Color(0xFFF9FCF8),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF9FCF8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10, top: 100),
              child: const Text(
                "Welcome Back",
                style: TextStyle(
                    color: Color(0xFf466443),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  errorText: checking ? userErrorText : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  hintText: 'Username',
                  prefixIcon: const Icon(Icons.person),
                ),
                onChanged: (value) {
                  setState(() {
                    test = value;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                obscureText: !_passwordvisible,
                controller: checking ? passwordController : null,
                decoration: InputDecoration(
                  errorText: passwordErrorText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordvisible = !_passwordvisible;
                      });
                    },
                    icon: Icon(
                      _passwordvisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    value = test;
                  });
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width,
                child: const Text('Forget Password'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 95,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xFf466443)),
                onPressed: () async {
                  setState(() {
                    if (checking == true) {
                      loading = true;
                      loginData();
                    } else {
                      setState(() {
                        checking = true;
                      });

                      loading = false;
                    }
                  });
                },
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Login"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
              child: Container(
                  child: RichText(
                      text: const TextSpan(
                          text: "Don't have an account?",
                          children: [
                    TextSpan(
                        text: 'Sign UP',
                        style: TextStyle(color: Color(0xFf466443))),
                  ]))),
            )
          ],
        ),
      ),
    );
  }
}
