//default
import 'package:flutter/material.dart';

//firebase
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

//packages
import 'package:provider/provider.dart';

//screens
import 'screens/ScreenA.dart';
import 'screens/ScreenLogin.dart';

//navigations
import 'navigators/PersonNavigator.dart';
import 'navigators/UmbrellaNavigator.dart';
import 'navigators/AlarmNavigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    title: 'Navigation',
    home: MainPage(),
  ));
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MyApp();
        } else {
          return const ScreenLogin();
        }
      },
    ));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentTabIndex = 0;
  void _tabSelect(int tabIndex) {
    setState(() {
      _currentTabIndex = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Stack(children: [
        Offstage(
          offstage: _currentTabIndex != 0,
          child: PersonNavigator(tabIndex: 0),
        ),
        Offstage(
          offstage: _currentTabIndex != 1,
          child: AlarmNavigator(tabIndex: 1),
        ),
        Offstage(
          offstage: _currentTabIndex != 2,
          child: UmbrellaNavigator(tabIndex: 2),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Person"),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "alarm"),
          BottomNavigationBarItem(icon: Icon(Icons.umbrella), label: "umbrella")
        ],
        currentIndex: _currentTabIndex,
        onTap: (value) => _tabSelect(value),
      ),
    );
  }
}
