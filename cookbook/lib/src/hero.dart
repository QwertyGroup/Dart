import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// https://youtu.be/-zJ6CnOVndE?t=554
class HeroImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
    // return SingleChildScrollView(
    //   child: CustomScrollView(
    //     slivers: <Widget>[
    //       SliverPersistentHeader(
    //         pinned: true,
    //         delegate: HeroHeader(),
    //       ),
    //       SliverFixedExtentList(
    //         itemExtent: 80,
    //         delegate: SliverChildBuilderDelegate(
    //           (ctx, i) {
    //             return Container(
    //               alignment: Alignment.center,
    //               child: Text(
    //                 'Item $i',
    //                 style: TextStyle(
    //                   color: (i + 1) % 9 > 4 ? Colors.white : Colors.black,
    //                 ),
    //               ),
    //               color: Colors.blue[100 * ((i + 1) % 9)],
    //             );
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class HeroHeader implements SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(children: <Widget>[
      Image.asset(
        'assets/images/image_three.jpg',
        fit: BoxFit.cover,
      ),
      Positioned(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
        child: Text(
          'Hero Image',
          style: TextStyle(fontSize: 32.0, color: Colors.white),
        ),
      ),
    ]);
  }

  @override
  double get maxExtent => 250;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
}
