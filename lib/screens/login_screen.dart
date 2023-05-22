import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../component/rounded_button.dart';
import '../constants.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "Login_Screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                //Do something with the user input.
                email = value;
              },
              style: kInputTextStyle,
              decoration: KTextInputBoxDecoration.copyWith(hintText: "Email"),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
                password = value;
              },
              style: kInputTextStyle,
              decoration:
                  KTextInputBoxDecoration.copyWith(hintText: "Password"),
            ),
            SizedBox(
              height: 24.0,
            ),
            SolidColuredButton(
              buttonColor: Colors.purpleAccent,
              lebelText: 'Log In',
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                await logIn(context);
              },
            ),
            showSpinner
                ? Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Future<void> logIn(BuildContext context) async {
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if ((newUser != null)) {
        Navigator.pushNamed(context, ChatScreen.id);
      }
      setState(() {
        showSpinner = true;
      });
    } catch (e) {
      print(e);
    }
  }
}
