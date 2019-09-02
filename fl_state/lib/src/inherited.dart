import 'package:flutter/material.dart';

/// 3. Inherited Widget
class InheritedCounter extends InheritedWidget {
  final Map _counter = {'val': 0};
  final Widget child;
  InheritedCounter({this.child}) : super(child: child);

  increment() {
    _counter['val']++;
  }

  get couner => _counter['val'];

  @override
  // look diff to determine if update needed
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static InheritedCounter of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(InheritedCounter);
}

class MyHomePage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        var counter = InheritedCounter.of(context).couner;
        var increment = InheritedCounter.of(context).increment;

        return Scaffold(
          body: SafeArea(
            child: Text(
              '$counter',
              textScaleFactor: 4,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.track_changes),
            onPressed: () => setState(() => increment()),
          ),
        );
      },
    );
  }
}
