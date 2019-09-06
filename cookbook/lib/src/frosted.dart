import 'dart:ui';

import 'package:flutter/material.dart';

class FrozenList extends StatefulWidget {
  FrozenList({key}) : super(key: key);

  @override
  _FrozenListState createState() => _FrozenListState();
}

class _FrozenListState extends State<FrozenList> {
  var _items = List.generate(20, (i) => 'a$i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (ctx, i) {
          return Dismissible(
            key: Key(_items[i]),
            child: Stack(
              children: [
                FlutterLogo(),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: FittedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.5)),
                        child: Center(
                          child: Text('Frosted ${_items[i]}',
                              style: Theme.of(context).textTheme.display3),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onDismissed: (direction) {
              _items.removeAt(i);
            },
          );
        },
      ),
    );
  }
}
