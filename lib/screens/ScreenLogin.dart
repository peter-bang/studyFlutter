import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//for google sign-in
import 'package:google_sign_in/google_sign_in.dart';

//for apple sign-in
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final emailContoller = TextEditingController();
  final passController = TextEditingController();
  String errorString = '';
  void fireAuthLogin() async {
    print('${emailContoller.text}, ${passController.text}');
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailContoller.text, password: passController.text)
        .catchError((error) => setState(() => errorString = error.message));
    // FirebaseAuth.instance.signInAnonymously();
    print("${FirebaseAuth.instance.currentUser}");
  }

  Future<UserCredential> googleAuthSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn()?.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email],
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
              child: Center(
            child: Image.asset("assets/images/peter.jpeg", width: 300),
          )),
          Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                "로그인하시던가",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  child: Text("구글 로그인!"), onPressed: () => googleAuthSignIn()),
              ElevatedButton(
                  child: Text("앱플 로그인!"), onPressed: () => signInWithApple()),
            ],
          )),
          Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                  controller: emailContoller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("e-mail")))),
          Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text("password")),
              )),
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => fireAuthLogin(),
                    child: Text("로그인하라귯!"),
                  ))),
          Container(
              margin: EdgeInsets.all(10),
              child: Center(
                child: Text(errorString),
              ))
        ]),
      ),
    );
  }
}
