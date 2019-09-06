import 'package:cookbook/src/frosted.dart';
import 'package:cookbook/src/modal_sheet.dart';
import 'package:cookbook/src/phys_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookBook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: PhysicsCardDragDemo(), // PhysicsCardDragDemo
      // home: FrozenList(), // Frosted list
      home: ModalSheet(),
      debugShowCheckedModeBanner: false,
    );
  }
}
