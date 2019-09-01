import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      // home: MyHomePage('Home Page'),
      // home: MyHomePage2(),
      // home: InheritedCounter(child: MyHomePage3()),
      // home: InheritedCounter(child: MyHomePage4()),
      home: BlocProvider<CounterBloc>(
        builder: (context) => CounterBloc(),
        child: MyHomePage5(),
      ),
    );
  }
}

/// 5. BLoC
enum CounterEvent { increment }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield currentState + 1;
        break;
    }
  }
}

class MyHomePage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc bloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC'),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (ctx, count) {
          return Text(
            '$count',
            textScaleFactor: 4,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => bloc.dispatch(CounterEvent.increment),
      ),
    );
  }
}

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
