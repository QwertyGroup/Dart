import 'package:flutter/material.dart';

/// 2. StatefulBuilder
/// but with rules violation
class MyHomePage2 extends StatelessWidget {
  // int _counter = 0; // needs to be final (immutable) because "Stateless"
  final state = {'counter': 0}; // so use dict, but now "counter" is string
  // I think this is bad design
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, StateSetter setState) => Scaffold(
        body: SafeArea(
          child: Text(
            '${state['counter']}',
            textScaleFactor: 4,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.toys),
          onPressed: () => setState(() => state['counter']++),
        ),
      ),
    );
  }
}
