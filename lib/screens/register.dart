import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: use_build_context_synchronously

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  void saveData() async {
    if (userErrorText == null && passwordErrorText == null) {
      setState(() {
        loading = true;
      });
      try {
        final auth = FirebaseAuth.instance;
        final newemail = await auth.createUserWithEmailAndPassword(
            email: usernameController.text, password: passwordController.text);
        print('>>>>>>>>>>');
        print(newemail);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        const snackbar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('The email address is already  use by another account'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var test = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
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
                  errorText: checking ? userErrorText : null,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red)),
                  hintText: 'Enter your email',
                  prefixIcon: const Icon(Icons.person),
                ),
                onChanged: (value) {
                  setState(() {
                    value = test;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                obscureText: !_passwordvisible,
                controller: passwordController,
                decoration: InputDecoration(
                  errorText: checking ? passwordErrorText : null,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red)),
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
                    test = value;
                  });
                },
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
                  // setState(() {
                  //   loading = true;
                  // });
                  setState(() {
                    if (checking == true) {
                      saveData();
                    } else {
                      setState(() {
                        checking = true;
                      });
                      setState(() {
                        loading = false;
                      });
                    }
                  });
                },
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Register"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const SizedBox(
                child: Text('Already have an account? Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
