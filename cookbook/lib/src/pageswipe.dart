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
              initialPage: 1,
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
                    child: Tile(_images, i),
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
  Tile(this.images, this.i);
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
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: Hero(
                      tag: images[i],
                      child: Tile(images, i),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.endDocked,
                    floatingActionButton: FloatingActionButton(
                      // elevation: 0,
                      child: Icon(
                        Icons.blur_circular,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.redAccent,
                      onPressed: () => Navigator.of(context).pop(),
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
