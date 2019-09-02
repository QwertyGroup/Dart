import 'package:fl_state/src/bloc.dart';
import 'package:fl_state/src/builder.dart';
import 'package:fl_state/src/classicStateful.dart';
import 'package:fl_state/src/inherited.dart';
import 'package:fl_state/src/rx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    return CupertinoApp(
      title: 'State Management',
      // theme: ThemeData(
      // primarySwatch: Colors.brown,
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          navLargeTitleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 70,
            color: CupertinoColors.black,
          ),
        ),
      ),
      // home: MyHomePage('Home Page'),
      // home: MyHomePage2(),
      // home: InheritedCounter(child: MyHomePage3()),
      // home: MyHomePage4(),
      home: BlocProvider<CounterBloc>(
        builder: (context) => CounterBloc(),
        child: MyHomePage5(),
      ),
    );
  }
}
