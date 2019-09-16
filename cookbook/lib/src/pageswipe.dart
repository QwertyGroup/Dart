import 'dart:math';
// import 'dart:ui';

import 'package:flutter/material.dart';

class PageSwipe extends StatelessWidget {
  final List<String> _images = [
    'assets/images/image_one.png',
    'assets/images/image_two.jpg',
    'assets/images/image_three.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: Size.fromHeight(550),
          child: PageView.builder(
            controller: PageController(
              viewportFraction: .8,
              initialPage: 0,
            ),
            itemCount: _images.length,
            physics: BouncingScrollPhysics(),
            pageSnapping: false,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Hero(
                  tag: _images[i],
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(8),
                    clipBehavior: Clip.antiAlias,
                    child: Tile(
                      _images,
                      i,
                      depth: 0,
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

class Tile extends StatelessWidget {
  final List<String> images;
  final int i;
  final int depth;

  Tile(this.images, this.i, {@required this.depth});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          images[i],
          fit: BoxFit.cover,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.7),
                ],
                stops: [
                  0.8,
                  1
                ]),
          ),
        ),
        // if (depth > 0)
        //   Positioned.fill(
        //     top: 20,
        //     child: Align(
        //       alignment: Alignment.topCenter,
        //       child: FittedBox(
        //         fit: BoxFit.cover,
        //         child: BigCounter(
        //           key: UniqueKey(),
        //           count: depth,
        //         ),
        //       ),
        //     ),
        //   ),

        if (depth > 0)
          BigCounter(
            // key: UniqueKey(),
            count: depth,
          ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            child: Text(
              '${images[i]}',
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.white,
                    fontSize: 9,
                  ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.black,
            onDoubleTap: () => Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('${images[i]}'),
                ),
              ),
            onLongPress: () {
              // Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: Hero(
                      tag: images[i],
                      child: Tile(
                        images,
                        i,
                        depth: depth + 1,
                      ),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.endFloat,
                    floatingActionButton: FloatingActionButton(
                      // elevation: 0,
                      child: Transform.rotate(
                        angle: -pi / 2,
                        child: Icon(
                          Icons.keyboard_backspace,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.black,
                      onPressed: () => Navigator.of(context).pop(),
                      // onPressed: () {},
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class BigCounter extends StatefulWidget {
  final int count;

  const BigCounter({Key key, this.count}) : super(key: key);

  @override
  _BigCounterState createState() => _BigCounterState();
}

class _BigCounterState extends State<BigCounter>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    // _controller.repeat();
    _controller.forward();
    print('Forvard');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _controller.forward();
    // print('yolo');
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 120,
      fontFamily: 'Exo',
      fontWeight: FontWeight.w600,
    );
    return FadeTransition(
      opacity: Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
        parent: _controller,
        // curve: Curves.easeOut,
        curve: Curves.linear,
      )),
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                'x',
                style: textStyle.copyWith(
                    fontSize: 80, fontWeight: FontWeight.normal),
              ),
              Text(
                '${widget.count}',
                style: textStyle.copyWith(fontFamily: 'Arial'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
