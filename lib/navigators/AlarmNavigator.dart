import 'package:flutter/material.dart';
import 'package:study_flutter/screens/ScreenA.dart';
import 'package:study_flutter/screens/ScreenB.dart';

class AlarmNavigator extends StatelessWidget {
  const AlarmNavigator({super.key, required this.tabIndex});
  final int tabIndex;
  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      "/": (context) => ScreenA(
            tabIndex: tabIndex,
          ),
      "/ScreenB": (context) => ScreenB(
            tabIndex: tabIndex,
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilder = _routeBuilder(context);
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilder[settings.name!]!(context),
        );
      }),
    );
  }
}
