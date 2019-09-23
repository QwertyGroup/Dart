import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';

class Slivers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.teal[100],
          expandedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Slivers',
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
            ),
            centerTitle: true,
          ),
        ),
        // SliverPersistentHeader(
        //   delegate: HeroHeader(),
        //   pinned: true,
        //   // backgroundColor: Colors.deepOrange[200],
        //   // expandedHeight: 100,
        //   // flexibleSpace: FlexibleSpaceBar(
        //   //   title: Text(
        //   //     'Grid Sliver',
        //   //     style: Theme.of(context).textTheme.title.copyWith(
        //   //           color: Colors.black,
        //   //           fontSize: 18,
        //   //         ),
        //   //   ),
        //   //   centerTitle: true,
        //   // ),
        // ),
        SliverAppBar(
          pinned: false,
          backgroundColor: Colors.deepPurpleAccent[400],
          expandedHeight: 90,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Item (-1)',
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
            ),
            centerTitle: true,
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3 / 1,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, i) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  'Item $i',
                ),
                color: Colors.amber[100 * (i % 7)],
              );
            },
            childCount: 31,
          ),
        ),
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.brown[900],
          expandedHeight: 100,
          leading: Icon(Icons.arrow_back),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(color: Colors.brown[700]),
            // titlePadding: EdgeInsets.all(8),
            title: Text(
              'List Sliver',
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
            ),
            centerTitle: false,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 80,
          delegate: SliverChildBuilderDelegate(
            (ctx, i) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  'Item $i',
                  style: TextStyle(
                    color: (i + 1) % 9 > 4 ? Colors.white : Colors.black,
                  ),
                ),
                color: Colors.blue[100 * ((i + 1) % 9)],
              );
            },
          ),
        ),
      ],
    );
  }
}
