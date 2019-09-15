import 'dart:math';

import 'package:flutter/material.dart';

class PositionedTiles extends StatefulWidget {
  @override
  _PositionedTilesState createState() => _PositionedTilesState();
}

class _PositionedTilesState extends State<PositionedTiles> {
  List<Widget> _tiles;
  @override
  void initState() {
    super.initState();
    _tiles = [
      Test(key: UniqueKey()),
      Test(key: UniqueKey()),
      // Test(),
      // Test(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _tiles,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.rotate_90_degrees_ccw),
        onPressed: swapTiles,
      ),
    );
  }

  void swapTiles() {
    setState(() {
      _tiles.insert(1, _tiles.removeAt(0));
    });
  }
}

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  final _radius = (Random().nextInt(50) + 14).toDouble();

  _TestState() {
    // _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: 100,
    //   height: 100,
    //   color: _color,
    // );
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Material(
            color: _color,
            elevation: 17,
            shadowColor: _color,
            animationDuration: Duration(seconds: 1),
            // borderRadius: BorderRadius.all(Radius.circular(_radius)),
            borderRadius: BorderRadius.all(
              Radius.circular(
                Random().nextDouble() *
                    min(constraints.biggest.width / 2,
                        constraints.biggest.height / 2),
              ),
            ),
            child: Center(
              child: Text('${constraints.biggest.width}'),
            ),
          ),
        ),
      ),
    );
  }
}
