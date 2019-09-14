import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  final sentence =
      '''Material is the central metaphor in material design. Each piece of material exists at a given elevation, which influences how that piece of material visually relates to other pieces of material and how that material casts shadows.''';

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todos = List<String>();
  @override
  void initState() {
    super.initState();
    _todos = widget.sentence.split(' ');
    // setState(() {
    //   _todos = widget.sentence.split(' ');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            var future = Future.delayed(Duration(microseconds: 500));
            setState(() {
              _todos = _todos.reversed.toList();
            });
            return future;
          },
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _todos.length,
            itemBuilder: (ctx, i) {
              var color =
                  Colors.primaries[_todos[i].length % Colors.primaries.length];
              // Colors.primaries[Random().nextInt(Colors.primaries.length)];
              String capitalize(String s) =>
                  s[0].toUpperCase() + s.substring(1);
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Dismissible(
                  key: UniqueKey(),
                  resizeDuration: Duration(milliseconds: 800),
                  // confirmDismiss: (direction) =>
                  //     Future.value(direction.index == 3),
                  // dismissThresholds: {DismissDirection.endToStart: 0.9},
                  // // crossAxisEndOffset: 1,
                  movementDuration: Duration(milliseconds: 300),
                  dragStartBehavior: DragStartBehavior.down,
                  onDismissed: (direction) {
                    print(direction.index);
                    if (direction.index == 3) {
                      setState(() {
                        _todos.removeAt(i);
                      });
                    } else if (direction.index == 2) {
                      setState(() {
                        _todos.insert(i, _todos[i]);
                        // _todos.insert(0, _todos[i]);
                      });
                    }
                  },
                  background: Material(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 32,
                          ),
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                    color: color,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8),
                      bottom: Radius.zero,
                    ),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8),
                      bottom: Radius.zero,
                    ),
                    elevation: 6,
                    borderOnForeground: true,
                    shadowColor: color,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Stack(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: SizedBox(
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: BM(),
                                  ),
                                  height: 38,
                                ),
                              ),
                              Center(
                                // alignment: Alignment.center,
                                child: Text(
                                  capitalize(_todos[i]),
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 4, color: color),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BM extends StatefulWidget {
  @override
  _BMState createState() => _BMState();
}

class _BMState extends State<BM> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.repeat(reverse: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Transform.translate(
          offset: Offset(19, -9.0), // ln: 29
          child: Transform.rotate(
            angle: 4.8 / 180 * pi,
            child: RotationTransition(
              turns: Tween<double>(
                begin: 0,
                end: 2,
              ).animate(
                CurvedAnimation(
                  curve: Curves.easeInOutBack,
                  parent: _controller,
                ),
              ),
              child: Icon(
                Icons.settings,
                size: 76,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Transform.rotate(
          angle: 44 / 180 * pi,
          child: RotationTransition(
            turns: Tween<double>(
              begin: 2,
              end: 0,
            ).animate(
              CurvedAnimation(
                curve: Curves.easeInOutBack,
                // reverseCurve: Curves.easeInOut,
                parent: _controller,
              ),
            ),
            child: Icon(
              Icons.settings,
              size: 76,
              color: Colors.black,
            ),
          ),
        ),
        // Transform.translate(
        //   offset: Offset(-4, 0),
        //   child: Text(
        //     'BM',
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 80,
        //       color: CupertinoColors.black,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
