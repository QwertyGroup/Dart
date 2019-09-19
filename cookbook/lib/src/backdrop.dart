import 'package:cookbook/src/bloc/bcard_bloc.dart';
import 'package:cookbook/src/cf_identity.dart';
import 'package:cookbook/src/modal_sheet.dart';
import 'package:cookbook/src/model/bcard_data.dart';
import 'package:cookbook/src/pageswipe.dart';
import 'package:cookbook/src/staggered.dart';
import 'package:cookbook/src/waveslider.dart';
import 'package:cookbook/src/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackdropPage extends StatefulWidget {
  @override
  _BackdropPageState createState() => _BackdropPageState();
}

class _BackdropPageState extends State<BackdropPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  BCardBloc bloc;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      value: 1,
    );

    bloc = BCardBloc();
  }

  @override
  void dispose() {
    _controller.dispose();
    bloc.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _triggerFling() {
    _controller.fling(velocity: isPanelVisible ? -1 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Backdrop'),
          elevation: 0,
          actions: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Icon(Icons.add_shopping_cart),
            // ),
            IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                progress: _controller.view,
              ),
              onPressed: _triggerFling,
            ),
          ],
          // airplanemode_inactive
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(CFIdentity.fff_circs),
            // child: Icon(CFIdentity.cflogo_cell_negative),
          ),
        ),
        body: TwoPanels(
          controller: _controller,
          onTap: _triggerFling,
        ),
      ),
    );
  }
}

class TwoPanels extends StatefulWidget {
  final AnimationController controller;
  final VoidCallback onTap;
  TwoPanels({@required this.controller, @required this.onTap});

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> {
  static const double headerHeight = 32;

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - headerHeight;
    final frontPanelHeight = -headerHeight;
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, backPanelHeight, 0, frontPanelHeight),
      end: RelativeRect.fromLTRB(0, 0, 0, 0),
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Curves.linear,
      ),
    );
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    final theme = Theme.of(context);
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: theme.primaryColor,
            // child: Center(
            //   child: Text(
            //     'Backpanel',
            //     style: theme.textTheme.title.copyWith(
            //       color: Colors.white,
            //       fontSize: 24,
            //     ),
            //   ),
            // ),
            child: GridView.count(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              // gridDelegate: ,
              crossAxisCount: 3,
              childAspectRatio: 6 / 5,
              // crossAxisSpacing: 4,
              // mainAxisSpacing: 4,
              children: BCardData.list
                  .map(
                    (data) => new BackdropCard(
                        context: context, data: data, onTap: widget.onTap),
                  )
                  .toList(),
            ),
          ),
          PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: Material(
              color: theme.cardColor,
              elevation: 7,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: BlocBuilder(
                  bloc: BlocProvider.of<BCardBloc>(context),
                  builder: (BuildContext context, BCardData data) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: widget.onTap,
                          onVerticalDragStart: (_) => widget.onTap(),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: headerHeight,
                            child: Center(
                              child: Text(
                                // 'Drag',
                                data.title,
                                style: theme.textTheme.button
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: LayoutBuilder(
                        //     builder: (context, constraints) {
                        //       return FittedBox(
                        //         fit: BoxFit.cover,
                        //         child: Container(
                        //           constraints: constraints,
                        //           // child: PageSwipe(),
                        //           child: WaveApp(),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        // Expanded(
                        //   child: FittedBox(
                        //     fit: BoxFit.cover,
                        //     child: Container(
                        //       constraints: constraints,
                        //       // child: PageSwipe(),
                        //       child: WaveApp(),
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          child: Container(
                            constraints: constraints,
                            // child: PageSwipe(),
                            // child: WaveApp(),
                            // child: TodoListPage(),
                            child: data.content,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}

class BackdropCard extends StatelessWidget {
  const BackdropCard({
    Key key,
    @required this.context,
    @required this.data,
    @required this.onTap,
  }) : super(key: key);

  // final ThemeData theme;
  final BCardData data;
  final BuildContext context;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      // shape: Shape,
      elevation: 6,
      margin: EdgeInsets.all(5),
      // clipBehavior: Clip.,
      color: theme.cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            // data as String,
            data.title,
            style: theme.textTheme.button.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 28,
            child: OutlineButton(
              // icon: Icon(
              //   Icons.arrow_right,
              //   size: 28,
              // ),
              textColor: theme.primaryColor,
              child: Text(
                'Launch',
                style: theme.textTheme.title.copyWith(
                  color: theme.primaryColor,
                  fontSize: 14,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
                // side: BorderSide()
              ),
              // hoverColor: Colors.amber,
              splashColor: theme.primaryColor,
              // hoverColor: Colors.amber,
              // focusColor: Colors.amber,
              highlightColor: Colors.black,
              // highlightElevation: 3,
              // color: theme.primaryColor,
              // highlightedBorderColor: Colors.blue,
              borderSide: BorderSide(
                color: theme.primaryColor,
                style: BorderStyle.solid,
                width: 1,
              ),
              // child: Text(
              //   'Launch',
              //   style: theme.textTheme.title.copyWith(
              //     color: theme.primaryColor,
              //     fontSize: 14,
              //   ),
              // ),
              onPressed: () {
                // print('pressed');
                BlocProvider.of<BCardBloc>(context).dispatch(LaunchEvent(data));
                onTap();
              },
            ),
          )
        ],
      ),
    );
  }
}

// child: Center(
//   child: Text(
//     'Front',
//     style: theme.textTheme.display3,
//   ),
// ),
// flex: ,
// child: SizedBox(
//   width: 200,
//   height: 200,
//   child: FittedBox(
// fit: BoxFit.cover,
