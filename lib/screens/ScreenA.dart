import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ScreenB.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ScreenA")),
        body: Center(
          child: Column(children: [
            Text("안녕! ${FirebaseAuth.instance.currentUser!.email}"),
            Text("from tab: ${tabIndex.toString()}"),
            TextButton(
              child: Text("Go to ScreenB"),
              onPressed: () {
                Navigator.pushNamed(context, '/ScreenB');
              },
            ),
            TextButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: Text("로그아웃")),
          ]),
        ));
  }
}
