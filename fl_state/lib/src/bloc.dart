import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 5. BLoC
enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield currentState + 1;
        break;
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
    }
  }
}

class MyHomePage5 extends StatefulWidget {
  @override
  _MyHomePage5State createState() => _MyHomePage5State();
}

class _MyHomePage5State extends State<MyHomePage5> {
  var _switch = true;
  @override
  Widget build(BuildContext context) {
    final CounterBloc bloc = BlocProvider.of<CounterBloc>(context);
    return CupertinoPageScaffold(
      // appBar: AppBar(
      //   title: Text('BLoC'),
      // ),
      child: BlocBuilder(
        bloc: bloc,
        builder: (ctx, count) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$count',
                  // textScaleFactor: 4,
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navLargeTitleTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text(
                        "increment",
                        textScaleFactor: 2,
                      ),
                      onPressed: _switch
                          ? () => bloc.dispatch(CounterEvent.increment)
                          : null,
                    ),
                    CupertinoSwitch(
                      value: _switch,
                      onChanged: (flag) {
                        _switch ^= true; // or _switch = !_switch;
                        bloc.dispatch(flag
                            ? CounterEvent.increment
                            : CounterEvent.decrement);
                      },
                    ),
                  ],
                ),
                CupertinoButton.filled(
                  child: Text(
                    'decrement',
                    textScaleFactor: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  onPressed: () => bloc.dispatch(CounterEvent.decrement),
                )
              ],
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () => bloc.dispatch(CounterEvent.increment),
      // ),
    );
  }
}
