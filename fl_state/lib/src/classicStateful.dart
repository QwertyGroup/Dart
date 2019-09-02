import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 1. StatefulWidget
class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage(this.title);
  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          '$_counter',
          textScaleFactor: 4,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incCounter,
        child: Icon(Icons.near_me),
      ),
    );
  }
}
