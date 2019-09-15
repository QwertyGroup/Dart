import 'dart:math';

import 'package:cookbook/src/backdrop.dart';
import 'package:cookbook/src/frosted.dart';
import 'package:cookbook/src/modal_sheet.dart';
import 'package:cookbook/src/pageswipe.dart';
import 'package:cookbook/src/phys_card.dart';
import 'package:cookbook/src/postiles.dart';
import 'package:cookbook/src/todo_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playground',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // home: PhysicsCardDragDemo(), // PhysicsCardDragDemo
      // home: FrozenList(), // Frosted list
      // home: ModalSheet(),
      // home: PositionedTiles(),
      // home: TodoListPage(),
      // home: BackdropPage(),
      home: PageSwipe(),
      debugShowCheckedModeBanner: false,
    );
  }
}
