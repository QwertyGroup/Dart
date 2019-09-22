import 'dart:convert';

import 'package:flutter/material.dart';

final GlobalKey<AnimatedListState> _listKey = GlobalKey();
List<String> _data = ['Sun', 'Moon', 'Star'];

class DynamicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _data.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_data[index], animation);
        },
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: _insertSingleItem,
          ),
          SizedBox(width: 4),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: _removeSingleItem,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String item, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(
            item,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void _insertSingleItem() {
    String newItem = "Planet";
    int insertIndex = 2;
    _data.insert(insertIndex, newItem);
    _listKey.currentState.insertItem(insertIndex);
  }

  void _removeSingleItem() {
    int removeIndex = 2;
    if (_data.length < 4) return;
    String removedItem = _data.removeAt(removeIndex);
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removedItem, animation);
    };
    _listKey.currentState.removeItem(removeIndex, builder);
  }
}
