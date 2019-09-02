import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

/// 4. RxDart
class Counter {
  BehaviorSubject _counter = BehaviorSubject.seeded(0);

  // dot really know what "$" means
  Observable get stream$ => _counter.stream;
  int get current => _counter.value;

  increment() {
    _counter.add(current + 1);
  }
}

Counter counterService = Counter(); // like global thingie

class MyHomePage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: counterService.stream$,
        builder: (ctx, snap) {
          return SafeArea(
            child: Text(
              '${snap.data}',
              textScaleFactor: 4,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.whatshot),
        onPressed: () => counterService.increment(),
      ),
    );
  }
}
