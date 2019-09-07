import 'dart:math';

import 'package:cookbook/src/cf_identity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookbook/src/cf_identity.dart';

class ModalSheet extends StatefulWidget {
  @override
  _ModalSheetState createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  String _selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(
            side: BorderSide(
          color: Theme.of(context).canvasColor,
          width: 0,
        )),
        elevation: 0,
        child: Icon(
          Icons.wrap_text,
          // CFIdentity.fff_circs,
        ),
        backgroundColor: Colors.black,
        onPressed: _onButtonPressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        // clipBehavior: Clip.hardEdge,
        color: Colors.black,
        child: Container(
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    CFIdentity.cflogo_row,
                    size: 30,
                    color: Theme.of(context).canvasColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    CFIdentity.fff_orsen,
                    size: 30,
                    color: Theme.of(context).canvasColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // if (_selectedItem == 'Crystal\nFactory') ...[
            //   Icon(CFIdentity.fff_circs)
            // ],
            if (_selectedItem == 'cf')
              Icon(
                CFIdentity.fff_circs,
                size: 200,
              )
            else
              Text(
                _selectedItem,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 70,
                  color: CupertinoColors.black,
                ),
              )
          ],
        ),
      ),
    );
  }

  void _onButtonPressed() {
    //  showCupertinoModalPopup(context: context, builder: );
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // backgroundColor: Colors.lightBlue,
      // elevation: 10,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        // side: BorderSide(
        //   color: Colors.green,
        //   width: 4,
        // ),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(80),
        ),
      ),
      context: context,
      builder: (context) {
        // return Container(
        //   height: 100,
        //   decoration: BoxDecoration(
        //     // color: Colors.blue,
        //     color: Colors.transparent,
        //     borderRadius: BorderRadius.circular(50),
        //   ),
        //   child: Placeholder(),
        // );
        // return Placeholder();
        return _buildModalSheet();
        // return ClipRRect(
        //   // borderRadius: BorderRadius.circular(100),
        //   borderRadius: BorderRadius.only(
        //     topLeft: const Radius.circular(50),
        //     topRight: const Radius.circular(10),
        //   ),
        // borderRadius: Radius.zero,
        // child: Container(
        // height: 200,
        // child:
        // return Align(
        //   alignment: Alignment.bottomRight,
        //   child: _buildModalSheet(),
        // ),
        // decoration: BoxDecoration(
        // color: Colors.lightBlue,
        // color: Theme.of(context).canvasColor,
        // borderRadius: BorderRadius.only(
        //   topLeft: const Radius.circular(10),
        //   topRight: const Radius.circular(10),
        // ),
        // ),
        // ),
        // );
      },
    );
  }

  Widget _buildModalSheet() {
    // return Align(
    //   alignment: Alignment.bottomRight,
    // child:
    var style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: CupertinoColors.black,
    );

    return Row(
      children: <Widget>[
        Spacer(flex: 3),
        Flexible(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30),
            ),
            child: Container(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,

                  // textDirection: TextDirection.rtl,
                  // verticalDirection: VerticalDirection.up,

                  children: <Widget>[
                    ListTile(
                      // leading: Icon(
                      //   Icons.ac_unit,
                      //   color: Colors.black,
                      // ),
                      // contentPadding: EdgeInsets.all(8),
                      // dense: true,
                      // enabled: false,
                      // selected: true,

                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.ac_unit,
                            color: Colors.black,
                          ),
                          // Spacer(),

                          Text(
                            'Frosting',
                            textAlign: TextAlign.start,
                            style: style,
                          ),
                        ],
                      ),
                      onTap: () => _selectItem('Frosting'),
                    ),
                    ListTile(
                      // leading: Icon(Icons.accessibility_new, color: Colors.black),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.threesixty,
                            color: Colors.black,
                          ),
                          Text(
                            'Around',
                            textAlign: TextAlign.start,
                            style: style,
                          ),
                        ],
                      ),
                      onTap: () => _selectItem('Around'),
                    ),
                    ListTile(
                      // leading: Icon(Icons.assessment, color: Colors.black),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: Colors.black,
                          ),
                          Text(
                            'Booking',
                            textAlign: TextAlign.start,
                            style: style,
                          ),
                        ],
                      ),
                      onTap: () => _selectItem('BM'),
                    ),
                    ListTile(
                      // leading: Icon(Icons.assessment, color: Colors.black),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Transform.translate(
                            offset: Offset(-7, 0),
                            // angle: pi / 4,
                            // alignment: Alignment.centerLeft,
                            child: Icon(
                              CFIdentity.cflogo_cell,
                              color: Colors.black,
                              size: 18,
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(-7, 0),
                            child: Text(
                              'Crystal',
                              textAlign: TextAlign.start,
                              style: style,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => _selectItem('cf'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Spacer(flex: 1),
      ],
    );
  }

  void _selectItem(String item) {
    Navigator.pop(context);
    setState(() {
      _selectedItem = item;
    });
  }
}
