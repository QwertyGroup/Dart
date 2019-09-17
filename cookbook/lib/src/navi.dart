import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: , // routes map. See difference
      onGenerateRoute: Router.generateRoute,
      initialRoute: homeRoute,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showPerformanceOverlay: false,
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: () {
          Navigator.pushNamed(context, feedRoute, arguments: 'Data from home');
        },
      ),
      body: Center(child: Text('Home')),
    );
  }
}

class Feed extends StatelessWidget {
  final String data;

  Feed(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Feed: $data')),
    );
  }
}

// router.dart file
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Home());
      case feedRoute:
        return MaterialPageRoute(
            builder: (_) => Feed(settings.arguments as String));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Column(
                children: <Widget>[
                  Text('404', style: TextStyle(fontSize: 60)),
                  Text('No route defined for ${settings.name}'),
                ],
              ),
            ),
          ),
        );
    }
  }
}

// constants.dart file

/// This file contains all the routing constants used within the app
const String homeRoute = '/';
const String feedRoute = '/feed';
